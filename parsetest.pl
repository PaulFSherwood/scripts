#!/usr/bin/perl

open (FILE, 'data');
while (<FILE>){
chomp;
($name, $email, $phone) = split("\t");
print "Name: $name\n";
print "Email: $email\n";
print "Phone: $phone\n";

print "-------\n";
} 
close (FILE);
exit

