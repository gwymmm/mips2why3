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
#>
#@ procedure
#> let branch_example(t0: ref int)(t1: ref int)(v1: ref int) 
#>                   (ra: ref int) : unit  
#> requires { "expl: argument in bounds" 
#>              in_32bit_bounds !t0 }
#> ensures {"expl: closer to ten"
#>            ( ((unsigned_to_signed !t0) > 10) -> ( (unsigned_to_signed !v1) = (unsigned_to_signed !t0) - 1) ) /\
#>            ( ((unsigned_to_signed !t0) < 10) -> ( (unsigned_to_signed !v1) = (unsigned_to_signed !t0) + 1) ) /\
#>            ( ((unsigned_to_signed !t0) = 10) -> ( (unsigned_to_signed !v1) = 10 )     )    }
#> ensures {"expl: ra restored" !ra = old (!ra) }
branch_example:
slti $t1, $t0, 10  # $t0 < 10
#@ branch
bne $t1, $zero, lt_ten
#> assert {"expl: $t0 >= 10" (unsigned_to_signed !t0) >= 10 };
addi $t1, $zero, 10
#@ branch
beq $t0, $t1, eq_ten
#> assert {"expl: $t0 > 10" (unsigned_to_signed !t0) > 10 };
addi $v1, $t0, -1
j inner
eq_ten:
#> assert {"expl: $t0 = 10" (unsigned_to_signed !t0) = 10 };
add $v1, $t0, $zero
#@ end branch
inner:
j return
lt_ten:
#> assert {"expl: $t0 < 10" (unsigned_to_signed !t0) < 10};
addi $v1, $t0, 1
#@ end branch
return:
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
addi $t0, $zero, -32
#@ call
#> branch_example t0 t1 v1 ra;
jal branch_example
#> assert {"expl: v1 = -31" (unsigned_to_signed !v1) = -31};
lw $ra, 0 ($sp)
addi $sp, $sp, 4
jr $ra
#@ end procedure
#>
