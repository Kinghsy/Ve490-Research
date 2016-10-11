#! /usr/bin/perl

my $num_input = $ARGV[0];
my $num_output = $ARGV[1];
my $sample_number = $ARGV[2];

my $numPI_init = $num_input;
my $numPO_init = $num_output;

`rm ./verilog_files/ckt_tb.v` if (-e "./verilog_files/ckt_tb.v");
open(outfile, ">./verilog_files/ckt_tb.v") || die "Cannot open ckt_tb.v$!";

print outfile "module ckt_tb();\n";
print outfile "  parameter M = ${num_input}, N = ${num_output};\n";
print outfile "  parameter snum = ${sample_number};\n";
print outfile "  parameter H1 = M/2 , H2 = M - H1;\n";
print outfile "  reg [M-1:0] rand;\n";
print outfile "  reg [H1-1:0] rand1;\n";
print outfile "  reg [H2-2:0] rand2;\n";
print outfile "  wire [N-1:0] y_ini, y_sim;\n";
print outfile "  integer i, fp;\n";

###########################################################

print outfile "  ckt_org dut1(";
for(my $i = $numPI_init - 1; $i >= 0; $i--){
        print outfile "rand\[$i\], ";
}
for(my $j = $numPO_init - 1; $j >= 0; $j--)
{
    if($j eq 0){
        print outfile "y_ini\[$j\] ";
    }
    else{
        print outfile "y_ini\[$j\], ";
    }
}
print outfile ");\n";

###########################################################

print outfile "  ckt_sim dut2(";
for(my $i = $numPI_init - 1; $i >= 0; $i--){
        print outfile "rand\[$i\], ";
}
for(my $j = $numPO_init - 1; $j >= 0; $j--)
{
    if($j eq 0){
        print outfile "y_sim\[$j\] ";
    }
    else{
        print outfile "y_sim\[$j\], ";
    }
}
print outfile ");\n";

###########################################################

print outfile "  initial begin \n";
print outfile "    fp = \$fopen(\"comp.txt\", \"w\");\n";

if($num_input <= 20)
{
    print outfile "    for(i=0; i < 2**(M); i=i+1) begin\n";
    print outfile "      rand = i;\n";
}
else
{
    print outfile "    for(i=0; i < 2**snum; i=i+1) begin\n";
    print outfile "       rand1 = {$random};\n";
    print outfile "       rand2 = {$random};\n";
    print outfile "       rand = {rand1, rand2};\n";
}   

print outfile "      \#1 if(y_ini != y_sim)\n";
print outfile "      \$fwrite(fp, \"%b, y_ini = %b, y_sim = %b\\n\", rand, y_ini, y_sim);\n";
print outfile "    end\n";
print outfile "    \$fclose(fp);\n";

print outfile "  end\n";
print outfile "endmodule\n";

close outfile;

















