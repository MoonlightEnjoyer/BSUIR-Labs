using System;
using System.Collections.Generic;
using System.Linq;
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
        

        public UdpReader(Socket socket)
        {
            this.packets = new byte[cacheSize][];
            this.socket = socket;
        }

        public void SaveData(byte[] data)
        {
            byte[] result = data[8..];
            var num = BitConverter.ToInt32(data[0..8]);
            this.packets[num % (blockNumber * cacheSize)] = result;
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

        public byte[]? GetPacketsFromCache()
        {
            int size = 0;
            int counter = 0;

            for (int i = 0; i < packets.Length; i++)
            {
                if (packets[i] is null)
                {
                    return null;
                }

                size += packets[i].Length;
            }

            byte[] result = new byte[size];
            foreach (var packet in packets)
            {
                foreach (var b in packet)
                {
                    result[counter++] = b;
                }
            }

            this.ClearCache();
            return result;
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

