using System.Net.Sockets;
using System.Net;
using System.Text;
using System.Collections.Concurrent;

List<Thread> threads = new List<Thread>();

Socket s = new Socket(AddressFamily.InterNetwork, SocketType.Raw, ProtocolType.Icmp);
ConcurrentDictionary<string, List<string>> routes = new ConcurrentDictionary<string, List<string>>();
Mutex mutex = new Mutex();


foreach (var arg in args[1..])
{
    if (args[0] == "ping")
    {
        threads.Add(new Thread(() => Ping(arg, s)));
    }
    else if (args[0] == "traceroute")
    {
        threads.Add(new Thread(() => Traceroute(arg, s, routes)));
    }
    else if (args[0] == "smurf")
    {

    }
}

foreach (var thread in threads)
{
    thread.Start();
}

foreach (var thread in threads)
{
    thread.Join();
}

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
    List<string> nodes = new List<string>();
    byte[] data = new byte[1024];
    int recv = 0;
    IPHostEntry iphe = Dns.GetHostEntry(hostName);
    IPEndPoint iep = new IPEndPoint(iphe.AddressList[0], 0);
    EndPoint ep = iep;
    ICMP packet = new ICMP();

    packet.Type = 0x08;

    packet.Code = 0x00;
    packet.Checksum = 0;
    packet.Id = (short)Thread.CurrentThread.ManagedThreadId;
    packet.SequenceNumber = 1;
    //Buffer.BlockCopy(BitConverter.GetBytes(Thread.CurrentThread.ManagedThreadId), 0, packet.Message, 0, 2);
    //Buffer.BlockCopy(BitConverter.GetBytes(1), 0, packet.Message, 2, 2);
    data = Encoding.ASCII.GetBytes("qwertyuiop");
    Buffer.BlockCopy(data, 0, packet.Message, 0, data.Length);
    packet.MessageSize = data.Length;
    int packetsize = packet.MessageSize + 8;

    UInt16 chcksum = packet.getChecksum();
    packet.Checksum = chcksum;
    socket.SetSocketOption(SocketOptionLevel.Socket, SocketOptionName.ReceiveTimeout, 3000);

    int badcount = 0;

    for (int i = 1; i < 256; i++)
    {
        mutex.WaitOne();
        socket.SetSocketOption(SocketOptionLevel.IP, SocketOptionName.IpTimeToLive, i);

        DateTime timestart = DateTime.Now;

        socket.SendTo(packet.getBytes(), packetsize, SocketFlags.None, iep);
        mutex.ReleaseMutex();

        try
        {
            ICMP response;
            data = new byte[1024];
            byte[] ddd = new byte[1024];
            
            while (true)
            {
                byte[] tid = BitConverter.GetBytes((short)Thread.CurrentThread.ManagedThreadId);
                byte[] id;
                mutex.WaitOne();
                recv = socket.Receive(data, SocketFlags.Peek);

                response = new ICMP(data, recv);
                if (response.Type == 11)
                {
                    id = data[52..54];
                }
                else
                {
                    id = data[24..26];
                }
                
                //recv = socket.ReceiveFrom(ddd, SocketFlags.Peek, ref ep);
                //response.Id = BitConverter.ToInt16(data, 52);
                if (tid[0] == id[0] && tid[1] == id[1])
                {
                    //recv = socket.ReceiveFrom(ddd, SocketFlags.Peek, ref ep);

                    recv = socket.ReceiveFrom(ddd, ref ep);
                    mutex.ReleaseMutex();
                    break;
                }
                mutex.ReleaseMutex();
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
}

void Ping(string hostName, Socket socket)
{
    byte[] data = new byte[1024];
    int recv = 0;
    IPHostEntry iphe = Dns.GetHostEntry(hostName);
    IPEndPoint iep = new IPEndPoint(iphe.AddressList[0], 0);
    EndPoint ep = iep;
    ICMP packet = new ICMP();

    packet.Type = 0x08;

    packet.Code = 0x00;
    packet.Checksum = 0;
    packet.Id = (short)Thread.CurrentThread.ManagedThreadId;
    packet.SequenceNumber = 1;
    data = Encoding.ASCII.GetBytes("qwertyuiop");
    Buffer.BlockCopy(data, 0, packet.Message, 0, data.Length);
    packet.MessageSize = data.Length;
    int packetsize = packet.MessageSize + 8;

    UInt16 chcksum = packet.getChecksum();
    packet.Checksum = chcksum;
    socket.SetSocketOption(SocketOptionLevel.Socket, SocketOptionName.ReceiveTimeout, 3000);
    
    mutex.WaitOne();

    DateTime timestart = DateTime.Now;

    socket.SendTo(packet.getBytes(), packetsize, SocketFlags.None, iep);
    mutex.ReleaseMutex();

    try
    {
        ICMP response;
        data = new byte[1024];

        while (true)
        {
            byte[] tid = BitConverter.GetBytes((short)Thread.CurrentThread.ManagedThreadId);
            byte[] id;
            mutex.WaitOne();
            recv = socket.Receive(data, SocketFlags.Peek);

            response = new ICMP(data, recv);
            if (response.Type == 0)
            {
                id = data[24..26];
            }
            else
            {
                id = data[24..26];
            }

            if (tid[0] == id[0] && tid[1] == id[1])
            {
                recv = socket.ReceiveFrom(data, ref ep);
                mutex.ReleaseMutex();
                break;
            }
            mutex.ReleaseMutex();
        }

        TimeSpan timestop = DateTime.Now - timestart;

        if (response.Type == 0)
        {
            Console.WriteLine($"Ответ от {hostName} получен.");
        }
        else
        {
            //problem text
        }
     }
    catch (SocketException)
    {
        Console.WriteLine($"не удалось получить ответ от {hostName}");
    }
    
}
