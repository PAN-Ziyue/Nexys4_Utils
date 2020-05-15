module Enter(
    input [4:0] BTN_OK,
    input clk,
    input [3:0] ctrl,
    output reg [31:0] Ai = 32'h87654321, 
    output reg [31:0] Bi = 32'h12345678,
    output reg [7:0] blink
);

    reg [2:0] blink_bit = 3'b111;
    always @(*) begin
        if(ctrl[0])
            case (blink_bit)
                3'b000: blink <= 8'b00000001;
                3'b001: blink <= 8'b00000010;
                3'b010: blink <= 8'b00000100;
                3'b011: blink <= 8'b00001000;
                3'b100: blink <= 8'b00010000;
                3'b101: blink <= 8'b00100000;
                3'b110: blink <= 8'b01000000;
                3'b111: blink <= 8'b10000000;
            endcase
        else
            blink <= 8'b00000000;
    end

    always @(posedge clk) begin
        if(ctrl[0]) begin
            if(BTN_OK[4])
                blink_bit <= blink_bit + 1;
             
            else if(BTN_OK[2])
                blink_bit <= blink_bit - 1;
                
            else if(BTN_OK[3]) begin
                case (blink_bit)
                    3'b000:begin
                        if (ctrl[3:1]==3'b000) Ai[3:0] <= Ai[3:0] + 1;
                        else if(ctrl[3:1]==3'b001) Bi[3:0] <= Bi[3:0] + 1;
                    end
                    3'b001:begin
                        if (ctrl[3:1]==3'b000) Ai[7:4] <= Ai[7:4] + 1;
                        else if(ctrl[3:1]==3'b001) Bi[7:4] <= Bi[7:4] + 1;
                    end
                    3'b010:begin
                        if (ctrl[3:1]==3'b000) Ai[11:8] <= Ai[11:8] + 1;
                        else if(ctrl[3:1]==3'b001) Bi[11:8] <= Bi[11:8] + 1;
                    end
                    3'b011:begin
                        if (ctrl[3:1]==3'b000) Ai[15:12] <= Ai[15:12] + 1;
                        else if(ctrl[3:1]==3'b001) Bi[15:12] <= Bi[15:12] + 1;
                    end
                    3'b100:begin
                        if (ctrl[3:1]==3'b000) Ai[19:16] <= Ai[19:16] + 1;
                        else if(ctrl[3:1]==3'b001) Bi[19:16] <= Bi[19:16] + 1;
                    end
                    3'b101:begin
                        if (ctrl[3:1]==3'b000) Ai[23:20] <= Ai[23:20] + 1;
                        else if(ctrl[3:1]==3'b001) Bi[23:20] <= Bi[23:20] + 1;
                    end
                    3'b110:begin
                        if (ctrl[3:1]==3'b000) Ai[27:24] <= Ai[27:24] + 1;
                        else if(ctrl[3:1]==3'b001) Bi[27:24] <= Bi[27:24] + 1;
                    end
                    3'b111:begin
                        if (ctrl[3:1]==3'b000) Ai[31:28] <= Ai[31:28] + 1;
                        else if(ctrl[3:1]==3'b001) Bi[31:28] <= Bi[31:28] + 1;
                    end
                endcase
            end else if(BTN_OK[1]) begin
                case (blink_bit)
                    3'b000:begin
                        if (ctrl[3:1]==3'b000) Ai[3:0] <= Ai[3:0] - 1;
                        else if(ctrl[3:1]==3'b001) Bi[3:0] <= Bi[3:0] - 1;
                    end
                    3'b001:begin
                        if (ctrl[3:1]==3'b000) Ai[7:4] <= Ai[7:4] - 1;
                        else if(ctrl[3:1]==3'b001) Bi[7:4] <= Bi[7:4] - 1;
                    end
                    3'b010:begin
                        if (ctrl[3:1]==3'b000) Ai[11:8] <= Ai[11:8] - 1;
                        else if(ctrl[3:1]==3'b001) Bi[11:8] <= Bi[11:8] - 1;
                    end
                    3'b011:begin
                        if (ctrl[3:1]==3'b000) Ai[15:12] <= Ai[15:12] - 1;
                        else if(ctrl[3:1]==3'b001) Bi[15:12] <= Bi[15:12] - 1;
                    end
                    3'b100:begin
                        if (ctrl[3:1]==3'b000) Ai[19:16] <= Ai[19:16] - 1;
                        else if(ctrl[3:1]==3'b001) Bi[19:16] <= Bi[19:16] - 1;
                    end
                    3'b101:begin
                        if (ctrl[3:1]==3'b000) Ai[23:20] <= Ai[23:20] - 1;
                        else if(ctrl[3:1]==3'b001) Bi[23:20] <= Bi[23:20] - 1;
                    end
                    3'b110:begin
                        if (ctrl[3:1]==3'b000) Ai[27:24] <= Ai[27:24] - 1;
                        else if(ctrl[3:1]==3'b001) Bi[27:24] <= Bi[27:24] - 1;
                    end
                    3'b111:begin
                        if (ctrl[3:1]==3'b000) Ai[31:28] <= Ai[31:28] - 1;
                        else if(ctrl[3:1]==3'b001) Bi[31:28] <= Bi[31:28] - 1;
                    end
                endcase
            end 
        end
    end

endmodule // Enter