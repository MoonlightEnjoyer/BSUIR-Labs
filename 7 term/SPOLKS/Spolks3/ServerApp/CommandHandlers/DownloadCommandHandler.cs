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
        private string username;

        private DownloadData downloadData;

        public DownloadCommandHandler(string username)
        {
            this.username = username;
        }

        public override bool CanHandle(string commandName)
        {
            return commandName == "DOWNLOAD";
        }

        public override object Handle(Client client)
        {
            if (CanHandle(client.Context.Parameters.CommandName))
            {
                Download(client);
            }
            else
            {
                return base.Handle(client);
            }

            return null;
        }

        private void Download(Client client)
        {
            int packetSize = client.Socket.ReceiveBufferSize / 2;
            int filenameStart;
            string filename;
            byte[] buffer = new byte[packetSize];
            long length;
            int recBytes;

            try
            {
                if (client.Context.CommandExecutionData is not null)
                {
                    downloadData = client.Context.CommandExecutionData as DownloadData;
                    length = downloadData.length;
                    filename = downloadData.filename;
                }
                else
                {
                    filenameStart = client.Context.Parameters.Parameters.LastIndexOf('\\');
                    filename = "./" + this.username + "/" + client.Context.Parameters.Parameters[(filenameStart + 1)..];
                    using FileStream fileStream1 = new FileStream(filename, FileMode.OpenOrCreate);
                    length = fileStream1.Length;

                    recBytes = client.Socket.Receive(buffer, sizeof(long), SocketFlags.None);
                    long position = BitConverter.ToInt64(buffer[0..8]);
                    client.Socket.Send(BitConverter.GetBytes(fileStream1.Length));

                    if (BitConverter.ToInt32(buffer[0..4]) == -1)
                    {
                        fileStream1.Dispose();
                        File.Delete(filename);
                        return;
                    }

                    fileStream1.Position = fileStream1.Length;
                    length = BitConverter.ToInt64(buffer[0..8]);
                    downloadData = new DownloadData()
                    { length = length, filename = filename, position = position };

                    client.Context.CommandExecutionData = downloadData;
                }



                using FileStream fileStream = new FileStream(filename, FileMode.Open);
                int bytesRead;
                fileStream.Position = downloadData.position;
                int counter = 0;

                do
                {
                    bytesRead = fileStream.Read(buffer, 0, buffer.Length);
                    downloadData.position += bytesRead;
                    client.Socket.Send(buffer, bytesRead, SocketFlags.None);

                    counter++;
                    if (counter == 4)
                    {
                        return;
                    }
                }
                while (bytesRead > 0);

                client.Context.Parameters.CommandName = null;
                client.Context.Parameters = null;
                client.Context.CommandExecutionData = null;
                Console.WriteLine("Download finished.");
            }
            catch(FileNotFoundException exception)
            {
                client.Socket.Send(BitConverter.GetBytes(-1));
                client.Socket.Receive(buffer, sizeof(long), SocketFlags.None);
            }
        }
    }

    class DownloadData
    {
        public string filename;
        public long length;
        public long position;
    }
}
