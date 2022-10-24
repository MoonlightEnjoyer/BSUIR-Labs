#include <msp430.h>
#include <math.h>

typedef unsigned char uchar;

#define SET_COLUMN_ADDRESS_LSB        0x00
#define SET_COLUMN_ADDRESS_MSB        0x10
#define SET_PAGE_ADDRESS              0xB0


#define SET_SEG_DIRECTION             0xA1
#define SET_COM_DIRECTION             0xC8

#define SET_POWER_CONTROL             0x2F // Управление питанием. PC[0] – усилитель, PC[1] — регулятор, PC[2] — повторитель. 0 — отключено, 1 — включено
#define SET_SCROLL_LINE               0x40 // Установка начальной линии скроллинга SL=0..63
#define SET_VLCD_RESISTOR_RATIO       0x27 // Установка уровня внутреннего резисторного делителя PC = [0..7].Используется для управления контрастом.
#define SET_ELECTRONIC_VOLUME_MSB     0x81 // Регулировка контраста. Двухбайтная команда. PM[5..0] PM = 0..63.
#define SET_ELECTRONIC_VOLUME_LSB     0x0F
#define SET_ALL_PIXEL_ON              0xA4 // Включение всех пикселей. 0 – отображение содержимого памяти, 1 – все пиксели включены (содержимое памяти сохраняется).
#define SET_INVERSE_DISPLAY           0xA6 // Включение инверсного режима. 0 — нормальное отображение содержимого памяти, 1 — инверсное.
#define SET_DISPLAY_ENABLE            0xAF // Отключение экрана. 0 — экран отключен, 1 — включен.
#define SET_LCD_BIAS_RATIO            0xA2 // Смещение напряжения делителя: 0 – 1/9, 1 – 1/7.
#define SET_ADV_PROGRAM_CONTROL0_MSB  0xFA // Расширенное управление. ТС — температурная компенсация 0 = -0.05, 1 = -0.11 % / °С;
#define SET_ADV_PROGRAM_CONTROL0_LSB  0x90 // WC – циклический сдвиг столбцов 0 = нет, 1 = есть; WP –циклический сдвиг страниц 0 = нет, 1 = есть.

// CD: 0 - display choosen, 1 - controller choosen
#define CD              BIT6 // CD - choose device mode (BIT6 -> P5.6)
#define CS              BIT4 // CS - choose slave device (BIT4 -> P7.4)

#define NONE                        0
#define READ_X_AXIS_DATA            0x18
#define READ_Z_AXIS_DATA            0x20

uchar mirror = 0xC0;
uchar* p_mirror = &mirror;

uchar Dogs102x6_initMacro[] = {
    SET_SCROLL_LINE,
    SET_SEG_DIRECTION,
    SET_COM_DIRECTION,
    SET_ALL_PIXEL_ON,
    SET_INVERSE_DISPLAY,
    SET_LCD_BIAS_RATIO,
    SET_POWER_CONTROL,
    SET_VLCD_RESISTOR_RATIO,
    SET_ELECTRONIC_VOLUME_MSB,
    SET_ELECTRONIC_VOLUME_LSB,
    SET_ADV_PROGRAM_CONTROL0_MSB,
    SET_ADV_PROGRAM_CONTROL0_LSB,
    SET_DISPLAY_ENABLE,
    // SET_PAGE_ADDRESS,
    // SET_COLUMN_ADDRESS_MSB,
    // SET_COLUMN_ADDRESS_LSB
};

int COLUMN_START_ADDRESS = 0; // 0 - default (30), 1 - mirror horizontal (0)

uchar symbols[12][11] = {
    {0x00, 0x00, 0x20, 0x20, 0x20, 0xF8, 0x20, 0x20, 0x20, 0x00, 0x00}, // plus
    {0x00, 0x00, 0x00, 0x00, 0x00, 0xF8, 0x00, 0x00, 0x00, 0x00, 0x00}, // minus
    {0xF8, 0xF8, 0xD8, 0xD8, 0xD8, 0xD8, 0xD8, 0xD8, 0xD8, 0xF8, 0xF8}, // num0
    {0xF8, 0xF8, 0x30, 0x30, 0x30, 0x30, 0xF0, 0xF0, 0x70, 0x70, 0x30}, // num1
    {0xF8, 0xF8, 0xC0, 0xC0, 0xC0, 0xF8, 0xF8, 0x18, 0x18, 0xF8, 0xF8}, // num2
    {0xF8, 0xF8, 0x18, 0x18, 0x18, 0xF8, 0xF8, 0x18, 0x18, 0xF8, 0xF8}, // num3
    {0x18, 0x18, 0x18, 0x18, 0xF8, 0xF8, 0xD8, 0xD8, 0xD8, 0xD8, 0xD8}, // num4
    {0xF8, 0xF8, 0x18, 0x18, 0x18, 0xF8, 0xF8, 0xC0, 0xC0, 0xF8, 0xF8}, // num5
    {0xF8, 0xF8, 0xD8, 0xD8, 0xD8, 0xF8, 0xF8, 0xC0, 0xC0, 0xF8, 0xF8}, // num6
    {0xC0, 0xC0, 0xC0, 0xC0, 0xE0, 0x70, 0x38, 0x18, 0x18, 0xF8, 0xF8}, // num7
    {0xF8, 0xF8, 0xD8, 0xD8, 0xD8, 0xF8, 0xD8, 0xD8, 0xD8, 0xF8, 0xF8}, // num8
    {0xF8, 0xF8, 0x18, 0x18, 0xF8, 0xF8, 0xD8, 0xD8, 0xD8, 0xF8, 0xF8}  // num9
};

int lenHelper(int number);
int abs(int number);
int _pow(int base, int exponent);
void printNumber(int number);

void Dogs102x6_clearScreen(void);
void Dogs102x6_setAddress(uchar pa, uchar ca);
void Dogs102x6_writeData(uchar* sData, uchar i);
void Dogs102x6_writeCommand(uchar* sCmd, uchar i);
void Dogs102x6_backlightInit(void);
void Dogs102x6_init(void);

void delay(long int value)
{
    volatile long int i = 0;
    volatile long int temp = 0;
    for (; i < value; i++)
    {
        temp++;
    }
}

void enableLED2() { P8OUT |= BIT1; }
void disableLED2() { P8OUT &= ~BIT1; }

void setupLED2() {
  P8DIR |= BIT1; // make LED2 output
  disableLED2(); // make LED2 off by default
}

uchar CMA3000_writeCommand(uchar byte_one, uchar byte_two)
{
  char indata;

  P3OUT &= ~BIT5;

  indata = UCA0RXBUF;

  while(!(UCA0IFG & UCTXIFG));

  UCA0TXBUF = byte_one;

  while(!(UCA0IFG & UCRXIFG));

  indata = UCA0RXBUF;

  while(!(UCA0IFG & UCTXIFG));

  UCA0TXBUF = byte_two;

  while(!(UCA0IFG & UCRXIFG));

  indata = UCA0RXBUF;

  while(UCA0STAT & UCBUSY);

  P3OUT |= BIT5;

  return indata;
}

void disableWatchDogTimer() {
    WDTCTL = WDTPW | WDTHOLD;
}

void setupResetSignal() {
    P5DIR |= BIT7; // output direction
    P5OUT &= ~BIT7; // RST = 0
    P5OUT |= BIT7; // RST = 1
}

void setupAccelerometer()
{
    P2DIR  &= ~BIT5;    // mode: input
    P2REN  |=  BIT5;    // enable pull up resistor
    P2IE   |=  BIT5;    // interrupt enable
    P2IES  &= ~BIT5;    // process on interrupt's front
    P2IFG  &= ~BIT5;    // clear interrupt flag

    // set up cma3000 (CBS - Chip Select)
    P3DIR  |=  BIT5;    // mode: output
    P3OUT  |=  BIT5;

    // set up ACCEL_SCK (SCK - Serial Clock)
    P2DIR  |=  BIT7;
    P2SEL  |=  BIT7;

    // Setup SPI communication
    P3DIR  |= (BIT3 | BIT6);    // Set MOSI and PWM pins to output mode
    P3DIR  &= ~BIT4;            // Set MISO to input mode
    P3SEL  |= (BIT3 | BIT4);    // Set mode : P3.3 - UCA0SIMO , P3.4 - UCA0SOMI
    P3OUT  |= BIT6;             // Power cma3000

    UCA0CTL1 |= UCSWRST;        // set UCSWRST bit to disable USCI and change its control registers

    UCA0CTL0 = (
        UCCKPH  &   // UCCKPH - 1: change out on second signal change, capture input on first one)
        ~UCCKPL |   // UCCKPL - 0: active level is 1
        UCMSB   |   // MSB comes first, LSB is next
        UCMST   |   // Master mode
        UCSYNC  |   // Synchronous mode
        UCMODE_0    // 3 pin SPI mode
    );

    // set SMCLK as source and keep RESET
    UCA0CTL1 = UCSSEL_2 | UCSWRST;

    UCA0BR0 = 0x50;
    UCA0BR1 = 0x0;

    UCA0CTL1 &= ~UCSWRST;   // enable USCI

    CMA3000_writeCommand(0x04, NONE);
    __delay_cycles(550);

    CMA3000_writeCommand(
        0x0A,
        BIT4 |
        BIT2
    );
    __delay_cycles(10500);
}

int main(void) {
    disableWatchDogTimer();

    setupLED2();

    Dogs102x6_init();
    Dogs102x6_backlightInit();
    Dogs102x6_clearScreen();

    setupAccelerometer();

    P1DIR &= ~BIT7;
          P1REN |= BIT7;
          P1OUT |= BIT7;

          P1SEL &= (~BIT7);
          P1IES |= (BIT7);
          P1IFG &= (~BIT7);
          P1IE |=  (BIT7);

          //Timer TA1
                      TA1CTL |= (BIT2 | BIT9 | MC__UP | ID__8);
                      TA1CCR0 = 5000;
                      TA1CCTL0 |= BIT4;

    __bis_SR_register(GIE);

    return 0;
}

void printNumber(int number) {
    int nDigits = lenHelper(number);



    int i = 0;
    int divider = 10;
    int n = number;
    number = abs(number);

    for (i = 0; i < nDigits; i++) {
        int digit = number % divider;

        Dogs102x6_setAddress(i, COLUMN_START_ADDRESS);
        Dogs102x6_writeData(symbols[digit + 2], 11);

        number /= divider;
    }

    Dogs102x6_setAddress(i, COLUMN_START_ADDRESS);
        Dogs102x6_writeData(n > 0 ? symbols[0] : symbols[1], 11);
}

int lenHelper(int number) {
    number = abs(number);

    if (number >= 100000) return 6;
    if (number >= 10000) return 5;
    if (number >= 1000) return 4;
    if (number >= 100) return 3;
    if (number >= 10) return 2;

    return 1;
}

int abs(int number) {
    return number > 0 ? number : number * (-1);
}

int _pow(int base, int exponent) {
    int i = 0;
    int result = base;

    for (i = 0; i < exponent - 1; i++) {
        result *= base;
    }

    return result;
}

void Dogs102x6_clearScreen(void)
{
    uchar LcdData[] = { 0x00 };
    uchar p, c;

    // 8 total pages in LCD controller memory
    for (p = 0; p < 8; p++)
    {
        Dogs102x6_setAddress(p, 0);
        // 132 total columns in LCD controller memory
        for (c = 0; c < 132; c++)
        {
            Dogs102x6_writeData(LcdData, 1);
        }
    }
}

void Dogs102x6_setAddress(uchar pa, uchar ca)
{
    uchar cmd[1];

    // 8 pages allowed
    if (pa > 7) {
        pa = 7;
    }

    // actual screen size smaller than controller
    if (ca > 101) {
        ca = 101;
    }

    cmd[0] = SET_PAGE_ADDRESS + (pa); // (7 - pa) - inverse pages
    uchar H = 0x00;
    uchar L = 0x00;
    uchar ColumnAddress[2];

    L = (ca & 0x0F);
    H = (ca & 0xF0);
    H = (H >> 4);

    ColumnAddress[0] = SET_COLUMN_ADDRESS_LSB + L;
    ColumnAddress[1] = SET_COLUMN_ADDRESS_MSB + H;

    Dogs102x6_writeCommand(cmd, 1);
    Dogs102x6_writeCommand(ColumnAddress, 2);
}

void Dogs102x6_writeData(uchar* sData, uchar i)
{
    P7OUT &= ~CS;
    P5OUT |= CD; // 1 - data mode

    while (i){
        while (!(UCB1IFG & UCTXIFG)); // wait for controller interruption (1 - Buffer is available for writing)

        UCB1TXBUF = *sData;

        sData++;
        i--;
    }

    while (UCB1STAT & UCBUSY);
    // Dummy read to empty RX buffer and clear any overrun conditions
    UCB1RXBUF;

    P7OUT |= CS;
}

void Dogs102x6_writeCommand(uchar* sCmd, uchar i)
{
    P7OUT &= ~CS; // choose display
    P5OUT &= ~CD; // enter command mode

    while (i) {
        while (!(UCB1IFG & UCTXIFG)); // wait for controller interruption (1 - Buffer is available for writing)

        UCB1TXBUF = *sCmd;

        sCmd++;
        i--;
    }

    while (UCB1STAT & UCBUSY); // waiting for all data transmitted
    // Dummy read to empty RX buffer and clear any overrun conditions (? clear UCRXIFG)
    UCB1RXBUF;

    P7OUT |= CS; // choose controller
}

void Dogs102x6_backlightInit(void)
{
    P7DIR |= BIT6;
    P7OUT |= BIT6;
    P7SEL &= ~BIT6;
}

void Dogs102x6_init(void)
{
    setupResetSignal();

    P7DIR |= CS; // output direction

    P5DIR |= CD; // output direction
    P5OUT &= ~CD; // 0 - command mode

    P4SEL |= BIT1; // data transmission - LCD_SIMO (SIMO - Slave In, Master Out)
    P4DIR |= BIT1; // ?? - should be ignored

    P4SEL |= BIT3; // clock signal SCLK
    P4DIR |= BIT3; // ?? - should be ignored

    // UCSSEL__SMCLK - Select SMCLK as signal source
    // UCSWRST - enable software reset
    UCB1CTL1 = UCSSEL__SMCLK + UCSWRST;

    //3-pin, 8-bit SPI master
    UCB1CTL0 = UCCKPH + UCMSB + UCMST + UCMODE_0 + UCSYNC;

    // Frequency delimiters
    UCB1BR0 = 0x02;
    UCB1BR1 = 0;

    UCB1CTL1 &= ~UCSWRST; // disable software reset (used to change some CTL registers)
    UCB1IFG &= ~UCRXIFG;

    Dogs102x6_writeCommand(Dogs102x6_initMacro, 13);
}

int getProjectionValue(uchar projectionByte)
{
    uchar isNegative = projectionByte & BIT7;
    volatile int value_bits = 7;
    uchar bits[] = { BIT6, BIT5, BIT4, BIT3, BIT2, BIT1, BIT0 };
    int mapping[] = { 4571, 2286, 1142, 571, 286, 143, 71 };

    int i = 0;
    int projection = 0;
    for (; i < value_bits; i++)
    {
        if (!isNegative)
        {
            projection += (bits[i] & projectionByte) ? mapping[i] : 0;
        }
        else
        {
            projection += (bits[i] & projectionByte) ? 0 : mapping[i];
        }
    }
    projection = isNegative ? projection * (-1) : projection;

    return projection;
}

# define M_PI           3.14159265358979323846  /* pi */

double RADIAN_TO_ANGLE_COEFICIENT = 180 / M_PI;

double convertRadianToAngle(double radian) {
    return radian * RADIAN_TO_ANGLE_COEFICIENT;
}

int getAngle(int xProjection, int yProjection)
{
    double radianAngle = atan((double)xProjection / (double)yProjection);

    double angle = convertRadianToAngle(radianAngle);

    return angle;
}

# define CONVERT_TO_METERS_PER_SECONDS           9.80665

int convertToMeterPerSeconds(int gValue) {
    return (double)gValue * CONVERT_TO_METERS_PER_SECONDS;
}

volatile int delay1 = 0;

#pragma vector=PORT1_VECTOR
__interrupt void Port_1(void)
{
    if (delay1 == 0  && ((P1IES & BIT7) == BIT7))
    {
        TA1CTL |= TACLR;
        delay1 = 1;
        TA1CTL |= MC__UP | ID__8;
        P1IES &= ~BIT7;
        if(mirror == 0xC8)
        {
            mirror = 0xC0;
        }
        else
        {
            mirror = 0xC8;
        }
        Dogs102x6_writeCommand(p_mirror, 1);

    }
    else if(delay1 == 0 && ((P1IES & BIT7) != BIT7))
    {
        TA1CTL |= TACLR;
                delay1 = 1;
                TA1CTL |= MC__UP | ID__8;
                P1IES |= BIT7;
    }

    P1IFG &= ~BIT7;
}

#pragma vector=TIMER1_A0_VECTOR
__interrupt void Timer1(void)
{
    delay1 = 0;
}

#pragma vector = PORT2_VECTOR
__interrupt void __Accelerometer_ISR(void)
{
    delay(300);
    uchar z_projection_byte = CMA3000_writeCommand(READ_Z_AXIS_DATA, NONE);
    delay(300);
    uchar x_projection_byte = CMA3000_writeCommand(READ_X_AXIS_DATA, NONE);

    int x_projection = getProjectionValue(x_projection_byte);
    int z_projection = getProjectionValue(z_projection_byte);

    int angle = getAngle(x_projection, z_projection);

        // 1
    if(x_projection >= 0 && z_projection >= 0) {
        angle *= -1;
    } else
        // 2
        if(x_projection >= 0 && z_projection < 0) {
        angle = -180 - angle;
    } else
        // 3
        if(x_projection < 0 && z_projection >= 0) {
        angle *= -1;
    }
        // 4
        else { // (x_projection < 0 && z_projection < 0)
        angle = 180 - angle;
    }

  Dogs102x6_clearScreen();
  //printNumber(convertToMeterPerSeconds(x_projection));
  printNumber(angle);

    if (angle >= -135 && angle <= -45) {
        enableLED2();
    }
    else {
        disableLED2();
    }
}
