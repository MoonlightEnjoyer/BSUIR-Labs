using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;
using ClientApp;

namespace ServerApp.CommandHandlers
{
    public class UploadCommandHandler : CommandHandlerBase
    {
        private string username;
        private IConfiguration configuration;

        public UploadCommandHandler(string username, IConfiguration configuration)
        {
            this.username = username;
            this.configuration = configuration;
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
            using FileStream fileStream = new FileStream(configuration["path"] + this.username + "/" + parameters.Parameters[(filenameStart + 1)..], FileMode.OpenOrCreate);
            byte[] bytes = new byte[packetSize + sizeof(long)];
            long length = fileStream.Length;
            parameters.Socket.SendTo(BitConverter.GetBytes(length), parameters.DestinationIp);
            EndPoint remoteIp = new IPEndPoint(IPAddress.Any, 0);
            int byteRec;
            byteRec = parameters.Socket.ReceiveFrom(bytes, sizeof(long), SocketFlags.None, ref remoteIp);
            if (BitConverter.ToInt64(bytes[0..8]) == -1)
            {
                fileStream.Dispose();
                File.Delete(configuration["path"] + this.username + "/" + parameters.Parameters[(filenameStart + 1)..]);
                return;
            }

            fileStream.Position = fileStream.Length;
            length = BitConverter.ToInt64(bytes[0..8]);
            byte[][] cache = new byte[length / packetSize + (length % packetSize == 0 ? 0 : 1)][];
            int blockSize = 64 * 4;
            long lastAckedPacket = 0;
            int counter = 0;
            long byteCounter = 0;
            byte[] rsBuf = new byte[10];
            long lostPacketNumber;
            while (true)
            {
                byteRec = parameters.Socket.ReceiveFrom(bytes, bytes.Length, SocketFlags.None, ref remoteIp);  
                var data = this.UnpackData(bytes, byteRec);

                counter++;

                byteCounter += data.data.Length;
                cache[data.number] = data.data;

                if (counter - lastAckedPacket >= blockSize)
                {
                    lostPacketNumber = CheckCache();
                    if (lostPacketNumber == -1)
                    {                            
                        for (long i = lastAckedPacket; i < counter + blockSize && i < cache.Length; i++)
                        {
                            fileStream.Write(cache[i]);
                        }

                        fileStream.Flush();
                        lastAckedPacket += blockSize;
                    }
                    else
                    {
                        Console.WriteLine("CheckCache: false");
                        rsBuf[0] = (byte)'R';
                        rsBuf[1] = (byte)'S';
                        var num = BitConverter.GetBytes(lostPacketNumber);
                        for (int i = 2; i < rsBuf.Length; i++)
                        {
                            rsBuf[i] = num[i - 2];
                        }

                        parameters.Socket.SendTo(rsBuf, parameters.DestinationIp);
                    }
                }
                else if (length - byteCounter == 0)
                {
                    lostPacketNumber = CheckCache();
                    if (lostPacketNumber == -1)
                    {
                        for (long i = lastAckedPacket; i < counter + blockSize && i < cache.Length; i++)
                        {
                            fileStream.Write(cache[i]);
                            fileStream.Flush();
                        }

                        lastAckedPacket += blockSize;
                    }
                    else
                    {
                        Console.WriteLine("CheckCache: false");
                        rsBuf[0] = (byte)'R';
                        rsBuf[1] = (byte)'S';
                        var num = BitConverter.GetBytes(lostPacketNumber);
                        for (int i = 2; i < rsBuf.Length; i++)
                        {
                            rsBuf[i] = num[i - 2];
                        }

                        parameters.Socket.SendTo(rsBuf, parameters.DestinationIp);
                    }
                }

                if (fileStream.Length == length && length != 0)
                {
                    break;
                }
                
            }
            
            Console.WriteLine("Upload finished.");

            long CheckCache()
            {
                int cacheCounter = 0;

                for (long i = lastAckedPacket; i < lastAckedPacket + blockSize && i < cache.Length; i++)
                {
                    if (cache[i] is null)
                    {
                        cache[i] = new byte[0];
                        return i;
                    }
                    else if (cache[i].Length == 0)
                    {
                        cache[i] = null;
                    }
                    else
                    {
                        cacheCounter++;
                    }
                }

                return -1;
            }
        }

        private (long number, byte[] data) UnpackData(byte[] data, int bytesRead)
        {
            byte[] result = data[8..bytesRead];
            var num = BitConverter.ToInt64(data[0..8]);

            return (num, result);
        }
    }
}
