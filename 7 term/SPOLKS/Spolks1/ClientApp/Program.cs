using ClientApp.CommandHandlers;
using System.Net;
using System.Net.Sockets;
using System.Text;

IPAddress ipAddress = new IPAddress(new byte[] { 192, 168, 0, 11 });
Socket socket = new Socket(ipAddress.AddressFamily, SocketType.Stream, ProtocolType.Tcp);
socket.SetSocketOption(SocketOptionLevel.Socket, SocketOptionName.KeepAlive, 1);
//handler.IOControl(IOControlCode.KeepAliveValues, inValue, outvalue);
socket.SetSocketOption(SocketOptionLevel.Tcp, SocketOptionName.TcpKeepAliveTime, 30);
socket.Connect(ipAddress, 60000);
Console.WriteLine("Connected.");
byte[] bytes = new byte[1024];



while (socket.Connected)
{
    string command = Console.ReadLine();
    socket.Send(Encoding.UTF8.GetBytes(command + "\r\n"));
    ExecuteCommand(command);
}

void ExecuteCommand(string command)
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