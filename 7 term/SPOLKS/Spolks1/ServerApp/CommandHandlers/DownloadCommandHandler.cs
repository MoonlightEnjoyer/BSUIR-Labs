using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace ServerApp.CommandHandlers
{
    public class DownloadCommandHandler : CommandHandlerBase
    {
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
            using FileStream fileStream = new FileStream(parameters.Parameters, FileMode.Open);
            byte[] buffer = new byte[1024];
            int bytesRead;
            int recBytes = parameters.Socket.Receive(buffer, sizeof(long), SocketFlags.None);
            fileStream.Position = BitConverter.ToInt64(buffer[0..8]);
            parameters.Socket.Send(BitConverter.GetBytes(fileStream.Length));
            do
            {
                bytesRead = fileStream.Read(buffer, 0, buffer.Length);
                parameters.Socket.Send(buffer, bytesRead, SocketFlags.None);
            }
            while(bytesRead > 0);
            Console.WriteLine("Download finished.");
        }
    }
}
