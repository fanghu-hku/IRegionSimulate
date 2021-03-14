#!/usr/bin/perl -w 
use strict;
my ($in,$out)=@ARGV;
open IN,$in;
my %hash;
while(<IN>){
	chomp;
	my @field=split;
	if(($field[3] eq "C" && $field[4] eq "A")||($field[3] eq "G" && $field[4] eq "T")){
		my $tmp=$field[6]."-CA";
		$hash{$tmp}++;
	}elsif(($field[3] eq "C" && $field[4] eq "G")||($field[3] eq "G" && $field[4] eq "C")){
		my $tmp=$field[6]."-CG";
                $hash{$tmp}++;
	}elsif(($field[3] eq "C" && $field[4] eq "T")||($field[3] eq "G" && $field[4] eq "A")){
                my $tmp=$field[6]."-CT";
                $hash{$tmp}++;
        }elsif(($field[3] eq "T" && $field[4] eq "A")||($field[3] eq "A" && $field[4] eq "T")){
                my $tmp=$field[6]."-TA";
                $hash{$tmp}++;
        }elsif(($field[3] eq "T" && $field[4] eq "C")||($field[3] eq "A" && $field[4] eq "G")){
                my $tmp=$field[6]."-TC";
                $hash{$tmp}++;
        }elsif(($field[3] eq "T" && $field[4] eq "G")||($field[3] eq "A" && $field[4] eq "C")){
                my $tmp=$field[6]."-TG";
                $hash{$tmp}++;
        }
}
close IN;
open OUT,">$out";
foreach my $i (keys %hash){
	print OUT "$i\t$hash{$i}\n";
}
close OUT;
close IN;
