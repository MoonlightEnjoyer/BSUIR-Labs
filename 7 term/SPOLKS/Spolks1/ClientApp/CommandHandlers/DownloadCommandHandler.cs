using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace ClientApp.CommandHandlers
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
            using FileStream fileStream = new FileStream(parameters.Parameters, FileMode.OpenOrCreate);
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

            Console.WriteLine("Download finished.");
        }
    }
}
