# Helper Functions

## in_32bit_bounds

Test whether v in [0, 2^(32) - 1]

## in_16bit_bounds

Test whether v in [0, 2^(16) - 1]

## in_32bit_twos_complement_bounds

Test whether v in [-2^(31), 2^(31) - 1]

## in_16bit_twos_complement_bounds 

Test whether v in [-2^(15), 2^(15) - 1]

## unsigned_to_signed

Defines how to convert unsigned 32-bit numbers to signed numbers. Note
that the function is total (defined for all integers). Nevertheless it
makes only sense to call it with the argument in the range [0, 2^(32) - 1].

## signed_to_unsigned

The reverse operation of unsigned_to_signed. Converts signed 32-bit two's complement number to its unsigned representation.
Argument should be in the range [-2^(31), 2^(31) - 1].

## sign_extend_16to32

Takes a signed 16-bit two's complement number in the range [-2^(15), 2^(15) - 1] and converts it to its unsigned 32-bit representation.
If the number is negative it has to be padded with ones. 

## sign_extend_8to32

Note that here the argument is an unsigned number in the range [0, 2^(8) - 1].

## bool_or, bool_and

Implement the truth tables for the or and the and boolean operators.
Work with integers so that no boolean type needs to be introduced.

## Bitwise Logical Operations

### bitwise_and (and, andi instructions)

x and y should be in 32-bit bounds [0, 2^(32) - 1].

Operation consisting of three steps:

* Splitting two register values in single bits
* Applying the and operation on the single bits
* Reconstructing the 32-bit result from the single bits

A single bit is chopped by mod r 2. The remaining register is div r 2.
Doing this for all bits the following pattern is observed.

Bit splitting:

     31  30  29  28  27  26  25  24  23  22  21  20  19  18  17  16  15  14  13  12  11  10   9   8   7   6   5   4   3   2   1   0
    | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | x

    |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tx0

    |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tx1

    |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tx2

    |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tx3

    |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tx4

    |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tx5

    |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tx6

    |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tx7

    |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tx8

    |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tx9

    |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tx10

    |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tx11

    |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tx12

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tx13

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tx14

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tx15

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tx16

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tx17

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | tx18

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | tx19

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | tx20

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | tx21

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | tx22

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | tx23

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | tx24

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | tx25

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | tx26

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | tx27

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | tx28

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | tx29

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | tx30

A word is reconstructed from a bit bn by a shift left (bn * 2) and 
the addition of the next less significant bit (bn * 2) + b(n-1).
Applying this operation to all bits of the result leads to 
following pattern.

Word reconstruction:

     31  30  29  28  27  26  25  24  23  22  21  20  19  18  17  16  15  14  13  12  11  10   9   8   7   6   5   4   3   2   1   0
    |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | tz0

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | tz1

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | tz2

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | tz3

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | tz4

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | tz5

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | tz6

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | tz7

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | tz8

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | tz9

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | tz10

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | tz11

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | tz12

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tz13

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tz14

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tz15

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tz16

    |   |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tz17

    |   |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tz18

    |   |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tz19

    |   |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tz20

    |   |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tz21

    |   |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tz22

    |   |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tz23

    |   |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tz24

    |   |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tz25

    |   |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tz26

    |   |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tz27

    |   |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tz28

    |   |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tz29

    |   | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | tz30

    | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | * | z


### bitwise_or (or, ori instructions)

x and y should be in 32-bit bounds [0, 2^(32) - 1].

The same operation as with bitwise_and. Only a bitwise or is performed
instead.

# Arithmetic Instructions

Register values are expected to be in 32-bit unsigned bounds [0, 2^(32) - 1].

## add

Overflow is checked by performing the addition with unbounded integers.
Addition modulo 2^32 is performed.

## addi

The immediate is expected to be in 16-bit unsigned bounds [-2^(15), 2^(15) - 1]
The immediate is sign extended for the addition.

## addiu

Note that unsigned is a misnomer here. The immediate is sign extended!
Only no check for overflow is made.

## sub, subu

Are like add, addu. Only with subtraction.

## mult

mult, multu and divu take WhyML references as arguments. So a manual
dataflow specification is needed.

The asynchronous behavior of the mult and div instructions is not treated here.

This operation is checked for overflow here, although this is not 
described in the MIPS ISA. 

## divu

Only the divu instruction is implemented here to keep things simple.
So no additional convention for the mod and div functions needs to be
introduced.

## sll

The mod 2^32 operation is needed to discard the bits that exceed the 
32-bit range of the register.

## slt

Performs a signed comparison with two registers.

## slti 

Performs a signed comparison with a register and an immediate.

## sltiu

Performs an unsigned comparison but the immediate is sign extended!

## sltu

Performs an usigned comparison of two registers.

# Data Transfer Instructions

The map that stands for the memory (called mem here) stores word
values (map interface convention).

## lw, sw

The calculation of the effective address is like the addi instruction.
The effective address has to be word aligned (divisible by four without
remainder). Since the effective address is a byte address it has
to be divided by four to get a word address. So the map interface 
convention is obeyed.

## lb, sb

Since the memory map stores word values we have to start with a word value.
The appropriate bytes are selected with div and mod operations.
Note also that MIPS is Little Endian:

    0a 0b 0c 0d : 32-bit register value

    store word to memory:

    0d : at word address a (least significant byte at lowest word address)

    0c : at a + 1

    0b : at a + 2

    0a : at a + 3 (most significant byte at highest word address)

With lb the loaded byte is sign extended.


## lbu

The lbu instruction does not sign extend the loaded byte.

# Bitwise Logical Instructions

Use the bitwise helper functions to model their behavior.

# Conditional Branches

It is assumed that no far jumps are needed to reach target destination.

# Jump and Link Instruction

To tell Why3 that the jal instruction changes the value of the $ra register, 
mips2why3 calls the touch function during each procedure invocation.