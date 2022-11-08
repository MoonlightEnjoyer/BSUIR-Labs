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
            int blockSize = 64 * 4;
            long resendPacketNumber;
            TimeSpan lastAckTime;
            TimeSpan lastResponceTime;
            try
            {
                using FileStream fileStream = new FileStream(parameters.Parameters, FileMode.Open);
                int bytesRead;
                long length = fileStream.Length;
                int recBytes;
                while (!parameters.Socket.Poll(1, SelectMode.SelectRead))
                {
                }
                recBytes = parameters.Socket.Receive(buffer, sizeof(long), SocketFlags.None);
                
                fileStream.Position = BitConverter.ToInt64(buffer[0..8]);
                while (!parameters.Socket.Poll(1, SelectMode.SelectWrite))
                {
                }
                parameters.Socket.Send(BitConverter.GetBytes(fileStream.Length));
                long uploadSize = (fileStream.Length - fileStream.Position) * 8 / 1000000;
                Stopwatch stopwatch = new Stopwatch();
                stopwatch.Start();
                long lastPos;
                long packetCounter = 0;
                parameters.Socket.Blocking = false;
                byte[] ackBuf = new byte[11];
                lastAckTime = DateTime.UtcNow.TimeOfDay;
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
                            parameters.Socket.Send(dataToSend, SocketFlags.None);
                        }

                        packetCounter++;
                    }

                    //Console.WriteLine($"{(DateTime.UtcNow.TimeOfDay - lastAckTime).Ticks} : {TimeSpan.TicksPerMillisecond * 1000 * 10}");
                    
                    if (parameters.Socket.Poll(1, SelectMode.SelectRead))
                    {
                        int byteRec = parameters.Socket.Receive(ackBuf);
                        if (byteRec == 10)
                        {
                            AckSystem.ResendPacket(fileStream, BitConverter.ToInt64(ackBuf[2..10]), packetSize, parameters.Socket);
                        }
                        else if (byteRec == 11)
                        {
                            long ack = BitConverter.ToInt64(ackBuf[3..11]);
                            if (ack > lastAckedPacket)
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
                        
                        AckSystem.ResendPacket(fileStream, resendPacketNumber++, packetSize, parameters.Socket);
                        

                        lastAckTime = DateTime.UtcNow.TimeOfDay;
                    }
                }

                //parameters.Socket.Blocking = true;
                

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

        
    }
}
