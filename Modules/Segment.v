module Segment(input flash, SW0,
               input [31:0] data,
               input [7:0] le, point,
               input [2:0] scan,
               output reg [7:0] seg, an);

    wire [6:0] segments[15:0];
    assign segments[0]  = 7'b100_0000;
    assign segments[1]  = 7'b111_1001;
    assign segments[2]  = 7'b010_0100;
    assign segments[3]  = 7'b011_0000;
    assign segments[4]  = 7'b001_1001;
    assign segments[5]  = 7'b001_0010;
    assign segments[6]  = 7'b000_0010;
    assign segments[7]  = 7'b111_1000;
    assign segments[8]  = 7'b000_0000;
    assign segments[9]  = 7'b001_1000;
    assign segments[10] = 7'b000_1000;
    assign segments[11] = 7'b000_0011;
    assign segments[12] = 7'b100_0110;
    assign segments[13] = 7'b010_0001;
    assign segments[14] = 7'b000_0110;
    assign segments[15] = 7'b000_1110;
    
    reg [7:0] img;

    always @*  begin
        case (scan)
            3'b111: begin
                img = {data[30],data[15],data[11],data[23],data[31],data[22],data[10],data[3]};
                seg <= SW0? img: {~point[7], segments[data[31:28]]};
                an  <= le[7] | flash ? 8'b0111_1111 : 8'hff;
            end
            3'b110: begin
                img = {data[28],data[14],data[9],data[21],data[29],data[20],data[8],data[2]};
                seg <= SW0? img: {~point[6], segments[data[27:24]]};
                an  <= le[6] | flash ? 8'b1011_1111 : 8'hff;
            end
            3'b101: begin
                img = {data[26],data[13],data[7],data[19],data[27],data[18],data[6],data[1]};
                seg <= SW0? img: {~point[5], segments[data[23:20]]};
                an  <= le[5] | flash ? 8'b1101_1111 : 8'hff;
            end
            3'b100: begin
                img = {data[24],data[12],data[5],data[17],data[25],data[16],data[4],data[0]};
                seg <= SW0? img: {~point[4], segments[data[19:16]]};
                an  <= le[4] | flash ? 8'b1110_1111 : 8'hff;
            end
            3'b011: begin
                img = {data[30],data[15],data[11],data[23],data[31],data[22],data[10],data[3]};                
                seg <= SW0? img: {~point[3], segments[data[15:12]]};
                an  <= le[3] | flash ? 8'b1111_0111 : 8'hff;
            end
            3'b010: begin
                img = {data[28],data[14],data[9],data[21],data[29],data[20],data[8],data[2]};                
                seg <= SW0? img: {~point[2], segments[data[11:8]]};
                an  <= le[2] | flash ? 8'b1111_1011 : 8'hff;
            end
            3'b001: begin
                img = {data[26],data[13],data[7],data[19],data[27],data[18],data[6],data[1]};                
                seg <= SW0? img: {~point[1], segments[data[7:4]]};
                an  <= le[1] | flash ? 8'b1111_1101 : 8'hff;
            end
            3'b000: begin
                img = {data[24],data[12],data[5],data[17],data[25],data[16],data[4],data[0]};                
                seg <= SW0? img: {~point[0], segments[data[3:0]]};
                an  <= le[0] | flash ? 8'b1111_1110 : 8'hff;
            end
        endcase
    end
    
endmodule // Segment