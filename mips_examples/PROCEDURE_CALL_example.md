# Procedure Call Example

## Description

A procedure that adds two integers is called.
The procedure simple_addition has the precondition that its parameters
are in the range [0, 10]. We call the procedure with 5 and 10 as arguments.
So we expect the result to be 15. We can also prove that the result of
simple_addition is in the range [0, 20].

Since the JAL instruction changes the value of the $ra register we have to
store the initial value of $ra on the stack. At the end of the main
procedure we restore $ra (and the stack pointer $sp) again.

Note that mips2why3 introduces a "touch ra" 
invocation during a procedure call. This signals Why3 that the JAL
instruction changes the return address. 

"touch" is defined in the MIPS Why3 model: "mips.mlw"

## Result

All assertions can be proved in Why3.

Execution of the code in MARS finishes successfully. 

The final value of register $v1 is 15.








