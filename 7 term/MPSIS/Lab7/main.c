#include <msp430.h>
#include "HAL_Dogs102x6.h"
#include "ff.h"
#include "structure.h"
#include "CTS_Layer.h"
#include <stdlib.h>
#include "HAL_Wheel.h"
#include "HAL_Buttons.h"

#define LED_ON  1
#define LED_OFF 0

#define LED1_PORT   1
#define LED1_PIN    0

#define BUTT2_PORT  2
#define BUTT2_PIN   2

#define DRAW_DIGITS_ROW 4 // PRINT INFO TO LCD
#define DRAW_TEXT_ROW 7 // PRINT INFO TO LCD
//#define LINE_Y  54

#define BUFFER_FILENAME "buffer.bin"


#define BUFFER_SIZE  50 // DEFINES FOR BUFFER
#define BUFFER_COUNT (BUFFER_SIZE / 2)
volatile uint16_t buffer[BUFFER_COUNT];
volatile uint8_t index = 0;


#define GPIO_DIR_OUTPUT(...)  GPIO_DIR_OUTPUT_SUB(__VA_ARGS__) //interaction with Genaral pins I/O
#define GPIO_DIR_OUTPUT_SUB(port, pin) (P##port##DIR |= (1 << (pin)))

#define GPIO_DIR_INPUT(...)  GPIO_DIR_INPUT_SUB(__VA_ARGS__)
#define GPIO_DIR_INPUT_SUB(port, pin) (P##port##DIR &= ~(1 << (pin)))

#define GPIO_PULLUP(...) GPIO_PULLUP_SUB(__VA_ARGS__)
#define GPIO_PULLUP_SUB(port, pin) P##port##REN |= (1 << (pin)); \
                                   P##port##OUT |= (1 << (pin))
#define GPIO_PULLDOWN(...) GPIO_PULLDOWN_SUB(__VA_ARGS__)
#define GPIO_PULLDOWN_SUB(port, pin) P##port##REN |= (1 << (pin)); \
                                     P##port##OUT &= ~(1 << (pin))

#define GPIO_NOPULL(...) GPIO_NOPULL_SUB(__VA_ARGS__)
#define GPIO_NOPULL_SUB(port, pin) (P##port##REN &= ~(1 << (pin)))

#define GPIO_READ_PIN(...) GPIO_READ_PIN_SUB(__VA_ARGS__)
#define GPIO_READ_PIN_SUB(port, pin) ((P##port##IN & (1 << (pin))) ? 1 : 0)

#define GPIO_WRITE_PIN(...) GPIO_WRITE_PIN_SUB(__VA_ARGS__)
#define GPIO_WRITE_PIN_SUB(port, pin, value) (P##port##OUT = (P##port##OUT & ~(1 << (pin))) | (value << (pin)))

#define GPIO_TOGGLE_PIN(...) GPIO_TOGGLE_PIN_SUB(__VA_ARGS__)
#define GPIO_TOGGLE_PIN_SUB(port, pin) (P##port##OUT ^= (1 << (pin)))

#define GPIO_TRIG_EDGE_FALLING(...) GPIO_TRIG_EDGE_FALLING_SUB(__VA_ARGS__)
#define GPIO_TRIG_EDGE_FALLING_SUB(port, pin) (P##port##IES |= (1 << (pin)))

#define GPIO_TRIG_EDGE_RISING(...) GPIO_TRIG_EDGE_RISING_SUB(__VA_ARGS__)
#define GPIO_TRIG_EDGE_RISING_SUB(port, pin) (P##port##IES &= ~(1 << (pin)))

#define GPIO_INTERRUPT_ENABLE(...) GPIO_INTERRUPT_ENABLE_SUB(__VA_ARGS__)
#define GPIO_INTERRUPT_ENABLE_SUB(port, pin) P##port##IFG &= ~(1 << (pin)); \
                                             P##port##IE |= (1 << (pin))

#define GPIO_INTERRUPT_DISABLE(...) GPIO_INTERRUPT_DISABLE_SUB(__VA_ARGS__)
#define GPIO_INTERRUPT_DISABLE_SUB(port, pin) (P##port##IE &= ~(1 << (pin)))

#define GPIO_PERIPHERAL(...) GPIO_PERIPHERAL_SUB(__VA_ARGS__)
#define GPIO_PERIPHERAL_SUB(port, pin) (P##port##SEL |= (1 << (pin)))

#define GPIO_CLEAR_IT_FLAG(...) GPIO_CLEAR_IT_FLAG_SUB(__VA_ARGS__)
#define GPIO_CLEAR_IT_FLAG_SUB(port, pin) (P##port##IFG &= ~(1 << (pin)))

void displaySelection(int value);
void displayNumberSelection(int num);
void displayOperationSelection(int num);

void Add(uint8_t* num1, uint8_t* num2);
void Div(uint8_t* num1, uint8_t* num2, uint8_t* result);
void Mul(uint8_t* num1, uint8_t* num2, uint8_t* result);
void StringToBinary(uint8_t* str);
void BinaryToString(uint8_t* str);
uint8_t isZero(uint8_t* num);
uint8_t* binaryAbs(uint8_t* num, uint8_t length);
uint8_t* inverseSign(uint8_t* num, uint8_t length);
uint8_t isGreater(uint8_t* num1, uint8_t* num2);

// PAD1 describing
const struct Element PAD1 =
{
    .inputBits = CBIMSEL_0,
    .maxResponse = 250,
    .threshold = 125
};
// PAD5 describing
const struct Element PAD5 =
{
    .inputBits = CBIMSEL_4,
    .maxResponse = 1900,
    .threshold = 475
};

// PAD1 for CTS_Layer.h
const struct Sensor Sensor1 =
{
    .halDefinition = RO_COMPB_TA1_TA0,
    .numElements = 1,
    .baseOffset = 0,
    .cbpdBits = 0x0001, //CB0
    .arrayPtr[0] = &PAD1,
    .cboutTAxDirRegister = (uint8_t *)&P1DIR,
    .cboutTAxSelRegister = (uint8_t *)&P1SEL,
    .cboutTAxBits = BIT6, // P1.6
    .measGateSource = TIMER_ACLK, //timer
    .sourceScale = TIMER_SOURCE_DIV_0, // 50 ACLK/1 cycles or 272*1/32Khz = 8.5ms
    .accumulationCycles = 50
};

// PAD5 for CTS_Layer.h
const struct Sensor Sensor5 =
{
    .halDefinition = RO_COMPB_TA1_TA0,
    .numElements = 1,
    .baseOffset = 4,
    .cbpdBits = 0x0010, //CB4
    .arrayPtr[0] = &PAD5,
    .cboutTAxDirRegister = (uint8_t *)&P1DIR,
    .cboutTAxSelRegister = (uint8_t *)&P1SEL,
    .cboutTAxBits = BIT6, // P1.6
    .measGateSource = TIMER_ACLK,//timer
    .sourceScale = TIMER_SOURCE_DIV_0,
    .accumulationCycles = 272 // 50 ACLK/1 cycles or 272*1/32Khz = 8.5ms
};

// Кастомизированная функция для измерения PAD5 из CTS_HAL
void TI_CTS_RO_COMPB_TA1_TA0_HAL_CUSTOM(const struct Sensor *group, uint8_t index)
{
    // Конфигурируем пин CBOUT.
    *(group->cboutTAxDirRegister) |= (group->cboutTAxBits);
    *(group->cboutTAxSelRegister) |= (group->cboutTAxBits);

    // Источник опорного напряжения Vcc,
    // Vcc*(0x18+1)/32 for CBOUT = 1 and Vcc*((0x04+1)/32 for CBOUT = 0 (Такие значения используются в CTS_HAL)
    CBCTL2 = CBRS_1 + CBREF14 + CBREF13 + CBREF02;
    // Отключает входной буфер пинов
    CBCTL3 |= (group->cbpdBits);

    // TimerA2 используется для задания времени измерения
    TA2CCR0 = group->accumulationCycles;
    TA2CTL = group->measGateSource + group->sourceScale;
    // Включаем компаратор
    CBCTL1 = CBON;

    // Включаем вход определенный вход компаратора
    CBCTL0 = CBIMEN + (group->arrayPtr[index])->inputBits;

    // Таймер A1 используется для измерения релаксационных циклов сенсора, которые подключены к TACLK.
    // Источник TACLK, непрерывный счет.
    TA1CTL = TASSEL__TACLK+MC__CONTINUOUS+TACLR;
    // Сбрасываем флаг прерывания
    TA1CTL &= ~TAIFG;
    // Запуск Таймера 2
    TA2CTL |= (TACLR + MC__UP);
}



// Вычисления значения для рисования
uint16_t Get_Draw_Value(uint8_t index)
{
   uint16_t data_range = PAD5.maxResponse - PAD5.threshold;
   int16_t value = buffer[index] - PAD5.threshold;
   if (value < 0)
   {
       value = 0;
   }

   uint16_t draw_value = (uint16_t)((float)DOGS102x6_X_SIZE * (float)value / (float)data_range);
   return draw_value;

}

uint16_t main(void)
{
    // Остановка сторожевого таймера
    WDTCTL = WDTPW + WDTHOLD;

    FATFS fs;
    FIL file;

    GPIO_DIR_OUTPUT(LED1_PORT, LED1_PIN); //led1 init
    GPIO_WRITE_PIN(LED1_PORT, LED1_PIN, LED_OFF);

    GPIO_DIR_INPUT(BUTT2_PORT, BUTT2_PIN); //button2(s2) init
    GPIO_PULLUP(BUTT2_PORT, BUTT2_PIN);

    Dogs102x6_init(); //lcd init
    Dogs102x6_backlightInit();
    Dogs102x6_setBacklight(255);
    Dogs102x6_clearScreen();
    //Dogs102x6_horizontalLineDraw(0, DOGS102x6_X_SIZE - 1, LINE_Y, DOGS102x6_DRAW_NORMAL);

    TI_CAPT_Init_Baseline(&Sensor1);//PADs init
    TI_CAPT_Update_Baseline(&Sensor1,5);
    TI_CAPT_Init_Baseline(&Sensor5);
    TI_CAPT_Update_Baseline(&Sensor5,5);

    // Монтирование диска
    FRESULT res = f_mount(0, &fs);
    if (res == FR_NO_FILESYSTEM)
    {
        f_mkfs(0, 0, 512);
    }


    displaySelection(2);
    displaySelection(12);

    uint8_t digits[] = {'0', '1', '\0'};

    Dogs102x6_stringDraw(DRAW_DIGITS_ROW, 0, digits, DOGS102x6_DRAW_NORMAL);

    uint8_t string[] = {'-', '+', '/', '*', '=', 'M', 'R', ' ', 'M', 'S','\0'};

    Dogs102x6_stringDraw(DRAW_TEXT_ROW, 0, string, DOGS102x6_DRAW_NORMAL);

    Wheel_init();

    Buttons_init(BUTTON_S1);
    Buttons_interruptEnable(BUTTON_S1);

    int input_counter = 1;
    uint8_t num1[] = {'+', '0', '0', '0', '\0'};// first bit is for sign
    uint8_t num2[] = {'+', '0', '0', '0', '\0'};
    uint8_t result[] = {'+', '0', '0', '0', '0', '0', '0','\0'};
    uint8_t sign[] = {' ', '\0'};
    uint8_t eq[] = {'=', '\0'};

    while(1)
    {
        uint8_t str[128];

        uint16_t val = Wheel_getValue();


        val  = (4091 - val) / 500;
        uint16_t valuev = val;
        uint8_t i = 0;
        if (val == 0)
        {
            str[0] = '0';
            i++;
        }
        else
        {
            while(val > 0)
            {
                str[i++] = val % 10 + '0';
                val/= 10;
            }
        }
        str[i] = '\0';
        if (i == 2)
        {
            uint8_t temp = str[0];
            str[0] = str[1];
            str[1] = temp;
        }


        Dogs102x6_clearRow(0);
        Dogs102x6_stringDraw(0, 0, str, DOGS102x6_DRAW_NORMAL);

        displaySelection(valuev);
        int read_bytes = 0;

        if (buttonsPressed != 0 && buttonDebounce == 2)
        {
            if (input_counter == 1 && (valuev == 2 || valuev == 3))//enter num1 sign
            {
                num1[0] = string[valuev - 2];
            }
            else if (input_counter == 1 && valuev == 7)//read num1 from memory
            {
                f_open(&file, BUFFER_FILENAME, FA_READ);
                f_read(&file, num1, 5, &read_bytes);
                f_close(&file);
                input_counter = 4;
            }
            if(input_counter < 4 && valuev <= 1)//enter num1
            {
                num1[input_counter++] = '0' + valuev;
            }
            else if (input_counter == 4 && valuev >= 2 && valuev <= 5)//enter operation
            {
                sign[0] = string[valuev - 2];
                input_counter++;
            }
            else if (input_counter == 5 && valuev == 8)//save num1 to memory
            {

                f_open(&file, BUFFER_FILENAME, FA_WRITE);
                f_write(&file, num1, 5, &read_bytes);
                f_close(&file);
            }
            else if (input_counter == 5 && (valuev == 2 || valuev == 3))//enter num2 sign
            {
                num2[0] = string[valuev - 2];
            }
            else if (input_counter == 5 && valuev == 7)//read num2 from memory
            {
                f_open(&file, BUFFER_FILENAME, FA_READ);
                f_read(&file, num2, 5, &read_bytes);
                f_close(&file);
                input_counter = 8;
            }

            if (input_counter > 4 && input_counter < 8 && valuev <= 1)//enter num2
            {
                num2[input_counter++ - 4] = '0' + valuev;
            }
            else if (input_counter == 8 && valuev == 8)//save num2 to memory
            {
                f_open(&file, BUFFER_FILENAME, FA_WRITE);
                f_write(&file, num2, 5, &read_bytes);
                f_close(&file);
            }
            else if(input_counter == 8 && valuev == 6)
            {

                if (sign[0] == '-' || sign[0] == '+')
                {
                    if (num2[0] == '+' && sign[0] == '-')
                    {
                        num2[0] = '-';
                    }
                    else if (num2[0] == '-' && sign[0] == '-')
                    {
                        num2[0] = '+';
                    }

                    result[0] = num1[0];
                    int sss = 4;
                    for (sss; sss < 7; sss++)
                    {
                        result[sss] = num1[sss - 3];
                    }
                    StringToBinary(result);
                    StringToBinary(num2);
                    Add(result, num2);
                    BinaryToString(result);
                    BinaryToString(num2);
                }
                else if (sign[0] == '/')
                {
                    StringToBinary(num1);
                    StringToBinary(num2);
                    Div(num1, num2, result);
                    BinaryToString(num1);
                    BinaryToString(num2);
                    BinaryToString(result);
                }
                else if (sign[0] == '*')
                {
                    StringToBinary(num1);
                    StringToBinary(num2);
                    Mul(num1, num2, result);
                    BinaryToString(num1);
                    BinaryToString(num2);
                    BinaryToString(result);
                }


                Dogs102x6_stringDraw(2, 0, result, DOGS102x6_DRAW_NORMAL);
                input_counter++;
            }
            else if(input_counter == 9)
            {
                int c = 1;
                for(c; c < 4; c++)
                {
                    num1[c] = '0';
                    num2[c] = '0';
                }

                num1[0] = '+';
                num2[0] = '+';

                for (c = 1; c < 7; c++)
                {
                    result[c] = '0';
                }

                result[0] = '+';

                //Dogs102x6_stringDraw(2, 0, result, DOGS102x6_DRAW_NORMAL);
                Dogs102x6_clearRow(2);

                sign[0] = ' ';

                input_counter = 1;
            }

            while (buttonDebounce != 1)
            {

            }
        }

        Dogs102x6_stringDraw(1, 0, num1, DOGS102x6_DRAW_NORMAL);
        Dogs102x6_stringDraw(1, 4 * 6, sign, DOGS102x6_DRAW_NORMAL);
        Dogs102x6_charDraw(1, 5  *6, '(', 0);
        Dogs102x6_stringDraw(1, 6 * 6, num2, DOGS102x6_DRAW_NORMAL);
        Dogs102x6_charDraw(1, 10 * 6, ')', 0);
        Dogs102x6_stringDraw(1, 11 * 6, eq, DOGS102x6_DRAW_NORMAL);
    }
}

void StringToBinary(uint8_t* str)
{
    if (str[0] == '+')
    {
        str[0] = '0';
    }
    else
    {
        str[0] = '1';
    }
}

void BinaryToString(uint8_t* str)
{
    if (str[0] == '0')
    {
        str[0] = '+';
    }
    else
    {
        str[0] = '-';
    }
}

void displaySelection(int value)
{
    if (value > 1 && value <= 8)
    {
        Dogs102x6_clearRow(DRAW_DIGITS_ROW - 1);
        displayOperationSelection(value);
    }
    else
    {
        Dogs102x6_clearRow(DRAW_TEXT_ROW - 1);
        displayNumberSelection(value);
    }
}



void displayNumberSelection(int num)
{
    uint8_t dots[] = {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '\0'};
    dots[num] = '.';

    Dogs102x6_stringDraw(DRAW_DIGITS_ROW-1, 0, dots, DOGS102x6_DRAW_NORMAL);
}

void displayOperationSelection(int op)
{
    op -= 2;
    if (op == 6)
    {
        op = 8;
    }
    uint8_t dots[] = {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' , ' ', '\0'};
    dots[op] = '.';
    Dogs102x6_stringDraw(DRAW_TEXT_ROW - 1, 0, dots, DOGS102x6_DRAW_NORMAL);
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
    for (i; i >= 1; i--, j--)
    {
        n1 = num1[j];
        n2 = num2[i];
        num1[j] = ((n1 - '0') ^ (n2 - '0')) ^ carry_out + '0';
        carry_out = (num1[j] - '0') ^ ((n1 - '0') | (n2 - '0') | carry_out) | ((n1 - '0') & (n2 - '0') & carry_out);
    }

    if (num1[j] == '0' && carry_out == 1)
    {
        num1[j] == '1';
    }
    else if (num1[j] == '1' && carry_out == 1)
    {
        num1[j] == '0';
        num1[j - 1] == '1';
    }
/*
    if(num1[3] == '1')
    {
        for (i = 0; i < 3; i++)
        {
            num1[i] = '1';
        }
    }*/
}

void Div(uint8_t* num1, uint8_t* num2, uint8_t* result)
{
    uint8_t num1_sign = num1[0];
    uint8_t num2_sign = num2[0];
    uint8_t one = {'0', '0', '0', '1'};
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
        Add(result, one);
        //counter++;
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
    uint8_t n1= 0;
    uint8_t n2= 0;
    int i = 1;
    for (i; i < 4; i++)
    {
        n1 <<= 1;
        n1 |= (num1[i] - '0');
        n2 <<= 1;
        n2 |= (num2[i] - '0');
    }

    if (num1[0] == '1')
    {
        n1 *= -1;
    }

    if (num2[0] == '1')
    {
        n2 += -1;
    }


    MPYS = n1;
    OP2 = n2;
    uint16_t res = RES0;
    i = 6;
    for(i; i >= 0; i--)
    {
        result[i] = (res & 1) + '0';
        res >>= 1;
    }

    if (result[0] == '1')
    {
        inverseSign(result, 7);
        result[0] = '1';
    }
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
        num[i] = (num[i] == '1') ? '0' : '1';
    }

    uint8_t one[] = {'0', '0', '0', '1', '\0'};
    Add(num, one);
    return num;
}

#pragma vector=DMA_VECTOR
__interrupt void DMA_ISR(void)
{
    switch(__even_in_range(DMAIV,16))
    {
        // Прерывание DMA0IFG
        case 2:
            TA1CTL &= ~MC__CONTINUOUS; //timers stop
            TA2CTL &= ~MC__UP;
            _bic_SR_register_on_exit(LPM0_bits);//lpm exit
            break;
        default: break;
    }
}

