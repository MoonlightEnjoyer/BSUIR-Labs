using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace ClientApp.CommandHandlers
{
    public class DownloadCommandHandler : CommandHandlerBase
    {
        public override bool CanHandle(string commandName)
        {
            return commandName == "DOWNLOAD";
        }

        public override void Handle(CommandParameters commandParameters)
        {
            if (CanHandle(commandParameters.CommandName))
            {
                Download(commandParameters);
            }
            else
            {
                base.Handle(commandParameters);
            }
        }

        private void Download(CommandParameters parameters)
        {
            int packetSize = parameters.Socket.ReceiveBufferSize - sizeof(long) - 128;
            using FileStream fileStream = new FileStream(parameters.Parameters, FileMode.OpenOrCreate);
            byte[] bytes = new byte[packetSize + sizeof(long)];
            long length = fileStream.Length;
            parameters.Socket.Send(BitConverter.GetBytes(length));
            int byteRec;
            byteRec = parameters.Socket.Receive(bytes, sizeof(long), SocketFlags.None);
            if (BitConverter.ToInt64(bytes[0..8]) == -1)
            {
                fileStream.Dispose();
                File.Delete(parameters.Parameters);
                Console.WriteLine("File not found.");
                return;
            }

            //fileStream.Position = fileStream.Length;
            
            length = BitConverter.ToInt64(bytes[0..8]);
            long uploadSize = (length - fileStream.Position) * 8 / 1000000;
            (TimeSpan resendTime, byte[] data)[] cache = new (TimeSpan, byte[])[length / packetSize + (length % packetSize == 0 ? 0 : 1)];
            int blockSize = 64 * 4;
            long lastAckedPacket = 0;
            int counter = 0;
            long byteCounter = 0;
            long lostPacketNumber;
            TimeSpan lastReceiveTime = DateTime.UtcNow.TimeOfDay;

            parameters.Socket.Blocking = false;
            Stopwatch stopwatch = new Stopwatch();
            stopwatch.Start();
            while (true)
            {
                if (parameters.Socket.Poll(1, SelectMode.SelectRead))
                {
                    byteRec = parameters.Socket.Receive(bytes, bytes.Length, SocketFlags.None);
                    lastReceiveTime = DateTime.UtcNow.TimeOfDay;

                    var data = AckSystem.UnpackData(bytes, byteRec);

                    counter++;

                    byteCounter += data.data.Length;
                    cache[data.number].data = data.data;
                }

                if ((DateTime.UtcNow.TimeOfDay - lastReceiveTime).Ticks >= TimeSpan.TicksPerSecond * 30)
                {
                    Console.WriteLine("Disconnected.");
                    parameters.Socket.Blocking = true;
                    return;
                }
                else if (counter - lastAckedPacket >= blockSize || (DateTime.UtcNow.TimeOfDay - lastReceiveTime).Ticks >= TimeSpan.TicksPerSecond)
                {
                    lostPacketNumber = CheckCache();
                    if (lostPacketNumber == -1)
                    {
                        for (long i = lastAckedPacket; i < lastAckedPacket + blockSize && i < counter && i < cache.Length; i++)
                        {
                            fileStream.Write(cache[i].data);
                            fileStream.Flush();
                        }

                        lastAckedPacket += blockSize;
                        AckSystem.SendAck(lastAckedPacket, parameters.Socket);
                    }
                    else if (lostPacketNumber != -2)
                    {
                        AckSystem.RequestResend(lostPacketNumber, parameters.Socket);
                    }
                }

                if (fileStream.Length == length && length != 0)
                {
                    break;
                }
            }

            parameters.Socket.Blocking = true;

            Console.WriteLine("Download finished.");
            stopwatch.Stop();
            Console.WriteLine($"Bitrate: {uploadSize / stopwatch.Elapsed.TotalSeconds} mb/s");

            long CheckCache()
            {
                for (long i = lastAckedPacket; i < lastAckedPacket + blockSize && i < cache.Length; i++)
                {
                    var utcNow = DateTime.UtcNow.TimeOfDay;
                    var elapsedTime = (utcNow - cache[i].resendTime).Ticks;
                    if (cache[i].data is null && elapsedTime >= TimeSpan.TicksPerMillisecond * 100)
                    {
                        cache[i].resendTime = utcNow;
                        return i;
                    }
                    else if (cache[i].data is null && elapsedTime < TimeSpan.TicksPerMillisecond * 100)
                    {
                        return -2;
                    }
                }

                return -1;
            }
        }
    }
}
