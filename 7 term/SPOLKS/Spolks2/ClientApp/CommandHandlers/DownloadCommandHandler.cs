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
            while (!parameters.Socket.Poll(1, SelectMode.SelectWrite))
            {
            }
            parameters.Socket.Send(BitConverter.GetBytes(length));
            int byteRec;
            while (!parameters.Socket.Poll(1, SelectMode.SelectRead))
            {
            }
            byteRec = parameters.Socket.Receive(bytes, SocketFlags.None);
            if (BitConverter.ToInt32(bytes[0..4]) == -1)
            {
                fileStream.Dispose();
                File.Delete(parameters.Parameters);

                if (parameters.Socket.Poll(100000,SelectMode.SelectRead))
                {
                    parameters.Socket.Receive(bytes);
                }

                Console.WriteLine("File not found.");

                return;
            }

            fileStream.Position = fileStream.Length;
            
            length = BitConverter.ToInt64(bytes[0..8]);
            long uploadSize = (length - fileStream.Position) * 8 / 1000000;
            (TimeSpan resendTime, byte[] data)[] cache = new (TimeSpan, byte[])[length / packetSize + (length % packetSize == 0 ? 0 : 1)];
            int blockSize = 64 * 4;
            long lastAckedPacket = fileStream.Length / packetSize;
            long counter = lastAckedPacket;
            //long byteCounter = fileStream.Length;
            long lostPacketNumber;
            TimeSpan lastReceiveTime = DateTime.UtcNow.TimeOfDay;
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
                    //if (data.number > counter)
                    //{
                    //    counter = data.number;
                    //}

                    //byteCounter += data.data.Length;
                    cache[data.number].data = data.data;
                }

                if ((DateTime.UtcNow.TimeOfDay - lastReceiveTime).Ticks >= TimeSpan.TicksPerSecond * 30)
                {
                    Console.WriteLine("Disconnected.");
                    parameters.Socket.Shutdown(SocketShutdown.Both);
                    parameters.Socket.Close();
                    return;
                }
                else if (counter - lastAckedPacket >= blockSize || (DateTime.UtcNow.TimeOfDay - lastReceiveTime).Ticks >= TimeSpan.TicksPerSecond)
                {
                    lostPacketNumber = CheckCache();
                    if (lostPacketNumber == -1)
                    {
                        for (long i = lastAckedPacket; i < lastAckedPacket + blockSize && i < cache.Length; i++)
                        {
                            //Console.WriteLine($"Cache block[{i}] : {cache[i].data.Length}");
                            fileStream.Write(cache[i].data);
                            fileStream.Flush();
                        }

                        //Console.WriteLine($"Lost packet: {CheckCache()}");

                        lastAckedPacket += blockSize;
                        //Console.WriteLine($"Counter: {counter}");
                        //Console.WriteLine($"ByteCounter: {byteCounter}");
                        //Console.WriteLine($"File size: {fileStream.Length}");
                        //Console.WriteLine($"Expected file size: {ex_length}");
                        //Console.WriteLine($"lastAckedPacket: {lastAckedPacket}");
                        AckSystem.SendAck(lastAckedPacket, parameters.Socket);

                        if (lastAckedPacket * packetSize >= length)
                        {
                            break;
                        }
                    }
                    else if (lostPacketNumber != -2)
                    {
                        AckSystem.RequestResend(lostPacketNumber, parameters.Socket);
                    }
                }

                
            }

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
