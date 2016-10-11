#! /usr/bin/perl

open infile, "t.txt" or die $!;

`rm result.txt` if (-e "result.txt");
open(outfile, ">result.txt") || die "Cannot open result.txt$!";

while(<infile>){
	chomp;
	my $minterm;
	if(/^([\d|\-]+)\s+1/){
		#print "$_\n";
		$minterm = $1;
	}
	print "minterm = $minterm\n";
	my @array1 = split(//,$minterm);
	#print "@array1\n";
	&subroutine(@array1);
}






close infile, outfile;


# read in an array, and change the first '-' to 0 and 1 and forms two new arrays
sub subroutine{
	my @array = @_;
	my $len = @array;
	my $one = 1;
	my $zero = 0;

	my $dash_exist_flag = &isDashExists(@array);
	if($dash_exist_flag eq 0){
		print "@array\n";
	}
	else{

		#print "length of array = $len\n";
		for(my $i=0;$i<$len;$i++){
			if($array[$i] =~ /-/){
				my @new_array1 = @array;
				$new_array1[$i] = $zero;
				my @new_array2 = @array;
				$new_array2[$i] = $one;
				&subroutine(@new_array1);
				&subroutine(@new_array2);
						
				last;
			}
		}
	}
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
