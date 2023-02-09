using System.Net;
using System.Net.NetworkInformation;
using System.Net.Sockets;
using System.Text;

GetLocalIpAddress();

Socket s = new Socket(AddressFamily.InterNetwork, SocketType.Dgram, ProtocolType.Udp);
EndPoint local = new IPEndPoint(new IPAddress(new byte[] { 192, 168, 0, 14 }), 60000);
s.Bind(local);
int currentPosition = 1;
Thread receiveThread = new Thread(() => Receive());
receiveThread.Start();
JoinGroup(s);
s.Blocking = false;
string input;
while (true)
{
    Console.SetCursorPosition(0, 0);
    input = Console.ReadLine();
    Console.SetCursorPosition(0, 0);
    Console.WriteLine(new string(' ', Console.WindowWidth));
    

    if (input.Length != 0 && input[0] == '/')
    {
        //process command
    }
    else if (input.Length != 0)
    {
        while (!s.Poll(1, SelectMode.SelectWrite))
        {
        }

        SendMessage(s, input);
        Console.SetCursorPosition(0, currentPosition++);
        Console.WriteLine(input);
    }
}


//broadcast
void AnnounceIp(Socket socket)
{
    socket.EnableBroadcast= true;

    byte[] data;
    data = Encoding.ASCII.GetBytes("ip announce");


    IPEndPoint iep = new IPEndPoint(new IPAddress(new byte[] { 224, 168, 100, 2 }), 0);

    socket.SendTo(data, data.Length, SocketFlags.None, iep);
}

//broadcast
//List<string> RequestChatMembers()
//{

//}

//multicast
void SendMessage(Socket socket, string message)
{
    IPEndPoint multicast = new IPEndPoint(new IPAddress(new byte[] { 224, 168, 100, 2 }), 60000);


   

    byte[] data;
    data = Encoding.ASCII.GetBytes(message);

    socket.SendTo(data, data.Length, SocketFlags.None, multicast);
}

string ReceiveMessage(Socket socket)
{
    byte[] buffer = new byte[1024];
    int recv = socket.Receive(buffer);
    return Encoding.UTF8.GetString(buffer, 0, recv);
}

void Receive()
{
    while (true)
    {
        if (s.Poll(1, SelectMode.SelectRead))
        {
            string receivedMessage = ReceiveMessage(s);
            Console.SetCursorPosition(0, currentPosition++);
            Console.WriteLine(receivedMessage);
        }
    }
}



void GetLocalIpAddress()
{
    var host = Dns.GetHostEntry(Dns.GetHostName());
    foreach (var ip in host.AddressList)
    {
        if (ip.AddressFamily == AddressFamily.InterNetwork)
        {
            Console.WriteLine(ip.ToString());
        }
    }

    Console.WriteLine("///////////////////////////////////////////");

    var nics = from nic in NetworkInterface.GetAllNetworkInterfaces()
               where nic.OperationalStatus == OperationalStatus.Up
               select nic;

    foreach (var nic in nics)
    {
        IPInterfaceProperties p = nic.GetIPProperties();
        foreach (var a in p.UnicastAddresses)
        {
            Console.WriteLine(a.Address);
            Console.WriteLine(a.IPv4Mask);
        }

        Console.WriteLine(nic.Id);
        Console.WriteLine(nic.Name);
        Console.WriteLine(nic.Description);
        Console.WriteLine(nic.NetworkInterfaceType);
        Console.WriteLine(nic.OperationalStatus);
        Console.WriteLine(nic.OperationalStatus);

        Console.WriteLine("-----------------------------");
    }
}

void JoinGroup(Socket socket)
{
    s.SetSocketOption(SocketOptionLevel.IP, SocketOptionName.AddMembership, new MulticastOption(new IPAddress(new byte[] { 224, 168, 100, 2 }), new IPAddress(new byte[] { 192, 168, 0, 14 })));
    s.SetSocketOption(SocketOptionLevel.IP, SocketOptionName.MulticastLoopback, false);
}

void LeaveGroup(Socket socket)
{
    s.SetSocketOption(SocketOptionLevel.IP, SocketOptionName.DropMembership, new MulticastOption(new IPAddress(new byte[] { 224, 168, 100, 2 }), new IPAddress(new byte[] { 192, 168, 0, 14 })));
}