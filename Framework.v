module Framework(
    input RSTN, clk_100mhz,
    input BTNL, BTNR, BTNU, BTND, BTNC,
    input [15:0] SW,
    output [15:0] LED,
    output [7:0] SEGMENT, AN
);
    wire RST = ~RSTN;
    wire[31:0] div;
    wire clk_cpu;
    assign LED = div[31:16];


    clk_div U8(.clk(clk_100mhz), .rst(RST), 
    .SW2(SW[2]), .Clk_CPU(clk_cpu), .clkdiv(div));

    Segment U6(.flash(), .data(div), .les(SW[7:0]), .point(SW[15:8]),
    .scan(div[20:18]), .seg(SEGMENT), .an(AN));


endmodule // Framework