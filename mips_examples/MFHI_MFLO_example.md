# MFHI MFLO Example

## Description

We split the number 0x aaaa bbbb in two halves. Therefore we divide it by
2^16. The quotient in LO is 0x aaaa and the remainder in HI is 0x bbbb.
Finally we write the result to $t1 and $t2 with MFHI and MFLO.

## Result

All assertions can be proved in Why3 (Z3 can handle the ORI instruction!).

Execution of the code in MARS finishes successfully. 

Final value of the $t1 register: 0x 0000 bbbb.

Final value of the $t2 register: 0x 0000 aaaa.
