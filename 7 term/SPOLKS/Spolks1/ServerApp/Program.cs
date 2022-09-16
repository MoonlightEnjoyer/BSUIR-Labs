using ServerApp;
Server server = Server.GetInstance(args[0], args[1]);
server.StartListening();

