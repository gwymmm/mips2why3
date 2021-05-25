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
#> let main (t0: ref int) (t1: ref int) (t2: ref int) (ra: ref int) : unit
#> requires { in_32bit_bounds !t0 }
#> requires { in_32bit_bounds !t1 }
#> requires { in_32bit_bounds !t2 }
#> requires { in_32bit_bounds !ra }
main:
#> let initial_ra = !ra in
lui $t0, 0x0a0b
ori $t0, $t0, 0x0c0d
#> assert {"expl: $t0 val" !t0 = 0x0a0b_0c0d };
lui $t1, 0x00ff
ori $t1, $t1, 0xff00
#> assert {"expl: $t1 val" !t1 = 0x00ff_ff00};
and $t2, $t0, $t1
#> assert {"expl: !t2 val " !t2 = 0x000b_0c00 };
#> assert { "expl: return address restored" !ra = initial_ra };
jr $ra
#@ end procedure
