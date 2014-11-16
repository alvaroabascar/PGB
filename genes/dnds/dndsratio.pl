#!/usr/bin/perl 

print "enter the name of the input file:\n -> ";
$input=<STDIN>;
open(IN,"<$input") || die "cannot open input file\n";
print "enter the name of the output file:\n -> ";
$output=<STDIN>;
open(OUT,">$output") || die "cannot open output file\n";
$line=<IN>;
while($line)   
	{
	chomp($line);
	if ($line =~ /(\d+\.\d+)\s(\d+\.\d+)/) # we have two numbers with decimals
		{
		if (($2>0)&&($2<2)&&($1<2))
			{
			$dnds=$1/$2;
			print "$line\t$dnds\n";
			$dnds=sprintf("%.5f",$dnds);
			print OUT "$line\t$dnds\n";
			}
		}
	$line=<IN>;
	}
close(IN);
close(OUT);
