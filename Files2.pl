#!/usr/local/bin/perl

$netlist_filename = $ARGV[0];
$report_filename = $ARGV[1];
open(FILE_IN, $netlist_filename);
open(FILE_OUT, ">$report_filename");
while($line = <FILE_IN>) {
	$line_count++;
	print FILE_OUT "$line_count: $line";
	}
	# perl filter_netlist.pl chip_timesim.vhd report.txt
