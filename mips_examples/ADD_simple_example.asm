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
#> (* addition *)
addi $t0, $zero, 5
addi $t1, $zero, -10
add $t2, $t0, $t1
#> assert { "expl: result of signed addition" !t2 = signed_to_unsigned (-5) };
#> assert { "expl: result of signed addition2" unsigned_to_signed (!t2) = -5 };
#> assert { "expl: return address restored" !ra = initial_ra };
jr $ra
#@ end procedure
