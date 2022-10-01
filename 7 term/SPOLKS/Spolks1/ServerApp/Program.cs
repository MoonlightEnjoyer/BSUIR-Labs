using ServerApp;
using Microsoft.Extensions.Configuration;

Server server = Server.GetInstance(args[0], args[1]);
server.StartListening();