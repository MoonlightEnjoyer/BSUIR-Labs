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
            this.packets[num % cacheSize] = result;
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
            packetCounter++;
            return result;
        }

        public byte[] ResendData(byte[] numData)
        {
            var num = BitConverter.ToInt32(numData[2..6]);
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
                Console.WriteLine("Waiting for ack: main loop.");

                while (this.socket.Receive(buffer) == 0)
                {
                    Console.WriteLine("Waiting for ack : receive loop.");
                }
                Console.WriteLine("Get message in Ack().");
                if (buffer[0] == 'A' && buffer[1] == 'C' && buffer[2] == 'K' && BitConverter.ToInt32(buffer[3..7]) == this.blockNumber)
                {
                    Console.WriteLine("ACK: " + BitConverter.ToInt32(buffer[3..7]));
                    wait = false;
                }
                else if (buffer[0] == 'R' && buffer[1] == 'S')
                {
                    Console.WriteLine("RS");
                    var resendData = ResendData(buffer);
                    this.socket.Send(resendData);
                    for (int i = 0; i < buffer.Length; i++)
                    {
                        buffer[i] = 0;
                    }
                }
                else
                {
                    Console.WriteLine("Waiting for ack : undefinaed message.");
                }
            }

            ClearCache();
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
