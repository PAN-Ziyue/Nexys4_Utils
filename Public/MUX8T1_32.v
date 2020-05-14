//*  Created Date: 2020-03-02
//*  copyright (c): Raymond Rhino 
//*  Module Description:
//*    32-bit 8T1 Multiplex
module MUX8T1_32(
	input [2:0] s,
	input [31:0] I0, I1, I2, I3, I4, I5, I6, I7,
	output reg [31:0] o
    );
	
always@(*) begin
	case(s)
		3'b000:o=I0;
		3'b001:o=I1;
		3'b010:o=I2;
		3'b011:o=I3;
		3'b100:o=I4;
		3'b101:o=I5;
		3'b110:o=I6;
		3'b111:o=I7;
	endcase
end
endmodule // MUX

