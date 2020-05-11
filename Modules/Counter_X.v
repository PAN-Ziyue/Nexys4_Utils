//*  Created Date: 2020-03-18
//*  copyright (c): Raymond Rhino 
//*  Module Description:
//*    3 channel output counter
module Counter_X(
    input clk, rst,
    input clk0, clk1, clk2,
    input counter_we,
    input [31:0] counter_val,
    input [1:0] counter_ch,
    output counter0_out, counter1_out, counter2_out,
    output reg[31:0] counter_out
);

reg [32:0] counter0, counter1, counter2;
reg [31:0] counter0_Lock, counter1_Lock, counter2_Lock;
reg [23:0] counter_ctrl;
reg sq0, sq1, sq2;
reg M0, M1, M2;
reg clr0, clr1, clr2;
	
always @ (posedge clk or posedge rst) begin 
    if (rst) begin
        counter0_Lock <=0;
        counter1_Lock <=0;
        counter2_Lock <=0;
        counter_ctrl <=0;
    end
    else if (counter_we) begin
        case(counter_ch)
            2'h0: begin counter0_Lock <= counter_val; M0<=1; end
            2'h1: begin counter1_Lock <= counter_val; M1<=1; end
            2'h2: begin counter2_Lock <= counter_val; M2<=1; end
            2'h3: begin counter_ctrl <= counter_val[23:0]; end
        endcase
    end
    else begin 
        counter0_Lock <=counter0_Lock;
        counter1_Lock <=counter1_Lock;
        counter2_Lock <=counter2_Lock;
        counter_ctrl <=counter_ctrl;
        if(clr0) M0<=0;
        if(clr1) M1<=0;
        if(clr2) M2<=0;
    end
end

always @ (posedge clk0 or posedge rst) begin 
	if (rst)begin 
		counter0<=0; 
		sq0<=0; 
	end
	else begin
		case(counter_ctrl[2:1])
			2'b00:begin 
				if(M0) begin 
					counter0 <= {1'b0,counter0_Lock}; 
					clr0<=1; 
				end 
				else if(counter0[32]==0) begin 
					counter0 <= counter0 - 1'b1; 
					clr0<=0; 
				end
			end  
			2'b01:begin 
				if(counter0[32]==0) 
					counter0 <= counter0 - 1'b1; 
				else 
					counter0 <={1'b0,counter0_Lock}; 
			end
			2'b10:begin 
				sq0<=counter0[32];
				if (sq0!=counter0[32]) 
					counter0[31:0] <= {1'b0,counter0_Lock[31:1]}; 
				else 
					counter0 <= counter0 - 1'b1;
			end  
			2'b11: counter0 <= counter0 - 1'b1; 
		endcase
	end	
end


	
always @ (posedge clk1 or posedge rst) begin 
	if (rst) begin 
		counter1<=0;
		sq1<=0; 
	end
	else begin
		case(counter_ctrl[10:9])
			2'b00:begin 
				if(M1) begin 
					counter1 <= {1'b0,counter1_Lock}; 
					clr1<=1; 
				end 
				else if(counter1[32]==0) begin 
					counter1 <= counter1 - 1'b1; 
					clr1<=0; 
				end
			end
			2'b01:begin 
				if(counter1[32]==1) 
					counter1 <= counter1 - 1'b1; 
				else 
					counter1 <={1'b1,counter1_Lock}; 
			end
			2'b10:begin 
				sq1<=counter1[32];
				if (sq1!=counter1[32]) 
					counter1 <= {1'b0,counter1_Lock[31:1]}; 
				else 
					counter1 <= counter1 - 1'b1;
			end  
			2'b11: counter1 <= counter1 - 1'b1; 
		endcase
	end
end

	
always @ (posedge clk2 or posedge rst) begin 
	if (rst) begin 
		counter2<=0;
		sq2<=0; 
	end
	else begin
		case(counter_ctrl[10:9])
			2'b00:begin 
				if(M2) begin 
					counter2 <= {1'b0,counter2_Lock}; 
					clr2<=1; 
				end 
				else if(counter2[32] == 0) begin 
					counter2 <= counter2 - 1'b1; 
					clr2 <= 0; 
				end
			end  
			2'b01:begin 
				if(counter2[32] == 1) 
					counter2 <= counter2 - 1'b1; 
				else 
					counter2 <={1'b1,counter2_Lock}; 
			end
			2'b10:begin 
				sq2 <= counter2[32];
				if (sq2 != counter2[32]) 
					counter2 <= {1'b0,counter2_Lock[31:1]}; 
				else 
					counter2 <= counter2 - 1'b1;
			end  
			2'b11: counter2 <= counter2 - 1'b1; 
		endcase
	end
end

always @*
	case(counter_ch)
		2'h0: counter_out <= counter0[31:0];
		2'h1: counter_out <= counter1[31:0];
		2'h2: counter_out <= counter2[31:0];
		2'h3: counter_out <= {8'h00,counter_ctrl} ;
	endcase

assign counter0_out=counter0[32];
assign counter1_out=counter1[32];
assign counter2_out=counter2[32];


endmodule // Counter_X