int previousNumber = 37;
int a = 131;
int m = 100;
int c = 1021;
int[] states = new int[3];
State lastState = State.S0;
double p0 = 0, p1 = 0, p2 = 0;
double diff = 0.0001;

double[,] p = new double[,]
{
    { 0.1, 0.8, 0.1 },
    { 0.3, 0.5, 0.2 },
    { 0.7, 0.2, 0.1 },
};

int iterations = 100;
int counter = 0;

while(true)
{
    double randValue = GenerateRandom();
    double value = 0;
    for (int i = 0; i < 3; i++)
    {
        if (randValue <= (p[(int)lastState, i] + value))
        {
            states[i]++;
            lastState = (State)i;
            break;
        }

        value += p[(int)lastState, i];
    }

    counter++;

    if (counter >= iterations)
    {
        if (
            p0 - ((double)states[0] / counter) < diff &&
            p1 - ((double)states[1] / counter) < diff &&
            p2 - ((double)states[2] / counter) < diff)
        {
            p0 = (double)states[0] / counter;
            p1 = (double)states[1] / counter;
            p2 = (double)states[2] / counter;
            break;
        }
    }

    p0 = (double)states[0] / counter;
    p1 = (double)states[1] / counter;
    p2 = (double)states[2] / counter;
}

Console.WriteLine($"P0 = {p0}, P1 = {p1}, P2 = {p2}");
Console.WriteLine($"Iterations: {counter}");


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