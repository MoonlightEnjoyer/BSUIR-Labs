//ток потребления jp7 = 57 mA
//
//ток потребления jp6 = 27.5 mA(processor)
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

      //Timer TA1
            TA1CTL |= (BIT2 | BIT9 | MC__UP | ID__8);
            TA1CCR0 = 15000;
            TA1CCTL0 |= BIT4;

      //Timer TA2
      TA2CTL |= (BIT2 | TASSEL__ACLK | MC__UPDOWN | ID__8);
      TA2CCR0 = 65535;
      TA2CCTL0 |= BIT4;



      //Led4
      P1DIR |= BIT1;
      P1OUT |= BIT1;

      //Led5
      P1DIR |= BIT2;
      P1OUT &= ~BIT2;

      //Led8
            P1DIR |= BIT5;
            P1OUT &= ~BIT5;


      //S1 button
      P1DIR &= ~BIT7;
      P1REN |= BIT7;
      P1OUT |= BIT7;

      P1SEL &= (~BIT7);
      P1IES |= (BIT7);
      P1IFG &= (~BIT7);
      P1IE |=  (BIT7);

      //S2 button
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

      PMMCTL0_H = PMMPW_H;                    // Open PMM registers for write
                  SVSMHCTL |= SVSHE                        // Set SVS/SVM high side new level
                         | SVSHRVL_2
                         | SVMHE
                         | SVSMHRRL_2;
                  SVSMLCTL |= SVSLE                        // Set SVM low side to new level
                         | SVMLE
                         | SVSMLRRL_2;
                  while ((PMMIFG & SVSMLDLYIFG) == 0);    // Wait till SVM is settled
                  PMMIFG &= ~(SVMLVLRIFG | SVMLIFG);      // Clear already set flags
                  PMMCTL0_L = PMMCOREV_2;          // Set VCore to new level
                  if ((PMMIFG & SVMLIFG))                 // Wait till new level reached
                  while ((PMMIFG & SVMLVLRIFG) == 0);
                  SVSMLCTL = SVSLE                        // Set SVS/SVM low side to new level
                        + SVSLRVL_2
                        + SVMLE
                        + SVSMLRRL_2;
                  PMMCTL0_H = 0x00;

      /*__bis_SR_register(LPM4_bits + GIE);       // Enter LPM4 w/interrupt
      __no_operation();                       // For debugger*/
      __enable_interrupt();
}

volatile int delay1 = 0;
volatile int delay2 = 0;

#pragma vector=TIMER1_A0_VECTOR
__interrupt void Timer1(void)
{
    delay1 = 0;
    delay2 = 0;
}

#pragma vector=TIMER2_A0_VECTOR
__interrupt void Timer2(void)
{
    //delay = 0;
    P1OUT ^= BIT5;
}



// Port 1 interrupt service routine
#pragma vector=PORT1_VECTOR
__interrupt void Port_1(void)
{
switch(__even_in_range(P1IV,16))
{
case 16:
{
    if (delay1 == 0 && ((P1IES & BIT7) == BIT7))
    {
        TA1CTL |= TACLR;
        delay1 = 1;
        TA1CTL |= MC__UP | ID__8;
        P1IES &= ~BIT7;
        P8OUT &= ~BIT1;
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


    }
    else if(delay1 == 0 && ((P1IES & BIT7) != BIT7))
    {
        TA1CTL |= TACLR;
                delay1 = 1;
                TA1CTL |= MC__UP | ID__8;
                P1IES |= BIT7;
    }

    P1IFG &= ~BIT7;
    break;
}// P1.7
}
}

volatile int level = 0;

// Port 2 interrupt service routine
#pragma vector=PORT2_VECTOR
__interrupt void Port_2(void)
{


    if (delay2 == 0 && ((P2IES & BIT2) == BIT2))
    {
        TA1CTL |= TACLR;
        delay2 = 1;
        TA1CTL |= MC__UP | ID__8;
        P2IES &= ~BIT2;
        //frequency
        //UCSCTL5 ^= DIVM__4;

        //UCSCTL2 ^= FLLD__16;

        UCSCTL3 ^= FLLREFDIV__4;

        if (level == 0)
        {
            PMMCTL0_H = PMMPW_H;                    // Open PMM registers for write
                                         SVSMHCTL |= SVSHE                        // Set SVS/SVM high side new level
                                                | SVSHRVL_0
                                                | SVMHE
                                                | SVSMHRRL_0;
                                         SVSMLCTL |= SVSLE                        // Set SVM low side to new level
                                                | SVMLE
                                                | SVSMLRRL_0;
                                         while ((PMMIFG & SVSMLDLYIFG) == 0);    // Wait till SVM is settled
                                         PMMIFG &= ~(SVMLVLRIFG | SVMLIFG);      // Clear already set flags
                                         PMMCTL0_L = PMMCOREV_0;          // Set VCore to new level
                                         if ((PMMIFG & SVMLIFG))                 // Wait till new level reached
                                         while ((PMMIFG & SVMLVLRIFG) == 0);
                                         SVSMLCTL = SVSLE                        // Set SVS/SVM low side to new level
                                               + SVSLRVL_0
                                               + SVMLE
                                               + SVSMLRRL_0;
                                         PMMCTL0_H = 0x00;

                                         level = 1;
        }
        else
        {
            PMMCTL0_H = PMMPW_H;                    // Open PMM registers for write
                             SVSMHCTL |= SVSHE                        // Set SVS/SVM high side new level
                                    | SVSHRVL_2
                                    | SVMHE
                                    | SVSMHRRL_2;
                             SVSMLCTL |= SVSLE                        // Set SVM low side to new level
                                    | SVMLE
                                    | SVSMLRRL_2;
                             while ((PMMIFG & SVSMLDLYIFG) == 0);    // Wait till SVM is settled
                             PMMIFG &= ~(SVMLVLRIFG | SVMLIFG);      // Clear already set flags
                             PMMCTL0_L = PMMCOREV_2;          // Set VCore to new level
                             if ((PMMIFG & SVMLIFG))                 // Wait till new level reached
                             while ((PMMIFG & SVMLVLRIFG) == 0);
                             SVSMLCTL = SVSLE                        // Set SVS/SVM low side to new level
                                   + SVSLRVL_2
                                   + SVMLE
                                   + SVSMLRRL_2;
                             PMMCTL0_H = 0x00;

                             level = 0;
        }

        //////

/*
        PMMCTL0_H = PMMPW_H;                    // Open PMM registers for write
            SVSMHCTL |= SVSHE                        // Set SVS/SVM high side new level
                   | SVSHRVL_2
                   | SVMHE
                   | SVSMHRRL_2;
            SVSMLCTL |= SVSLE                        // Set SVM low side to new level
                   | SVMLE
                   | SVSMLRRL_2;
            while ((PMMIFG & SVSMLDLYIFG) == 0);    // Wait till SVM is settled
            PMMIFG &= ~(SVMLVLRIFG | SVMLIFG);      // Clear already set flags
            PMMCTL0_L = PMMCOREV_2;          // Set VCore to new level
            if ((PMMIFG & SVMLIFG))                 // Wait till new level reached
            while ((PMMIFG & SVMLVLRIFG) == 0);
            SVSMLCTL = SVSLE                        // Set SVS/SVM low side to new level
                  + SVSLRVL_2
                  + SVMLE
                  + SVSMLRRL_2;
            PMMCTL0_H = 0x00;*/

            P1OUT ^= BIT1;
            P1OUT ^= BIT2;
        }
    else if(delay2 == 0 && ((P2IES & BIT2) != BIT2))
        {
            TA1CTL |= TACLR;
                    delay2 = 1;
                    TA1CTL |= MC__UP | ID__8;
                    P2IES |= BIT2;
        }

        P2IFG &= ~BIT2;

}


