using ServerApp;
using Microsoft.Extensions.Configuration;

Ass server = Ass.GetInstance(args[0], args[1]);
server.StartListening();