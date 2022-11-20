using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;

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
               
                while (true)
                {
                    var client = AddClient(socket);

                    if (client is not null)
                    {
                        CreateProcess(client.Username, client.Socket);
                    }
                }
            }
            catch (SocketException exception)
            {
                Console.WriteLine(exception.Message);
            }
        }

        private Client? AddClient(Socket listener)
        {
            listener.Blocking = false;
            if (!listener.Poll(1, SelectMode.SelectRead))
            {
                listener.Blocking = true;
                return null;
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

            return new Client() { Socket = handler, Username = username };
        }

        private void CreateProcess(string username, Socket socket)
        {
            ProcessStartInfo startInfo = new ProcessStartInfo("ExecutableCommands\\ExecutableCommands.exe");
            startInfo.RedirectStandardInput = true;
            startInfo.Arguments = username;
            var process = Process.Start(startInfo);
            var si = socket.DuplicateAndClose(process.Id);

            Console.WriteLine("Length at server: " + si.ProtocolInformation.Length);
            process.StandardInput.WriteLine(si.ProtocolInformation.Length);
            Console.WriteLine($"Options {si.Options}");
            foreach (byte b in si.ProtocolInformation)
            {
                process.StandardInput.WriteLine(b);
            }
        }
    }
}
