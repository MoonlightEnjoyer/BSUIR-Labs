using Lab7;
using MatrixGenerator;
using System.IO.Compression;
using System.Net;
using System.Net.NetworkInformation;
using System.Net.Sockets;
using System.Security.Cryptography;
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

int[] row = Array.Empty<int>();
int[] column = Array.Empty<int>();

Thread receiveThread = new Thread(() => Receive(s));
receiveThread.Start();
int[,] matrix1 = null;
int[,] matrix2 = null;

if (isMaster)
{
    AnnounceMaster(s);
    matrix1 = Matrix.CreateMatrix(int.Parse(args[1]), int.Parse(args[2]));
    matrix2 = Matrix.CreateMatrix(int.Parse(args[3]), int.Parse(args[4]));
    Thread.Sleep(3000);
    int i = 0;
    foreach (var slave in slaves)
    {
        slave.Free = true;
        Console.WriteLine($"slave {i++}: {slave.SlaveEP.Address}");
    }
}

bool receivedData = false;

int rowNumber = 0;
int columnNumber = 0;


//op = 1 - multiply
while (true)
{
    if (isMaster)
    {
        foreach (var slave in slaves)
        {
            Console.WriteLine(slave.Free);
            if (slave.Free)
            {
                List<(byte op, int length, int[] value)> parameters = new List<(byte op, int length, int[] value)>();
                int[] r = new int[matrix1.GetLength(0)];
                int[] c = new int[matrix2.GetLength(1)];
                Buffer.BlockCopy(matrix1, rowNumber * matrix1.GetLength(0) * 4, r, 0, matrix1.GetLength(0) * 4);

                for (int j = 0; j < matrix2.GetLength(1); j++)
                {
                    c[j] = matrix2[j, columnNumber];
                }

                parameters.Add((1, r.Length, r));
                parameters.Add((1, c.Length, c));
                SendCommand(s, slave, parameters);
                slave.Free = false;
                rowNumber++;
                columnNumber++;
            }
        }
    }
    else
    {
        if (receivedData)
        {
            Console.WriteLine($"Matrix size: {row.Length} {column.Length}");
        }
    }
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

void SendCommand(Socket socket, Slave slave, List<(byte op, int length, int[] value)> parameters)
{
    byte[] data = new byte["command".Length + parameters.Sum(p => (1 + 4 + p.value.Length * 4))];
    Buffer.BlockCopy(Encoding.UTF8.GetBytes("command"), 0, data, 0, 7);
    int bufferOffset = 7;
    foreach (var param in parameters)
    {
        data[bufferOffset++] = param.op;
        Buffer.BlockCopy(BitConverter.GetBytes(param.length), 0, data, bufferOffset, 4);
        bufferOffset += 4;
        Buffer.BlockCopy(param.value, 0, data, bufferOffset, param.value.Length * 4);
        bufferOffset += param.value.Length * 4;
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
            slaves.Add(slv);
        }
        else if (isMaster == false && message.Contains("setrank"))
        {
            myRank = BitConverter.ToInt32(buffer[8..12]);
        }
        else if (!isMaster && message.Contains("command"))
        {
            int rowLength = BitConverter.ToInt32(buffer[8..12]);
            int columnLength = BitConverter.ToInt32(buffer[(12 + rowLength)..]);
            Buffer.BlockCopy(buffer, 12, row, 0, rowLength);
            Buffer.BlockCopy(buffer, 12 + rowLength, column, 0, columnLength);
            receivedData = true;
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