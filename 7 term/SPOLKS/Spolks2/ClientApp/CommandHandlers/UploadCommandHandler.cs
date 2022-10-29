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
            byte[] buffer = new byte[1024];
            try
            {
                using FileStream fileStream = new FileStream(parameters.Parameters, FileMode.Open);
                int bytesRead;
                long length = fileStream.Length;
                int recBytes;
                recBytes = parameters.Socket.Receive(buffer, sizeof(long), SocketFlags.None);
                
                //Console.WriteLine("Received length from server.");
                fileStream.Position = BitConverter.ToInt64(buffer[0..8]);
                parameters.Socket.Send(BitConverter.GetBytes(fileStream.Length));
                //Console.WriteLine("Send length to server.");
                long uploadSize = (fileStream.Length - fileStream.Position) * 8 / 1000000;
                Stopwatch stopwatch = new Stopwatch();
                stopwatch.Start();
                long lastPos;
                long packetCounter = 0;
                Console.WriteLine("Socket.Bocking: " + parameters.Socket.Blocking);
                //UdpSender udpSender = new UdpSender(parameters.Socket, (int)fileStream.Length);
                do
                {
                    bytesRead = fileStream.Read(buffer, 0, buffer.Length);
                    parameters.Socket.Blocking = false;
                    if (bytesRead == 0)
                    {
                        break;
                    }
                    //Console.WriteLine("Data from file length: " + bytesRead);
                    //var dataToSend = udpSender.SendData(buffer[0..bytesRead]);
                    //Console.WriteLine("Data to send length: " + dataToSend.Length);
                    var dataToSend = PackData(buffer, packetCounter);
                    parameters.Socket.Send(dataToSend, SocketFlags.None);
                    packetCounter++;
                    byte[] ackBuf = new byte[11];
                    if (parameters.Socket.Poll(100, SelectMode.SelectRead))
                    {
                        int byteRec = parameters.Socket.Receive(ackBuf);
                        if (byteRec > 0)
                        {
                            //resend;
                            lastPos = fileStream.Position;
                            fileStream.Position = BitConverter.ToInt64(ackBuf[3..11]) * 1024;
                            bytesRead = fileStream.Read(buffer, 0, buffer.Length);
                            dataToSend = PackData(buffer, BitConverter.ToInt64(ackBuf[3..11]));
                            parameters.Socket.Send(dataToSend, SocketFlags.None);
                            fileStream.Position = lastPos;
                        }
                    }
                    parameters.Socket.Blocking = true;
                    //Console.WriteLine("Send data to server.");
                    //Console.WriteLine("Data length: " + dataToSend.Length);

                    //udpSender.Ack();

                }
                while (bytesRead > 0);

                //while(udpSender.lastAckedPacketNumber < udpSender.length)
                //{
                //    udpSender.Ack();
                //}
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
            catch(Exception exception)
            {
                Console.WriteLine(exception.Message);
            }
        }

        public byte[] PackData(byte[] data, long packetNumber)
        {
            byte[] result = new byte[data.Length + sizeof(long)];
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
