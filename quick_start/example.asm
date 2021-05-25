#> module Test
#> (* Procedure Call Example *)
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
#>
#@ procedure
#> let simple_addition(t0: ref int) (t1: ref int) 
#>                    (v1: ref int) (ra: ref int) : unit
#> requires { "expl: t0 in [0, 10]" (!t0 >= 0) /\ (!t0 <= 10) }
#> requires { "expl: t1 in [0, 10]" (!t1 >= 0) /\ (!t1 <= 10) }
#> ensures {"expl: v1 = t0 + t1" !v1 = !t0 + !t1 }
#> ensures {"expl: ra restored" !ra = old (!ra) }
simple_addition:
add $v1, $t0, $t1
jr $ra
#@ end procedure
#>
#@ procedure
#> let main (t0: ref int) (t1: ref int) (v1: ref int) (ra: ref int) 
#>           (mem: ref (map int int) ) (sp: ref int): unit
#> requires { in_32bit_bounds !t0 }
#> requires { in_32bit_bounds !t1 }
#> requires { in_32bit_bounds !v1 }
#> requires { in_32bit_bounds !ra }
#> requires { !sp = 0x7fff_effc }
#> ensures { "expl: sp restored" !sp = old (!sp) }
#> ensures { "expl: ra restored" !ra = old (!ra) }
main:
addi $sp, $sp, -4
sw $ra, 0 ($sp)
addi $t0, $zero, 10
addi $t1, $zero, 5
#@ call
#> simple_addition t0 t1 v1 ra;
jal simple_addition
#> assert {"expl: v1 in [0, 20]" (!v1 >= 0) /\ (!v1 <= 20)};
#> assert {"expl: v1 = 15" !v1 = 15 };
lw $ra, 0 ($sp)
addi $sp, $sp, 4
jr $ra
#@ end procedure
#>
