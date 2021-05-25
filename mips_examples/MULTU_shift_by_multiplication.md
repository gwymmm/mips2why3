# MULTU Shift By Multiplication

## Description

We use the MULTU instruction to shift 2^32 - 1 (0xffff ffff) by 16 bits.

The result of a 32-bit multiplication fits into 64 bits. LO and HI are used
together to hold the result of the unsigned multiplication. LO holds the
32 least significant bits and HI holds the 32 most significant bits.

The multiplication of 0xffff ffff with 2^16 (0x0001 0000) is equivalent to
a shift left by 16 bits. So we expect as result:

       HI          LO

    0000 ffff | ffff 0000

## Result

All assertions can be proved in Why3.

Execution of the code in MARS finishes successfully. 

Final value of the LO register: 0xffff 0000.

Final value of the HI register: 0x0000 ffff.
