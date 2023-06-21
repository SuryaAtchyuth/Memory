
module memory(clk, reset, wr, rd, addr, wdata, rdata, response);

parameter reg [15:0] ADDR_WIDTH=8;
  parameter reg [15:0] DATA_WIDTH=16;
parameter reg [15:0] MEM_SIZE=16;

input clk, reset;
input wr, rd;
input [ADDR_WIDTH-1:0] addr;
input [DATA_WIDTH-1:0] wdata;
output [DATA_WIDTH-1:0] rdata;
output reg response;

  wire [DATA_WIDTH-1:0] rdata;
  reg  [DATA_WIDTH-1:0] mem [MEM_SIZE];
  reg  [DATA_WIDTH-1:0] data_out;
// reg response

reg out_enable;

assign rdata=out_enable? data_out : 'bZ;

// async reset & sync write.

always@(posedge clk or posedge reset) begin
	if(reset) begin
		for(int i=0; i<MEM_SIZE ; i++)
          mem[i]<= 'b0;
	end
    else if(wr) begin
      mem[addr]<=wdata;
		response<=1'b1;
	end
	else response<=1'b0;
end

// sync read.

always @(posedge clk) begin
	if(reset) begin
		data_out<='b0;
		out_enable<=1'b0;
	end
  else if (rd) begin
		data_out<=mem[addr];
		out_enable<=1'b1;
    end  
    else 
		out_enable<=1'b0;
end

endmodule		

