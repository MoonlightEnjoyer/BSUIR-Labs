#include "stdint.h"
#include "stdio.h"

void Add(uint8_t* num1, uint8_t* num2);
void Div(uint8_t* num1, uint8_t* num2, uint8_t* result);
void Mul(uint8_t* num1, uint8_t* num2, uint8_t* result);
uint8_t isZero(uint8_t* num);
uint8_t* binaryAbs(uint8_t* num, uint8_t length);
uint8_t* inverseSign(uint8_t* num, uint8_t length);
uint8_t isGreater(uint8_t* num1, uint8_t* num2);

int main()
{
    uint8_t num1[] = {'0', '1', '0', '1', '\0'};//first bit is for sign
    uint8_t num2[] = {'0', '0', '0', '1', '\0'};
    uint8_t result[] = {'0', '0', '0', '0', '0', '0', '0', '\0'};
    int i = 0;
    for (i; i < 4; i++)
    {
        result[i + 3] = num1[i];
    }

    Add(result, num2);
    i = 0;
    for (i; i < 7; i++)
    {
        printf("%c", (char)(result[i]));
    }

    printf("\n");
}

//negative numbers have to be passed in two's complement representation
//can be used as subtraction
void Add(uint8_t* num1, uint8_t* num2)
{
    int i = 3;
    int j = 6;
    uint8_t carry_out = 0;
    uint8_t n1;
    uint8_t n2;
    for (i; i >= 0; i--, j--)
    {
        n1 = num1[j];
        n2 = num2[i];
        num1[j] = ((n1 - '0') ^ (n2 - '0')) ^ carry_out + '0';
        carry_out = (num1[j] - '0') ^ ((n1 - '0') | (n2 - '0') | carry_out) | ((n1 - '0') & (n2 - '0') & carry_out);
    }

    num1[j] = carry_out + '0';

    if(num1[3] == '1')
    {
        for (i = 0; i < 3; i++)
        {
            num1[i] = '1';
        }
    }
}

void Div(uint8_t* num1, uint8_t* num2, uint8_t* result)
{
    uint8_t num1_sign = num1[0];
    uint8_t num2_sign = num2[0];
    num1 = binaryAbs(num1, 4);
    num2 = binaryAbs(num2, 4);

    uint8_t* greater = num2;
    uint8_t* lesser = num1;

    if (isGreater(num1, num2))
    {
        greater = num1;
        lesser = num2;
    }

    int counter = 0;
    while (greater[0] != '1' && !isZero(greater))
    {
        Add(greater, inverseSign(lesser, 4));
        counter++;
    }


    //result = abs(greater)
    //while(result > 0)
    //{
    //  Add(abs(greater), -abs(lesser))
    //  counter++;
    //}
    //result = [sign](counter)
}

void Mul(uint8_t* num1, uint8_t* num2, uint8_t* result)
{
    //implement with msp430 multiplier
}

uint8_t isZero(uint8_t* num)
{
    int i = 0;
    for (i; i < 4; i++)
    {
        if (num[i] != '0')
        {
            return 1;
        }
    }

    return 0;
}

uint8_t* binaryAbs(uint8_t* num, uint8_t length)
{
    if (num[0] == '0')
    {
        return num;
    }

    int i = 0;
    for (i; i < length; i++)
    {
        num[i] = num[i] == '1' ? '0' : '1';
    }

    uint8_t one[] = {'0', '0', '0', '1', '\0'};
    Add(num, one);
    return num;
}

uint8_t isGreater(uint8_t* num1, uint8_t* num2)
{
    int i = 0;
    for (i; i < 4; i++)
    {
        if (num1[i] > num2[i])
        {
            return 1;
        }
        else
        {
            return 0;
        }
    }

    return 0;
}

uint8_t* inverseSign(uint8_t* num, uint8_t length)
{
    int i = 0;
    for(i; i < length; i++)
    {
        num[i] = num[i] == '1' ? '0' : '1';
    }

    uint8_t one[] = {'0', '0', '0', '1', '\0'};
    Add(num, one);
    return num;
}