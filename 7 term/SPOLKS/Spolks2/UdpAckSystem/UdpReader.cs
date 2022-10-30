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
        //
        private Socket socket;
        private int cacheSize = 64;
        private byte[][] packets;
        private long length;
        private long lengthCounter = 0;
        private int blockSize;
        private long lastAckedPacketNumber = 0;
        private EndPoint remoteIp;



        public UdpReader(Socket socket, int length, EndPoint remoteIp)
        {
            this.packets = new byte[cacheSize][];
            this.socket = socket;
            this.length = length;
            this.blockSize = cacheSize * 1024;
            this.remoteIp = remoteIp;
        }

        public bool SaveData(byte[] data)
        {
            byte[] result = data[8..];
            var num = BitConverter.ToInt64(data[0..8]);
            if (num - lastAckedPacketNumber >= blockSize)
            {
                var lostPacket = FindLostPacket();
                if (lostPacket != -1)
                {
                    RequestResend(lostPacket + lastAckedPacketNumber + 1);
                    return false;
                }
            }

            this.packets[num % cacheSize] = result;
            return true;
        }

        private int FindLostPacket()
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
                    return null;
                }
                if (packets[i] is not null)
                {
                    size += packets[i].Length;
                }
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
            this.SendAck(remoteIp, size);
            return result;
        }

        private void SendAck(EndPoint remoteIp, int packetsToAck)
        {
            this.lastAckedPacketNumber += packetsToAck;
            Console.WriteLine("Ack send: " + this.lastAckedPacketNumber);
            byte[] buf = new byte[3 + sizeof(long)];
            buf[0] = (byte)'A';
            buf[1] = (byte)'C';
            buf[2] = (byte)'K';
            var n = BitConverter.GetBytes(this.lastAckedPacketNumber);
            for (int i = 3; i < buf.Length; i++)
            {
                buf[i] = n[i - 3];
            }

            this.socket.SendTo(buf, remoteIp);
        }

        private void RequestResend(long lostPacketNumber)
        {
            Console.WriteLine("Request resend: " + lostPacketNumber);
            byte[] buf = new byte[2 + sizeof(long)];
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

