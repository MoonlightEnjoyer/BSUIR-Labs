#include <iostream>
#include <string>
#include <iostream>
#include <fstream>
#include <filesystem>

using std::string;
using std::ifstream;
using std::filesystem::path;
using std::filesystem::directory_iterator;
using std::cout;
using std::endl;

struct Neuron
{
    float state;

    void ReadState(char c)
    {
        this->state = c == '0' ? 1 : -1;
    }
};

int neuronsNumber = 100;
Neuron* neurons = new Neuron[neuronsNumber];
float** coeffs = new float*[neuronsNumber];

void WriteNeurons(string filename);
float ActivationFunction(float x);
void Learn(string filename);

int main()
{
    for (int i = 0; i < neuronsNumber; i++)
    {
        neurons[i] = Neuron();
        coeffs[i] = new float[neuronsNumber];
        for (int j = 0; j < neuronsNumber; j++)
        {
            coeffs[i][j] = 0;
        }
    }


    //LEARN
    const path learningDirectory{ "D:\\Study shit\\BSUIR-Labs\\7 term\\COSiI\\Lab3\\x64\\Debug\\learning_samples" };
    for (auto const& dir_entry : directory_iterator{ learningDirectory })
    {
        Learn(dir_entry.path().string());
        cout<< dir_entry.path() <<endl;

        for (int i = 0; i < neuronsNumber; i++)
        {
            if (i % 10 == 0 && i != 0)
            {
                cout << endl;
            }

            cout << (neurons[i].state == 1 ? "0" : ".");

        }

        cout << endl << "--------------------------------------" << endl;
    }

    //USE
    WriteNeurons("D:\\Study shit\\BSUIR-Labs\\7 term\\COSiI\\Lab3\\x64\\Debug\\noised_samples\\D.txt");
    float* finalResult = new float[neuronsNumber];
    for (int i = 0; i < neuronsNumber; i++)
    {
        float sum = 0;

        for (int j = 0; j < neuronsNumber; j++)
        {
            sum += coeffs[i][j] * neurons[j].state;
        }

        finalResult[i] = ActivationFunction(sum);
    }

    cout << "Result:" << endl;
    for (int i = 0; i < neuronsNumber; i++)
    {
        if (i % 10 == 0 && i != 0)
        {
            cout << endl;
        }

        cout << (finalResult[i] == 1 ? "0" : ".");
    }

    cout << endl;
}

void Learn(string filename)
{
    ifstream fs(filename);
    string line;
    string str;

    while (getline(fs, line))
    {
        str += line;
    }

    fs.close();

    str.erase(remove(str.begin(), str.end(), '\r'), str.end());
    str.erase(remove(str.begin(), str.end(), '\n'), str.end());
    int counter = 0;
    for (int i = 0; i < neuronsNumber; i++)
    {
        neurons[i].ReadState(str[counter++]);
    }

    for (int i = 0; i < neuronsNumber; i++)
    {
        for (int j = 0; j < neuronsNumber; j++)
        {
            if (i != j)
            {
                coeffs[i][j] += neurons[i].state * neurons[j].state;
            }
        }
    }
}

void WriteNeurons(string filename)
{
    ifstream fs(filename);
    
    string line;
    string str;

    while (getline(fs, line))
    {
        str += line;
    }

    fs.close();

    str.erase(remove(str.begin(), str.end(), '\r'), str.end());
    str.erase(remove(str.begin(), str.end(), '\n'), str.end());
    int counter = 0;
    for (int i = 0; i < neuronsNumber; i++)
    {
        neurons[i].ReadState(str[counter++]);
    }
}

float ActivationFunction(float x)
{
    return x > 0 ? 1 : -1;
}