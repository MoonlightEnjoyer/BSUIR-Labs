using System.Net.Sockets;
using System.Net;
using System.Text;
using System.Collections.Concurrent;

Socket s = new Socket(AddressFamily.InterNetwork, SocketType.Raw, ProtocolType.Icmp);
ConcurrentDictionary<string, List<string>> routes = new ConcurrentDictionary<string, List<string>>(); 
Thread thread1 = new Thread(() => Traceroute("google.com", s, routes));
//var result = Traceroute("google.com", s); 
thread1.Start();
 

void Traceroute(string hostName, Socket socket, ConcurrentDictionary<string, List<string>> routes)
{
    List<string> nodes = new List<string>();
    byte[] data = new byte[1024];
    int recv = 0;
    IPHostEntry iphe = Dns.GetHostEntry(hostName);
    IPEndPoint iep = new IPEndPoint(iphe.AddressList[0], 0);
    EndPoint ep = (EndPoint)iep;
    ICMP packet = new ICMP();

    packet.Type = 0x08;

    packet.Code = 0x00;
    packet.Checksum = 0;
    Buffer.BlockCopy(BitConverter.GetBytes(1), 0, packet.Message, 0, 2);
    Buffer.BlockCopy(BitConverter.GetBytes(1), 0, packet.Message, 2, 2);
    data = Encoding.ASCII.GetBytes("test packet");
    Buffer.BlockCopy(data, 0, packet.Message, 4, data.Length);
    packet.MessageSize = data.Length + 4;
    int packetsize = packet.MessageSize + 4;

    UInt16 chcksum = packet.getChecksum();
    packet.Checksum = chcksum;

    socket.SetSocketOption(SocketOptionLevel.Socket, SocketOptionName.ReceiveTimeout, 3000);

    int badcount = 0;

    for (int i = 1; i < 256; i++)
    {
        socket.SetSocketOption(SocketOptionLevel.IP, SocketOptionName.IpTimeToLive, i);

        DateTime timestart = DateTime.Now;
        socket.SendTo(packet.getBytes(), packetsize, SocketFlags.None, iep);
        try
        {
            data = new byte[1024];
            recv = socket.ReceiveFrom(data, ref ep);
            TimeSpan timestop = DateTime.Now - timestart;
            ICMP response = new ICMP(data, recv);

            if (response.Type == 11)
            {
                //Console.WriteLine(i + ": " + ep.ToString() + " " + (timestop.Milliseconds.ToString()));
                nodes.Add(i + ": " + ep.ToString() + " " + (timestop.Milliseconds.ToString()));
            }

            if (response.Type == 0)
            {
                //Console.WriteLine(ep.ToString() + " достигнут за " + i + " прыжков, " + (timestop.Milliseconds.ToString()) + "мс\n");
                nodes.Add(ep.ToString() + " достигнут за " + i + " прыжков, " + (timestop.Milliseconds.ToString()) + "мс\n");
                break;
            }

            badcount = 0;
        }
        catch (SocketException)
        {
            //Console.WriteLine(i + ": нет ответа от " + ep + " (" + iep + ") - " + Convert.ToString(socket.Ttl) + "\n");
            nodes.Add(i + ": нет ответа от " + ep + " (" + iep + ") - " + Convert.ToString(socket.Ttl) + "\n");
            badcount++;

            if (badcount == 5)
            {
                //Console.WriteLine("Не удалось установить соединение\n");
                nodes.Add("Не удалось установить соединение\n");
                break;
            }
        }
    }

    socket.Close();
    if (!routes.ContainsKey(hostName))
    {
        routes.TryAdd(hostName, nodes);
    }
    

}
