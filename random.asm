init   sta byte_a
       stx byte_b
       sty byte_c
       rts

Nast�pnie mo�emy wo�a� poni�sz� funkcj�. Warto�� zwracana jest w akumulatorze (ca�y bajt). 

random lda byte_a
       eor byte_b
       asl
       sta byte_a
       clc
       lda byte_b
       adc byte_c
       sta byte_b
       lda byte_c
       eor byte_b
       sta byte_c
       rts
