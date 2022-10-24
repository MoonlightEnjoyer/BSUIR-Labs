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
WriteNeurons(Directory.GetCurrentDirectory() + "/noised_samples/К.txt");
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

void Learn(string filename)
{
    using FileStream fs = new FileStream(filename, FileMode.Open);
    using StreamReader reader = new StreamReader(fs);
    string str = reader.ReadToEnd();
    str = str.Replace("\r\n", string.Empty);
    for(int i = 0; i < neurons.Length; i++)
    {
        neurons[i].ReadState(str[i]);
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
    for (int i = 0; i < neurons.Length; i++)
    {
        neurons[i].ReadState(str[i]);
    }
}

float ActivationFunction(float x)
{
    return x > 0 ? 1 : -1;
}

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


