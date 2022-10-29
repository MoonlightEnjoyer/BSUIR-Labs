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
        private int cacheSize = 64;
        private byte[][] packets;
        private long packetCounter = 0;
        private int blockSize = 64 * 1024;
        public long lastAckedPacketNumber = 0;
        public long length;

        public UdpSender(Socket socket, int length)
        {
            this.packets = new byte[cacheSize][];
            this.socket = socket;
            this.length = length;
        }

        public byte[] SendData(byte[] data)
        {
            byte[] result = new byte[data.Length + sizeof(long)];
            var num = BitConverter.GetBytes(packetCounter);
            for (int i = 0; i < num.Length; i++)
            {
                result[i] = num[i];
            }

            for (int i = num.Length; i < result.Length; i++)
            {
                result[i] = data[i - num.Length];
            }

            this.packets[packetCounter % cacheSize] = data;
            packetCounter++;
            return result;
        }

        public byte[] ResendData(byte[] numData)
        {
            var num = BitConverter.ToInt64(numData[2..10]);
            byte[] result = new byte[packets[num].Length + sizeof(long)];
            
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
            if (this.packetCounter - this.lastAckedPacketNumber < this.blockSize && this.packetCounter < this.length)
            {
                return;
            }

            byte[] buffer = new byte[1024];
            bool wait = true;
            while (wait)
            {
                Console.WriteLine("Waiting for ack: main loop.");

                while (this.socket.Receive(buffer) == 0)
                {
                    Console.WriteLine("Waiting for ack : receive loop.");
                }
                Console.WriteLine("Get message in Ack(): " + (char)buffer[0] + (char)buffer[1] + (char)buffer[2] + " : " + BitConverter.ToInt64(buffer[3..11]));
                Console.WriteLine("Last acked packet number: " + this.lastAckedPacketNumber);
                Console.WriteLine("Expected packet number: " + (this.lastAckedPacketNumber + this.blockSize));
                if (buffer[0] == 'A' && buffer[1] == 'C' && buffer[2] == 'K' && ((BitConverter.ToInt64(buffer[3..11]) == this.lastAckedPacketNumber + this.blockSize) || (BitConverter.ToInt64(buffer[3..11]) == this.length)))
                {
                    this.lastAckedPacketNumber += this.blockSize;
                    Console.WriteLine("ACK: " + BitConverter.ToInt64(buffer[3..11]));
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
                    Console.WriteLine("Waiting for ack : undefined message.");
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
