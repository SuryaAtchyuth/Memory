vlib work
vlog test.sv +acc
vlog memory.sv +acc
vsim work.test
add wave -r *
add wave sim:/test/DUT/mem* 
run -all