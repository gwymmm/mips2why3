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
#> let main (t0: ref int) (t1: ref int) (t2: ref int) (ra: ref int)
#>          (t3: ref int) (t4: ref int)
#>          (sp: ref int) (mem: ref (map int int) ): unit
#> requires { in_32bit_bounds !t0 }
#> requires { in_32bit_bounds !t1 }
#> requires { in_32bit_bounds !t2 }
#> requires { in_32bit_bounds !t3 }
#> requires { in_32bit_bounds !t4 }
#> requires { !sp = 0x7fff_effc }
#> requires { in_32bit_bounds !ra }
main:
#> let initial_ra = !ra in
#> let initial_sp = !sp in
addi $sp, $sp, -4
lui $t0, 0x8a0b
ori $t0, $t0, 0x0c0d
#> assert {"expl: $t0 val" !t0 = 0x8a0b_0c0d };
sw $t0, 0 ($sp)
lbu $t1, 0 ($sp)
lbu $t2, 1 ($sp)
lbu $t3, 2 ($sp)
lbu $t4, 3 ($sp)
#> assert {"expl: !t1 val " !t1 = 0x0d };
#> assert {"expl: !t2 val " !t2 = 0x0c };
#> assert {"expl: !t3 val " !t3 = 0x0b };
#> assert {"expl: !t4 val " !t4 = 0x8a };
addi $sp, $sp, 4
#> assert { "expl: $sp restored" !sp = initial_sp };
#> assert { "expl: return address restored" !ra = initial_ra };
jr $ra
#@ end procedure
