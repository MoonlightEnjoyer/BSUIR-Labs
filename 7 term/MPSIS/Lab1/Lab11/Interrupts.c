/*
#include <msp430.h>
#include <stdio.h>

void TurnOnLed(int number);
void TurnOffLed(int number);

int main(void)
{
    volatile int i;

      // stop watchdog timer
      WDTCTL = WDTPW | WDTHOLD;
      //set direction for led2 and led3
      P8DIR |= BIT2;
      P8DIR |= BIT1;

      P8OUT = 0;
      //set direction for s1, s2

      P1SEL &= (~BIT7);
      P1IES |= (BIT7);
      P1IFG &= (~BIT7);
      P1IE |=  (BIT7);

      P1DIR = 0;
      P1REN = BIT7;
      P1OUT= BIT7;

      P2SEL &= (~BIT2);
      P2IES |= (BIT2);
      P2IFG &= (~BIT2);
      P2IE |= (BIT2);

      P2DIR = 0;
      P2REN = BIT2;
      P2OUT = BIT2;

      __bis_SR_register(LPM4_bits + GIE);       // Enter LPM4 w/interrupt
      __no_operation();                       // For debugger
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


// Port 1 interrupt service routine
#pragma vector=PORT1_VECTOR
__interrupt void Port_1(void)
{
switch(__even_in_range(P1IV,16))
{
case 16:
{
    __delay_cycles(8000);//bouncing = 1ms, fr = 8mhz
           if (((P2IN & BIT2) == BIT2))
           {
               P8OUT ^= BIT1;
               P1IES ^= BIT7;
           }


           P1IFG &= ~BIT7;
    break;
}// P1.7
}
}


// Port 2 interrupt service routine
#pragma vector=PORT2_VECTOR
__interrupt void Port_2(void)
{
switch(__even_in_range(P2IV,16))
{
case 6:
{

        __delay_cycles(8000);//bouncing = 1ms, fr = 8mhz
        if (((P2IN & BIT2) != BIT2))
        {
            TurnOnLed(3);

            P2IES &= ~BIT2;
        }

        if (((P2IN & BIT2) == BIT2) && ((P1IN & BIT7) != BIT7))
        {
            TurnOffLed(3);
            P2IES |= BIT2;
        }


        P2IFG &= ~BIT2;


break;

}// P1.2
}
}*/

