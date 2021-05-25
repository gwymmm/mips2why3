# Sample Workflow

Install Why3 (Debian 9):

	apt-get install why3

Install some provers, for example:

	apt-get install z3

Let Why3 detect the provers:

	why3 config --detect

Get the MARS MIPS simulator from courses.missouristate.edu/KenVollmar/mars

Translate assembly to WhyML:

	java -jar mips2why3.jar example.asm > example.mlw

Perform proof within an interactive Why3 session:

	why3 ide -L . example.mlw

Compare with execution in MARS:

	java -jar Mars4_5.jar 
