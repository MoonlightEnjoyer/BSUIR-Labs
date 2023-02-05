using System.Net.Sockets;
using System.Net;
using System.Text;
using System.Collections.Concurrent;

//Socket s = new Socket(AddressFamily.InterNetwork, SocketType.Raw, ProtocolType.Icmp);
Socket s = new Socket(AddressFamily.InterNetwork, SocketType.Raw, ProtocolType.Icmp);
ConcurrentDictionary<string, List<string>> routes = new ConcurrentDictionary<string, List<string>>();
Mutex mutex = new Mutex();
Thread thread1 = new Thread(() => Traceroute("yandex.ru", s, routes));
Thread thread2 = new Thread(() => Traceroute("google.com", s, routes));
Thread thread3 = new Thread(() => Traceroute("stackoverflow.com", s, routes));

//var result = Traceroute("google.com", s); 
thread1.Start();
thread2.Start();
thread3.Start();
thread1.Join();
thread2.Join();
thread3.Join();
int i = 1;
foreach (var route in routes)
{
    Console.WriteLine($"Route to {route.Key}:");
    foreach (var node in route.Value)
    {
        Console.WriteLine(node);
    }
}

void Traceroute(string hostName, Socket socket, ConcurrentDictionary<string, List<string>> routes)
{
    mutex.WaitOne();
    Console.WriteLine($"Thread id: {(short)Thread.CurrentThread.ManagedThreadId}");
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
    packet.Id = (short)Thread.CurrentThread.ManagedThreadId;
    packet.SequenceNumber = 1;
    //Buffer.BlockCopy(BitConverter.GetBytes(Thread.CurrentThread.ManagedThreadId), 0, packet.Message, 0, 2);
    //Buffer.BlockCopy(BitConverter.GetBytes(1), 0, packet.Message, 2, 2);
    data = Encoding.ASCII.GetBytes(hostName);
    Buffer.BlockCopy(data, 0, packet.Message, 0, data.Length);
    packet.MessageSize = data.Length;
    int packetsize = packet.MessageSize;

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
            ICMP response;
            data = new byte[1024];
            byte[] ddd = new byte[1024];
            while (true)
            {
                byte[] tid = BitConverter.GetBytes((short)Thread.CurrentThread.ManagedThreadId);
                byte[] id;
                
                recv = socket.ReceiveFrom(data, SocketFlags.Peek, ref ep);

                recv = socket.ReceiveFrom(data, ref ep);
                response = new ICMP(data, recv);
                if (response.Type == 11)
                {
                    id = data[52..54];
                }
                else
                {
                    id = data[52..54];
                }
                
                //recv = socket.ReceiveFrom(ddd, SocketFlags.Peek, ref ep);
                //response.Id = BitConverter.ToInt16(data, 52);
                if (tid[0] == id[0] && tid[1] == id[1])
                {
                    //recv = socket.ReceiveFrom(ddd, SocketFlags.Peek, ref ep);

                    recv = socket.ReceiveFrom(ddd, ref ep);
                    break;
                }
            }

            
            TimeSpan timestop = DateTime.Now - timestart;

            if (response.Type == 11)
            {
                //Console.WriteLine(i + ": " + ep.ToString() + " " + (timestop.Milliseconds.ToString()));
                nodes.Add(i + ": " + ep.ToString() + " " + timestop.Milliseconds.ToString());
            }

            if (response.Type == 0)
            {
                //Console.WriteLine(ep.ToString() + " достигнут за " + i + " прыжков, " + (timestop.Milliseconds.ToString()) + "мс\n");
                nodes.Add(i + ": " + ep.ToString() + " достигнут за " + i + " прыжков, " + (timestop.Milliseconds.ToString()) + "мс");
                break;
            }

            badcount = 0;
        }
        catch (SocketException)
        {
            //Console.WriteLine(i + ": нет ответа от " + ep + " (" + iep + ") - " + Convert.ToString(socket.Ttl) + "\n");
            nodes.Add(i + ": нет ответа от " + ep + " (" + iep + ") - " + Convert.ToString(socket.Ttl));
            badcount++;

            if (badcount == 5)
            {
                //Console.WriteLine("Не удалось установить соединение\n");
                nodes.Add("Не удалось установить соединение\n");
                break;
            }
        }
    }

    //socket.Close();
    if (!routes.ContainsKey(hostName))
    {
        routes.TryAdd(hostName, nodes);
    }

    mutex.ReleaseMutex();
}
