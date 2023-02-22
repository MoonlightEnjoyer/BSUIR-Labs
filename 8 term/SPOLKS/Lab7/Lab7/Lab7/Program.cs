using Lab7;
using MatrixGenerator;
using System.Diagnostics;
using System.Diagnostics.Metrics;
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

int bufferSize = s.ReceiveBufferSize;


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
    Matrix.WriteToFile("mpi_source_matrix1.txt", matrix1);
    Matrix.WriteToFile("mpi_source_matrix2.txt", matrix2);
    resultMatrix = new int[matrix1.GetLength(0), matrix2.GetLength(1)];
}

int rowNumber = 0;
int columnNumber = 0;

Mutex mutex = new Mutex();

Thread receiveThread = new Thread(() => Receive(s));
Thread multiplyThread = new Thread(() => MultiplyThread());
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

    multiplyThread.Start();
}



bool receivedData = false;



bool run = true;
//op = 1 - multiply
long mpiMul;
long mul;
Stopwatch stopwatch1 = new Stopwatch();
Stopwatch stopwatch2 = new Stopwatch();



stopwatch1.Start();

while (run)
{
    if (isMaster)
    {
        foreach (var slave in slaves)
        {
            if (rowNumber == matrix1.GetLength(0))
            {
                run = false;
                break;
            }


            if (slave.Free)
            {
                int[] r_slave = new int[matrix1.GetLength(0)];
                int[] c_slave = new int[matrix2.GetLength(1)];
                //Console.WriteLine("Sending data to slave.");

                int c_n, r_n;

                List<(byte op, int length, int[] value)> parameters = new List<(byte op, int length, int[] value)>();

                mutex.WaitOne();
                if (columnNumber == matrix2.GetLength(1))
                {
                    //rowNumber++;
                    Interlocked.Increment(ref rowNumber);
                    Interlocked.Exchange(ref columnNumber, 0);
                    //columnNumber = 0;
                }

                if (rowNumber == matrix1.GetLength(0))
                {
                    mutex.ReleaseMutex();
                    break;
                }

                Buffer.BlockCopy(matrix1, rowNumber * matrix1.GetLength(0) * 4, r_slave, 0, matrix1.GetLength(0) * 4);

                for (int j = 0; j < matrix2.GetLength(1); j++)
                {
                    c_slave[j] = matrix2[j, columnNumber];
                }

                c_n = columnNumber;
                r_n = rowNumber;
                Interlocked.Increment(ref columnNumber);
                //columnNumber++;
                if (columnNumber == matrix2.GetLength(1))
                {
                    //rowNumber++;
                    Interlocked.Increment(ref rowNumber);
                    Interlocked.Exchange(ref columnNumber, 0);
                    //columnNumber = 0;
                }

                mutex.ReleaseMutex();

                parameters.Add((1, r_slave.Length, r_slave));
                parameters.Add((1, c_slave.Length, c_slave));
                slave.Row = r_n;
                slave.Column = c_n;
                //Console.WriteLine("Row:");
                //foreach(var b in r)
                //{
                //    Console.WriteLine(b);
                //}
                //Console.WriteLine("Column:");
                //foreach (var b in c)
                //{
                //    Console.WriteLine(b);
                //}
                SendCommand(s, slave, parameters);
                slave.Free = false;
            }
        }
    }
    else
    {
        if (receivedData)
        {
            receivedData = false;
            //foreach (var b in row)
            //{
            //    Console.WriteLine(b);
            //}
            //Console.WriteLine("Column:");
            //foreach (var b in column)
            //{
            //    Console.WriteLine(b);
            //}
            int res = Multiply(row, column);
            //Console.WriteLine($"row * column = {res}");
            SendResult(s, res);
        }
    }
}

while (slaves.Any(sl => !sl.Free))
{

}

stopwatch1.Stop();
mpiMul = stopwatch1.ElapsedMilliseconds;

if (isMaster)
{
    Matrix.WriteToFile("mpi_matrix.txt", resultMatrix);
    stopwatch2.Start();
    var resultReference = Matrix.MultiplyMatrices(matrix1, matrix2);
    stopwatch2.Stop();
    mul = stopwatch2.ElapsedMilliseconds;
    Matrix.WriteToFile("reference.txt", resultReference);
    Console.WriteLine("Multiplication finished.");
    Console.WriteLine($"Single thread multiplication: {mul} ms");
    Console.WriteLine($"MPI multiplication: {mpiMul} ms");
    Console.Write("Comparing matrices: ");
    Console.WriteLine(Matrix.CompareMatrices(resultMatrix, resultReference));
}


void AnnounceMaster(Socket socket)
{
    EndPoint broadcast = new IPEndPoint(new IPAddress(new byte[] { 192, 168, 0, 255 }), 60000);
    socket.SendTo(new byte[] { 0 }, broadcast);
    //socket.SendTo(Encoding.UTF8.GetBytes("masterannounce"), broadcast);
}

void AnnounceSlave(Socket socket, IPAddress masterAddress)
{
    EndPoint master = new IPEndPoint(masterAddress, 60000);
    socket.SendTo(new byte[] { 1 }, master);
    //socket.SendTo(Encoding.UTF8.GetBytes("slaveannounce"), master);
}

void MultiplyThread()
{
    int[] r = new int[matrix1.GetLength(0)];
    int[] c = new int[matrix2.GetLength(1)];

    while (true)
    {
        
        int c_n, r_n;
        mutex.WaitOne();

        //Console.WriteLine($"inside thread {rowNumber} {columnNumber}");

        if (columnNumber == matrix2.GetLength(1))
        {
            //rowNumber++;
            Interlocked.Increment(ref rowNumber);
            Interlocked.Exchange(ref columnNumber, 0);
            //columnNumber = 0;
        }

        if (rowNumber == matrix1.GetLength(0))
        {
            mutex.ReleaseMutex();
            break;
        }

        Buffer.BlockCopy(matrix1, rowNumber * matrix1.GetLength(0) * 4, r, 0, matrix1.GetLength(0) * 4);

        for (int j = 0; j < matrix2.GetLength(1); j++)
        {
            c[j] = matrix2[j, columnNumber];
        }

        c_n = columnNumber;
        r_n = rowNumber;

        Interlocked.Increment(ref columnNumber);
        //columnNumber++;
        if (columnNumber == matrix2.GetLength(1))
        {
            //rowNumber++;
            Interlocked.Increment(ref rowNumber);
            Interlocked.Exchange(ref columnNumber, 0);
            //columnNumber = 0;
        }

        mutex.ReleaseMutex();

        resultMatrix[r_n, c_n] = Multiply(r, c);

        if (rowNumber == matrix1.GetLength(0))
        {
            break;
        }
    }
}

int Multiply(int[] r, int[] c)
{
    int result = 0;
    for (int i = 0; i < r.Length; i++)
    {
        result += r[i] * c[i];
        //Console.WriteLine($"{r[i]} * {c[i]}");
    }

    //Console.WriteLine("---------------------------");

    return result;
}

void SendRank(Socket socket, Slave slave)
{
    byte[] buffer = new byte[2];
    //Buffer.BlockCopy(Encoding.UTF8.GetBytes("setrank"), 0, buffer, 0, 7);
    buffer[0] = 2;
    buffer[1] = (byte)slave.Rank;
    //Buffer.BlockCopy(BitConverter.GetBytes(slave.Rank), 0, buffer, 1, 4);
    socket.SendTo(buffer, slave.SlaveEP);
}

void SendResult(Socket socket, int value)
{
    byte[] buffer = new byte[6];
    //Buffer.BlockCopy(Encoding.UTF8.GetBytes("result"), 0, buffer, 0, 6);
    buffer[0] = 4;
    buffer[1] = myRank;
    Buffer.BlockCopy(BitConverter.GetBytes(value), 0, buffer, 2, 4);
    socket.SendTo(buffer, masterEp);
}

void SendCommand(Socket socket, Slave slave, List<(byte op, int length, int[] value)> parameters)
{
    byte[] data = new byte[1 + parameters.Sum(p => (1 + 4 + p.value.Length * 4))];
    //Buffer.BlockCopy(Encoding.UTF8.GetBytes("command"), 0, data, 0, 7);
    data[0] = 3;
    int bufferOffset = 1;
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

//masterannounce = 0
//slaveannounce = 1
//setrank = 2
//command = 3
//result = 4
void Receive(Socket socket)
{
    byte[] buffer = new byte[bufferSize];
    EndPoint ep = new IPEndPoint(IPAddress.Any, 0);
    while (true)
    {
        socket.ReceiveFrom(buffer, ref ep);
        //string message = Encoding.UTF8.GetString(buffer);
        if (!isMaster && buffer[0] == 0)
        {
            masterEp = new IPEndPoint((ep as IPEndPoint).Address, (ep as IPEndPoint).Port);
            AnnounceSlave(socket, (masterEp as IPEndPoint).Address);
        }
        else if (isMaster && buffer[0] == 1)
        {
            var slv = new Slave();
            slv.SlaveEP = new IPEndPoint((ep as IPEndPoint).Address, (ep as IPEndPoint).Port);
            slv.Rank = ++rank;
            SendRank(socket, slv);
            slaves.Add(slv);
        }
        else if (isMaster == false && buffer[0] == 2)
        {
            myRank = buffer[1];
        }
        else if (!isMaster && buffer[0] == 3)
        {
            int rowLength = BitConverter.ToInt32(buffer[2..6]);
            int columnLength = BitConverter.ToInt32(buffer[(6 + rowLength * 4 + 1)..(6 + rowLength * 4 + 1 + 4)]);
            row = new int[rowLength];
            column = new int[columnLength];

            for (int i = 0; i < rowLength * 4; i += 4)
            {
                row[i / 4] = BitConverter.ToInt32(buffer[(6 + i)..(6 + i + 4)]);
            }

            for (int i = 0; i < columnLength * 4; i += 4)
            {
                column[i / 4] = BitConverter.ToInt32(buffer[(6 + rowLength * 4 + 5 + i)..(6 + rowLength * 4 + 5 + i + 4)]);
            }

            //Buffer.BlockCopy(buffer, 6, row, 0, rowLength);
            //Buffer.BlockCopy(buffer, 6 + rowLength * 4 + 5, column, 0, columnLength);
            receivedData = true;
        }
        else if (isMaster && buffer[0] == 4)
        {
            var sl = slaves.FindIndex(e => e.Rank == buffer[1]);
            resultMatrix[slaves[sl].Row, slaves[sl].Column] = BitConverter.ToInt32(buffer[2..6]);
            slaves[sl].Free = true;
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