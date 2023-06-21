program pgm_tb(inf wir);
   
reg [DATA_WIDTH-1:0] w_d[$], r_d[$]; 
 
initial begin
  $dumpfile("tb.vcd"); $dumpvars(0,test.UT);
  wir.reset=0;
  wir.wr=0; wir.rd=0;
  wir.addr=0;
  wir.wdata=0;
  #1 wir.reset=1;
  #1 wir.reset=0;
end
  
initial begin
  repeat(2) @(posedge wir.clk); //wait
  
  wir.wr<=1; //write gen
  for(int i=0;i<MEM_SIZE;i++) begin
  	wir.addr<=i;
  	wir.wdata<=$random;
    @(posedge wir.clk);
    w_d.push_back(wir.wdata);
    @(negedge wir.clk);
  end  
  	wr<=0;
  
  repeat(2) @(posedge wir.clk); //wait
  
  wir.rd<=1; //read gen
  for(int i=0;i<MEM_SIZE;i++) begin
 	 wir.addr<=i;
    @(posedge wir.clk);
    @(negedge wir.clk);
     r_d.push_back(wir.rdata);
  end  
  wir.rd<=0;
  
  @(posedge wir.clk);
  $finish;
end

final begin
  
  if(w_d==r_d) $display("\n-----Success-----\n");
  else $display("\n-----Failure-----\n","\n\t",w_d,"\n\t",r_d);
end
 
  
endprogram
