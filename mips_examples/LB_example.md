# LB Example

## Description

First we store the value 0x 8a0b 0c0d on the stack. Then we fetch the
fourth byte (byte 3 when we begin counting at 0). Since MIPS is Little
Endian the most significant byte is stored at the highest word address.
We get the following layout in our example:


    8a 0b 0c 0d : 32-bit register value

    store word to memory:

    0d : at word address a (least significant byte at lowest word address)

    0c : at a + 1

    0b : at a + 2

    8a : at a + 3 (most significant byte at highest word address)

So we get 0x8a when we load byte 3. Since we use the LB instruction 0x8a
 is sign extended (padded with ones) and we get 0x ffff ff8a.

## Result

All assertions can be proved in Why3 (using Z3).

Execution of the code in MARS finishes successfully. 

Final value of the $t0 register: 0x 8a0b 0c0d.

Final value of the $t1 register: 0x ffff ff8a.





