using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace ClientApp
{
    public class UdpSender
    {
        private Socket socket;
        private int blockNumber = 1;
        private int cacheSize = 64;
        private byte[][] packets;
        private int packetCounter = 0;

        public UdpSender(Socket socket)
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

        public byte[] SendData(byte[] data)
        {
            byte[] result = new byte[data.Length + sizeof(int)];
            var num = BitConverter.GetBytes(packetCounter);
            for (int i = 0; i < num.Length; i++)
            {
                result[i] = num[i];
            }

            for (int i = num.Length; i < result.Length; i++)
            {
                result[i] = data[i - num.Length];
            }

            this.packets[packetCounter % (blockNumber * cacheSize)] = data;

            return result;
        }

        public byte[] ResendData(byte[] numData)
        {
            var num = BitConverter.ToInt32(numData);
            byte[] result = new byte[packets[num].Length + sizeof(int)];
            
            for (int i = 0; i < numData.Length; i++)
            {
                result[i] = numData[i];
            }

            for (int i = numData.Length; i < result.Length; i++)
            {
                result[i] = packets[num][i - numData.Length];
            }

            return result;
        }



        public void Ack()
        {
            byte[] buffer = new byte[1024];
            bool wait = true;
            while (wait)
            {
                while (((buffer[0] != 'R' && buffer[1] != 'S')) || (buffer[0] != 'A' && buffer[1] != 'C' && buffer[2] != 'K'))
                {
                    this.socket.Receive(buffer);
                }

                if (buffer[0] != 'A' && buffer[1] != 'C' && buffer[2] != 'K' && BitConverter.ToInt32(buffer[3..7]) == this.blockNumber)
                {
                    wait = false;
                }
                else if (buffer[0] != 'R' && buffer[1] != 'S')
                {
                    var resendData = ResendData(buffer);
                    this.socket.Send(resendData);
                }
            }
        }

        public bool IsCacheFull()
        {
            for (int i = 0; i < packets.Length; i++)
            {
                if (packets[i] is null)
                {
                    return false;
                }
            }

            return true;
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
