using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
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
                IPEndPoint ipEndPoint = new IPEndPoint(ipAddress, port);
                MySocket handler = new MySocket(ipAddress.AddressFamily, SocketType.Dgram, ProtocolType.Udp);
                handler.Bind(ipEndPoint);
                EndPoint remoteIp = new IPEndPoint(IPAddress.Any, 0);
                Console.WriteLine("Waiting for connection.");
                byte[] bytes = new byte[1024];
                int byteRec = handler.ReceiveFrom(bytes, ref remoteIp);
                handler.SendTo(new byte[0], remoteIp);
                string username = Encoding.UTF8.GetString(bytes[0..byteRec]);
                if (!Directory.Exists(username))
                {
                    Directory.CreateDirectory(username);
                }

                Console.WriteLine("Client connected.");

                List<string> messages = new List<string>() { string.Empty };
                bool messageEnded = true;
                int lastProcessedCommand = 0;
                while (!handler.isClosed)
                {
                    byteRec = handler.ReceiveFrom(bytes, ref remoteIp);
                    string data = Encoding.UTF8.GetString(bytes, 0, byteRec);

                    string[] splittedData = data.Split("\r\n");
                    messages[^1] += splittedData[0];
                    messages.AddRange(splittedData[1..]);


                    messageEnded = data.Length > 1 && data.LastIndexOf("\r\n") == data.Length - 2;
                    while (lastProcessedCommand < messages.Count - 1)
                    {
                        ExecuteCommand(messages[lastProcessedCommand++], username, handler, remoteIp);
                    }
                }
            }
            catch (SocketException exception)
            {
                Console.WriteLine(exception.Message);
            }
        }

        private void ExecuteCommand(string command, string username, MySocket socket, EndPoint destinationIp)
        {
            int startOfParams = command.IndexOf(' ');
            string commandName = startOfParams == -1? command : command[0..startOfParams];
            CloseCommandHandler closeCommandHandler = new CloseCommandHandler();
            EchoCommandHandler echoCommandHandler = new EchoCommandHandler();
            TimeCommandHandler timeCommandHandler = new TimeCommandHandler();
            DownloadCommandHandler downloadCommandHandler = new DownloadCommandHandler(username);
            UploadCommandHandler uploadCommandHandler = new UploadCommandHandler(username);
            closeCommandHandler.SetNext(echoCommandHandler);
            echoCommandHandler.SetNext(timeCommandHandler);
            timeCommandHandler.SetNext(downloadCommandHandler);
            downloadCommandHandler.SetNext(uploadCommandHandler);
            closeCommandHandler.Handle(new CommandParameters(commandName.ToUpper(), command[(startOfParams + 1)..], socket, destinationIp));
        }
    }
}
