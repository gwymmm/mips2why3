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
#> let main (t0: ref int) (t1: ref int) (t2: ref int) (ra: ref int): unit
#> requires { in_32bit_bounds !t0 }
#> requires { in_32bit_bounds !t1 }
#> requires { in_32bit_bounds !t2 }
#> requires { in_32bit_bounds !ra }
main:
#> let initial_ra = !ra in
#>
addi $t0, $zero, 1
lui $t1, 0x8000
#> assert { "expl: lui works" !t1 = 0x8000_0000 };
subu $t2, $t1, $t0
#> assert { "expl: MIN_INT - 1, no overflow" !t2 = 0x7fff_ffff};
#> assert { "expl: return address restored" !ra = initial_ra };
jr $ra
#@ end procedure
