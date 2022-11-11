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
                IPEndPoint iPEndPoint = new IPEndPoint(ipAddress, port);
                Socket socket = new Socket(ipAddress.AddressFamily, SocketType.Stream, ProtocolType.Tcp);
                socket.Bind(iPEndPoint);
                socket.Listen(10);
                Console.WriteLine("Waiting for connection.");
                
                List<Client> clients = new List<Client>();
                

                

                List<string> messages = new List<string>() { string.Empty };
                bool messageEnded = true;
                int lastProcessedCommand = 0;
                int currentClient = 0;
                byte[] bytes = new byte[1024];
                int byteRec = 0;

                while (true)
                {
                    AddClient(clients, socket);

                    if (clients.Count == 0)
                    {
                        continue;
                    }

                    if (!clients[currentClient].Socket.Connected)
                    {
                        Console.WriteLine("Client disconnected.");
                        return;
                    }

                    foreach (var client in clients)
                    {
                        client.Socket.Blocking = false;
                        if (!client.Socket.Poll(1, SelectMode.SelectRead))
                        {
                            client.Message = null;
                            client.Socket.Blocking = true;
                            continue;
                        }

                        byteRec = client.Socket.Receive(bytes);

                        client.Socket.Blocking = true;

                        client.Message = Encoding.UTF8.GetString(bytes, 0, byteRec);
                    }


                    //check context is null

                    //check message is null

                    var data = clients[currentClient].Message;
                    string[] splittedData = data.Split("\r\n");
                    messages[^1] += splittedData[0];
                    messages.AddRange(splittedData[1..]);


                    messageEnded = data.Length > 1 && data.LastIndexOf("\r\n") == data.Length - 2;
                    while (lastProcessedCommand < messages.Count - 1)
                    {
                        ExecuteCommand(messages[lastProcessedCommand++], clients[currentClient].Username, clients[currentClient].Socket);
                        currentClient++;

                        if (currentClient >= clients.Count)
                        {
                            currentClient = 0;
                        }
                    }

                    Console.WriteLine(currentClient);
                }
            }
            catch (SocketException exception)
            {
                Console.WriteLine(exception.Message);
            }
        }

        private void AddClient(List<Client> clients, Socket listener)
        {
            listener.Blocking = false;
            if (!listener.Poll(1, SelectMode.SelectRead))
            {
                listener.Blocking = true;
                return;
            }

            Socket handler = listener.Accept();

            listener.Blocking = true;
            handler.Blocking = true;
            byte[] bytes = new byte[1024];
            int byteRec = handler.Receive(bytes);
            string username = Encoding.UTF8.GetString(bytes[0..byteRec]);
            if (!Directory.Exists(username))
            {
                Directory.CreateDirectory(username);
            }

            handler.SetSocketOption(SocketOptionLevel.Socket, SocketOptionName.KeepAlive, 1);
            handler.SetSocketOption(SocketOptionLevel.Tcp, SocketOptionName.TcpKeepAliveTime, 30);
            Console.WriteLine("Client connected.");

            clients.Add(new Client() { Socket = handler, Username = username });
        }

        private void ExecuteCommand(string command, string username, Socket socket)
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
            closeCommandHandler.Handle(new CommandParameters(commandName.ToUpper(), command[(startOfParams + 1)..], socket));
        }
    }
}
