# Documentation for the mips2why3 Grammar

## Introduction

The aim of mips2why3 is to translate an assembly file in MARS MIPS 
simulator syntax to WhyML (the input language of Why3). For this purpose
mips2why3 also recognizes special annotations (path through blocks, 
annotation keywords) that make translations to WhyML possible.

Important points about mips2why3:

* in the input everything should be lowercase
* no semantic checks are made, so take care that you jump to the right
  labels
* the language is not a 100% match to the assembly syntax of MARS

## Lexer

The lexer is described by a set of regular expressions. When a string
is matched by more than one regular expression the longest match is
prefered. When multiple rules match the same number of characters, the
rule that is defined first wins.

The ".text" assembler directive is the only one that is recognized.

Annotation keywords start with "#@". They denote branches, loops, procedures,
procedure calls and exits from a loop. 

General purpose registers (GPR) start with a "$" followed by a character,
followed by a character or digit.

A label starts with a character followed by zero or more characters, digits
or underscores.

A decimal number starts with an optional "+" or "-" followed by one or
more digits.

A hex number begins with "0x" followed by zero or more digits and 
characters.

A pass through block begins with "#>". Everything until the next line
is printed as it is from input to output.

Comments are lines that start only with "#". Comments are skipped
(not passed to the parser).

Whitespace characters are also skipped.

## Parser

The grammar of mips2why3
describes a context free language and is written in BNF. Furthermore
the grammar is in Greibach Normal Form. With the further limitations
that no empty word is used and that all rule alternatives start with
a different terminal symbol. So each rule of the mips2why3 grammar is
of the following form:

    a := B c d e f

Here a is a non-terminal. B is a terminal and c and the following symbols
denote terminal or non-terminal symbols. So a non-terminal is always
substituted by a non-terminal followed by multiple symbols that can be
terminal or non-terminal. Since every rule alternative starts with
a different non-terminal, the grammar is unambiguous by construction.
It maps to a deterministic push-down automaton.

The parser is generated from the input grammar by a LL(1) parser 
generator tool (javacc).

### Grammar

Essentially the language can be described as follows: After a 
(hard coded) startup code the parser recognizes a list of procedure
definitions. The procedure definitions can contain single instructions,
branches, loops and procedure calls. Loops can be nested in branches and
other loops. Branches can be nested in loops and other branches.
Loops are exited with a break construct.

In the following, lowercase names denote non-terminal and uppercase names
terminal symbols.

The semantic actions are always print statements to standard output.
You can look at annotated_mips.jj to see what is done in detail.

Assembler program is the start symbol.

    assembler_program := PASS_THROUGH_BLOCK prequel startup procedures

The prequel is a series of pass through blocks. Import declarations
for Why3 can be made here. The prequel ends with the .text directive.

    prequel := PASS_THROUGH_BLOCK prequel
             | TEXT_DIRECTIVE

Startup is a hard coded instruction sequence that calls the main 
program and then exits. The reason is that Why3 seems to work in one
pass. So functions can not be used before being defined. The workaround
is to implement this startup sequence to call main that is the last
procedure in the assembly file. Procedures that are called by main
are defined above main.

    startup := JAL LABEL ADDI GPR COMMA ZERO COMMA DECIMAL_NUMBER SYSCALL
             | PASS_THROUGH_BLOCK startup

Procedures is used to recognize a series of procedure definitions.

    procedures := PROCEDURE signature procedure_body procedures
                | PASS_THROUGH_BLOCK procedures
                | EOF

Signature is a series of pass through blocks. The signature of the 
WhyML function can be defined here. Signature ends with a label 
definition.

    signature := PASS_THROUGH_BLOCK signature
               | LABEL COLON

Procedure body contains the instruction sequence of a procedure. A jr
instruction ends the procedure.

    procedure_body := BRANCH branch_instruction not_branched branched procedure_body
                    | LOOP loop_body loop_end procedure_body
                    | CALL procedure_call procedure_body
                    | PASS_THROUGH_BLOCK procedure_body
                    | ADD add_instruction procedure_body
                    | ADDI addi_instruction procedure_body
                    | ADDU addu_instruction procedure_body
                    | ADDIU addiu_instruction procedure_body
                    | SUB sub_instruction procedure_body
                    | SUBU subu_instruction procedure_body
                    | MULT mult_div_instruction procedure_body
                    | MULTU mult_div_instruction procedure_body
                    | DIVU mult_div_instruction procedure_body
                    | MFHI mfhi_instruction procedure_body
                    | MFLO mflo_instruction procedure_body
                    | LUI lui_instruction procedure_body
                    | SRL srl_instruction procedure_body
                    | SLL sll_instruction procedure_body
                    | SLT slt_instruction procedure_body
                    | SLTI slti_instruction procedure_body
                    | SLTIU sltiu_instruction procedure_body
                    | SLTU sltu_instruction procedure_body
                    | LW lw_instruction procedure_body
                    | SW sw_instruction procedure_body
                    | LB lb_instruction procedure_body
                    | LBU lbu_instruction procedure_body
                    | SB sb_instruction procedure_body
                    | AND and_instruction procedure_body
                    | ANDI andi_instruction procedure_body
                    | OR or_instruction procedure_body
                    | ORI ori_instruction procedure_body
                    | LABEL COLON procedure_body
                    | JR GPR END_PROCEDURE

Most of the instruction look the same. The destination operand and the
intsruction mnemonic switch their positions for Why3.

    add_instruction := GPR COMMA middle_operand COMMA last_operand

    middle_operand := GPR
                    | ZERO

Last operand prints the final semicolon of the instruction.

    last_operand := GPR
                  | ZERO

    addi_instruction := GPR COMMA middle_operand COMMA immediate

    immediate := DECIMAL_NUMBER
               | HEX_NUMBER

    addu_instruction := GPR COMMA middle_operand COMMA last_operand

    addiu_instruction := GPR COMMA middle_operand COMMA immediate

    sub_instruction := GPR COMMA middle_operand COMMA last_operand

    subu_instruction := GPR COMMA middle_operand COMMA last_operand

Mult und div have same rule, since mnemonic and source register do not
need to be switched for these instructions.

    mult_div_instruction := middle_operand COMMA last_mult_operand

Mult and div write to lo and hi. These arguments are added at the end
of the instruction.

    last_mult_operand := GPR
                       | ZERO

    mfhi_instruction := GPR

    mflo_instruction := GPR

    lui_instruction := GPR COMMA immediate

    srl_instruction := GPR COMMA middle_operand COMMA immediate

    sll_instruction := GPR COMMA middle_operand COMMA immediate

    slt_instruction := GPR COMMA middle_operand COMMA last_operand

    slti_instruction := GPR COMMA middle_operand COMMA immediate

    sltiu_instruction := GPR COMMA middle_operand COMMA immediate

    sltu_instruction := GPR COMMA middle_operand COMMA last_operand

    lw_instruction := GPR COMMA indexed_access

Assume that no hexadecimal number is given as offset.

    indexed_access := DECIMAL_NUMBER OPEN_BRACKET GPR CLOSE_BRACKET

    sw_instruction := GPR COMMA indexed_access

    lb_instruction := GPR COMMA indexed_access

    lbu_instruction := GPR COMMA indexed_access

    sb_instruction := GPR COMMA indexed_access

    and_instruction := GPR COMMA middle_operand COMMA last_operand

    or_instruction := GPR COMMA middle_operand COMMA last_operand

    andi_instruction := GPR COMMA middle_operand COMMA immediate

    ori_instruction := GPR COMMA middle_operand COMMA immediate

Write branch decision into local WhyML constant.

    branch_instruction := BEQ branch_instruction_operands
                        | BNE branch_instruction_operands

Start the if-then-else construct.

    branch_instruction_operands := GPR COMMA middle_operand COMMA LABEL
                                 | ZERO COMMA middle_operand COMMA LABEL

Procedure call touches the $ra register.

    procedure_call :=   PASS_THROUGH_BLOCK JAL LABEL

Not branched recognizes the sequences of instructions that are executed
when the program does not branch. The sequence stops at a jump to label.
Then the else part begins.

    not_branched := J LABEL
                    | BRANCH branch_instruction not_branched branched not_branched
                    | LOOP loop_body loop_end not_branched
                    | CALL procedure_call not_branched
                    | PASS_THROUGH_BLOCK not_branched
                    | ADD add_instruction not_branched
                    | ADDI addi_instruction not_branched
                    | ADDU addu_instruction not_branched
                    | ADDIU addiu_instruction not_branched
                    | SUB sub_instruction not_branched
                    | SUBU subu_instruction not_branched
                    | MULT mult_div_instruction not_branched
                    | MULTU mult_div_instruction not_branched
                    | DIVU mult_div_instruction not_branched
                    | MFHI mfhi_instruction not_branched
                    | MFLO mflo_instruction not_branched
                    | LUI lui_instruction not_branched
                    | SRL srl_instruction not_branched
                    | SLL sll_instruction not_branched
                    | SLT slt_instruction not_branched
                    | SLTI slti_instruction not_branched
                    | SLTIU sltiu_instruction not_branched
                    | SLTU sltu_instruction not_branched
                    | LW lw_instruction not_branched
                    | SW sw_instruction not_branched
                    | LB lb_instruction not_branched
                    | LBU lbu_instruction not_branched
                    | SB sb_instruction not_branched
                    | AND and_instruction not_branched
                    | ANDI andi_instruction not_branched
                    | OR or_instruction not_branched
                    | ORI ori_instruction not_branched
                    | LABEL COLON not_branched

Branched recognizes the sequences of instructions that are executed
when the program does branch. The sequence stops at a end branch
annotation. Then the else part finishes. 

    branched := END_BRANCH
                    | BRANCH branch_instruction not_branched branched branched
                    | LOOP loop_body loop_end branched
                    | CALL procedure_call branched
                    | PASS_THROUGH_BLOCK branched
                    | ADD add_instruction branched
                    | ADDI addi_instruction branched
                    | ADDU addu_instruction branched
                    | ADDIU addiu_instruction branched
                    | SUB sub_instruction branched
                    | SUBU subu_instruction branched
                    | MULT mult_div_instruction branched
                    | MULTU mult_div_instruction branched
                    | DIVU mult_div_instruction branched
                    | MFHI mfhi_instruction branched
                    | MFLO mflo_instruction branched
                    | LUI lui_instruction branched
                    | SRL srl_instruction branched
                    | SLL sll_instruction branched
                    | SLT slt_instruction branched
                    | SLTI slti_instruction branched
                    | SLTIU sltiu_instruction branched
                    | SLTU sltu_instruction branched
                    | LW lw_instruction branched
                    | SW sw_instruction branched
                    | LB lb_instruction branched
                    | LBU lbu_instruction branched
                    | SB sb_instruction branched
                    | AND and_instruction branched
                    | ANDI andi_instruction branched
                    | OR or_instruction branched
                    | ORI ori_instruction branched
                    | LABEL COLON branched

A loop body ends at a jump to a label. It can contain break constructs

    loop_body := J LABEL
              | BREAK break_instruction loop_body
                    | BRANCH branch_instruction not_branched branched loop_body
                    | LOOP loop_body loop_end loop_body
                    | CALL procedure_call loop_body
                    | PASS_THROUGH_BLOCK loop_body
                    | ADD add_instruction loop_body
                    | ADDI addi_instruction loop_body
                    | ADDU addu_instruction loop_body
                    | ADDIU addiu_instruction loop_body
                    | SUB sub_instruction loop_body
                    | SUBU subu_instruction loop_body
                    | MULT mult_div_instruction loop_body
                    | MULTU mult_div_instruction loop_body
                    | DIVU mult_div_instruction loop_body
                    | MFHI mfhi_instruction loop_body
                    | MFLO mflo_instruction loop_body
                    | LUI lui_instruction loop_body
                    | SRL srl_instruction loop_body
                    | SLL sll_instruction loop_body
                    | SLT slt_instruction loop_body
                    | SLTI slti_instruction loop_body
                    | SLTIU sltiu_instruction loop_body
                    | SLTU sltu_instruction loop_body
                    | LW lw_instruction loop_body
                    | SW sw_instruction loop_body
                    | LB lb_instruction loop_body
                    | LBU lbu_instruction loop_body
                    | SB sb_instruction loop_body
                    | AND and_instruction loop_body
                    | ANDI andi_instruction loop_body
                    | OR or_instruction loop_body
                    | ORI ori_instruction loop_body
                    | LABEL COLON loop_body

A break instruction is is a branch instruction that throws a Break exception in WhyML.

    break_instruction := BEQ break_instruction_operands
                       | BNE break_instruction_operands

    break_instruction_operands := GPR COMMA middle_operand COMMA LABEL
                                | ZERO COMMA middle_operand COMMA LABEL

Loop end ends a loop.

    loop_end := END_LOOP