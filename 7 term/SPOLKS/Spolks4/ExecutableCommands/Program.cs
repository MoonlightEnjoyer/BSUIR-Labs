using ExecutableCommands.CommandHandlers;
using System.Net.Sockets;
using System.Text;

namespace ExecutableCommands;

public class Program
{
    public static void Main(string[] args)
    {
        string username = args[0];
        int length = int.Parse(Console.ReadLine());
        byte[] protocolInformation = new byte[length];
        for (int i = 0; i < length; i++)
        {
            protocolInformation[i] = byte.Parse(Console.ReadLine());
        }

        SocketInformation si = new SocketInformation();
        si.Options = SocketInformationOptions.Connected;
        si.ProtocolInformation = protocolInformation;

        Socket socket = new Socket(si);


        //read command and execute them(copy code from lab 1 server)
        int byteRec;
        List<string> messages = new List<string>() { string.Empty };
        bool messageEnded = true;
        int lastProcessedCommand = 0;
        byte[] bytes = new byte[128];
        while (true)
        {
            if (!socket.Connected)
            {
                Console.WriteLine("Client disconnected.");
                return;
            }



            byteRec = socket.Receive(bytes);
            string data = Encoding.UTF8.GetString(bytes, 0, byteRec);

            string[] splittedData = data.Split("\r\n");
            messages[^1] += splittedData[0];
            messages.AddRange(splittedData[1..]);


            messageEnded = data.Length > 1 && data.LastIndexOf("\r\n") == data.Length - 2;
            while (lastProcessedCommand < messages.Count - 1)
            {
                ExecuteCommand(messages[lastProcessedCommand++], username, socket);
            }

        }

    }

    private static void ExecuteCommand(string command, string username, Socket socket)
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