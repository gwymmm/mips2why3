# ADDIU Sign Extension Pitfall

## Description

Note that the immediate of the ADDIU instruction is sign extended although
the instruction is called unsigned ("misnomer").

-1 is 0xffff in 16-bit twos complement. So 0 + 0xffff would lead 0x0000_ffff as 32-bit value. But the immediate is sign extended to
0xffff_ffff so we get 0 + 0xffff_ffff as result.

## Result

All assertions can be proved in Why3.

Execution of the code in MARS finishes successfully. Register $t0 holds
the value 0xffff_ffff (and not 0x0000_ffff) at the end of the program.
