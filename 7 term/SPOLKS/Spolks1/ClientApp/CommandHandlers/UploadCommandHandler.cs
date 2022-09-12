using System;
using System.Collections.Generic;
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
            using FileStream fileStream = new FileStream(parameters.Parameters, FileMode.Open);
            byte[] buffer = new byte[1024];
            int bytesRead;
            long length = fileStream.Length;
            int recBytes = parameters.Socket.Receive(buffer, sizeof(long), SocketFlags.None);
            fileStream.Position = BitConverter.ToInt64(buffer[0..8]);
            parameters.Socket.Send(BitConverter.GetBytes(fileStream.Length));
            do
            {
                bytesRead = fileStream.Read(buffer, 0, buffer.Length);
                parameters.Socket.Send(buffer, bytesRead, SocketFlags.None);
            }
            while (bytesRead > 0);
            Console.WriteLine("Upload finished.");
        }
    }
}
