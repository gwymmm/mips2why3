# SLTIU Simple Example

## Description

We test whether 

    10 < -1 

But we use unsigned comparison. The signed immediate -1 is sign extended to
0x ffff ffff (2^32 - 1). When we finally compare 

    10 < (2^32 - 1)

we get True ($t2 = 1) as result.

## Result

All assertions can be proved in Why3.

Execution of the code in MARS finishes successfully. 

Final value of the $t2 register: 1.




