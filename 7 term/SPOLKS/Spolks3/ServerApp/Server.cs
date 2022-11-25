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
                
                int currentClient = -1;
                byte[] bytes = new byte[128];
                int byteRec = 0;

                while (true)
                {
                    currentClient++;

                    if (currentClient >= clients.Count)
                    {
                        currentClient = 0;.......
                    }

                    AddClient(clients, socket);

                    if (clients.Count == 0)
                    {
                        continue;
                    }

                    foreach (var client in clients)
                    {
                        if (client.LastReceivedMessage is not null || client.Context.Parameters?.CommandName is not null)
                        {
                            continue;
                        }

                        client.Socket.Blocking = false;
                        if (!client.Socket.Poll(100, SelectMode.SelectRead) && client.LastReceivedMessage is null && client.Context.Parameters?.CommandName is null)
                        {
                            client.Socket.Blocking = true;
                            continue;
                        }

                        if (!client.Socket.Poll(100, SelectMode.SelectRead))
                        {
                            client.Socket.Blocking = true;
                            continue;
                        }

                        client.Socket.Blocking = true;

                        byteRec = client.Socket.Receive(bytes);//read command

                        client.LastReceivedMessage = Encoding.UTF8.GetString(bytes, 0, byteRec);
                    }


                    for (int i = currentClient; i < clients.Count; i++)
                    {
                        if (clients[i].LastReceivedMessage is not null)
                        {
                            clients[i].LastReceivedMessage = clients[i].LastReceivedMessage.Replace("\r\n", string.Empty);

                            ExecuteCommand(clients[i], clients);
                            if (i < clients.Count)
                            {
                                clients[i].LastReceivedMessage = null;
                            }
                            break;
                        }
                        else if (clients[i].Context.Parameters?.CommandName is not null)
                        {
                            ExecuteCommand(clients[i], clients);
                            break;
                        }
                    }
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
            byte[] bytes = new byte[25];
            int byteRec = handler.Receive(bytes);//read username
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

        private void ExecuteCommand(Client client, List<Client> clients)
        {
            if (client.Context.Parameters is null)
            {
                client.Context.Parameters = new CommandParameters();
                int startOfParams = client.LastReceivedMessage.IndexOf(' ');
                string commandName = startOfParams == -1 ? client.LastReceivedMessage : client.LastReceivedMessage[0..startOfParams];
                client.Context.Parameters.CommandName = commandName.ToUpper();
                client.LastReceivedMessage = client.LastReceivedMessage[(startOfParams + 1)..];
                client.Context.Parameters.Socket = client.Socket;
            }

            if (client.Context.Parameters?.CommandName is null)
            {
                int startOfParams = client.LastReceivedMessage.IndexOf(' ');
                string commandName = startOfParams == -1 ? client.LastReceivedMessage : client.LastReceivedMessage[0..startOfParams];
                client.Context.Parameters.CommandName = commandName.ToUpper();
                client.LastReceivedMessage = client.LastReceivedMessage[(startOfParams + 1)..];
            }
            
            CloseCommandHandler closeCommandHandler = new CloseCommandHandler();
            EchoCommandHandler echoCommandHandler = new EchoCommandHandler();
            TimeCommandHandler timeCommandHandler = new TimeCommandHandler();
            DownloadCommandHandler downloadCommandHandler = new DownloadCommandHandler(client.Username);
            UploadCommandHandler uploadCommandHandler = new UploadCommandHandler(client.Username);
            closeCommandHandler.SetNext(echoCommandHandler);
            echoCommandHandler.SetNext(timeCommandHandler);
            timeCommandHandler.SetNext(downloadCommandHandler);
            downloadCommandHandler.SetNext(uploadCommandHandler);
            client.Context.Parameters = new CommandParameters(client.Context.Parameters.CommandName, client.LastReceivedMessage, client.Socket);
            var result = closeCommandHandler.Handle(client) as Client;

            if (result is not null)
            {
                Console.WriteLine("Client disconnected.");
                clients.RemoveAt(clients.FindIndex(c => c.Username == result.Username));
            }
        }
    }
}
