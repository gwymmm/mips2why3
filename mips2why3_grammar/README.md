# Grammar for mips2why3

## Generate the parser from the grammar

[Install javacc:]

	apt-get install javacc

Generate java source files:

	javacc annotated_mips.jj

Compile:

	javac *.java

Make jar archive:

	jar cfe mips2why3.jar MipsParser *.class


