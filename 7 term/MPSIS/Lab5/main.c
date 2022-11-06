#include <msp430.h>


int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer
	
	//P1DIR |= BIT6;
	//P1SEL |= BIT6;

	CBCTL3 |= BIT0 | BIT4; // Input Buffer Disable @P6.1/CB0 & CB4

    // Led4
    P1DIR |= BIT1;
    P1OUT &= ~BIT1;

    // Led8
    P1DIR |= BIT5;
    P1OUT &= ~BIT5;

    P6DIR &= ~(BIT1 | BIT2 | BIT3);
    P6OUT |= BIT1 | BIT2 | BIT3;

    //+ > - = 1
    CBCTL0 |= CBIMEN | CBIMSEL_0 | CBIPEN | CBIPSEL_4;//CB0 = -, CB4 = +
    CBCTL1 |= CBF | CBFDLY_3;
    CBCTL1 &= ~CBIES;       // прерывания по фронту

    CBCTL1 &= ~CBSHORT;

    CBCTL2 |= CBREFACC;


    CBINT &= ~CBIFG;        // сбрасываем флаг прерывания компаратора
    CBINT &= ~CBIIFG;       // сбрасываем флаг инверсного прерывания компаратора

    CBINT |= CBIE;          // разрешаем прерывания компаратора
    //CBINT |= CBIIE;         // разрешаем инверсные прерывания компаратора
    CBCTL1 |= CBON;


    __bis_SR_register(GIE + LPM0_bits);
        //while(1);
        __no_operation();
}

#pragma vector=COMP_B_VECTOR
__interrupt void comparator_interrupt()
{

    if (CBCTL1 & CBOUT)
    {
        P1OUT &= ~BIT1;
        P1OUT |= BIT5;
    }
    else
    {

        P1OUT |= BIT1;
        P1OUT &= ~BIT5;
    }

    P1OUT &= ~BIT1;
    P1OUT &= ~BIT5;
   CBINT &= ~CBIFG;  // сбрасываем флаг прерывания
   CBINT &= ~CBIIFG; // сбрасываем флаг инверсного прерывания
}
