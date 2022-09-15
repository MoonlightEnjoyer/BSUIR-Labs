using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace ServerApp.CommandHandlers
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
            int filenameStart = parameters.Parameters.LastIndexOf('\\');
            using FileStream fileStream = new FileStream(parameters.Parameters[(filenameStart + 1)..], FileMode.OpenOrCreate);
            byte[] bytes = new byte[1024];
            long length = fileStream.Length;
            parameters.Socket.Send(BitConverter.GetBytes(length));
            parameters.Socket.Receive(bytes, sizeof(long), SocketFlags.None);
            fileStream.Position = fileStream.Length;
            length = BitConverter.ToInt64(bytes[0..8]);
            
            while (parameters.Socket.Connected)
            {
                if (parameters.Socket.Available > 0)
                {
                    int byteRec = parameters.Socket.Receive(bytes, bytes.Length, SocketFlags.None);
                    fileStream.Write(bytes, 0, byteRec);
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
