using ClientApp;
using ClientApp.CommandHandlers;
using System.Net;
using System.Net.Sockets;
using System.Text;

Client client = Client.GetInstance(args[0], args[1]);
client.Connect();