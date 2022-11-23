int x1 = 79;
int a = 131;
int c = 1021;
int m = 100;

double lambda = 0.1;
int mu = 2;

int prevNumber = x1;
List<double> randomProbabilities = new List<double>();
List<double> fList = new List<double>();
List<double> gList = new List<double>();

for (int i = 0; i < 100; i++)
{
    var generatedNumber = RandomNumber(prevNumber);
    prevNumber = generatedNumber;
    randomProbabilities.Add((double)generatedNumber / 100);
    fList.Add(F(randomProbabilities[i]));
    gList.Add(G(randomProbabilities[i]));
}

Console.WriteLine("PROBABILITIES:");
foreach (var p in randomProbabilities)
{
    Console.Write($"{p} ");
}
Console.WriteLine();

Console.WriteLine("F functions:");
foreach (var f in fList)
{
    Console.Write($"{f} ");
}
Console.WriteLine();


Console.WriteLine("G functions:");
foreach (var g in gList)
{
    Console.Write($"{g} ");
}
Console.WriteLine();

Console.WriteLine("Average service time:");
Console.WriteLine(AverageServiceTime(gList));

Console.WriteLine("Average staying time:");
Console.WriteLine(AverageStaying(AverageDowntime(Downtime(gList, fList)), AverageServiceTime(gList)));

Console.WriteLine("Load percentage:");
Console.WriteLine(LoadPercentage());

int RandomNumber(int prevNum)
{
    return (a * prevNum + c) % m;
}

double F(double p)
{
    return Math.Round(p * 10);
}

double G(double p)
{
    var log = Math.Log(1 - p) * (-1);
    var t = mu / log;

    return Math.Round(t, 1);
}

double AverageServiceTime(List<double> gList)
{
    return gList.Average();
}

List<double> Downtime(List<double> gList, List<double> fList)
{
    List<double> downtime = new List<double>();
    double delay;
    for (int i = 0; i < fList.Count - 1; i++)
    {
        delay = gList[i] = fList[i + 1];
        if (delay > 0)
        {
            downtime.Add(delay);
        }
    }

    return downtime;
}

double AverageDowntime(List<double> downtime)
{
    return downtime.Average();
}

double AverageStaying(double averageDowntime, double averageService)
{
    return averageDowntime + averageService;
}

double LoadPercentage()
{
    return lambda / mu;
}