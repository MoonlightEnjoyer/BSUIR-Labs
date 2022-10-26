#include <iostream>
#include <string>
#include <iostream>
#include <fstream>
#include <filesystem>
using namespace std;

using std::string;
using std::ifstream;
using std::filesystem::path;
using std::filesystem::directory_iterator;
using std::cout;
using std::endl;

struct Neuron
{
    int state;
};

int neuronsNumber = 100;
vector<Neuron> neurons(100);
vector<vector<int>> coeffs(100);

void WriteNeurons(string filename);
int ActivationFunction(int x);
void Learn(string filename);
void SaveToFile(string filename, vector<int> image);
void ProcessImage(string filename);

int main()
{
    for (int i = 0; i < neuronsNumber; i++)
    {
        neurons[i] = Neuron();
        coeffs[i] = vector<int>(100);
        for (int j = 0; j < neuronsNumber; j++)
        {
            coeffs[i][j] = 0;
        }
    }


    //LEARN
    const path learningDirectory{ "C:\\Users\\Dude\\Desktop\\BSUIR-Labs\\7 term\\COSiI\\Lab3\\x64\\Debug\\learning_samples" };
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
    const path noisedDirectory{ "C:\\Users\\Dude\\Desktop\\BSUIR-Labs\\7 term\\COSiI\\Lab3\\x64\\Debug\\noised_samples" };
    for (auto const& dir_entry : directory_iterator{ noisedDirectory })
    {
        ProcessImage(dir_entry.path().string());
    }
}

void ProcessImage(string filename)
{
    WriteNeurons(filename);
    vector<int> finalResult;
    for (int i = 0; i < neuronsNumber; i++)
    {
        int sum = 0;

        for (int j = 0; j < neuronsNumber; j++)
        {
            sum += coeffs[i][j] * neurons[j].state;
        }

        finalResult.push_back(ActivationFunction(sum));
    }



    SaveToFile("C:\\Users\\Dude\\Desktop\\BSUIR-Labs\\7 term\\COSiI\\Lab3\\x64\\Debug\\results\\" + filesystem::path(filename).filename().string(), finalResult);
}

void Learn(string filename)
{
    ifstream fs(filename);
    string line;
    string str;
    char* buffer = new char[29];
    fs.read(buffer, 29);

    fs.close();

    vector<char> buf;

    int cccc = 0;
    for (int i = 9; i < 29; i++)
    {
        char c = buffer[i];
        for (int j = 0; j < 8; j++, c <<= 1)
        {
            if ((c & 256) == 256)
            {
                //cout << "0";
                buf.push_back(1);
            }
            else
            {
                //cout << ".";
                buf.push_back(-1);
            }
            cccc++;
            if (cccc % 10 == 0)
            {
                //cout << endl;
                break;
            }
        }
    }

    for (int i = 0; i < neuronsNumber; i++)
    {
        neurons[i].state = buf[i];
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
    ifstream fs(filename, ios::binary);
    std::vector<unsigned char> buffer(std::istreambuf_iterator<char>(fs), {});

    fs.close();

    char* buf = new char[neuronsNumber];

    int counter = 0;
    for (int i = 9; i < 29; i++)
    {
        char c = buffer[i];
        for (int j = 0; j < 8; j++, c <<= 1)
        {
            if ((c & 256) == 256)
            {
                cout << "0";
                buf[counter] = 1;
            }
            else
            {
                cout << ".";
                buf[counter] = -1;
            }
            counter++;
            if (counter % 10 == 0)
            {
                cout << endl;
                break;
            }
        }
    }

    for (int i = 0; i < neuronsNumber; i++)
    {
        neurons[i].state = buf[i];
    }
}

void SaveToFile(string filename, vector<int> image)
{
    ofstream ofs;
    ofs.open(filename, ofstream::out | ofstream::binary);
    char* wrt_str = new char[9] { 'P', '4', '\n', '1', '0', '\n', '1', '0', '\n' };
    ofs.write(wrt_str, 9);
    vector<char> result;
   
    string str;


    //int counter = 0;
    for (int i = 0; i < neuronsNumber; i+= 10)
    {
        char c = 0;
        for (int j = 0; j < 8; j++)
        {
            if (i + j >= neuronsNumber)
            {
                break;
            }

            c <<= 1;
            c |= ((image[i + j] == 1) ? 1 : 0);
        }

        result.push_back(c);
        c = 0;
        c |= ((image[i + 8] == 1) ? 1 : 0);
        c <<= 1;
        c |= ((image[i + 9] == 1) ? 1 : 0);
        c <<= 6;
        result.push_back(c);
    }

    //ofs.write(reinterpret_cast<const char*>(&mem_buf[0]), 20);
    ofs.write(reinterpret_cast<const char*>(&result[0]), 20);

   ofs.close();
}

int ActivationFunction(int x)
{
    return x > 0 ? 1 : -1;
}