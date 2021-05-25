# DIVU Simple Example

## Description

The DIVU instruction performs integer division. The quotient (q) is stored in
LO and the remainder (r) in HI.

The calculation 53 % 10 leads to q = 5 and r = 3 with:

    q * 10 + r = 53

## Result

All assertions can be proved in Why3.

Execution of the code in MARS finishes successfully. 

Final value of the LO register: 5.

Final value of the HI register: 3.
