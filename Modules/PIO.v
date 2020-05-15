module PIO(
    input clk, rst, EN,
    input [31:0] P_Data,
    output reg [1:0] counter_set,
    output reg [15:0] LED_out,
    output reg [13:0] GPIOf0
);

    always @(negedge clk or posedge rst) begin
        if(rst) begin
        LED_out <= 8'h2A;
        counter_set <= 2'b00;   // default channel
        end else if(EN) begin
            {LED_out, counter_set, GPIOf0} <= P_Data; // assignment
        end
    end

endmodule // PIO