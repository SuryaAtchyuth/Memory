    
parameter reg [15:0] ADDR_WIDTH=8;
parameter reg [15:0] DATA_WIDTH=16;
parameter reg [15:0] MEM_SIZE=16;
  
reg clk, reset;
reg wr, rd;
reg [ADDR_WIDTH-1:0] addr;
reg [DATA_WIDTH-1:0] wdata;
wire [DATA_WIDTH-1:0] rdata;
wire response;


interface inf(input clk);
reg reset;
reg wr, rd;
reg [ADDR_WIDTH-1:0] addr;
reg [DATA_WIDTH-1:0] wdata;
reg [DATA_WIDTH-1:0] rdata;
reg response;
  
endinterface
