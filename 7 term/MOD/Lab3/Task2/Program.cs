int previousNumber = 37;
int a = 131;
int m = 101;
int c = 1021;
State lastState = State.S0;

double[,] p = new double[,]
{
    { 0.2, 0.1, 0.7 },
    { 0.0, 1, 0 },
    { 0.3, 0.6, 0.1 },
};

int counter = 0;

while(true)
{
    double randValue = GenerateRandom();
    double value = 0;
    for (int i = 0; i < 3; i++)
    {
        if (randValue <= (p[(int)lastState, i] + value))
        {
            lastState = (State)i;
            break;
        }

        value += p[(int)lastState, i];
    }

    if (lastState == State.S1)
    {
        Console.WriteLine($"It took {counter + 1} iterations to enter absorbing state.");
        break;
    }

    counter++;
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