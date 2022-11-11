using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace ServerApp
{
    public class Client
    {
        public Socket Socket { get; set; }

        public string Username { get; set; }

        public string Message { get; set; }

        public (string command, string parameters) Context = new();
    }
}
