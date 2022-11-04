using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace ClientApp.CommandHandlers
{
    public class UploadCommandHandler : CommandHandlerBase
    {
        

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
            int packetSize = parameters.Socket.SendBufferSize - sizeof(long) - 128;
            byte[] buffer = new byte[packetSize];
            long lastAckedPacket = 0;
            TimeSpan lastReceiveTime;
            try
            {
                using FileStream fileStream = new FileStream(parameters.Parameters, FileMode.Open);
                int bytesRead;
                long length = fileStream.Length;
                int recBytes;
                recBytes = parameters.Socket.Receive(buffer, sizeof(long), SocketFlags.None);
                
                fileStream.Position = BitConverter.ToInt64(buffer[0..8]);
                parameters.Socket.Send(BitConverter.GetBytes(fileStream.Length));
                long uploadSize = (fileStream.Length - fileStream.Position) * 8 / 1000000;
                Stopwatch stopwatch = new Stopwatch();
                stopwatch.Start();
                long lastPos;
                long packetCounter = 0;
                parameters.Socket.Blocking = false;
                byte[] ackBuf = new byte[11];
                lastReceiveTime = DateTime.UtcNow.TimeOfDay;
                lastAckedPacket = 0;
                while (lastAckedPacket * packetSize < length)
                {
                    bytesRead = fileStream.Read(buffer, 0, buffer.Length);
                    if (bytesRead != 0)
                    {
                        var dataToSend = PackData(buffer, bytesRead, packetCounter, packetSize);
                        if (parameters.Socket.Poll(1, SelectMode.SelectWrite))
                        {
                            parameters.Socket.Send(dataToSend, SocketFlags.None);
                        }

                        packetCounter++;
                    }
                    
                    if (parameters.Socket.Poll(1, SelectMode.SelectRead))
                    {
                        int byteRec = parameters.Socket.Receive(ackBuf);
                        if (byteRec == 10)
                        {
                            lastPos = fileStream.Position;
                            fileStream.Position = BitConverter.ToInt64(ackBuf[2..10]) * packetSize;
                            bytesRead = fileStream.Read(buffer, 0, buffer.Length);
                            var dataToSend = PackData(buffer, bytesRead, BitConverter.ToInt64(ackBuf[2..10]), packetSize);
                            
                            if (parameters.Socket.Poll(1, SelectMode.SelectWrite))
                            {
                                parameters.Socket.Send(dataToSend, SocketFlags.None);
                            }
                            fileStream.Position = lastPos;
                        }
                        else if (byteRec == 11)
                        {
                            long ack = BitConverter.ToInt64(ackBuf[3..11]);
                            if (ack > lastAckedPacket)
                            {
                                lastAckedPacket = ack;
                            }
                        }
                    }
                }

                parameters.Socket.Blocking = true;
                

                stopwatch.Stop();
                Console.WriteLine($"Bitrate: {uploadSize / stopwatch.Elapsed.TotalSeconds} mb/s");
                Console.WriteLine("Upload finished.");
            }
            catch(FileNotFoundException exception)
            {
                parameters.Socket.Send(BitConverter.GetBytes(-1));
                parameters.Socket.Receive(buffer, sizeof(long), SocketFlags.None);
                Console.WriteLine("File not found.");
            }
        }

        public byte[] PackData(byte[] data, int bytesRead, long packetNumber, int packetSize)
        {
            byte[] result = new byte[bytesRead + sizeof(long)];
            var num = BitConverter.GetBytes(packetNumber);
            for (int i = 0; i < num.Length; i++)
            {
                result[i] = num[i];
            }

            for (int i = num.Length; i < result.Length; i++)
            {
                result[i] = data[i - num.Length];
            }

            return result;
        }
    }
}
