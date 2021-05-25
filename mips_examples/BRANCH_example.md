# Branch Example

## Description

We write a procedure that takes an integer as argument and returns an 
integer. The result is closer to ten (by one) than the input argument
if this is possible.
Thus the specification is as follows:

    ( (input > 10) -> (output = input - 1) ) and
    ( (input < 10) -> (output = input + 1) ) and
    ( (input = 10) -> (output =        10) )

The implementation looks in general like this:

    if (t0 < 10) then (
     v1 := t0 + 1;
    )
    else (
     (* t0 >= 10 *)
     if (t0 = 10) then (
      v1 := t0;
     )
     else (
     (* t0 > 10 *)
      v1 := t0 - 1;
     )
    )

The assembly branch constructs are translated to nested if-then-else
 constructs in WhyML.

Why3 seems to optimize away the postcondition that the $ra register is
restored since it is never used in the procedure. In the main function,
on the other hand, the check is proved since we work with the $ra register
there.

Also note that, since we are interested in signed numbers, we have to 
work with the signed view of the register values:

    unsigned_to_signed !t0

## Result

All assertions can be proved in Why3.

Execution of the code in MARS finishes successfully. 

The final value of register $v1 is -31.








