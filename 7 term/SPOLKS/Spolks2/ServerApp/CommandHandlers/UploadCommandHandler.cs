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
            int filenameStart = parameters.Parameters.LastIndexOf('\\');
            using FileStream fileStream = new FileStream(configuration["path"] + this.username + "/" + parameters.Parameters[(filenameStart + 1)..], FileMode.OpenOrCreate);
            byte[] bytes = new byte[1024 + sizeof(int)];
            long length = fileStream.Length;
            parameters.Socket.SendTo(BitConverter.GetBytes(length), parameters.DestinationIp);
            EndPoint remoteIp = new IPEndPoint(IPAddress.Any, 0);
            parameters.Socket.ReceiveFrom(bytes, sizeof(long), SocketFlags.None, ref remoteIp);

            if (BitConverter.ToInt32(bytes[0..4]) == -1)
            {
                fileStream.Dispose();
                File.Delete(configuration["path"] + this.username + "/" + parameters.Parameters[(filenameStart + 1)..]);
                return;
            }

            fileStream.Position = fileStream.Length;
            length = BitConverter.ToInt64(bytes[0..8]);
            int byteRec;
            UdpReader udpReader = new UdpReader(parameters.Socket);
            while ((byteRec = parameters.Socket.ReceiveFrom(bytes, bytes.Length, SocketFlags.None, ref remoteIp)) > 0)
            {
                udpReader.SaveData(bytes[0..byteRec]);
                
                var dataToWrite = udpReader.GetPacketsFromCache();
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
            
            Console.WriteLine("Upload finished.");
        }
    }
}
