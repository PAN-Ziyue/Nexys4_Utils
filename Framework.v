//*  Created Date: 2020-05-11
//*  copyright (c): Raymond Rhino 
//*  Module Description:
//*    Top Module: Framework
module Framework(
    input RSTN, clk_100mhz,
    input BTNL, BTNR, BTNU, BTND, BTNC,
    input [15:0] SW,
    output [15:0] LED,
    output [7:0] SEGMENT, AN
);
    wire rst = ~RSTN;
    wire[31:0] div;
    wire clk_cpu;
    assign LED = SW;

    wire V5, N0;
    VCC VCC_PORT(.P(V5));
    GND GND_PORT(.G(N0));

    wire[7:0] point_out, LE_out, blink;
    wire [31:0] data_out, Ai, Bi;
    wire [63:0] les = ~{{48{N0}}, blink, blink};


    clk_div U8(.clk(clk_100mhz), .rst(rst), 
    .SW2(SW[2]), .Clk_CPU(clk_cpu), .clkdiv(div));

    Segment U6(.flash(div[25]), .data(data_out), .le(LE_out), 
    .point(point_out), .scan(div[20:18]), .seg(SEGMENT), .an(AN));

    Enter M4(.BTNL(BTNL), .BTNR(BTNR), .BTNU(BTNU), .BTND(BTND),
    .clk(div[22]), .ctrl({SW[7:5], SW[0]}), .Ai(Ai), .Bi(Bi),
    .blink(blink));


    Multi_8CH32 U5( .clk(clk_100mhz), .rst(rst), .EN(V5), 
                .Test(SW[7:5]), .point_in({div[31:0], div[31:0]}),
                .LES(les), .Data0(Ai), .data1(Bi), .data2(div),
                .data3(), .data4(), .data5(), 
                .data6(), .data7(), .point_out(~point_out),
                .LE_out(LE_out), .Disp_num(data_out));


endmodule // Framework