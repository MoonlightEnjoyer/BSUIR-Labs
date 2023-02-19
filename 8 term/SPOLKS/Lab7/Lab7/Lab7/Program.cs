using Lab7;
using System.IO.Compression;
using System.Net;
using System.Net.NetworkInformation;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks.Dataflow;

Socket s = new Socket(AddressFamily.InterNetwork, SocketType.Dgram, ProtocolType.Udp);
EndPoint local = new IPEndPoint(GetLocalIpAddress(), 60000);

s.Bind(local);

int rank = 0;

int myRank = 0;

List<Slave> slaves = new List<Slave>();

bool isMaster = args[0] == "master" ? true : false;
s.EnableBroadcast = true;
EndPoint masterEp = null;
Thread receiveThread = new Thread(() => Receive(s));
receiveThread.Start();

if (isMaster)
{
    AnnounceMaster(s);
}

while (true)
{

}


void AnnounceMaster(Socket socket)
{
    EndPoint broadcast = new IPEndPoint(new IPAddress(new byte[] { 192, 168, 0, 255 }), 60000);
    socket.SendTo(Encoding.UTF8.GetBytes("masterannounce"), broadcast);
}

void AnnounceSlave(Socket socket, IPAddress masterAddress)
{
    EndPoint master = new IPEndPoint(masterAddress, 60000);
    socket.SendTo(Encoding.UTF8.GetBytes("slaveannounce"), master);
}

void SendRank(Socket socket, Slave slave)
{
    byte[] buffer = new byte[11];
    Buffer.BlockCopy(Encoding.UTF8.GetBytes("setrank"), 0, buffer, 0, 7);
    Buffer.BlockCopy(BitConverter.GetBytes(slave.Rank), 0, buffer, 7, 4);
    socket.SendTo(buffer, slave.SlaveEP);
}

void SendCommand(Socket socket, Slave slave, string commandName, Dictionary<string, byte[]> parameters)
{
    byte[] data = new byte[commandName.Length + parameters.Sum(p => (p.Key.Length + p.Value.Length + 2))];
    Buffer.BlockCopy(Encoding.UTF8.GetBytes(commandName), 0, data, 0, commandName.Length);
    int bufferOffset = commandName.Length;
    foreach (var param in parameters)
    {
        Buffer.BlockCopy(new char[] { ':' }, 0, data, bufferOffset++, 1);
        Buffer.BlockCopy(Encoding.UTF8.GetBytes(param.Key), 0, data, bufferOffset, param.Key.Length);
        bufferOffset += param.Key.Length;
        Buffer.BlockCopy(new char[] {':'}, 0, data, bufferOffset++, 1);
        Buffer.BlockCopy(param.Value, 0, data, bufferOffset, param.Value.Length);
        bufferOffset += param.Value.Length;
    }

    socket.SendTo(data, slave.SlaveEP);
}

void Receive(Socket socket)
{
    byte[] buffer = new byte[1024];
    EndPoint ep = new IPEndPoint(IPAddress.Any, 0);
    while (true)
    {
        socket.ReceiveFrom(buffer, ref ep);
        string message = Encoding.UTF8.GetString(buffer);
        if (!isMaster && message.Contains("masterannounce"))
        {
            masterEp = new IPEndPoint((ep as IPEndPoint).Address, (ep as IPEndPoint).Port);
            AnnounceSlave(socket, (masterEp as IPEndPoint).Address);
        }
        else if (isMaster && message.Contains("slaveannounce"))
        {
            var slv = new Slave();
            slv.SlaveEP = new IPEndPoint((ep as IPEndPoint).Address, (ep as IPEndPoint).Port);
            slv.Rank = ++rank;
            SendRank(socket, slv);
            Console.WriteLine($"slave: {slv.SlaveEP.Address.ToString()}");
        }
        else if (isMaster == false && message.Contains("setrank"))
        {
            myRank = BitConverter.ToInt32(buffer[8..12]);
        }
        else if (isMaster && message.Contains("result"))
        {
            //receive command execution  result
        }
    }
}

IPAddress GetLocalIpAddress()
{
    var nics = from nic in NetworkInterface.GetAllNetworkInterfaces()
               where nic.OperationalStatus == OperationalStatus.Up
               select nic;

    IPAddress address = null;

    foreach (var nic in nics)
    {
        IPInterfaceProperties p = nic.GetIPProperties();


        if (p.GatewayAddresses.Count == 0)
        {
            continue;
        }

        foreach (var ua in p.UnicastAddresses)
        {
            if (ua.Address.AddressFamily == AddressFamily.InterNetwork)
            {
                address = new IPAddress(ua.Address.GetAddressBytes());
                break;
            }
        }


        break;
    }

    return address;
}