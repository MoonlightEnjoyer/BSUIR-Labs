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
            int packetSize = parameters.Socket.ReceiveBufferSize / 2;
            byte[] buffer = new byte[packetSize];
            try
            {
                using FileStream fileStream = new FileStream(parameters.Parameters, FileMode.Open);
                int bytesRead;
                long length = fileStream.Length;
                int recBytes = parameters.Socket.Receive(buffer, sizeof(long), SocketFlags.None);
                fileStream.Position = BitConverter.ToInt64(buffer[0..8]);
                parameters.Socket.Send(BitConverter.GetBytes(fileStream.Length));
                long uploadSize = (fileStream.Length - fileStream.Position) * 8 / 1000000;
                Stopwatch stopwatch = new Stopwatch();
                stopwatch.Start();
                do
                {
                    bytesRead = fileStream.Read(buffer, 0, buffer.Length);
                    parameters.Socket.Send(buffer, bytesRead, SocketFlags.None);
                }
                while (bytesRead > 0);
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
