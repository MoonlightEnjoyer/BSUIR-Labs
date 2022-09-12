using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;
using ServerApp.CommandHandlers;

namespace ServerApp
{
    public sealed class Server
    {
        private Server(byte[] ipAddress, int port)
        {
            this.ipAddress = new IPAddress(ipAddress);
            this.port = port;
        }

        private static Server instance;

        private IPAddress ipAddress;

        private int port;


        public static Server GetInstance(string ipAddress, string port)
        {
            if (instance is null)
            {
                instance = new Server(
                    ipAddress.Split('.').Select(n => byte.Parse(n)).ToArray(),
                    int.Parse(port));
            }

            return instance;
        }

        public void StartListening()
        {
            IPEndPoint iPEndPoint = new IPEndPoint(ipAddress, port);
            Socket socket = new Socket(ipAddress.AddressFamily, SocketType.Stream, ProtocolType.Tcp);
            socket.Bind(iPEndPoint);
            socket.Listen(10);
            Console.WriteLine("Waiting for connection.");
            Socket handler = socket.Accept();
            Console.WriteLine("Client connected.");
            byte[] bytes = new byte[1024];
            List<string> messages = new List<string>() { string.Empty };
            bool messageEnded = true;
            int lastProcessedCommand = 0;
            while (true)
            {
                if (!handler.Connected)
                {
                    Console.WriteLine("Waiting for connection.");
                    handler = socket.Accept();
                    Console.WriteLine("Client connected.");
                    continue;
                }
                int byteRec = handler.Receive(bytes);
                string data = Encoding.UTF8.GetString(bytes, 0, byteRec);

                string[] splittedData = data.Split("\r\n");
                messages[^1] += splittedData[0];
                messages.AddRange(splittedData[1..]);


                messageEnded = data.Length > 1 && data.LastIndexOf("\r\n") == data.Length - 2;
                while (lastProcessedCommand < messages.Count - 1)
                {
                    ExecuteCommand(messages[lastProcessedCommand++], handler);
                }
            }
        }

        private void ExecuteCommand(string command, Socket socket)
        {
            int startOfParams = command.IndexOf(' ');
            string commandName = startOfParams == -1? command : command[0..startOfParams];
            CloseCommandHandler closeCommandHandler = new CloseCommandHandler();
            EchoCommandHandler echoCommandHandler = new EchoCommandHandler();
            TimeCommandHandler timeCommandHandler = new TimeCommandHandler();
            DownloadCommandHandler downloadCommandHandler = new DownloadCommandHandler();
            UploadCommandHandler uploadCommandHandler = new UploadCommandHandler();
            closeCommandHandler.SetNext(echoCommandHandler);
            echoCommandHandler.SetNext(timeCommandHandler);
            timeCommandHandler.SetNext(downloadCommandHandler);
            downloadCommandHandler.SetNext(uploadCommandHandler);
            closeCommandHandler.Handle(new CommandParameters(commandName.ToUpper(), command[(startOfParams + 1)..], socket));
        }
    }
}
