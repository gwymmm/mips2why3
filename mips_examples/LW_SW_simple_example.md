# SW LW Simple Example

## Description

To test the memory model we store the value 0x 0a0b 0c0d on the stack.
Then we load it again in $t1. Finally we restore the stack pointer.

## Result

All assertions can be proved in Why3 (using Z3).

Execution of the code in MARS finishes successfully. 

Final value of the $t0 register: 0x 0a0b 0c0d.

Final value of the $t1 register: 0x 0a0b 0c0d.

In the memory at address (initial sp - 4) 
(word address (initial sp - 4) % 4 )
we have also the value: 0x 0a0b 0c0d.




