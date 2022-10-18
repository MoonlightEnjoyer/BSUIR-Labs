int previousNumber = 37;
int a = 131;
int m = 100;
int c = 1021;
int[] states = new int[3];
State lastState = State.S0;

double[,] p = new double[,]
{
    { 0.1, 0.8, 0.1 },
    { 0.3, 0.5, 0.2 },
    { 0.7, 0.2, 0.1 },
};

int iterations = 20000;

for (int counter = 0; counter < iterations; counter++)
{
    double randValue = GenerateRandom();
    double value = 0;
    for (int i = 0; i < 3; i++)
    {
        if (randValue <= (p[(int)lastState, i] + value) && randValue > value)
        {
            states[i]++;
            lastState = (State)i;
            break;
        }

        value += p[(int)lastState, i];
    }    
}
Console.WriteLine($"P0 = {(double)states[0] / iterations}, P1 = {(double)states[1] / iterations}, P2 = {(double)states[2] / iterations}");

double GenerateRandom()
{
    previousNumber = (a * previousNumber + c) % m;
    return (double)previousNumber / 100;
}


enum State
{
    S0,
    S1,
    S2,
}