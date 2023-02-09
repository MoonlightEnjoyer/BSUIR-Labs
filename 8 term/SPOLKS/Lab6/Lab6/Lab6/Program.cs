﻿using Lab6;
using System.Net;
using System.Net.NetworkInformation;
using System.Net.Sockets;
using System.Text;

var localAddr = GetLocalIpAddress();



Socket s = new Socket(AddressFamily.InterNetwork, SocketType.Dgram, ProtocolType.Udp);
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

        if (p.GatewayAddresses.Count== 0)
        {
            continue;
        }
        
        address.Address = p.UnicastAddresses[0].Address.GetAddressBytes();
        address.SubnetMask = p.UnicastAddresses[0].IPv4Mask.GetAddressBytes();
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