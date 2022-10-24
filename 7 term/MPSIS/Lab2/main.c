
#include <msp430.h>
#include <stdio.h>

#define Led1 BIT0
#define Led2 BIT1



int main(void)
{

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

      TA1CTL |= (BIT2 | BIT9 | MC__UP | ID__8);
      TA1CCR0 = 5000;
      TA1CCTL0 |= BIT4;

      __enable_interrupt();
}
volatile int delay = 0;

#pragma vector=TIMER1_A0_VECTOR
__interrupt void Timer1(void)
{
    delay = 0;
}

#pragma vector=TIMER2_A0_VECTOR
__interrupt void Timer2(void)
{

    P1OUT ^= Led1;
    P8OUT ^= Led2;
}


// Port 2 interrupt service routine

#pragma vector=PORT2_VECTOR
__interrupt void Port_2(void)
{
    if(delay == 0 && ((P2IES & BIT2) == BIT2))
    {
        TA1CTL |= TACLR;
        delay = 1;
        TA2CTL ^= BIT7;
        TA1CTL |= MC__UP | ID__8;
        P2IES &= ~BIT2;
    }
    else if (delay == 0 && ((P2IES & BIT2) != BIT2))
      {
        TA1CTL |= TACLR;
                delay = 1;
                TA1CTL |= MC__UP | ID__8;
                P2IES |= BIT2;
        }

    P2IFG &= ~BIT2;

}
