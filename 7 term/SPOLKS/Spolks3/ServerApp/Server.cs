﻿using System;
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
                    if (currentClient >= clients.Count)
                    {
                        currentClient = 0;
                    }

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

                    //read message for every client if clients last received message is null and clients context is null (=> client doesn't have command to execute and server didn't execute any commands for this client at previous client-time)
                    foreach (var client in clients)
                    {
                        if (clients[currentClient].LastReceivedMessage is not null || clients[currentClient].Context.Parameters?.CommandName is not null)
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
                            continue;
                        }

                        byteRec = client.Socket.Receive(bytes);

                        client.Socket.Blocking = true;

                        client.LastReceivedMessage = Encoding.UTF8.GetString(bytes, 0, byteRec);
                    }


                    for (currentClient = currentClient; currentClient < clients.Count; currentClient++)
                    {
                        if (clients[currentClient].LastReceivedMessage is not null)
                        {
                            var data = clients[currentClient].LastReceivedMessage;
                            string[] splittedData = data.Split("\r\n");
                            messages[^1] += splittedData[0];
                            messages.AddRange(splittedData[1..]);
                            clients[currentClient].LastReceivedMessage = clients[currentClient].LastReceivedMessage.Replace("\r\n", string.Empty);

                            messageEnded = data.Length > 1 && data.LastIndexOf("\r\n") == data.Length - 2;

                            ExecuteCommand(clients[currentClient]);
                            clients[currentClient].LastReceivedMessage = null;
                        }
                        else if (clients[currentClient].Context.Parameters?.CommandName is not null)
                        {
                            ExecuteCommand(clients[currentClient]);
                        }
                    }


                    

                    //Console.WriteLine(currentClient);
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

        private void ExecuteCommand(Client client)
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
            closeCommandHandler.Handle(client);
        }
    }
}
