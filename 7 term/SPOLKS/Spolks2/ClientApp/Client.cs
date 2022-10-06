using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;
using Microsoft.VisualBasic.FileIO;
using ClientApp.CommandHandlers;

namespace ClientApp
{
    public sealed class Client
    {
        private Client(byte[] ipAddress, int port, string username)
        {
            this.ipAddress = new IPAddress(ipAddress);
            this.port = port;
            this.username = username;
        }

        private static Client instance;

        private IPAddress ipAddress;

        private string username;

        private int port;


        public static Client GetInstance(string ipAddress, string port, string username, string password)
        {
            if (instance is null)
            {
                instance = new Client(
                    ipAddress.Split('.').Select(n => byte.Parse(n)).ToArray(),
                    int.Parse(port),
                    username);
            }

            return instance;
        }

        public void Connect()
        {
            Socket socket = new Socket(ipAddress.AddressFamily, SocketType.Stream, ProtocolType.Tcp);
            socket.SetSocketOption(SocketOptionLevel.Socket, SocketOptionName.KeepAlive, 1);
            socket.SetSocketOption(SocketOptionLevel.Tcp, SocketOptionName.TcpKeepAliveTime, 30);
            socket.Connect(ipAddress, port);
            Console.WriteLine("Connected.");
            socket.Send(Encoding.UTF8.GetBytes(username));
            
            byte[] bytes = new byte[1024];
            string? command;

            while (socket.Connected)
            {
                command = Console.ReadLine();
                if (!string.IsNullOrWhiteSpace(command))
                {
                    socket.Send(Encoding.UTF8.GetBytes(command + "\r\n"));
                    ExecuteCommand(command, socket);
                }
            }
        }

        private void ExecuteCommand(string command, Socket socket)
        {
            int startOfParams = command.IndexOf(' ');
            string commandName = startOfParams == -1 ? command : command[0..startOfParams];
            CloseCommandHandler closeCommandHandler = new CloseCommandHandler();
            DownloadCommandHandler downloadCommandHandler = new DownloadCommandHandler();
            TimeCommandHandler timeCommandHandler = new TimeCommandHandler();
            EchoCommandHandler echoCommandHandler = new EchoCommandHandler();
            UploadCommandHandler uploadCommandHandler = new UploadCommandHandler();
            closeCommandHandler.SetNext(downloadCommandHandler);
            downloadCommandHandler.SetNext(timeCommandHandler);
            timeCommandHandler.SetNext(echoCommandHandler);
            echoCommandHandler.SetNext(uploadCommandHandler);
            closeCommandHandler.Handle(new CommandParameters(commandName.ToUpper(), command[(startOfParams + 1)..], socket));
        }
    }
}
