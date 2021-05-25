#> module Test
#> 
#> use import int.Int
#> use import ref.Ref
#> use import map.Map
#> use import mips.MIPS
#> use import int.EuclideanDivision
.text
#>
# startup code
#>
jal main
addi $v0, $zero, 10
syscall 
#>
#@ procedure
#> let main (t0: ref int) (t1: ref int) (t2: ref int) (ra: ref int)
#>          (sp: ref int) (mem: ref (map int int) ): unit
#> requires { in_32bit_bounds !t0 }
#> requires { in_32bit_bounds !t1 }
#> requires { in_32bit_bounds !t2 }
#> requires { !sp = 0x7fff_effc }
#> requires { in_32bit_bounds !ra }
main:
#> let initial_ra = !ra in
#> let initial_sp = !sp in
addi $sp, $sp, -4
lui $t0, 0x0a0b
ori $t0, $t0, 0x0c0d
#> assert {"expl: $t0 val" !t0 = 0x0a0b_0c0d };
sw $t0, 0 ($sp)
lw $t1, 0 ($sp)
#> assert {"expl: !t1 val " !t1 = 0x0a0b_0c0d };
#> assert {"expl: mem val " (get (!mem) (div (initial_sp - 4) 4) ) = 0x0a0b_0c0d };
addi $sp, $sp, 4
#> assert { "expl: $sp restored" !sp = initial_sp };
#> assert { "expl: return address restored" !ra = initial_ra };
jr $ra
#@ end procedure
