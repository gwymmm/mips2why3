# OR Example

## Description

We use the OR instruction to see the effect of the bit mask 0x 00ff ff00
on the value 0x 0a0b 0c0d. The OR operation sets all bits to 1 where
the bit mask is 1. Where the bit mask is 0 the bit of the second 
operand is passed through. So we expect this result:

    0x 0a0b 0c0d : first operand

    0x 00ff ff00 : second operand (bit mask)

    0x 0aff ff0d : result of OR operation

## Result

All assertions can be proved in Why3 (using Z3).

Execution of the code in MARS finishes successfully. 

Final value of the $t0 register: 0x 0a0b 0c0d.

Final value of the $t1 register: 0x 00ff ff00.

Final value of the $t2 register: 0x 0aff ff0d.






