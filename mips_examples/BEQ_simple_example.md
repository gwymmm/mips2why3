# BEQ Simple Example

## Description

We write a minimal construct for conditional execution. If 10 = 15 the 
program should branch. Since 10 != 15 we expect that the branch is not taken.

## Result

All assertions can be proved in Why3.

Execution of the code in MARS finishes successfully. 

The program does not branch at the BEQ instruction. The "j merge_point"
instruction is executed.








