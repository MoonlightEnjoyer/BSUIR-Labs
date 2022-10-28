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

        //if i get packets from next block ==> call GetPacketsFromCache(). Do it inside SaveData method.
        private void Upload(CommandParameters parameters)
        {
            int filenameStart = parameters.Parameters.LastIndexOf('\\');
            using FileStream fileStream = new FileStream(configuration["path"] + this.username + "/" + parameters.Parameters[(filenameStart + 1)..], FileMode.OpenOrCreate);
            byte[] bytes = new byte[1024 + sizeof(int)];
            long length = fileStream.Length;
            parameters.Socket.SendTo(BitConverter.GetBytes(length), parameters.DestinationIp);
            //Console.WriteLine("Send length to client.");
            EndPoint remoteIp = new IPEndPoint(IPAddress.Any, 0);
            int byteRec;
            while ((byteRec = parameters.Socket.ReceiveFrom(bytes, sizeof(long), SocketFlags.None, ref remoteIp)) == 0)
            { }
            //Console.WriteLine("Received length from client.");
            if (BitConverter.ToInt32(bytes[0..4]) == -1)
            {
                fileStream.Dispose();
                File.Delete(configuration["path"] + this.username + "/" + parameters.Parameters[(filenameStart + 1)..]);
                return;
            }

            fileStream.Position = fileStream.Length;
            length = BitConverter.ToInt64(bytes[0..8]);
            //Console.WriteLine("Length: " + length);
            UdpReader udpReader = new UdpReader(parameters.Socket, (int)(length - fileStream.Position));
            int counter = 0;
            while (true)
            {
                byteRec = parameters.Socket.ReceiveFrom(bytes, bytes.Length, SocketFlags.None, ref remoteIp);
                //while ((byteRec = parameters.Socket.ReceiveFrom(bytes, bytes.Length, SocketFlags.None, ref remoteIp)) == 0)
                //{
                Console.WriteLine("Receive data from client.");
                counter += byteRec;
                Console.WriteLine(counter);
                //}
                if (byteRec > 0)
                {
                    
                    udpReader.SaveData(bytes[0..byteRec]);

                    if (fileStream.Length == length && length != 0)
                    {
                        break;
                    }
                }
                else
                {
                    Console.WriteLine("received 0 bytes.");
                    var dataToWrite = udpReader.GetPacketsFromCache(parameters.DestinationIp);
                    if (dataToWrite is not null)
                    {
                        fileStream.Write(dataToWrite);
                        fileStream.Flush();
                    }

                    if (fileStream.Length == length && length != 0)
                    {
                        break;
                    }
                }
            }
            
            Console.WriteLine("Upload finished.");
        }
    }
}
