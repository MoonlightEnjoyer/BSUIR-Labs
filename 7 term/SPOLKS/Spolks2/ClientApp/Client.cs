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


        public static Client GetInstance(string ipAddress, string port, string username)
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
            try
            {
                MySocket socket = new MySocket(ipAddress.AddressFamily, SocketType.Dgram, ProtocolType.Udp);
                socket.Blocking = false;
                socket.Connect(ipAddress, port);

                while (!socket.Poll(1, SelectMode.SelectWrite))
                {
                }
                socket.Send(Encoding.UTF8.GetBytes(username));

                while (!socket.Poll(1, SelectMode.SelectRead))
                {
                }
                socket.Receive(new byte[1]); 
                Console.WriteLine("Connected.");
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
            catch (SocketException exception)
            {
                Console.WriteLine(exception.Message);
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
