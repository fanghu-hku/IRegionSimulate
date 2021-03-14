#!/usr/bin/perl -w 
use strict;
my ($in,$out)=@ARGV;
open IN,$in;
my %hash;
while(<IN>){
	chomp;
	my @field=split;
	$hash{$field[3]}++;
}
close IN;
open OUT,">$out";
open IN,"/home/fanghu/Database/HG19_UCSC/penta_nucleotide/k3_c/tri_context";
while(<IN>){
        chomp;
        if(exists $hash{$_}){
		print OUT "$_\t$hash{$_}\n";
	}else{
		print OUT "$_\t0\n";
	}
}
close OUT;
close IN;
