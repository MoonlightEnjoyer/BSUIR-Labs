using Lab6;
using System.Linq;
using System.Net;
using System.Net.NetworkInformation;
using System.Net.Sockets;
using System.Text;

var localAddr = GetLocalIpAddress();
IPAddress sendAddress;
Dictionary<IpAddress, string> users = new Dictionary<IpAddress, string>();

string mode = args[0] ;
string username = args[1];

if (mode == "multicast")
{
    sendAddress = new IPAddress(new byte[] { 224, 168, 100, 2 });
}
else
{
    byte[] broadcastAddr = new byte[4];

    for (int i = 0; i < 4; i++)
    {
        broadcastAddr[i] = ((byte)(localAddr.Address[i] | (~localAddr.SubnetMask[i])));
    }

    sendAddress = new IPAddress(broadcastAddr);
}

Socket s = new Socket(AddressFamily.InterNetwork, SocketType.Dgram, ProtocolType.Udp);

//s.SetSocketOption(SocketOptionLevel.IP, SocketOptionName., false);


s.SetSocketOption(SocketOptionLevel.Socket, SocketOptionName.ReuseAddress, true);
EndPoint local = new IPEndPoint(new IPAddress(localAddr.Address), 60000); 
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
        if (input.ToUpperInvariant().Contains("LEAVE"))
        {
            LeaveGroup(s);
        }
        else if (input.ToUpperInvariant().Contains("JOIN"))
        {
            JoinGroup(s);
        }
        else if (input.ToUpperInvariant().Contains("UNBLOCK"))
        {
            UnblockHost(s);
        }
        else if (input.ToUpperInvariant().Contains("BLOCK"))
        {
            BlockHost(s);
        }
        else if (input.ToUpperInvariant().Contains("IPLIST"))
        {
            PrintIpList(s);
        }
        
    }
    else if (input.Length != 0)
    {
        while (!s.Poll(1, SelectMode.SelectWrite))
        {
        }

        SendMessage(s, input);
        Console.SetCursorPosition(0, currentPosition++);
        Console.WriteLine($"{username}: {input}");
    }
}

void PrintIpList(Socket socket)
{
    RequestChatMembers(socket);
    Console.WriteLine("Active users:");
    foreach (var user in users)
    {
        Console.WriteLine($"{user.Value} {IpToString(user.Key)}");
    }
}


void AnnounceIp(Socket socket)
{
    socket.EnableBroadcast= true;

    byte[] data;
    data = Encoding.ASCII.GetBytes($"ipannounce {username} {IpToString(localAddr)}");


    IPEndPoint iep = new IPEndPoint(sendAddress, 0);

    socket.SendTo(data, data.Length, SocketFlags.None, iep);
}

void RequestChatMembers(Socket socket)
{
    SendMessage(socket, "iprequest");
}

void SendMessage(Socket socket, string message)
{
    IPEndPoint multicast = new IPEndPoint(sendAddress, 60000);

    byte[] data;
    data = Encoding.ASCII.GetBytes(message);

    socket.SendTo(data, data.Length, SocketFlags.None, multicast);
}

(string username, string message) ReceiveMessage(Socket socket)
{
    EndPoint ep = new IPEndPoint(0, 0);
    byte[] buffer = new byte[1024];
    int recv = socket.ReceiveFrom(buffer, ref ep);
    string sender = string.Empty;

    foreach (var elem in users)
    {
        if (CompareAddresses(((IPEndPoint)ep).Address.GetAddressBytes(), elem.Key.Address))
        {
            sender = elem.Value;
        }
    }

    return (sender, Encoding.UTF8.GetString(buffer, 0, recv));
}

bool CompareAddresses(byte[] addr1, byte[] addr2)
{
    for (int i = 0; i < 4; i++)
    {
        if (addr1[i] != addr2[i])
        {
            return false;
        }
    }

    return true;
}

void Receive()
{
    while (true)
    {
        if (s.Poll(1, SelectMode.SelectRead))
        {
            (string sender, string message) receivedMessage = ReceiveMessage(s);
            if (receivedMessage.message.Contains("ipannounce"))
            {
                var userInfo = receivedMessage.message.Split(' ');
                if (!users.ContainsValue(userInfo[1]))
                {
                    var newIp = new IpAddress();
                    newIp.Address = userInfo[2].Split('.').Select(n => byte.Parse(n)).ToArray();
                    newIp.SubnetMask = userInfo[3].Split('.').Select(n => byte.Parse(n)).ToArray();
                    users.Add(newIp, userInfo[1]);
                }

                return;
            }

            if (receivedMessage.message.Contains("iprequest"))
            {
                AnnounceIp(s);
                return;
            }

            Console.SetCursorPosition(0, currentPosition++);
            Console.WriteLine($"{receivedMessage.sender}: {receivedMessage.message}");
            Console.SetCursorPosition(0, 0);
        }
    }
}



IpAddress GetLocalIpAddress()
{
    var nics = from nic in NetworkInterface.GetAllNetworkInterfaces()
               where nic.OperationalStatus == OperationalStatus.Up
               select nic;

    IpAddress address = new IpAddress();

    foreach (var nic in nics)
    {
        IPInterfaceProperties p = nic.GetIPProperties();

        if (p.GatewayAddresses.Count == 0)
        {
            continue;
        }

        foreach (var ua in p.UnicastAddresses)
        {
            if (ua.Address.AddressFamily == AddressFamily.InterNetwork)
            {
                address.Address = ua.Address.GetAddressBytes();
                address.SubnetMask = ua.IPv4Mask.GetAddressBytes();
                break;
            }
        }

        
        break;
    }

    return address;
}

string IpToString(IpAddress address)
{
    string addr = string.Empty;
    foreach (byte b in address.Address)
    {
        if (addr.Length != 0)
        {
            addr += ".";
        }

        addr += b;
    }

    string mask = string.Empty;

    foreach (byte b in address.SubnetMask)
    {
        if (mask.Length != 0)
        {
            mask += ".";
        }

        mask += b;
    }

    return addr + " " + mask;
}

void JoinGroup(Socket socket)
{
    s.SetSocketOption(SocketOptionLevel.IP, SocketOptionName.AddMembership, new MulticastOption(new IPAddress(new byte[] { 224, 168, 100, 2 }), new IPAddress(localAddr.Address)));
    s.SetSocketOption(SocketOptionLevel.IP, SocketOptionName.MulticastLoopback, false);
}

void LeaveGroup(Socket socket)
{
    s.SetSocketOption(SocketOptionLevel.IP, SocketOptionName.DropMembership, new MulticastOption(new IPAddress(new byte[] { 224, 168, 100, 2 }), new IPAddress(localAddr.Address)));
}

void BlockHost(Socket socket)
{
    s.SetSocketOption(SocketOptionLevel.IP, SocketOptionName.BlockSource, new byte[] { 224, 168, 100, 2, 192, 168, 0, 14, 192, 168, 0, 11});
}

void UnblockHost(Socket socket)
{
    s.SetSocketOption(SocketOptionLevel.IP, SocketOptionName.UnblockSource, new byte[] { 224, 168, 100, 2, 192, 168, 0, 14, 192, 168, 0, 11 });
}