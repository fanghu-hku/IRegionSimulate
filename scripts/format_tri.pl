#!/usr/bin/perl -w 
use strict;
my ($in,$out)=@ARGV;
open IN,$in;
open OUT,">$out";
while(<IN>){
	chomp;
	my @field=split/\s+/,$_;
	my $chr=(split/:/,$field[0])[0];
	my $end=((split/\-/,$field[0])[1])-1;
	my $sta=$end-1;
	$field[1]=~tr/tgca/TGCA/;
	my @tri=split//,$field[1];
	if($tri[1] eq "A" || $tri[1] eq "G"){
		my $rev=reverse($field[1]);
		$rev=~tr/ACGT/TGCA/;
		print OUT "$chr\t$sta\t$end\t$rev\n";
	}else{
		print OUT "$chr\t$sta\t$end\t$field[1]\n";
	}
}
close IN;
close OUT; 
