# Loop Example

## Description

We write a simple loop that counts to 10. In a high level language it 
would look like this:

     loop
     invariant { 0 <= !x <= 10 }
     variant { 10 - !x }
     (* begin loop *)
      if (!x = 10) then break;
      x := !x + 1 
     end (* loop *)
    assert { !x = 10 };

The invariant and the variant describe what happens inside the loop. So
the assertion at the end of the program can be proved.

## Result

All assertions can be proved in Why3.

Execution of the code in MARS finishes successfully. 

The final value of register $t0 is 10.








