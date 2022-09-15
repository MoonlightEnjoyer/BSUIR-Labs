using ServerApp;

Server server = Server.GetInstance("192.168.0.11", "60000");
server.StartListening();

