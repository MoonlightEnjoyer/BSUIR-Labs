﻿using System.Net.Sockets;
using System.Net;
using System.Text;

Traceroute("google.com");

void Traceroute(string hostName)
{
    byte[] data = new byte[1024];
    int recv = 0;
    Socket host = new Socket(AddressFamily.InterNetwork, SocketType.Raw, ProtocolType.Icmp);
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

    host.SetSocketOption(SocketOptionLevel.Socket, SocketOptionName.ReceiveTimeout, 3000);

    int badcount = 0;

    for (int i = 1; i < 256; i++)
    {
        host.SetSocketOption(SocketOptionLevel.IP, SocketOptionName.IpTimeToLive, i);

        DateTime timestart = DateTime.Now;
        host.SendTo(packet.getBytes(), packetsize, SocketFlags.None, iep);
        try
        {
            data = new byte[1024];
            recv = host.ReceiveFrom(data, ref ep);
            TimeSpan timestop = DateTime.Now - timestart;
            ICMP response = new ICMP(data, recv);

            if (response.Type == 11)
            {
                Console.WriteLine(i + ": " + ep.ToString() + " " + (timestop.Milliseconds.ToString()));
            }

            if (response.Type == 0)
            {
                Console.WriteLine(ep.ToString() + " достигнут за " + i + " прыжков, " + (timestop.Milliseconds.ToString()) + "мс\n");
                break;
            }

            badcount = 0;
        }
        catch (SocketException)
        {
            Console.WriteLine(i + ": нет ответа от " + ep + " (" + iep + ") - " + Convert.ToString(host.Ttl) + "\n");
            badcount++;

            if (badcount == 5)
            {
                Console.WriteLine("Не удалось установить соединение\n");
                break;
            }
        }
    }
    host.Close();
}
