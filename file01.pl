#!/usr/bin/perl

# Open File
open(FILE, "text.txt") or die("Unable to open file");

# Read file into an array
@data = <FILE>;

my $linenumber = 1;

# print file contentx
foreach $line (@data)
{
	if ($line =~ m/\/\//g)
	{
		print $linenumber;
		print ": ";
		print $line;
	}
	$linenumber = $linenumber + 1;
}

# Close file
close(FILE);
