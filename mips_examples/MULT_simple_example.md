# MULT Simple Example

## Description

We use the MULT instruction to calculate 10 * (-10).

The signed variant of the multiplication instruction uses LO to hold
the result of the multiplication.

The HI register can be used to check for overflow. All bits of the HI
register should be zero when the result is positive. 

All bits of the HI register should be one when the result is negative.

## Result

All assertions can be proved in Why3.

Execution of the code in MARS finishes successfully. 

The LO register holds the result: -100.

The HI register is 0xffff_ffff because the result is negative.
