
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

      P1DIR = 0;
      P1REN = BIT7;
      P1OUT= BIT7;

      P2DIR = 0;
      P2REN = BIT2;
      P2OUT = BIT2;


      int isPressed = 1;
      int isPressed2 = 1;

      for(;;)
      {

          if (((P1IN & BIT7) != BIT7) && ((P2IN & BIT2) == BIT2) && ((P1IN & BIT7) != isPressed))
          {
              TurnOnLed(2);
          }
          else if (((P1IN & BIT7) == BIT7) && ((P2IN & BIT2) == BIT2) && ((P1IN & BIT7) != isPressed))
          {
              TurnOffLed(2);
          }

          if (((P2IN & BIT2) != BIT2) &&  ((P2IN & BIT2) != isPressed2))
          {
              TurnOnLed(3);
          }
          else if (((P2IN & BIT2) == BIT2) && ((P1IN & BIT7) != BIT7) && ((P2IN & BIT2) != isPressed2))
          {
              TurnOffLed(3);
          }



          isPressed = P1IN & BIT7;
          isPressed2 = P2IN & BIT2;
          __delay_cycles(10000);
      }


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
