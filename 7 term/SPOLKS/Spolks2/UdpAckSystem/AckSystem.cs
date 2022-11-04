using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace ClientApp
{
    public static class AckSystem
    {
        public static (long number, byte[] data) UnpackData(byte[] data, int bytesRead)
        {
            byte[] result = data[8..bytesRead];
            var num = BitConverter.ToInt64(data[0..8]);

            return (num, result);
        }

        public static void RequestResend(long lostPacketNumber, Socket socket, EndPoint destinationIp)
        {
            byte[] rsBuf = new byte[10];
            rsBuf[0] = (byte)'R';
            rsBuf[1] = (byte)'S';
            var num = BitConverter.GetBytes(lostPacketNumber);
            for (int i = 2; i < rsBuf.Length; i++)
            {
                rsBuf[i] = num[i - 2];
            }

            if (socket.Poll(1, SelectMode.SelectWrite))
            {
                socket.SendTo(rsBuf, destinationIp);
            }
        }

        public static void SendAck(long packetToAck, Socket socket, EndPoint destinationIp)
        {
            byte[] ackBuf = new byte[11];
            ackBuf[0] = (byte)'A';
            ackBuf[1] = (byte)'C';
            ackBuf[2] = (byte)'K';
            var num = BitConverter.GetBytes(packetToAck);
            for (int i = 3; i < ackBuf.Length; i++)
            {
                ackBuf[i] = num[i - 3];
            }

            if (socket.Poll(1, SelectMode.SelectWrite))
            {
                socket.SendTo(ackBuf, destinationIp);
            }
        }
    }
}

