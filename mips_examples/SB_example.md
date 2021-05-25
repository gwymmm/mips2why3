# SB Example

## Description

First we store the value 0x 0a0b 0c0d on the stack.
Then we change byte 2 of the word in memory from 0b to 01.
So the memory changes from:

    0a 0b 0c 0d : 32-bit register value

    store word to memory:

    0d : at word address a (least significant byte at lowest word address)

    0c : at a + 1

    0b : at a + 2

    0a : at a + 3 (most significant byte at highest word address)

To:

    store byte to memory:

    0d : at word address a (least significant byte at lowest word address)

    0c : at a + 1

    01 : at a + 2

    0a : at a + 3 (most significant byte at highest word address)

Finally we load the word again in a register and get the value 0x 0a01 0c0d. Note that $t1 has the value 0x 0000 0201 but only the least 
significant byte is stored in memory.

## Result

All assertions can be proved in Why3 (using Z3).

Execution of the code in MARS finishes successfully. 

Final value of the $t0 register: 0x 0a0b 0c0d.

Final value of the $t1 register: 0x 0000 0201.

Final value of the $t2 register: 0x 0a01 0c0d.






