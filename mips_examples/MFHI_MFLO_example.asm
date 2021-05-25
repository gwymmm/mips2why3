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
#>          (hi: ref int) (lo: ref int) : unit
#> requires { in_32bit_bounds !t0 }
#> requires { in_32bit_bounds !t1 }
#> requires { in_32bit_bounds !t2 }
#> requires { in_32bit_bounds !ra }
main:
#> let initial_ra = !ra in
#>
lui $t0, 0xaaaa
ori $t0, $t0, 0xbbbb
#> assert {"expl: $t0 val" !t0 = 0xaaaa_bbbb };
lui $t1, 1
#> assert {"expl: $t1 val" !t1 = c_2_POW_16};
divu $t0, $t1
#> assert { "expl: lo value" !lo = 0x0000_aaaa };
#> assert { "expl: hi value" !hi = 0x0000_bbbb };
mfhi $t1
mflo $t2
#> assert {"expl: result $t1" !t1 = 0x0000_bbbb };
#> assert {"expl: result $t2" !t2 = 0x0000_aaaa };
#> assert { "expl: return address restored" !ra = initial_ra };
jr $ra
#@ end procedure
