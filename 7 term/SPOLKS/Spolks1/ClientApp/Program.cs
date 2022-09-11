using ClientApp.CommandHandlers;
using System.Net;
using System.Net.Sockets;
using System.Text;

IPAddress ipAddress = new IPAddress(new byte[] { 192, 168, 0, 14 });
Socket socket = new Socket(ipAddress.AddressFamily, SocketType.Stream, ProtocolType.Tcp);
socket.Connect(ipAddress, 60000);
Console.WriteLine("Connected.");
byte[] bytes = new byte[1024];



while (socket.Connected)
{
    
    string command = Console.ReadLine();
    socket.Send(Encoding.ASCII.GetBytes(command + "\r\n"));
    ExecuteCommand(command);
}

void ExecuteCommand(string command)
{
    string[] commandParts = command.Split(" ");
    CloseCommandHandler closeCommandHandler = new CloseCommandHandler();
    DownloadCommandHandler downloadCommandHandler = new DownloadCommandHandler();
    TimeCommandHandler timeCommandHandler = new TimeCommandHandler();
    EchoCommandHandler echoCommandHandler = new EchoCommandHandler();
    closeCommandHandler.SetNext(downloadCommandHandler);
    downloadCommandHandler.SetNext(timeCommandHandler);
    timeCommandHandler.SetNext(echoCommandHandler);
    closeCommandHandler.Handle(new CommandParameters(commandParts[0].ToUpper(), commandParts[1..], socket));
}