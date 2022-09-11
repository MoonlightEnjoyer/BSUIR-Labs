using Spolks1;
using System;
using System.Net;
using System.Net.Sockets;
using System.Text;

Server server = Server.GetInstance("192.168.0.14", "60000");
server.StartListening();

