#!/usr/bin/perl -w
use strict;
my ($wd,$sap,$num)=@ARGV;
open SH,">$sap.sh.list" || die;
foreach (1..$num){
        my $name=$_;
	`mkdir -p $wd/$sap`;
        `mkdir -p $wd/$sap/script`;
	open OUT,">$wd/$sap/script/$name.sh";
        my $content="Rscript /home/fanghu/Projects/promoter/simulate/scipts/simulate.R $wd/$sap $sap $name";
        print OUT "$content\n";
	print SH "$wd/$sap/script/$name.sh\n";
}
close SH;

