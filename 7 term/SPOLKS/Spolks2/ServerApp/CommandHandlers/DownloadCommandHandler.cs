using ClientApp;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace ServerApp.CommandHandlers
{
    public class DownloadCommandHandler : CommandHandlerBase
    {
        private string username;

        public DownloadCommandHandler(string username)
        {
            this.username = username;
        }

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
            int packetSize = parameters.Socket.SendBufferSize - sizeof(long) - 128;
            byte[] buffer = new byte[packetSize];
            long lastAckedPacket = 0;
            long resendPacketNumber;
            TimeSpan lastReceiveTime;
            TimeSpan lastResponceTime;
            TimeSpan lastAckTime;
            int blockSize = 64 * 4;
            EndPoint remoteIp = parameters.DestinationIp;

            try
            {
                using FileStream fileStream = new FileStream("./" + this.username + "/" + parameters.Parameters, FileMode.Open);
                int bytesRead;
                long length = fileStream.Length;
                int recBytes;

                while (!parameters.Socket.Poll(1, SelectMode.SelectRead))
                {
                }
                recBytes = parameters.Socket.ReceiveFrom(buffer, sizeof(long), SocketFlags.None, ref remoteIp);

                fileStream.Position = BitConverter.ToInt64(buffer[0..8]);

                while (!parameters.Socket.Poll(1, SelectMode.SelectWrite))
                {
                }
                parameters.Socket.SendTo(BitConverter.GetBytes(fileStream.Length), remoteIp);
                long uploadSize = (fileStream.Length - fileStream.Position) * 8 / 1000000;
                long lastPos;
                long packetCounter = 0;
                //parameters.Socket.Blocking = false;
                byte[] ackBuf = new byte[11];
                lastReceiveTime = DateTime.UtcNow.TimeOfDay;
                lastResponceTime = DateTime.UtcNow.TimeOfDay;
                lastAckTime = DateTime.UtcNow.TimeOfDay;
                lastAckedPacket = fileStream.Position / packetSize;
                resendPacketNumber = lastAckedPacket;
                while (lastAckedPacket * packetSize < length)
                {
                    bytesRead = fileStream.Read(buffer, 0, buffer.Length);
                    if (bytesRead != 0)
                    {
                        var dataToSend = PackData(buffer, bytesRead, packetCounter, packetSize);
                        if (parameters.Socket.Poll(1, SelectMode.SelectWrite))
                        {
                            parameters.Socket.SendTo(dataToSend, SocketFlags.None, remoteIp);
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
                                parameters.Socket.SendTo(dataToSend, SocketFlags.None, remoteIp);
                            }
                            fileStream.Position = lastPos;
                        }
                        else if (byteRec == 11)
                        {
                            long ack = BitConverter.ToInt64(ackBuf[3..11]);
                            if (ack > lastAckedPacket)
                            {
                                lastAckedPacket = ack;
                                lastAckTime = DateTime.UtcNow.TimeOfDay;
                            }
                        }

                        lastResponceTime = DateTime.UtcNow.TimeOfDay;
                    }
                    else if ((DateTime.UtcNow.TimeOfDay - lastResponceTime).Ticks >= TimeSpan.TicksPerMillisecond * 1000 * 30)
                    {
                        Console.WriteLine("Disconnected.");
                        parameters.Socket.Shutdown(SocketShutdown.Both);
                        parameters.Socket.Close();
                        return;
                    }
                    else if ((DateTime.UtcNow.TimeOfDay - lastAckTime).Ticks >= TimeSpan.TicksPerMillisecond * 1000 * 10)
                    {
                        Console.WriteLine("ACK timeout");

                        if (resendPacketNumber >= lastAckedPacket + blockSize || resendPacketNumber * packetSize > length)
                        {
                            resendPacketNumber = lastAckedPacket;
                        }

                        AckSystem.ResendPacket(fileStream, resendPacketNumber++, packetSize, parameters.Socket, parameters.DestinationIp);


                        lastAckTime = DateTime.UtcNow.TimeOfDay;
                    }
                }

                //parameters.Socket.Blocking = true;


                Console.WriteLine("Download finished.");
                //int bytesRead;
                //int recBytes = parameters.Socket.Receive(buffer, sizeof(long), SocketFlags.None);
                //fileStream.Position = BitConverter.ToInt64(buffer[0..8]);
                //parameters.Socket.SendTo(BitConverter.GetBytes(fileStream.Length), parameters.DestinationIp);
                //do
                //{
                //    bytesRead = fileStream.Read(buffer, 0, buffer.Length);
                //    parameters.Socket.SendTo(buffer, bytesRead, SocketFlags.None, parameters.DestinationIp);
                //}
                //while (bytesRead > 0);
                //Console.WriteLine("Download finished.");
            }
            catch(FileNotFoundException exception)
            {
                parameters.Socket.SendTo(BitConverter.GetBytes(-1), parameters.DestinationIp);
                parameters.Socket.ReceiveFrom(buffer, sizeof(long), SocketFlags.None, ref remoteIp);
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
