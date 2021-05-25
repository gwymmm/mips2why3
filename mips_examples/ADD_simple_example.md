# ADD Simple Example

## Description

We perform a simple signed addition: 5 + (-10) = -5.

The result in $t2 is an unsigned number. To check the result we can convert
-5 to the unsigned twos complement representation:

    signed_to_unsigned (-5)

Alternatively we can view the the result in $t2 as a signed number:

    unsigned_to_signed (!t2)

## Result

All assertions can be proved in Why3.

Execution of the code in MARS finishes successfully. Register $t2 holds
the value -5 at the end of the program.
