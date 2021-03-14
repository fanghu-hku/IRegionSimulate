echo =====Start at `date` =====
bed_file=$1
mut_bed=$2
simul_num=$3

#step1: Calculate trinucleotide composition for customize region.
bedtools makewindows -b $bed_file -w 1 > region_bed_w1.bed &&\
slopBed -i region_bed_w1.bed  -g hg19.chrom.sizes -b 1| fastaFromBed -fi WholeGenomeFasta.fa -bed - -tab >region_trinucleo.bed &&\
perl format_tri.pl region_trinucleo.bed region_bed_w1_tri.bed &&\
rm region_bed_w1.bed  region_trinucleo.bed &&\

#step2: Generate simulation shell script for each sample.
wd=`pwd`
mkdir "$wd/result"
for i in `cat $mut_bed`
do
fullname=$(basename $i)
sap=$(echo $fullname | cut -d . -f1)
slopBed -i $i -g hg19.chrom.sizes -b 1| fastaFromBed -fi WholeGenomeFasta.fa -bed - -tab >$sap.trinucleo.bed && \
perl format_tri.pl  $sap.trinucleo.bed $sap.w1_tri.bed &&\
perl get_trinucl_count.pl $sap.w1_tri.bed $sap.w1_tri_count.txt &&\
cut -f 4 $sap.w1_tri.bed |paste $i - > $sap.tss_mut_tri.bed &&\
perl get_trinucl_count_mut.pl $sap.tss_mut_tri.bed  $sap.w1_tri_count_mut.txt &&\
rm $sap.trinucleo.bed $sap.w1_tri.bed $sap.tss_mut_tri.bed &&\
perl get_Rscript.pl "$wd/result" $sap $simul_num 
done
echo =====Finish at `date` =====
