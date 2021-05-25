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
addi $t0, $zero, 10 
addi $t1, $zero, -11
addu $t2, $t0, $t1
#> assert { "expl: result of unsigned addition" !t2 = 0xffff_ffff };
#> assert { "expl: return address restored" !ra = initial_ra };
jr $ra
#@ end procedure
