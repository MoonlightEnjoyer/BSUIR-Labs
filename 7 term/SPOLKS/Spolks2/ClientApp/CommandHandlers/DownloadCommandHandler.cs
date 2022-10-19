using System;
using System.Collections.Generic;
using System.Diagnostics;
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
            if (BitConverter.ToInt32(bytes[0..4]) == -1)
            {
                fileStream.Dispose();
                File.Delete(parameters.Parameters);
                Console.WriteLine("File not found.");
                return;
            }

            fileStream.Position = fileStream.Length;
            length = BitConverter.ToInt64(bytes[0..8]);
            long uploadSize = (length - fileStream.Position) * 8 / 1000000;
            Stopwatch stopwatch = new Stopwatch();
            stopwatch.Start();
            int byteRec = 0;
            while ((byteRec = parameters.Socket.Receive(bytes, bytes.Length, SocketFlags.None)) > 0)
            {
                fileStream.Write(bytes, 0, byteRec);
                fileStream.Flush();
            }
            stopwatch.Stop();
            Console.WriteLine($"Bitrate: {uploadSize / stopwatch.Elapsed.TotalSeconds} mb/s");
            Console.WriteLine("Download finished.");
        }
    }
}
