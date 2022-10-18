int previousNumber = 37;
int a = 131;
int m = 101;
int c = 1021;
State[] buffer = Enumerable.Repeat(State.NoState, 10).ToArray();
State lastState = State.S0;

double[,] p = new double[,]
{
    { 0.2, 0.1, 0.7 },
    { 0.0, 1, 0 },
    { 0.3, 0.6, 0.1 },
};

int iterations = 100;

for (int counter = 0; counter < iterations; counter++)
{
    double randValue = GenerateRandom();
    double value = 0;
    for (int i = 0; i < 3; i++)
    {
        if (randValue <= (p[(int)lastState, i] + value))
        {
            buffer[counter % 10] = (State)i;
            lastState = (State)i;
            break;
        }

        value += p[(int)lastState, i];
    }

    if (buffer.All(e => e == buffer[0]))
    {
        Console.WriteLine(counter - buffer.Length);
        break;
    }
}

double GenerateRandom()
{
    previousNumber = (a * previousNumber + c) % m;
    return (double)previousNumber / 100;
}


enum State
{
    NoState = -1,
    S0,
    S1,
    S2,
}