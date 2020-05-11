//*  Created Date: 2020-03-02
//*  copyright (c): Raymond Rhino 
//*  Module Description:
//*    clock signal frequency division
module clk_div(
    input clk, rst, SW2,
    output Clk_CPU, clk_100mhz,
	output reg[31:0] clkdiv
);

always @ (posedge clk or posedge rst) begin
    if(rst) clkdiv<=0;
    else clkdiv<=clkdiv+1'b1;
end

assign clk_100mhz = clkdiv[0];
assign Clk_CPU = SW2? clkdiv[24]:clkdiv[1];

endmodule // clk_div