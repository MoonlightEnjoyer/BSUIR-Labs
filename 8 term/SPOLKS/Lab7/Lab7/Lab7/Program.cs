using Lab7;
using MatrixGenerator;
using System.IO.Compression;
using System.Net;
using System.Net.NetworkInformation;
using System.Net.Sockets;
using System.Reflection;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks.Dataflow;

Socket s = new Socket(AddressFamily.InterNetwork, SocketType.Dgram, ProtocolType.Udp);
EndPoint local = new IPEndPoint(GetLocalIpAddress(), 60000);

s.Bind(local);

byte rank = 0;

byte myRank = 0;

List<Slave> slaves = new List<Slave>();

bool isMaster = args[0] == "master" ? true : false;
s.EnableBroadcast = true;
EndPoint masterEp = null;

int[] row = Array.Empty<int>();
int[] column = Array.Empty<int>();

int[,] matrix1 = null;
int[,] matrix2 = null;
int[,] resultMatrix = null;
if (isMaster)
{
    matrix1 = Matrix.CreateMatrix(int.Parse(args[1]), int.Parse(args[2]));
    matrix2 = Matrix.CreateMatrix(int.Parse(args[3]), int.Parse(args[4]));
    resultMatrix = new int[matrix1.GetLength(0), matrix2.GetLength(1)];
}

Thread receiveThread = new Thread(() => Receive(s));
receiveThread.Start();

if (isMaster)
{
    AnnounceMaster(s);
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

bool run = true;
//op = 1 - multiply
while (run)
{
    if (isMaster)
    {
        foreach (var slave in slaves)
        {
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
                slave.Row = rowNumber;
                slave.Column = columnNumber;
                Console.WriteLine("Row:");
                foreach(var b in r)
                {
                    Console.WriteLine(b);
                }
                Console.WriteLine("Column:");
                foreach (var b in c)
                {
                    Console.WriteLine(b);
                }
                SendCommand(s, slave, parameters);
                slave.Free = false;
                
                columnNumber++;
                if (columnNumber == matrix2.GetLength(1))
                {
                    if (rowNumber == matrix1.GetLength(0))
                    {
                        run = false;
                        break;
                    }
                    columnNumber = 0;
                    rowNumber++;
                }
            }
        }
    }
    else
    {
        if (receivedData)
        {
            receivedData = false;
            foreach (var b in row)
            {
                Console.WriteLine(b);
            }
            Console.WriteLine("Column:");
            foreach (var b in column)
            {
                Console.WriteLine(b);
            }
            int res = Multiply(row, column);
            Console.WriteLine($"row * column = {res}");
            SendResult(s, res);
        }
    }
}

if (isMaster)
{
    Console.WriteLine("Multiplication finished.");
    Matrix.WriteToFile("mpi_matrix.txt", resultMatrix);
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

int Multiply(int[] r, int[] c)
{
    int result = 0;
    for (int i = 0; i < r.Length; i++)
    {
        for (int j = 0; j < c.Length; j++)
        {
            result += r[i] * c[j];
        }
    }

    return result;
}

void SendRank(Socket socket, Slave slave)
{
    byte[] buffer = new byte[11];
    Buffer.BlockCopy(Encoding.UTF8.GetBytes("setrank"), 0, buffer, 0, 7);
    Buffer.BlockCopy(BitConverter.GetBytes(slave.Rank), 0, buffer, 7, 4);
    socket.SendTo(buffer, slave.SlaveEP);
}

void SendResult(Socket socket, int value)
{
    byte[] buffer = new byte[11];
    Buffer.BlockCopy(Encoding.UTF8.GetBytes("result"), 0, buffer, 0, 6);
    buffer[6] = myRank;
    Buffer.BlockCopy(BitConverter.GetBytes(value), 0, buffer, 7, 4);
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
        int counter = 0;
        for (int i = bufferOffset; i < bufferOffset + param.value.Length * 4; i += 4)
        {
            var byteValue = BitConverter.GetBytes(param.value[counter++]);
            for (int j = 0; j < 4; j++)
            {
                data[i + j] = byteValue[j];
            }
        }
        //Buffer.BlockCopy(param.value, 0, data, bufferOffset, param.value.Length * 4);
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
            myRank = buffer[8];
        }
        else if (!isMaster && message.Contains("command"))
        {
            int rowLength = BitConverter.ToInt32(buffer[8..12]);
            int columnLength = BitConverter.ToInt32(buffer[(12 + rowLength * 4 + 1)..(12 + rowLength * 4 + 1 + 4)]);
            row = new int[rowLength];
            column = new int[columnLength];
            for (int i = 0; i < rowLength; i += 4)
            {
                row[i / 4] = BitConverter.ToInt32(buffer[(12 + i)..(12 + i + 4)]);
            }

            for (int i = 0; i < columnLength; i += 4)
            {
                column[i / 4] = BitConverter.ToInt32(buffer[(12 + rowLength + 1 + i)..(12 + rowLength + 1 + i + 4)]);
            }
            //Buffer.BlockCopy(buffer, 12, row, 0, rowLength);
            //Buffer.BlockCopy(buffer, 12 + rowLength + 1, column, 0, columnLength);
            receivedData = true;
        }
        else if (isMaster && message.Contains("result"))
        {
            var sl = slaves.Find(e => e.Rank == buffer[6]);
            resultMatrix[sl.Row, sl.Column] = BitConverter.ToInt32(buffer[7..11]);
            sl.Free = true;
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