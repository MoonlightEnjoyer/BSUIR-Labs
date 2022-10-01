
#include <msp430.h>


volatile int isLpm = 0;

int main(void)
{
    volatile int i;

      // stop watchdog timer
      WDTCTL = WDTPW | WDTHOLD;
      P1DIR |= BIT0;
      P1OUT |= BIT0;
      P8DIR |= BIT2;
      P8OUT &= ~BIT2;

      P1SEL &= (~BIT7);
      P1IES |= (BIT7);
      P1IFG &= (~BIT7);
      P1IE |=  (BIT7);

      P1DIR &= ~BIT7;
      P1REN |= BIT7;
      P1OUT |= BIT7;

      P2SEL &= (~BIT2);
      P2IES |= (BIT2);
      P2IFG &= (~BIT2);
      P2IE |= (BIT2);

      P2DIR &= ~BIT2;
      P2REN |= BIT2;
      P2OUT |= BIT2;

      P7SEL |= BIT7;
      P7DIR |= BIT7;

      UCSCTL4 |= SELA__DCOCLK;
      UCSCTL1 |= DCORSEL_2;
      UCSCTL2 |= 65;

      /*__bis_SR_register(LPM4_bits + GIE);       // Enter LPM4 w/interrupt
      __no_operation();                       // For debugger*/
      __enable_interrupt();
}




// Port 1 interrupt service routine
#pragma vector=PORT1_VECTOR
__interrupt void Port_1(void)
{
switch(__even_in_range(P1IV,16))
{
case 16:
{

    //__delay_cycles(8000);//bouncing = 1ms, fr = 8mhz

    if (isLpm == 1)
    {

        //__enable_interrupt();
        isLpm = 0;
        P1OUT |= BIT0;
        P8OUT &= ~BIT2;
        //P1OUT &= ~BIT0;
        __bic_SR_register_on_exit(LPM4_bits);
    }
    else
    {


        isLpm = 1;
        //P1OUT &= ~BIT0;
        P1OUT &= ~BIT0;
        P8OUT |= BIT2;
        __bis_SR_register(LPM4_bits + GIE);
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

        //__delay_cycles(8000);//bouncing = 1ms, fr = 8mhz
        UCSCTL5 ^= DIVM__4;
        int level = 1;
        PMMCTL0_H = PMMPW_H;                    // Open PMM registers for write
            SVSMHCTL = SVSHE                        // Set SVS/SVM high side new level
                   + SVSHRVL0 * level
                   + SVMHE
                   + SVSMHRRL0 * level;
            SVSMLCTL = SVSLE                        // Set SVM low side to new level
                   + SVMLE
                   + SVSMLRRL0 * level;
            while ((PMMIFG & SVSMLDLYIFG) == 0);    // Wait till SVM is settled
            PMMIFG &= ~(SVMLVLRIFG + SVMLIFG);      // Clear already set flags
            PMMCTL0_L = PMMCOREV0 * level;          // Set VCore to new level
            if ((PMMIFG & SVMLIFG))                 // Wait till new level reached
            while ((PMMIFG & SVMLVLRIFG) == 0);
            SVSMLCTL = SVSLE                        // Set SVS/SVM low side to new level
                  + SVSLRVL0 * level
                  + SVMLE
                  + SVSMLRRL0 * level;
            PMMCTL0_H = 0x00;

        P2IFG &= ~BIT2;


break;

}// P1.2
}
}

