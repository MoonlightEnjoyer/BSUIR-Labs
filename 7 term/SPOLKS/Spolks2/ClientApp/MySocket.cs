using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace ClientApp
{
    public class MySocket : Socket
    {
        public bool isClosed = false;

        public MySocket(AddressFamily addressFamily, SocketType socketType, ProtocolType protocolType)
            : base(addressFamily, socketType, protocolType)
        {
        }

        new public void Close()
        {
            this.isClosed = true;
            base.Close();
        }
    }
}
