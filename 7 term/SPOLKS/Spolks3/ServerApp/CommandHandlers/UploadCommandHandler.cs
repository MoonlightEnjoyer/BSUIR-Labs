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
        private string username;

        private UploadData uploadData;

        public UploadCommandHandler(string username)
        {
            this.username = username;
        }

        public override bool CanHandle(string commandName)
        {
            return commandName == "UPLOAD";
        }

        public override void Handle(Client client)
        {
            if (CanHandle(client.Context.Parameters.CommandName))
            {
                Upload(client);
            }
            else
            {
                base.Handle(client);
            }
        }

        private void Upload(Client client)
        {
            int packetSize = client.Socket.ReceiveBufferSize / 2;
            int filenameStart;
            string filename;
            byte[] bytes = new byte[packetSize];
            long length;
            //Console.WriteLine("Upload started.");
            //FileStream fileStream;

            if (client.Context.CommandExecutionData is not null)
            {
                uploadData = client.Context.CommandExecutionData as UploadData;
                length = uploadData.length;
                filename = uploadData.filename;
            }
            else
            {
                filenameStart = client.Context.Parameters.Parameters.LastIndexOf('\\');
                filename = "./" + this.username + "/" + client.Context.Parameters.Parameters[(filenameStart + 1)..];
                using FileStream fileStream1 = new FileStream(filename, FileMode.OpenOrCreate);
                length = fileStream1.Length;

                client.Context.Parameters.Socket.Send(BitConverter.GetBytes(length));
                client.Context.Parameters.Socket.Receive(bytes, sizeof(long), SocketFlags.None);

                if (BitConverter.ToInt32(bytes[0..4]) == -1)
                {
                    fileStream1.Dispose();
                    File.Delete("./" + this.username + "/" + client.Context.Parameters.Parameters[(filenameStart + 1)..]);
                    return;
                }

                fileStream1.Position = fileStream1.Length;
                length = BitConverter.ToInt64(bytes[0..8]);
                uploadData = new UploadData()
                { length = length, filename = filename };

                client.Context.CommandExecutionData = uploadData;
            }

            using FileStream fileStream = new FileStream(filename, FileMode.OpenOrCreate);
            fileStream.Position = uploadData.position;

            int counter = 0;

            while (client.Context.Parameters.Socket.Connected)
            {
                
                int byteRec = client.Context.Parameters.Socket.Receive(bytes, bytes.Length, SocketFlags.None);
                //Console.WriteLine($"Socket receive buffer: {client.Context.Parameters.Socket.ReceiveBufferSize}");
                //Console.WriteLine($"Received bytes {byteRec}");
                fileStream.Write(bytes, 0, byteRec);
                fileStream.Flush();
                uploadData.position = fileStream.Length;

                if (fileStream.Length == length && length != 0)
                {
                    break;
                }

                counter++;
                if (counter == 4)
                {
                    return;
                }
            }

            //after upload is completed
            client.Context.Parameters.CommandName = null;
            client.Context.Parameters = null;
            client.Context.CommandExecutionData = null;

            Console.WriteLine("Upload finished.");
        }
    }

    class UploadData
    {
        public string filename;
        public long length;
        public long position;
    }
}
