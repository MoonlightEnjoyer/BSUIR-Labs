using ServerApp;

Server server = Server.GetInstance("192.168.0.14", "60000");
server.StartListening();

