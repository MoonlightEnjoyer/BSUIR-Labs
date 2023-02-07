using System.Net;
using System.Net.Sockets;
using System.Text;

Socket s = new Socket(AddressFamily.InterNetwork, SocketType.Raw, ProtocolType.Icmp);
AnnounceIp(s);
s.SetSocketOption(SocketOptionLevel.IP, SocketOptionName.AddMembership, new MulticastOption(new IPAddress(new byte[] { 224, 0, 0, 11})));




//broadcast
void AnnounceIp(Socket socket)
{
    socket.EnableBroadcast= true;

    ICMP packet = new ICMP(); 

    packet.Type = 0x08;

    packet.Code = 0x00;
    packet.Checksum = 0;
    packet.Id = (short)Thread.CurrentThread.ManagedThreadId;
    packet.SequenceNumber = 1;

    byte[] data = new byte[1024];
    data = Encoding.ASCII.GetBytes("local chat");
    Buffer.BlockCopy(data, 0, packet.Message, 0, data.Length);
    packet.MessageSize = data.Length;
    int packetsize = packet.MessageSize + 8;

    UInt16 chcksum = packet.getChecksum();
    packet.Checksum = chcksum;

    IPEndPoint iep = new IPEndPoint(new IPAddress(new byte[] { 192, 168, 0, 255 }), 0);

    socket.SendTo(packet.getBytes(), packetsize, SocketFlags.None, iep);
}

//broadcast
//List<string> RequestChatMembers()
//{

//}

//multicast
void SendMessage(Socket socket)
{
    IPEndPoint multicast = new IPEndPoint(new IPAddress(new byte[] { 224, 0, 0, 11 }), 0);

    ICMP packet = new ICMP();

    packet.Type = 0x08;

    packet.Code = 0x00;
    packet.Checksum = 0;
    packet.Id = (short)Thread.CurrentThread.ManagedThreadId;
    packet.SequenceNumber = 1;

    byte[] data = new byte[1024];
    data = Encoding.ASCII.GetBytes("local chat");
    Buffer.BlockCopy(data, 0, packet.Message, 0, data.Length);
    packet.MessageSize = data.Length;
    int packetsize = packet.MessageSize + 8;

    UInt16 chcksum = packet.getChecksum();
    packet.Checksum = chcksum;
    socket.SendTo(packet.getBytes(), multicast);
}