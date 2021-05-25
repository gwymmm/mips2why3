# ADDU Simple Example

## Description

We perform a simple unsigned addition: 10 + (-11) = -1.

In this case signed and unsigned addition lead the same value.
-1 is (2^32 - 1) in twos complement. So we assert:

    !t2 = 0xffff_ffff

## Result

All assertions can be proved in Why3.

Execution of the code in MARS finishes successfully. Register $t2 holds
the value 0xffff_ffff at the end of the program.
