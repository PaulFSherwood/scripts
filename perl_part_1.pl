#!/usr/bin/perl
$a = "good";
$b = " day";
$c = "\n";
$total = $a.$b.$c;	# concatenate the string

print '$total: ';
print "$total";

$a = "bat";
$b = $a + 1;
print $a." and ".$b. "\n";

# repeat with x3 , x2
$a = $b x3;
print "Ba"."na"x2;
print "\n";

# arrays using space as seperator
@color = qw(red green blue);
print '@color: ';
print "@color"."\n";

#adding an array to another array
@colors = ("@color", "one two", "three");

# printing arrays
print '@colors: ';
print "@colors\n";

# array size
$size = scalar @colors;
print "$size\n";
$size = @colors;
print "$size\n";

@color = qw(red, blue, green, black);
print "@color\n";

# remove ending element
$first = pop @color;
# print removed element
print "$first\n";
# print new array
print "@color\n";

# add ending element
push(@color, "white");
print "@color\n";

print "$#color\n";

# remove first element
$first = shift @color;
print "@color\n";

# add first element
unshift(@color, "black");
print "@color\n";

# reverse array names
@rev = reverse @color;
print "@rev\n";
print "==========\n";
print "@color\n";

# return to original
@color = reverse @color;
print "@color\n";

# sort
@files = qw(10 2 5 22 7 15 103 250);
print "1st: @files\n";
# lexicographic
@articles = sort @files;
print "2nd: @articles\n";
# numeric sort
@third = sort {$a <=> $b} @files;
print "3rd: @third\n";
# element lenght sort
@forth = sort {length $b <=> length $a} @files;
print "4th: @forth\n";

# User Input
print "Enter Your name: ";
chop ($name = <STDIN>);	# Read from keyboard
# chomp ($name = <STDIN>); # would remove last character only if it is a \n
print "Good morning, $name.\n";

# Opening a file
$fname = "text.txt";
open XYZ, $fname;
while (<XYZ>) {
	print "Line number $. is : $_";
	}
