using ClientApp;
using System.Net;
using System.Net.Sockets;

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
                recBytes = parameters.Socket.ReceiveFrom(buffer, SocketFlags.None, ref remoteIp);

                fileStream.Position = BitConverter.ToInt64(buffer[0..8]);

                while (!parameters.Socket.Poll(1, SelectMode.SelectWrite))
                {
                }
                parameters.Socket.SendTo(BitConverter.GetBytes(fileStream.Length), remoteIp);
                long uploadSize = (fileStream.Length - fileStream.Position) * 8 / 1000000;
                long lastPos;
                long packetCounter = 0;
                byte[] ackBuf = new byte[11];
                lastAckTime = DateTime.UtcNow.TimeOfDay;
                lastReceiveTime = lastAckTime;
                lastResponceTime = lastAckTime;
                lastAckedPacket = fileStream.Position / packetSize;
                resendPacketNumber = lastAckedPacket;
                while (lastAckedPacket * packetSize < length)
                {
                    bytesRead = fileStream.Read(buffer, 0, buffer.Length);
                    if (bytesRead != 0)
                    {
                        var dataToSend = AckSystem.PackData(buffer, bytesRead, packetCounter, packetSize);
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
                            AckSystem.ResendPacket(fileStream, BitConverter.ToInt64(ackBuf[2..10]), packetSize, parameters.Socket, parameters.DestinationIp);
                        }
                        else if (byteRec == 11)
                        {
                            long ack = BitConverter.ToInt64(ackBuf[3..11]);
                            if (ack == lastAckedPacket + blockSize)
                            {
                                lastAckedPacket = ack;
                                resendPacketNumber = lastAckedPacket;
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

                Console.WriteLine("Download finished.");
            }
            catch(FileNotFoundException)
            {
                while (!parameters.Socket.Poll(1, SelectMode.SelectRead))
                {
                }
                parameters.Socket.ReceiveFrom(buffer, SocketFlags.None, ref remoteIp);

                while (!parameters.Socket.Poll(1, SelectMode.SelectWrite))
                {
                }
                parameters.Socket.SendTo(BitConverter.GetBytes(-1), parameters.DestinationIp);
            }
        }
    }
}
