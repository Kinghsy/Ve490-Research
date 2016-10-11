#! /usr/bin/perl

open infile0, "../inputs/$ARGV[0]" or die $!;
open infile1, "../inputs/$ARGV[0]" or die $!;
open infile2, "../inputs/$ARGV[1]" or die $!;
open infile3, "../inputs/$ARGV[1]" or die $!; # same as infile2

`rm "../intermediate_files/$ARGV[2]"` if (-e "../intermediate_files/$ARGV[2]");
open(outfile, ">../intermediate_files/$ARGV[2]") || die "Cannot open $ARGV[2]$!";


#open infile1, "../inputs/apprx_circuit_matlab.blif" or die $!;
#open infile2, "../inputs/c880_MFFC_candidate.blif" or die $!;

#`rm "../outputs/result.blif"` if (-e "../outputs/result.blif");
#open(outfile, ">../outputs/result.blif") || die "Cannot open result.blif$!";


# find unique node names of "c880_MFFC_candidate.blif", and put them in an array
# 1. get all the node names behind .names into an array, and unify the array elements
# 2. delete the input and output node names from the array


my $output_name;
my @input_array = ();
my @io_array = ();
my $header = ".model bigNode\n";
my $tail = ".end\n";
my @internal_node_array_candidate = ();

while(<infile2>){
	chomp;
	if(/^\.inputs\s+(\S.*)/){
		@input_array = split(/\s/,$1);
		$count = @input_array;
		$header = "$header$_\n";
	}
	elsif(/^\.outputs\s+(\S+)/){
		$output_name = $1;
		$header = "$header$_\n";
	}
	if(/\.names/){
		my @line = split(/\s/,$_);
		my $len1 = @line;
		for(my $i=1;$i<$len1;$i++){
			push @internal_node_array_candidate, $line[$i];
		}
	}
}

push @io_array, @input_array;
push @io_array, $output_name;
#print "io_array = @io_array\n";

my @unique_internal_node_array_candidate = &get_array_with_unique_elements(@internal_node_array_candidate);
my @unique_internal_node_array_candidate_without_io = &get_elements_in_array1_not_in_array2(\@unique_internal_node_array_candidate,\@io_array);

#print "internal_node_array_candidate = @internal_node_array_candidate\n";
#print "unique_internal_node_array_candidate = @unique_internal_node_array_candidate\n";
#print "unique_internal_node_array_candidate_without_io = @unique_internal_node_array_candidate_without_io\n";
print outfile $header;

#print "@input_array\n";

my @inner_node_names_apprx = ();

while(<infile0>){
	chomp;
	#$_ =~ s/\_/00/g;
	
	#print outfile "$_\n";

	if(/f_/){
		my @line = split(/\s/,$_);
		my $len2 = @line;
		for(my $i=0;$i<$len2;$i++){
			my $str = $line[$i];
			if($str =~ /f_/){
				push @inner_node_names_apprx, $str;
			}
		}
	}
}

my @unique_inner_node_names_apprx = &get_array_with_unique_elements(@inner_node_names_apprx);
#print "inner_node_names_apprx = @inner_node_names_apprx\n";
#print "unique_inner_node_names_apprx = @unique_inner_node_names_apprx\n";

# build the inner node hash table
my %hash_internal_node_names={};
my $len3 = @unique_inner_node_names_apprx;
for(my $i=0; $i<$len3; $i++){
	my $inner_node_apprx = $unique_inner_node_names_apprx[$i];
	my $inner_node_candidate = $unique_internal_node_array_candidate_without_io[$i];
	$hash_internal_node_names{$inner_node_apprx} = $inner_node_candidate;
}





while(<infile1>){
	chomp;
	#$_ =~ s/\_/00/g;

	if(/\sf$/){
		#print "$_\n";
		$_ =~ s/f$/${output_name}/g;
	}
	#print "$_\n";
	#if(/f\s/){
	#	$_ =~ s/f\s/${output_name}/g;
	#}

	if(/x\d+\s/){
		#print "$_\n";
		my @input_array2 = split(/\s/,$_);
		#print "@input_array2\n";
		my $len = @input_array2;
		for(my $i=0;$i<$len;$i++){
			my $str = $input_array2[$i];
			#print "$str\n";
			if($str =~ /x(\d+)/){
				my $index = $1;
				#print "$index\n";
				my $input_exp = $input_array[$index-1];
				#print "$input_exp\n";
				$input_array2[$i] = $input_exp;
			}
			if($str =~ /f_/){
				my $name_exp = $hash_internal_node_names{$str};	
				#print "name_exp = $name_exp\n";			
				$input_array2[$i] = $name_exp;
			}
		}
		my @joined_input_array2 = join(' ',@input_array2);
		#print outfile "@joined_input_array2\n"
		$_ = ".names @joined_input_array2";
	}
	print outfile "$_\n";
}




print outfile $tail;

close infile0, infile1, infile2, infile3, outfile;


#my @array = (1,1,2,1,3,2,4,5);
#my @unique_arr = &get_array_with_unique_elements(@array);
#print "my unique_array = @unique_arr\n";

sub get_array_with_unique_elements{
	my @array = @_;
	my $count;
	my @unique_array = grep{++$count{$_}<2} @array;
	return(@unique_array);
}


#my @arr1 = (1,2,3,3,2,1,0,4,5);
#my @arr2 = (2,3,0);
#my @result_arr = &get_elements_in_array1_not_in_array2(\@arr1,\@arr2);
#print "result_arr = @result_arr\n";

sub get_elements_in_array1_not_in_array2(\@\@){
	my ($ref1, $ref2) = @_;
	my @array1 = @{$ref1};
	my @array2 = @{$ref2};
	#print "array1 = @array1\n";
	#print "array2 = @array2\n";
	my @new_array = ();
	foreach $array1(@array1){
		my $i = 0;
		foreach (@array2){
			if($_ eq $array1){$i=1;}
		}
		unless($i==1){@new_array = (@new_array, $array1);}	
	}
	return(@new_array);
}





