module test; //Automated self test
  
parameter reg [15:0] ADDR_WIDTH=8;
parameter reg [15:0] DATA_WIDTH=16;
parameter reg [15:0] MEM_SIZE=16;
  
reg clk, reset;
reg wr, rd;
reg [ADDR_WIDTH-1:0] addr;
reg [DATA_WIDTH-1:0] wdata;
wire [DATA_WIDTH-1:0] rdata;
wire response;
  
  reg [DATA_WIDTH-1:0] w_d[$], r_d[$]; 
  
  memory DUT(clk, reset, wr, rd, addr, wdata, rdata, response);
  
always #5 clk=~clk;

initial begin
  //$dumpfile("tb.vcd"); $dumpvars(0,test.DUT);
  clk=0;
  reset=0;
  wr=0; rd=0;
  addr=0;
  wdata=0;
  #1 reset=1;
  #1 reset=0;
end
  
initial begin
  repeat(2) @(posedge clk); //wait
  
  wr<=1; //write gen
  for(int i=0;i<MEM_SIZE;i++) begin
  	addr<=i;
  	wdata<=$random;
    @(posedge clk);
    w_d.push_back(wdata);
    @(negedge clk);
  end  
  	wr<=0;
  
  repeat(2) @(posedge clk); //wait
  
  rd<=1; //read gen
  for(int i=0;i<MEM_SIZE;i++) begin
 	 addr<=i;
 	 @(posedge clk);
     @(negedge clk);
     r_d.push_back(rdata);
  end  
  rd<=0;
  
  @(posedge clk);
  $finish;
end

final begin
  $display("\n\t",w_d,"\n\t",r_d); 
  
  if(w_d==r_d) $display("\n-----Success-----\n");
  else $display("\n-----Failure-----\n");
end
 
  
endmodule

  