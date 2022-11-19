using ExecutableCommands.CommandHandlers;
using System.Net.Sockets;
namespace ExecutableCommands;

public class Program
{
    public static void Main(string[] args)
    {

    }

    private void ExecuteCommand(string command, string username, Socket socket)
    {
        int startOfParams = command.IndexOf(' ');
        string commandName = startOfParams == -1 ? command : command[0..startOfParams];
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