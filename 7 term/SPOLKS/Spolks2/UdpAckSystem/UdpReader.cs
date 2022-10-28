using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace ClientApp
{
    public class UdpReader
    {
        private Socket socket;
        private int blockNumber = 1;
        private int cacheSize = 64;
        private byte[][] packets;
        private int length;
        private int lengthCounter = 0;
        

        public UdpReader(Socket socket, int length)
        {
            this.packets = new byte[cacheSize][];
            this.socket = socket;
            this.length = length;
        }

        public void SaveData(byte[] data)
        {
            byte[] result = data[4..];
            var num = BitConverter.ToInt32(data[0..4]);
            this.packets[num % cacheSize] = result;
        }

        public int CheckCache()
        {
            for (int i = 0; i < packets.Length; i++)
            {
                if (packets[i] is null)
                {
                    return i;
                }
            }

            return -1;
        }

        public byte[]? GetPacketsFromCache(EndPoint remoteIp)
        {
            int size = 0;
            int counter = 0;

            for (int i = 0; i < packets.Length; i++)
            {
                if (packets[i] is null)
                {
                    this.RequestResend(i, remoteIp);
                    return null;
                }

                size += packets[i].Length;
                if (this.lengthCounter + size >= this.length)
                {
                    break;
                }
            }

            byte[] result = new byte[size];
            foreach (var packet in packets)
            {
                if (packet is not null)
                {
                    foreach (var b in packet)
                    {
                        result[counter++] = b;
                    }
                }
            }

            //Console.WriteLine("Clear");
            this.lengthCounter += size;
            this.ClearCache();
            this.SendAck(remoteIp);
            this.blockNumber++;
            return result;
        }

        private void SendAck(EndPoint remoteIp)
        {
            Console.WriteLine("Ack send: " + this.blockNumber);
            byte[] buf = new byte[3 + sizeof(int)];
            buf[0] = (byte)'A';
            buf[1] = (byte)'C';
            buf[2] = (byte)'K';
            var n = BitConverter.GetBytes(this.blockNumber);
            for (int i = 3; i < buf.Length; i++)
            {
                buf[i] = n[i - 3];
            }

            this.socket.SendTo(buf, remoteIp);
        }

        private void RequestResend(int lostPacketNumber, EndPoint remoteIp)
        {
            Console.WriteLine("Request resend: " + lostPacketNumber);
            byte[] buf = new byte[2 + sizeof(int)];
            buf[0] = (byte)'R';
            buf[1] = (byte)'S';
            var n = BitConverter.GetBytes(lostPacketNumber);
            for (int i = 2; i < buf.Length; i++)
            {
                buf[i] = n[i - 2];
            }

            this.socket.SendTo(buf, remoteIp);
        }

        private void ClearCache()
        {
            for (int i = 0; i < packets.Length; i++)
            {
                this.packets[i] = null;
            }
        }
    }
}

