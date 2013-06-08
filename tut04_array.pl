#!/usr/bin/perl
$some = 1;
$some = 3;

@number = (1,2,3,4,5);

print "@number\n";

print "$number[0]\n";

@wordlist = ("one", "two", "three", "four", "five");

print "@wordlist\n";

print "$wordlist[0]\n";

$wordlist[5] = "six";

print "@wordlist\n";

$total = $#wordlist + 1;

print "$total\n";

$#wordlist = 4;

print "@wordlist\n";

exit
