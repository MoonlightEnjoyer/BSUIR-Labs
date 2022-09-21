
#include <msp430.h>
#include <stdio.h>

#define Led1 BIT0
#define Led2 BIT1


void TurnOnLed(int number);
void TurnOffLed(int number);

int main(void)
{
    volatile int i;

      // stop watchdog timer
      WDTCTL = WDTPW | WDTHOLD;
      //set direction for led2 and led3
      P8DIR |= Led2;
      P1DIR |= Led1;

      P1OUT = 0;
      P8OUT |= Led2;
      //set direction for s1, s2


      P2SEL &= (~BIT2);
      P2IES |= (BIT2);
      P2IFG &= (~BIT2);
      P2IE |= (BIT2);

      P2DIR = 0;
      P2REN = BIT2;
      P2OUT = BIT2;

      TA2CTL |= (BIT2 | BIT9 | BIT4 | BIT5 | BIT6);
      TA2CCR0 = 65535;
      TA2CCTL0 |= BIT4;


      __enable_interrupt();
      /*__bis_SR_register(LPM0_bits + GIE);       // Enter LPM4 w/interrupt
      __no_operation();   */                      // For debugger



}



void TurnOnLed(int number)
{
    if(number == 2)
    {
        P8OUT |= BIT1;
    }
    else if(number == 3)
    {
        P8OUT |= BIT2;
    }
}

void TurnOffLed(int number)
{
    if(number == 2)
    {
        P8OUT &= ~BIT1;
    }
    else if(number == 3)
    {
        P8OUT &= ~BIT2;
    }
}


#pragma vector=TIMER2_A0_VECTOR
__interrupt void Timer(void)
{

    P1OUT ^= Led1;
    P8OUT ^= Led2;
    TA2CTL &= ~BIT0;
    TA2IV = 0;
}


// Port 2 interrupt service routine
#pragma vector=PORT2_VECTOR
__interrupt void Port_2(void)
{
switch(__even_in_range(P2IV,16))
{
case 6:
{
    //TA2CTL &= ~BIT4;
    TA2CTL &= ~BIT0;
    TA2IV = 0;
    __delay_cycles(8000);//bouncing = 1ms, fr = 8mhz
    TA2CTL ^= BIT7;
    P2IFG &= ~BIT2;
    //TA2CTL |= BIT4;
    TA2IV = 0;

break;

}
}
}
