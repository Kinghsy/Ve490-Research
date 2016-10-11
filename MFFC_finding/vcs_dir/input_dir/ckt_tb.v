module ckt_tb();
  parameter M = 11, N = 1;
  parameter snum = 1000;
  parameter H1 = M/2 , H2 = M - H1;
  reg [M-1:0] rand;
  reg [H1-1:0] rand1;
  reg [H2-2:0] rand2;
  wire [N-1:0] y_ini, y_sim;
  integer i, fp;
  ckt_org dut1(rand[10], rand[9], rand[8], rand[7], rand[6], rand[5], rand[4], rand[3], rand[2], rand[1], rand[0], y_ini[0] );
  ckt_sim dut2(rand[10], rand[9], rand[8], rand[7], rand[6], rand[5], rand[4], rand[3], rand[2], rand[1], rand[0], y_sim[0] );
  initial begin 
    fp = $fopen("comp.txt", "w");
    for(i=0; i < 2**(M); i=i+1) begin
      rand = i;
      #1 if(y_ini != y_sim)
      $fwrite(fp, "%b, y_ini = %b, y_sim = %b\n", rand, y_ini, y_sim);
    end
    $fclose(fp);
  end
endmodule
