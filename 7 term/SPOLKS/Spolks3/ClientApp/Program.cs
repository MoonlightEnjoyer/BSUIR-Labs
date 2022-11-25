using ClientApp;
using ClientApp.CommandHandlers;
using System.Net;
using System.Net.Sockets;
using System.Text;

ClientApp.ClientApp client = ClientApp.ClientApp.GetInstance(args[0], args[1], args[2]);
client.Connect();