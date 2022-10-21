Neuron[] neurons = new Neuron[100];
float[,] coeffs = new float[neurons.Length, neurons.Length];
for (int i = 0; i < neurons.Length; i++)
{
    neurons[i] = new Neuron();
}

//LEARN
foreach (var filename in Directory.GetFiles(Directory.GetCurrentDirectory() + "/learning_samples"))
{
    Learn(filename);
    Console.WriteLine(filename);

    for (int i = 0; i < neurons.Length; i++)
    {
        if (i % 10 == 0 && i != 0)
        {
            Console.WriteLine();
        }

        Console.Write(neurons[i].State == State.Enabled ? "0" : ".");

        
    }

    Console.WriteLine("\n--------------------------------------");
}

//USE
WriteNeurons(Directory.GetCurrentDirectory() + "/noised_samples/D.txt");
float[] finalResult = new float[neurons.Length];
for (int i = 0; i < neurons.Length; i++)
{
    float sum = 0;

    for (int j = 0; j < neurons.Length; j++)
    {
        sum += coeffs[i, j] * (float)neurons[j].State;
    }

    finalResult[i] = ActivationFunction(sum);
}

Console.WriteLine("Result:");
for (int i = 0; i < neurons.Length; i++)
{
    if (i % 10 == 0 && i != 0)
    {
        Console.WriteLine();
    }

    Console.Write(finalResult[i] == 1 ? "0" : ".");

}


//float[,] Multiply(float[,] m1, float[,] m2)
//{
//    float[,] result = new float[, m1.Length];

//    for (int i = 0; i < 10; i++)
//    {
//        for (int j = 0; j < 10; j++)
//        {
//            result[i, j] = m1[i, j] + m2[i, j];
//        }
//    }

//    return result;
//}

void Learn(string filename)
{
    using FileStream fs = new FileStream(filename, FileMode.Open);
    using StreamReader reader = new StreamReader(fs);
    string str = reader.ReadToEnd();
    str = str.Replace("\r\n", string.Empty);
    int counter = 0;
    for(int i = 0; i < neurons.Length; i++)
    {
        neurons[i].ReadState(str[counter++]);
    }

    for (int i = 0; i < neurons.Length; i++)
    {
        for (int j = 0; j < neurons.Length; j++)
        {
            if (i != j)
            {
                coeffs[i, j] += (float)neurons[i].State * (float)neurons[j].State;
            }
        }
    }
}

void WriteNeurons(string filename)
{
    using FileStream fs = new FileStream(filename, FileMode.Open);
    using StreamReader reader = new StreamReader(fs);
    string str = reader.ReadToEnd();
    str = str.Replace("\r\n", string.Empty);
    int counter = 0;
    for (int i = 0; i < neurons.Length; i++)
    {
        neurons[i].ReadState(str[counter++]);
    }
}

float ActivationFunction(float x)
{
    return x > 0 ? 1 : -1;
}

//float[,] AddMatrices(float[,] matrix1, float[,] matrix2)
//{
//    float[,] result = new float[10, 10];

//    for (int i = 0; i < 10; i++)
//    {
//        for (int j = 0; j < 10; j++)
//        {
//            result[i, j] = matrix1[i, j] + matrix2[i, j];
//        }
//    }

//    return result;
//}

//float[,] MultiplyMatrices(float[,] matrix1, float[,] matrix2)
//{
//    float[,] result = new float[10, 10];

//    for (int i = 0; i < 10; i++)
//    {
//        for (int j = 0; j < 10; j++)
//        {
//            for (int r = 0; r < 10; r++)
//            {
//                result[i, j] += matrix1[i, r] * matrix2[r, j];
//            }
//        }
//    }

//    return result;
//}

//float[,] TransponeMatrix(float[,] matrix)
//{
//    float[,] result = new float[10, 10];
//    for (int i = 0; i < 10; i++)
//    {
//        for (int j = 0; j < 10; j++)
//        {
//            result[j, i] = matrix[i, j];
//        }
//    }

//    return result;
//}

enum State
{
    Disabled = -1,
    Enabled = 1
}

class Neuron
{
    public State State { get; set; }

    public void ReadState(char c)
    {
        this.State = c == '0' ? State.Enabled : State.Disabled;
    }
}


