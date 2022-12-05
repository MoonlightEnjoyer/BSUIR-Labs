#include "stdint.h"
#include "stdio.h"

void Add(uint8_t* num1, uint8_t* num2);
void Add4(uint8_t* num1, uint8_t* num2);
void Div(uint8_t* num1, uint8_t* num2, uint8_t* result);
uint8_t isNotZero(uint8_t* num);
uint8_t isGreater(uint8_t* num1, uint8_t* num2);
uint8_t areEqual(uint8_t* num1, uint8_t* num2, uint8_t length);
void Compl(uint8_t* num, uint8_t length);

int main()
{
    uint8_t num1[] = { '1', '1', '1', '1', '\0' };//first bit is for sign
    uint8_t num2[] = { '1', '0', '1', '1', '\0' };
    uint8_t result[] = { '0', '0', '0', '0', '0', '0', '0', '\0' };
    int i = 0;
    for (i; i < 4; i++)
    {
        result[i + 3] = num1[i];
    }

    Add(result, num2);
    //Div(num1, num2, result);
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
    uint8_t temp2[] = { '0', '0', '0', '0', '0', '0', '0', '\0'};
    int i;
    for (i = 3; i < 7; i++)
    {
        temp2[i] = num2[i - 3];
    }

    if (num1[3] == '1')
    {
        num1[3] = '0';
        num1[0] = '1';
        Compl(num1, 7);
    }

    if (temp2[3] == '1')
    {
        temp2[3] = '0';
        temp2[0] = '1';
        Compl(temp2, 7);
    }

    i = 3;
    int j = 6;
    uint8_t carry_out = 0;
    uint8_t n1;
    uint8_t n2;
    for (j; j >= 0; j--)
    {
        n1 = num1[j];
        n2 = temp2[j];
        num1[j] = ((n1 - '0') ^ (n2 - '0')) ^ carry_out + '0';
        carry_out = ((n1 - '0') & (n2 - '0')) | ((n1 - '0') & carry_out) | ((n2 - '0') & carry_out);
    }

    if (num1[0] == '1')
    {
        Compl(num1, 7);
    }
}

void Add4(uint8_t* num1, uint8_t* num2)
{
    int i;

    if (num1[0] == '1')
    {
        Compl(num1, 4);
    }

    if (num2[0] == '1')
    {
        Compl(num2, 4);
    }

    i = 3;
    uint8_t carry_out = 0;
    uint8_t n1;
    uint8_t n2;
    for (i; i >= 0; i--)
    {
        n1 = num1[i];
        n2 = num2[i];
        num1[i] = ((n1 - '0') ^ (n2 - '0')) ^ carry_out + '0';
        carry_out = ((n1 - '0') & (n2 - '0')) | ((n1 - '0') & carry_out) | ((n2 - '0') & carry_out);
    }

    if (num1[0] == '1')
    {
        Compl(num1, 4);
    }

    if (num2[0] == '1')
    {
        Compl(num2, 4);
    }
}


void Compl(uint8_t* num, uint8_t length)
{
    uint8_t i = 1;
    for (i; i < length; i++)
    {
        num[i] = num[i] == '1' ? '0' : '1';
    }

    uint8_t carry_out = '0';
    if (num[length - 1] == '1')
    {
        carry_out = '1';
        num[length - 1] = '0';
        for (i = length - 2; i > 0; i--)
        {
            if (num[i] == '1' && carry_out == '1')
            {
                carry_out = '1';
                num[i] = '0';
            }
            else if (num[i] == '0' && carry_out == '1')
            {
                num[i] = '1';
                return;
            }
        }
    }
    else
    {
        num[length - 1] = '1';
    }


}

void Div(uint8_t* num1, uint8_t* num2, uint8_t* result)
{
    uint8_t one[] = {'0', '0', '0', '1', '\0'};
    int i;
    uint8_t temp[] = { '0', '0', '0', '0', '\0' };
    

    uint8_t num1_sign = num1[0];
    uint8_t num2_sign = num2[0];
    num1[0] = '0';
    num2[0] = '0';
    //num1 = binaryAbs(num1, 4);
    //num2 = binaryAbs(num2, 4);

    uint8_t* greater = num2;
    uint8_t* lesser = num1;

    if (isGreater(num1, num2))
    {
        greater = num1;
        lesser = num2;
    }

    //inverseSign(lesser, 4);
    for (i = 0; i < 4; i++)
    {
        temp[i] = lesser[i];
    }
    lesser[0] = '1';
    //Compl(lesser, 4);

    while (greater[0] != '1' && isNotZero(greater) && (isGreater(greater, temp) || areEqual(greater, temp, 4)))
    {
        Add4(greater, lesser);
        Add(result, one);
    }

    result[0] = (num1_sign - '0') ^ (num2_sign - '0') + '0';
    //result = abs(greater)
    //while(result > 0)
    //{
    //  Add(abs(greater), -abs(lesser))
    //  counter++;
    //}
    //result = [sign](counter)
}

uint8_t areEqual(uint8_t* num1, uint8_t* num2, uint8_t length)
{
    int i = 0;
    for (i; i < length; i++)
    {
        if (num1[i] != num2[i])
        {
            return 0;
        }
    }

    return 1;
}

uint8_t isNotZero(uint8_t* num)
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

    uint8_t one[] = { '0', '0', '0', '1', '\0' };
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
        else if (num1[i] < num2[i])
        {
            return 0;
        }
    }

    return 0;
}

uint8_t* inverseSign(uint8_t* num, uint8_t length)
{
    int i = 0;
    for (i; i < length; i++)
    {
        num[i] = num[i] == '1' ? '0' : '1';
    }

    uint8_t one[] = { '0', '0', '0', '1', '\0' };
    Add4(num, one);
    return num;
}