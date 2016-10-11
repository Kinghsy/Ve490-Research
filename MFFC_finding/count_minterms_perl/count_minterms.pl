#! /usr/bin/perl

open infile, "./inputs/t.txt" or die $!;

`rm ./outputs/output_mintermCount.txt` if (-e "./outputs/output_mintermCount.txt");
open(outfile, ">./outputs/output_mintermCount.txt") || die "Cannot open output_mintermCount.txt$!";
my $minterm;
my @results = ();
my @array1 = ();
while(<infile>){
	chomp;
	
	if(/^([\d|\-]+)\s+1/){
		#print "$_\n";
		$minterm = $1;
	}
	#print "minterm = $minterm\n";
	@array1 = split(//,$minterm);
	#print "@array1\n";	
	@results = &subroutine(@array1,@results);
	#print "results = \n";
	#print "@results\n";	
}
my $input_bit_count = @array1;
my $total_minterm_number = 2**$input_bit_count; # 2**3==8
print "total possible minterm count = ${total_minterm_number}\n";
print outfile "total possible minterm count = ${total_minterm_number}\n";

my $minterm_count = @results;
print "minterm count = ${minterm_count}\n";
print outfile "minterm count = ${minterm_count}\n";

my $error_rate = $minterm_count/$total_minterm_number;
print "error rate = ${error_rate}\n";
print outfile "error rate = ${error_rate}\n";


close infile, outfile;


# read in an array, and change the first '-' to 0 and 1 and forms two new arrays
sub subroutine{
	my (@array,@final_results) = @_;
	my $len = @array;
	my $one = 1;
	my $zero = 0;

	my $dash_exist_flag = &isDashExists(@array);
	if($dash_exist_flag eq 0){
		my $joined_array = join('',@array);
		#print "@array\n";
		#print "$joined_array\n";
		@final_results = (@final_results,$joined_array);
		#print "updated results = @final_results\n";
	}
	else{

		#print "length of array = $len\n";
		for(my $i=0;$i<$len;$i++){
			if($array[$i] =~ /-/){
				my @new_array1 = @array;
				$new_array1[$i] = $zero;
				my @new_array2 = @array;
				$new_array2[$i] = $one;
				my @final_results1 = &subroutine(@new_array1, @final_results);
				my @final_results2 = &subroutine(@new_array2, @final_results);
				@final_results = (@final_results,@final_results1,@final_results2);
				#print "here = @final_results\n";	
				last;
			}
		}
	}
	return(@final_results);
}

sub isDashExists{
	my $flag = 0;
	my @array2 = @_;
	my $len = @array2;
	for(my $i=0;$i<$len;$i++){
		if($array2[$i] =~ /-/){
			$flag = 1;			
			last;
		}
	}
	return($flag);
}

#&subroutine(1,2);
#sub subroutine{
#	my ($a,$b) = @_;
#	print "hello, I am subroutine, a = ${a}, b = ${b}\n";
#}