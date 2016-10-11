#! /usr/bin/perl

open infile1, "../intermediate_files/$ARGV[0]" or die $!; # matlab apprx sub circuit
open infile2, "../inputs/$ARGV[1]" or die $!; # rest part of the circuit

`rm "../intermediate_files/$ARGV[2]"` if (-e "../intermediate_files/$ARGV[2]");
open(outfile1, ">../intermediate_files/$ARGV[2]") || die "Cannot open $ARGV[2]$!";
`rm "../intermediate_files/$ARGV[3]"` if (-e "../intermediate_files/$ARGV[3]");
open(outfile2, ">../intermediate_files/$ARGV[3]") || die "Cannot open $ARGV[3]$!";




while(<infile1>){
	chomp;
	if(/model|inputs|outputs|end/){next;}
	print outfile1 "$_\n";
}
print outfile1 ".end\n";

while(<infile2>){
	chomp;
	if(/end/){next;}
	print outfile2 "$_\n";
}


close infile1,infile2,outfile1,outfile2;

system("rm ../outputs/*");
system("cat ../intermediate_files/$ARGV[3] ../intermediate_files/$ARGV[2] > ../outputs/$ARGV[4]");




