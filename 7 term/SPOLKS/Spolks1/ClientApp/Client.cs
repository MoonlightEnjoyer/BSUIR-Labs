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
        private Client(byte[] ipAddress, int port)
        {
            this.ipAddress = new IPAddress(ipAddress);
            this.port = port;
        }

        private static Client instance;

        private IPAddress ipAddress;

        private int port;


        public static Client GetInstance(string ipAddress, string port)
        {
            if (instance is null)
            {
                instance = new Client(
                    ipAddress.Split('.').Select(n => byte.Parse(n)).ToArray(),
                    int.Parse(port));
            }

            return instance;
        }

        public void Connect()
        {
            Socket socket = new Socket(ipAddress.AddressFamily, SocketType.Stream, ProtocolType.Tcp);
            socket.SetSocketOption(SocketOptionLevel.Socket, SocketOptionName.KeepAlive, 1);
            //handler.IOControl(IOControlCode.KeepAliveValues, inValue, outvalue);
            socket.SetSocketOption(SocketOptionLevel.Tcp, SocketOptionName.TcpKeepAliveTime, 30);
            socket.Connect(ipAddress, port);
            Console.WriteLine("Connected.");
            byte[] bytes = new byte[1024];



            while (socket.Connected)
            {
                string command = Console.ReadLine();
                socket.Send(Encoding.UTF8.GetBytes(command + "\r\n"));
                ExecuteCommand(command, socket);
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
