# LBU Example

## Description

First we store the value 0x 8a0b 0c0d on the stack. Then we fetch all 
four bytes into the registers $t1 - $t4. Since MIPS is Little
Endian the most significant byte is stored at the highest word address.
We get the following layout in our example:


    8a 0b 0c 0d : 32-bit register value

    store word to memory:

    0d : at word address a (least significant byte at lowest word address)

    0c : at a + 1

    0b : at a + 2

    8a : at a + 3 (most significant byte at highest word address)

So we get 0d, 0c, 0b, 8a. Note that unlike in the LB example the value
0x 8a is not sign extended when using the LBU instruction.

## Result

All assertions can be proved in Why3 (using Z3).

Execution of the code in MARS finishes successfully. 

Final value of the $t0 register: 0x 8a0b 0c0d.

Final value of the $t1 register: 0x 0000 000d.
Final value of the $t2 register: 0x 0000 000c.
Final value of the $t3 register: 0x 0000 000b.
Final value of the $t4 register: 0x 0000 008a.





