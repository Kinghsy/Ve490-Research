#! /usr/bin/perl

#open infile, "./inputs/t.txt" or die $!;

#`rm ./outputs/output_mintermCount.txt` if (-e "./outputs/output_mintermCount.txt");
#open(outfile, ">./outputs/output_mintermCount.txt") || die "Cannot open output_mintermCount.txt$!";

my $home_dir = "/home/wangchen/Research/MFFC_finding";
my $ckt_syn_dir = "${home_dir}/apprx_circuit_blif_synthesis_dir";
my $apprx_matlab_dir = "${home_dir}/approximation_matlab";
my $cktname = "rfile9"; #c880

my $iteration_num_max = 1;
my $iter = 1;

# cleanup dirs
system("rm ${home_dir}/result__approximated_ckt_dir/*");

print "benchmark circuit name is: $cktname.blif\n";

while($iter <= $iteration_num_max){

#=================================================================================================
chdir("${home_dir}/find_candidate_MFFC_cpp/");
system("rm ./myResults/*"); # clean up
system("rm ./benchmarks/*"); 

system("cp ../benchmarks/${cktname}.blif ./benchmarks/"); 
my $input_ckt;
if($iter == 1){
	$input_ckt = "benchmarks/${cktname}.blif";
}
else{
	my $ckt_index = $iter - 1;
	$input_ckt = "${home_dir}/result__approximated_ckt_dir/${cktname}_approximated_${ckt_index}.blif";	
}
system("cp ${input_ckt} input/ckt_input.blif");
system("./main input/ckt_input.blif myResults/${cktname}_MFFC_candidate.blif 4 6 > log.txt");
system("cp myResults/${cktname}_MFFC_candidate.blif PERL_working_dir/inputs/");
system("cp input/ckt_input.blif PERL_working_dir/inputs/");
chdir("${home_dir}/find_candidate_MFFC_cpp/PERL_working_dir/perl_tool");
system("rm ../outputs/*"); # cleanup
system("perl get_restPart_of_a_ckt.pl ../inputs/ckt_input.blif ../inputs/${cktname}_MFFC_candidate.blif ../outputs/${cktname}_restParts.blif");
chdir("../../");
system("cp PERL_working_dir/outputs/${cktname}_restParts.blif myResults/");
print "finding candidate MFFC done, return back to home dir...\n";






#=================================================================================================
chdir("${home_dir}");
system("rm ${home_dir}/print_MFFC_covers/input_dir/*"); # clean up
system("cp ${home_dir}/find_candidate_MFFC_cpp/myResults/${cktname}_MFFC_candidate.blif print_MFFC_covers/input_dir");
chdir("${home_dir}/print_MFFC_covers/");
system("rm output_dir/*"); # clean up
system("./main input_dir/${cktname}_MFFC_candidate.blif > output_dir/${cktname}_MFFC_candidate_cover.txt");
print "printing MFFC covers done, return back to home dir...\n";

#=================================================================================================
chdir("${home_dir}");
system("cp ${home_dir}/print_MFFC_covers/output_dir/${cktname}_MFFC_candidate_cover.txt ${home_dir}/minterm2truthTable_perl/inputs/");
chdir("${home_dir}/minterm2truthTable_perl/");
system("perl minterms2truthTable_parser.pl inputs/${cktname}_MFFC_candidate_cover.txt outputs/f_vec.txt");
print "candidate MFFC truth table f_vec generated, return back to home dir...\n";

#=================================================================================================
chdir("${home_dir}");
system("cp ${home_dir}/minterm2truthTable_perl/outputs/f_vec.txt ${home_dir}/approximation_matlab/inputs/");
chdir("${home_dir}/approximation_matlab/");
system("matlab -nosplash -nodesktop -r main1");
#system("exit");
print "matlab approximation for candidate MFFC truth table done, return back to home dir...\n";

#=================================================================================================
chdir("${home_dir}");
system("cp ${apprx_matlab_dir}/results/apprx_circuit.blif ${ckt_syn_dir}/inputs/apprx_circuit_matlab.blif");
system("cp ${home_dir}/find_candidate_MFFC_cpp/myResults/${cktname}_restParts.blif ${ckt_syn_dir}/inputs/");
system("cp ${home_dir}/find_candidate_MFFC_cpp/myResults/${cktname}_MFFC_candidate.blif ${ckt_syn_dir}/inputs/");
chdir("${ckt_syn_dir}/perl_files/");
system("perl new_apprx_ckt_synthesizer.pl apprx_circuit_matlab.blif ${cktname}_MFFC_candidate.blif ${cktname}_MFFC_candidate_modified.blif");
system("perl reprint_helper.pl ${cktname}_MFFC_candidate_modified.blif ${cktname}_restParts.blif buf1.txt buf2.txt ${cktname}_approximated.blif");

chdir("${ckt_syn_dir}");
system("cp outputs/${cktname}_approximated.blif ${home_dir}/result__approximated_ckt_dir/${cktname}_approximated_${iter}.blif");
chdir("${home_dir}");

$iter++;
}


print "finished!";

=pod
=cut




