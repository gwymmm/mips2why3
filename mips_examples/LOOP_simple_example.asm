#> module Test
#> 
#> use import int.Int
#> use import ref.Ref
#> use import map.Map
#> use import mips.MIPS
#>
.text
#>
# startup code
#>
jal main
addi $v0, $zero, 10
syscall 
#>
#@ procedure
#> let main (t0: ref int) (t1: ref int) : unit
#> requires { in_32bit_bounds !t0 }
#> requires { in_32bit_bounds !t1 }
main:
add $t0, $zero, $zero
addi $t1, $zero, 10
loopb:
#@ loop
#> invariant { (0 <= !t0) /\ (!t0 <= 10) }
#> variant { 10 - !t0 }
#@ break
beq $t0, $t1, endl
addi $t0, $t0, 1
j loopb
#@ end loop
endl:
#> assert {"expl: looped to 10" !t0 = 10};
jr $ra
#@ end procedure
#>
