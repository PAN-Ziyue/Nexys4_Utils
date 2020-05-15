module Anti_jitter(
    input clk,
    input [4:0] BTN,
    input [15:0] SW,
    output [15:0] SW_OK,
    output reg [4:0] BTN_OK = 5'b00000
);
    reg [23:0] counter = 24'h000_0000;
    assign SW_OK = SW;

    always @(posedge clk) begin
        if(counter != 24'h000_0000) begin
            counter <= counter + 1;
            BTN_OK <= 5'b00000;         
        end else begin
            if(BTN[0]) begin
                BTN_OK[0] <= 1;
                counter <= 1;        
            end                 
            if(BTN[1]) begin
                BTN_OK[1] <= 1;
                counter <= 1;        
            end 
            if(BTN[2]) begin
                BTN_OK[2] <= 1;
                counter <= 1;        
            end   
            if(BTN[3]) begin
                BTN_OK[3] <= 1;
                counter <= 1;        
            end   
            if(BTN[4]) begin
                BTN_OK[4] <= 1;
                counter <= 1;        
            end 
        end
    end

endmodule // Anti_jitter