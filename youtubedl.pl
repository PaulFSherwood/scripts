#!/usr/bin/perl

use strict;
use warnings;

my $filename = "Sub Terrania OST - ending.avi";
my $url = "http://www.youtube.com/watch?v=";
my $url2 = "rgXQjbGsWF4";

`youtube-dl -o $filename $url$url2`
