`include "inf.sv"
`include "pgm_tb.sv"

module test; //Automated self test
  
bit clk;

  always #5 clk=~clk;
  
  inf vif(clk);
  
  memory CUT(.clk(vif.clk), 
             .reset(vif.reset),
             .wr(vif.wr), 
             .rd(vif.rd), 
             .addr(vif.addr), 
             .wdata(vif.wdata), 
             .rdata(vif.rdata), 
             .response(vif.response));
  
  pgm_tb Stm1(vif); 
  
endmodule

  
