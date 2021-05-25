# SUBU No Overflow

## Description

We calculate MIN_INT - 1. With the signed SUB instruction this
gives an overflow exception.

With SUBU we get

    MIN_INT - 1 = 0x8000_0000 - 1 = 0x7fff_ffff

## Result

All assertions can be proved in Why3.

Execution of the code in MARS finishes successfully. 

No overflow exception occurs.

Register $t2 holds the value 0x7fff_ffff at program end.
