rm ./output_dir/*
../abc -c "source ../abc.rc;read_blif ../input_dir/rfile9.blif;write_verilog ../output_dir/rfile9.v;quit"
../abc -c "source ../abc.rc;read_blif ../input_dir/rfile9_apprx.blif;write_verilog ../output_dir/rfile9_apprx.v;quit"
