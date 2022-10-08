using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using Microsoft.Extensions.Configuration;
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
            try
            {
                IPEndPoint iPEndPoint = new IPEndPoint(ipAddress, port);
                Socket handler = new Socket(ipAddress.AddressFamily, SocketType.Dgram, ProtocolType.Udp);
                handler.Bind(iPEndPoint);
                
                Console.WriteLine("Waiting for connection.");
                byte[] bytes = new byte[1024];
                int byteRec = handler.Receive(bytes);
                string username = Encoding.UTF8.GetString(bytes[0..byteRec]);
                if (!Directory.Exists(username))
                {
                    Directory.CreateDirectory(username);
                }

                Console.WriteLine("Client connected.");

                List<string> messages = new List<string>() { string.Empty };
                bool messageEnded = true;
                int lastProcessedCommand = 0;
                while (true)
                {
                    byteRec = handler.Receive(bytes);
                    string data = Encoding.UTF8.GetString(bytes, 0, byteRec);

                    string[] splittedData = data.Split("\r\n");
                    messages[^1] += splittedData[0];
                    messages.AddRange(splittedData[1..]);


                    messageEnded = data.Length > 1 && data.LastIndexOf("\r\n") == data.Length - 2;
                    while (lastProcessedCommand < messages.Count - 1)
                    {
                        ExecuteCommand(messages[lastProcessedCommand++], username, handler);
                    }
                }
            }
            catch (SocketException exception)
            {
                Console.WriteLine(exception.Message);
            }
        }

        private void ExecuteCommand(string command, string username, Socket socket)
        {
            var config = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build();
            int startOfParams = command.IndexOf(' ');
            string commandName = startOfParams == -1? command : command[0..startOfParams];
            CloseCommandHandler closeCommandHandler = new CloseCommandHandler();
            EchoCommandHandler echoCommandHandler = new EchoCommandHandler();
            TimeCommandHandler timeCommandHandler = new TimeCommandHandler();
            DownloadCommandHandler downloadCommandHandler = new DownloadCommandHandler(username, config);
            UploadCommandHandler uploadCommandHandler = new UploadCommandHandler(username, config);
            closeCommandHandler.SetNext(echoCommandHandler);
            echoCommandHandler.SetNext(timeCommandHandler);
            timeCommandHandler.SetNext(downloadCommandHandler);
            downloadCommandHandler.SetNext(uploadCommandHandler);
            closeCommandHandler.Handle(new CommandParameters(commandName.ToUpper(), command[(startOfParams + 1)..], socket));
        }
    }
}
