#include <msp430.h>
#include <math.h>

typedef unsigned char uchar;

#define SET_COLUMN_ADDRESS_LSB 0x00
#define SET_COLUMN_ADDRESS_MSB 0x10
#define SET_PAGE_ADDRESS 0xB0

#define SET_SEG_DIRECTION 0xA1
#define SET_COM_DIRECTION 0xC8

#define SET_POWER_CONTROL 0x2F         // РЈРїСЂР°РІР»РµРЅРёРµ РїРёС‚Р°РЅРёРµРј. PC[0] вЂ“ СѓСЃРёР»РёС‚РµР»СЊ, PC[1] вЂ” СЂРµРіСѓР»СЏС‚РѕСЂ, PC[2] вЂ” РїРѕРІС‚РѕСЂРёС‚РµР»СЊ. 0 вЂ” РѕС‚РєР»СЋС‡РµРЅРѕ, 1 вЂ” РІРєР»СЋС‡РµРЅРѕ
#define SET_SCROLL_LINE 0x40           // РЈСЃС‚Р°РЅРѕРІРєР° РЅР°С‡Р°Р»СЊРЅРѕР№ Р»РёРЅРёРё СЃРєСЂРѕР»Р»РёРЅРіР° SL=0..63
#define SET_VLCD_RESISTOR_RATIO 0x27   // РЈСЃС‚Р°РЅРѕРІРєР° СѓСЂРѕРІРЅСЏ РІРЅСѓС‚СЂРµРЅРЅРµРіРѕ СЂРµР·РёСЃС‚РѕСЂРЅРѕРіРѕ РґРµР»РёС‚РµР»СЏ PC = [0..7].Р�СЃРїРѕР»СЊР·СѓРµС‚СЃСЏ РґР»СЏ СѓРїСЂР°РІР»РµРЅРёСЏ РєРѕРЅС‚СЂР°СЃС‚РѕРј.
#define SET_ELECTRONIC_VOLUME_MSB 0x81 // Р РµРіСѓР»РёСЂРѕРІРєР° РєРѕРЅС‚СЂР°СЃС‚Р°. Р”РІСѓС…Р±Р°Р№С‚РЅР°СЏ РєРѕРјР°РЅРґР°. PM[5..0] PM = 0..63.
#define SET_ELECTRONIC_VOLUME_LSB 0x0F
#define SET_ALL_PIXEL_ON 0xA4             // Р’РєР»СЋС‡РµРЅРёРµ РІСЃРµС… РїРёРєСЃРµР»РµР№. 0 вЂ“ РѕС‚РѕР±СЂР°Р¶РµРЅРёРµ СЃРѕРґРµСЂР¶РёРјРѕРіРѕ РїР°РјСЏС‚Рё, 1 вЂ“ РІСЃРµ РїРёРєСЃРµР»Рё РІРєР»СЋС‡РµРЅС‹ (СЃРѕРґРµСЂР¶РёРјРѕРµ РїР°РјСЏС‚Рё СЃРѕС…СЂР°РЅСЏРµС‚СЃСЏ).
#define SET_INVERSE_DISPLAY 0xA6          // Р’РєР»СЋС‡РµРЅРёРµ РёРЅРІРµСЂСЃРЅРѕРіРѕ СЂРµР¶РёРјР°. 0 вЂ” РЅРѕСЂРјР°Р»СЊРЅРѕРµ РѕС‚РѕР±СЂР°Р¶РµРЅРёРµ СЃРѕРґРµСЂР¶РёРјРѕРіРѕ РїР°РјСЏС‚Рё, 1 вЂ” РёРЅРІРµСЂСЃРЅРѕРµ.
#define SET_DISPLAY_ENABLE 0xAF           // РћС‚РєР»СЋС‡РµРЅРёРµ СЌРєСЂР°РЅР°. 0 вЂ” СЌРєСЂР°РЅ РѕС‚РєР»СЋС‡РµРЅ, 1 вЂ” РІРєР»СЋС‡РµРЅ.
#define SET_LCD_BIAS_RATIO 0xA2           // РЎРјРµС‰РµРЅРёРµ РЅР°РїСЂСЏР¶РµРЅРёСЏ РґРµР»РёС‚РµР»СЏ: 0 вЂ“ 1/9, 1 вЂ“ 1/7.
#define SET_ADV_PROGRAM_CONTROL0_MSB 0xFA // Р Р°СЃС€РёСЂРµРЅРЅРѕРµ СѓРїСЂР°РІР»РµРЅРёРµ. РўРЎ вЂ” С‚РµРјРїРµСЂР°С‚СѓСЂРЅР°СЏ РєРѕРјРїРµРЅСЃР°С†РёСЏ 0 = -0.05, 1 = -0.11 % / В°РЎ;
#define SET_ADV_PROGRAM_CONTROL0_LSB 0x90 // WC вЂ“ С†РёРєР»РёС‡РµСЃРєРёР№ СЃРґРІРёРі СЃС‚РѕР»Р±С†РѕРІ 0 = РЅРµС‚, 1 = РµСЃС‚СЊ; WP вЂ“С†РёРєР»РёС‡РµСЃРєРёР№ СЃРґРІРёРі СЃС‚СЂР°РЅРёС† 0 = РЅРµС‚, 1 = РµСЃС‚СЊ.

// CD: 0 - display choosen, 1 - controller choosen
#define CD BIT6 // CD - choose device mode (BIT6 -> P5.6)
#define CS BIT4 // CS - choose slave device (BIT4 -> P7.4)

#define NONE 0
#define READ_X_AXIS_DATA 0x18
#define READ_Z_AXIS_DATA 0x20

uchar mirror = 0xC0;
uchar *p_mirror = &mirror;

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

int number_digits(int number);
int abs(int number);
void print_number(int number);

void clear_display(void);
void set_display_address(uchar pa, uchar ca);
void write_data_to_display(uchar *sData, uchar i);
void write_command_to_display(uchar *sCmd, uchar i);
void display_backlight_setup(void);
void display_setup(void);
uchar write_command_to_accelerometer(uchar byte_one, uchar byte_two);
void delay(long int value);
void accelerometer_setup();
void display_reset();

int main(void)
{
    WDTCTL = WDTPW | WDTHOLD;

    display_setup();
    display_backlight_setup();
    clear_display();

    accelerometer_setup();

    P1DIR &= ~BIT7;
    P1REN |= BIT7;
    P1OUT |= BIT7;

    P1SEL &= (~BIT7);
    P1IES |= (BIT7);
    P1IFG &= (~BIT7);
    P1IE |= (BIT7);

    // Timer TA1
    TA1CTL |= (BIT2 | BIT9 | MC__UP | ID__8);
    TA1CCR0 = 5000;
    TA1CCTL0 |= BIT4;

    __bis_SR_register(GIE);

    return 0;
}

void print_number(int number)
{
    int nDigits = number_digits(number);

    int i = 0;
    int divider = 10;
    int n = number;
    number = abs(number);

    for (i = 0; i < nDigits; i++)
    {
        int digit = number % divider;

        set_display_address(i, COLUMN_START_ADDRESS);
        write_data_to_display(symbols[digit + 2], 11);

        number /= divider;
    }

    set_display_address(i, COLUMN_START_ADDRESS);
    write_data_to_display(n > 0 ? symbols[0] : symbols[1], 11);
}

int number_digits(int number)
{
    number = abs(number);

    if (number >= 100000)
        return 6;
    if (number >= 10000)
        return 5;
    if (number >= 1000)
        return 4;
    if (number >= 100)
        return 3;
    if (number >= 10)
        return 2;

    return 1;
}

int abs(int number)
{
    return number > 0 ? number : number * (-1);
}


void clear_display(void)
{
    uchar data[] = {0x00};
    uchar pages, columns;

    for (pages = 0; pages < 8; pages++)
    {
        set_display_address(pages, 0);
        // 132 total columns in LCD controller memory
        for (columns = 0; columns < 132; columns++)
        {
            write_data_to_display(data, 1);
        }
    }
}

void set_display_address(uchar page_address, uchar column_address)
{
    uchar command[1];

    // 8 pages allowed
    if (page_address > 7)
    {
        page_address = 7;
    }

    // actual screen size smaller than controller
    if (column_address > 101)
    {
        column_address = 101;
    }

    command[0] = SET_PAGE_ADDRESS + (page_address); // (7 - pa) - inverse pages
    uchar H = 0x00;
    uchar L = 0x00;
    uchar ColumnAddress[2];

    L = (column_address & 0x0F);
    H = (column_address & 0xF0);
    H = (H >> 4);

    ColumnAddress[0] = SET_COLUMN_ADDRESS_LSB + L;
    ColumnAddress[1] = SET_COLUMN_ADDRESS_MSB + H;

    write_command_to_display(command, 1);
    write_command_to_display(ColumnAddress, 2);
}

void write_data_to_display(uchar *data, uchar number)
{
    P7OUT &= ~CS;
    P5OUT |= CD; // 1 - data mode

    while (number)
    {
        while (!(UCB1IFG & UCTXIFG))
            ; // wait for controller interruption (1 - Buffer is available for writing)

        UCB1TXBUF = *data;

        data++;
        number--;
    }

    while (UCB1STAT & UCBUSY)
        ;
    // Dummy read to empty RX buffer and clear any overrun conditions
    UCB1RXBUF;

    P7OUT |= CS;
}

void write_command_to_display(uchar *command, uchar number)
{
    P7OUT &= ~CS; // choose display
    P5OUT &= ~CD; // enter command mode

    while (number)
    {
        while (!(UCB1IFG & UCTXIFG))
            ; // wait for controller interruption (1 - Buffer is available for writing)

        UCB1TXBUF = *command;

        command++;
        number--;
    }

    while (UCB1STAT & UCBUSY)
        ; // waiting for all data transmitted
    // Dummy read to empty RX buffer and clear any overrun conditions (? clear UCRXIFG)
    UCB1RXBUF;

    P7OUT |= CS; // choose controller
}

void display_backlight_setup(void)
{
    P7DIR |= BIT6;
    P7OUT |= BIT6;
    P7SEL &= ~BIT6;
}

void delay(long int value)
{
    volatile long int i = 0;
    volatile long int temp = 0;
    for (; i < value; i++)
    {
        temp++;
    }
}

uchar write_command_to_accelerometer(uchar byte_one, uchar byte_two)
{
    char indata;

    P3OUT &= ~BIT5;

    indata = UCA0RXBUF;

    while (!(UCA0IFG & UCTXIFG))
        ;

    UCA0TXBUF = byte_one;

    while (!(UCA0IFG & UCRXIFG))
        ;

    indata = UCA0RXBUF;

    while (!(UCA0IFG & UCTXIFG))
        ;

    UCA0TXBUF = byte_two;

    while (!(UCA0IFG & UCRXIFG))
        ;

    indata = UCA0RXBUF;

    while (UCA0STAT & UCBUSY)
        ;

    P3OUT |= BIT5;

    return indata;
}

void display_reset()
{
    P5DIR |= BIT7;  // output direction
    P5OUT &= ~BIT7; // RST = 0
    P5OUT |= BIT7;  // RST = 1
}

void accelerometer_setup()
{
    P2DIR &= ~BIT5; // mode: input
    P2REN |= BIT5;  // enable pull up resistor
    P2IE |= BIT5;   // interrupt enable
    P2IES &= ~BIT5; // process on interrupt's front
    P2IFG &= ~BIT5; // clear interrupt flag

    // set up cma3000 (CBS - Chip Select)
    P3DIR |= BIT5; // mode: output
    P3OUT |= BIT5;

    // set up ACCEL_SCK (SCK - Serial Clock)
    P2DIR |= BIT7;
    P2SEL |= BIT7;

    // Setup SPI communication
    P3DIR |= (BIT3 | BIT6); // Set MOSI and PWM pins to output mode
    P3DIR &= ~BIT4;         // Set MISO to input mode
    P3SEL |= (BIT3 | BIT4); // Set mode : P3.3 - UCA0SIMO , P3.4 - UCA0SOMI
    P3OUT |= BIT6;          // Power cma3000

    UCA0CTL1 |= UCSWRST; // set UCSWRST bit to disable USCI and change its control registers

    UCA0CTL0 = (UCCKPH &      // UCCKPH - 1: change out on second signal change, capture input on first one)
                    ~UCCKPL | // UCCKPL - 0: active level is 1
                UCMSB |       // MSB comes first, LSB is next
                UCMST |       // Master mode
                UCSYNC |      // Synchronous mode
                UCMODE_0      // 3 pin SPI mode
    );

    // set SMCLK as source and keep RESET
    UCA0CTL1 = UCSSEL_2 | UCSWRST;

    UCA0BR0 = 0x50;
    UCA0BR1 = 0x0;

    UCA0CTL1 &= ~UCSWRST; // enable USCI

    write_command_to_accelerometer(0x04, NONE);
    __delay_cycles(550);

    write_command_to_accelerometer(
        0x0A,
        BIT4 |
            BIT2);
    __delay_cycles(10500);
}

void display_setup(void)
{
    display_reset();

    P7DIR |= CS; // output direction

    P5DIR |= CD;  // output direction
    P5OUT &= ~CD; // 0 - command mode

    P4SEL |= BIT1; // data transmission - LCD_SIMO (SIMO - Slave In, Master Out)
    P4DIR |= BIT1; // ?? - should be ignored

    P4SEL |= BIT3; // clock signal SCLK
    P4DIR |= BIT3; // ?? - should be ignored

    // UCSSEL__SMCLK - Select SMCLK as signal source
    // UCSWRST - enable software reset
    UCB1CTL1 = UCSSEL__SMCLK + UCSWRST;

    // 3-pin, 8-bit SPI master
    UCB1CTL0 = UCCKPH + UCMSB + UCMST + UCMODE_0 + UCSYNC;

    // Frequency delimiters
    UCB1BR0 = 0x02;
    UCB1BR1 = 0;

    UCB1CTL1 &= ~UCSWRST; // disable software reset (used to change some CTL registers)
    UCB1IFG &= ~UCRXIFG;

    write_command_to_display(Dogs102x6_initMacro, 13);
}

int projection(uchar projectionByte)
{
    uchar isNegative = projectionByte & BIT7;
    volatile int value_bits = 7;
    uchar bits[] = {BIT6, BIT5, BIT4, BIT3, BIT2, BIT1, BIT0};
    int mapping[] = {4571, 2286, 1142, 571, 286, 143, 71};

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

#define M_PI 3.14159265358979323846

double RADIAN_TO_ANGLE_COEFICIENT = 180 / M_PI;

double radian_to_angle(double radian)
{
    return radian * RADIAN_TO_ANGLE_COEFICIENT;
}

int get_angle(int xProjection, int yProjection)
{
    double radianAngle = atan((double)xProjection / (double)yProjection);

    double angle = radian_to_angle(radianAngle);

    return angle;
}

#define CONVERT_TO_METERS_PER_SECONDS 9.80665

int convertToMeterPerSeconds(int gValue)
{
    return (double)gValue * CONVERT_TO_METERS_PER_SECONDS;
}

volatile int delay1 = 0;

#pragma vector = PORT1_VECTOR
__interrupt void Port_1(void)
{
    if (delay1 == 0 && ((P1IES & BIT7) == BIT7))
    {
        TA1CTL |= TACLR;
        delay1 = 1;
        TA1CTL |= MC__UP | ID__8;
        P1IES &= ~BIT7;
        if (mirror == 0xC8)
        {
            mirror = 0xC0;
        }
        else
        {
            mirror = 0xC8;
        }
        write_command_to_display(p_mirror, 1);
    }
    else if (delay1 == 0 && ((P1IES & BIT7) != BIT7))
    {
        TA1CTL |= TACLR;
        delay1 = 1;
        TA1CTL |= MC__UP | ID__8;
        P1IES |= BIT7;
    }

    P1IFG &= ~BIT7;
}

#pragma vector = TIMER1_A0_VECTOR
__interrupt void Timer1(void)
{
    delay1 = 0;
}

volatile int mem_angle;

#pragma vector = PORT2_VECTOR
__interrupt void __Accelerometer_ISR(void)
{
    delay(3000);
    uchar z_projection_byte = write_command_to_accelerometer(READ_Z_AXIS_DATA, NONE);
    delay(300);
    uchar x_projection_byte = write_command_to_accelerometer(READ_X_AXIS_DATA, NONE);

    int x_projection = projection(x_projection_byte);
    int z_projection = projection(z_projection_byte);

    int angle = get_angle(x_projection, z_projection);

    // 1
    if (x_projection >= 0 && z_projection >= 0)
    {
        angle *= -1;
    }
    else
        // 2
        if (x_projection >= 0 && z_projection < 0)
        {
            angle = -180 - angle;
        }
        else
            // 3
            if (x_projection < 0 && z_projection >= 0)
            {
                angle *= -1;
            }
            // 4
            else
            { // (x_projection < 0 && z_projection < 0)
                angle = 180 - angle;
            }

    if (mem_angle != angle)
    {
        clear_display();
        // print_number(convertToMeterPerSeconds(x_projection));
        print_number(angle);
    }

    mem_angle = angle;
}
