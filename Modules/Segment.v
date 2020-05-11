module Segment(input flash,
               input [31:0] data,
               input [7:0] les, point,
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
    
    always @*  begin
        case (scan)
            3'b000: begin
                seg <= {~point[7], segments[data[31:28]]};
                an  <= les[7] ? 8'b0111_1111 : 8'hff;
            end
            3'b001: begin
                seg <= {~point[6], segments[data[27:24]]};
                an  <= les[6] ? 8'b1011_1111 : 8'hff;
            end
            3'b010: begin
                seg <= {~point[5], segments[data[23:20]]};
                an  <= les[5] ? 8'b1101_1111 : 8'hff;
            end
            3'b011: begin
                seg <= {~point[4], segments[data[19:16]]};
                an  <= les[4] ? 8'b1110_1111 : 8'hff;
            end
            3'b100: begin
                seg <= {~point[3], segments[data[15:12]]};
                an  <= les[3] ? 8'b1111_0111 : 8'hff;
            end
            3'b101: begin
                seg <= {~point[2], segments[data[11:8]]};
                an  <= les[2] ? 8'b1111_1011 : 8'hff;
            end
            3'b110: begin
                seg <= {~point[1], segments[data[7:4]]};
                an  <= les[1] ? 8'b1111_1101 : 8'hff;
            end
            3'b111: begin
                seg <= {~point[0], segments[data[3:0]]};
                an  <= les[0] ? 8'b1111_1110 : 8'hff;
            end
        endcase
    end
    
endmodule // Segment
