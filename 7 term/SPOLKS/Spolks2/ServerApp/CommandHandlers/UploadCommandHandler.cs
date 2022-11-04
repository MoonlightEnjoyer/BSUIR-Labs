using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using ClientApp;

namespace ServerApp.CommandHandlers
{
    public class UploadCommandHandler : CommandHandlerBase
    {
        private string username;

        public UploadCommandHandler(string username)
        {
            this.username = username;
        }

        public override bool CanHandle(string commandName)
        {
            return commandName == "UPLOAD";
        }

        public override void Handle(CommandParameters commandParameters)
        {
            if (CanHandle(commandParameters.CommandName))
            {
                Upload(commandParameters);
            }
            else
            {
                base.Handle(commandParameters);
            }
        }

        private void Upload(CommandParameters parameters)
        {
            int packetSize = parameters.Socket.ReceiveBufferSize - sizeof(long) - 128;
            int filenameStart = parameters.Parameters.LastIndexOf('\\');
            using FileStream fileStream = new FileStream("./" + this.username + "/" + parameters.Parameters[(filenameStart + 1)..], FileMode.OpenOrCreate);
            byte[] bytes = new byte[packetSize + sizeof(long)];
            long length = fileStream.Length;
            parameters.Socket.SendTo(BitConverter.GetBytes(length), parameters.DestinationIp);
            EndPoint remoteIp = new IPEndPoint(IPAddress.Any, 0);
            int byteRec;
            byteRec = parameters.Socket.ReceiveFrom(bytes, sizeof(long), SocketFlags.None, ref remoteIp);
            if (BitConverter.ToInt64(bytes[0..8]) == -1)
            {
                fileStream.Dispose();
                File.Delete("./" + this.username + "/" + parameters.Parameters[(filenameStart + 1)..]);
                return;
            }

            fileStream.Position = fileStream.Length;
            length = BitConverter.ToInt64(bytes[0..8]);
            (TimeSpan resendTime, byte[] data)[] cache = new (TimeSpan, byte[])[length / packetSize + (length % packetSize == 0 ? 0 : 1)];
            int blockSize = 64 * 4;
            long lastAckedPacket = 0;
            int counter = 0;
            long byteCounter = 0;
            long lostPacketNumber;
            TimeSpan lastReceiveTime = DateTime.UtcNow.TimeOfDay;
            parameters.Socket.Blocking = false;
            while (true)
            {
                if (parameters.Socket.Poll(1, SelectMode.SelectRead))
                {
                    byteRec = parameters.Socket.ReceiveFrom(bytes, bytes.Length, SocketFlags.None, ref remoteIp);
                    lastReceiveTime = DateTime.UtcNow.TimeOfDay;

                    var data = AckSystem.UnpackData(bytes, byteRec);

                    counter++;

                    byteCounter += data.data.Length;
                    cache[data.number].data = data.data;
                }


                if (counter - lastAckedPacket >= blockSize || (DateTime.UtcNow.TimeOfDay - lastReceiveTime).Ticks >= TimeSpan.TicksPerSecond)
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
                        AckSystem.SendAck(lastAckedPacket, parameters.Socket, parameters.DestinationIp);
                    }
                    else if (lostPacketNumber != -2)
                    {
                        AckSystem.RequestResend(lostPacketNumber, parameters.Socket, parameters.DestinationIp);
                    }
                }

                if (fileStream.Length == length && length != 0)
                {
                    break;
                }
            }

            parameters.Socket.Blocking = true;

            Console.WriteLine("Upload finished.");

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
