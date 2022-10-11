int previousNumber = 37;
int a = 131;
int m = 101;
int c = 1021;

double[,] p = new double[,]
{
    { 0.1, 0.8, 0.1 },
    { 0.3, 0.5, 0.2 },
    { 0.7, 0.2, 0.1 },
};

State currentState = State.S0;

for (int i = 0; i < 100; i++)
{
    double randValue = GenerateRandom();
}

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