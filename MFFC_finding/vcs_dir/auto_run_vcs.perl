#! /usr/bin/perl

system("rm ./output_dir/*");

# verilog files are generated by calling ABC
#system("vcs +v2k  ./verilog_files/ckt_org.v ./verilog_files/ckt_sim.v ./verilog_files/ckt_tb.v");
system("vcs +v2k ./input_dir/ckt_org.v ./input_dir/ckt_sim.v ./input_dir/ckt_tb.v");
system("./simv");

# a file named "comp.txt" is generated, and read out its content
#system("touch ./comp.txt");
open infile, "./comp.txt" or die $!;
my $num_diff = 0;
# number of lines in this file is the count of difference
while(<infile>){
	$num_diff++;
}
	

print "$num_diff\n";
# the error rate is $num_diff/$total_test_number




close infile;
