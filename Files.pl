#!/usr/local/bin/perl

open(FILE1, '>text.txt' );
#	> meanse open in write mode
print FILE1 "The first line to text.txt\n";
print FILE1 "The final line to text.txt\n";

close( FILE1 );	# dont have to explicitly cose a file

print STDOUT "This goes to the standard output\n";
print		"So does this\n";
#		^^^^^	STDOUT is a file handle that always
#				refers to the standard output
#				It is the default so doesn't have to be stated.

open(FILE1, 'text.txt' );	# Open in read mode - the default mode
$first_line = <FILE1>;		# Reads the first line from text.txt into $first_line.
							# Includes the newline character, \n.

while($line = <FILE1>) {
	print $line;			# Read and print remaining lines from text.txt.
}							# When every line has been read <FILE1> returns undef.

$standard_input = <STDN>;	# Read a line from the standard input.
							# Can be the keyboard if run from the command line.

chomp($standard_input);		# Remove the trailing newline character
