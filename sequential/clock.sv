module 1hztick(
    input clk,
    input reset,
    output reg ena_1hz 
);
    reg [25:0] counter;

    always @(posedge clk) begin
        if(reset) begin
            counter <= 25'd0;
            ena_1hz <= 1'd0;
        end

        else begin 
            if(counter == 50000000 - 1) begin
                ena_1hz <= 1'd1;
                counter <= 25'd0;
            end

            else begin
                counter <= counter + 1;
                ena_1hz <= 1'd0;
            end
        end
    end
endmodule 

module bcdclock(
    input [3:0] limit,
    input [3:0] reset_val,
    input clk,
    input reset,
    input ena,
    output reg [3:0] q);
	
    always @(posedge clk) begin
        if(reset || q == limit && ena) begin
        	q <= reset_val;
        end
        
        else begin
            if(ena) begin
            	q <= q + 4'd1;
            end
		end
    end
    
endmodule

module bcdclockhours(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] q
);
    
    always @(posedge clk) begin 
        if(reset) begin
        	pm <= 0;
            q <= 8'h12;
        end
        
        else if(ena) begin
            if(q == 9) begin
            	q <= 8'h10;
            end

            else if(q == 8'h12) begin
            	q <= 8'h01;
            end 
            
            else if(q == 8'h11) begin
            	q <= 8'h12;
                pm <= ~pm;
            end
            
            else begin
            	q <= q + 8'h01;
            end
        end
    end

endmodule

module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss); 
	
    
    wire ena_ss1, ena_mm0, ena_mm1, ena_hh;
    assign ena_ss1 = ena & (ss[3:0] == 9);
    assign ena_mm0 = ena_ss1 & (ss[7:0] == 8'h59);
    assign ena_mm1 = ena_mm0 & (mm[3:0] == 9);
    assign ena_hh = ena_mm1 & (mm == 8'h59);
	bcdclock ss0(.limit(9), .reset_val(0), .clk(clk), .reset(reset), .ena(ena), .q(ss[3:0]));
    bcdclock ss1(.limit(5), .reset_val(0), .clk(clk), .reset(reset), .ena(ena_ss1), .q(ss[7:4]));
    bcdclock mm0(.limit(9), .reset_val(0), .clk(clk), .reset(reset), .ena(ena_mm0), .q(mm[3:0]));
    bcdclock mm1(.limit(5), .reset_val(0), .clk(clk), .reset(reset), .ena(ena_mm1), .q(mm[7:4]));
    
    bcdclockhours hrs(.clk(clk), .reset(reset), .ena(ena_hh), .q(hh), .pm(pm));
    
        

    
    
endmodule


// module bcdclock(
//     input [3:0] limit,
//     input [3:0] reset_val,
//     input clk,
//     input reset,
//     input ena,
//     output [3:0] q);
	
//     always @(posedge clk) begin
//         if(reset || q == limit & ena) begin
//         	q <= reset_val;
//         end
        
//         else begin
//             if(ena) begin
//             	q <= q + 4'd1;
//             end
// 		end
//     end
    
// endmodule

// module bcdclockhours(
//     input clk,
//     input reset,
//     input ena,
//     output reg pm,
//     output reg [7:0] q);
	
//     always @(posedge clk) begin
//         if(q == 8'h11 & ena) begin
//         	pm <= 
//         end
//         if(reset) begin
// 			q <= 8'h12;
//             pm <= 0;
//         end
        
//         else begin
//             if(q == 8'h12 & ena) begin
// 				q <= 8'h01;
//             end
            
//             else begin 
//                 if(q < 8'h10 & ena) begin
//                 	q <= q + 8'h01;
//                 end
                
//                 else begin
//                     if(q == 8'h09 & ena) begin
//                         q <= 8'h10;
//                     end
                    
//                     else begin
//                         if(ena) 
//                         	q <= q + 8'h01;
//                     end
//                 end
//             end
//         end
//     end
// endmodule
    

// module top_module(
//     input clk,
//     input reset,
//     input ena,
//     output pm,
//     output reg [7:0] hh,
//     output reg [7:0] mm,
//     output reg [7:0] ss); 
	
//     wire ena_ss1, ena_mm0, ena_mm1, ena_hh;
//     assign ena_ss1 = ena & (ss[3:0] == 9);
//     assign ena_mm0 = ena_ss1 & (ss[7:0] == 8'h59);
//     assign ena_mm1 = ena_mm0 & (mm[3:0] == 9);
//     assign ena_hh = ena_mm1 & (mm == 8'h59);
// 	bcdclock ss0(.limit(9), .reset_val(0), .clk(clk), .reset(reset), .ena(ena), .q(ss[3:0]));
//     bcdclock ss1(.limit(5), .reset_val(0), .clk(clk), .reset(reset), .ena(ena_ss1), .q(ss[7:4]));
//     bcdclock mm0(.limit(9), .reset_val(0), .clk(clk), .reset(reset), .ena(ena_mm0), .q(mm[3:0]));
//     bcdclock mm1(.limit(5), .reset_val(0), .clk(clk), .reset(reset), .ena(ena_mm1), .q(mm[7:4]));
    
//     bcdclockhours(.clk(clk), .reset(reset), .ena(ena_hh), .q(hh), .pm(pm));
    
        

    
    
// endmodule

//  // module bcdclock(
// //     input [3:0] limit,
// //     input [3:0] reset_val,
// //     input clk,
// //     input reset,
// //     input ena,
// //     output [3:0] q);
	
// //     always @(posedge clk) begin
// //         if(reset || q == limit & ena) begin
// //         	q <= reset_val;
// //         end
        
// //         else begin
// //             if(ena) begin
// //             	q <= q + 4'd1;
// //             end
// // 		end
// //     end
    
// // endmodule

// // module bcdclockhours(
// //     input clk,
// //     input reset,
// //     input ena,
// //     output pm,
// //     output [7:0] q);
	
// //     always @(posedge clk) begin
// //         if(q < 10) begin
// //             if(reset) begin
// //         		q <= 8'b00010010;
// //         	end
        
// //         	else begin
// //             	if(ena) begin
// //             		q <= q + 1'd1;
// //             	end
// // 			end
// //         end
        
// //         else begin
// //             if(reset) begin
// //             	q <= 8'b00010010;
// //             end
            	
// //             else begin
// //                 if (q == 8'h12 & ena) begin
// //                     q <= 1; 
// //                 end
                
// //                 else begin
// //                 	if (q == 9) begin
// //                 		q <= 8'b00010000;
// //                 	end
                
// //                 	else begin
// //                     	q <= q + 1'd1;
// //                 	end
// //                 end
// //             end
// //         end 
// //     end
    
// // endmodule
    

// // module top_module(
// //     input clk,
// //     input reset,
// //     input ena,
// //     output pm,
// //     output [7:0] hh,
// //     output [7:0] mm,
// //     output [7:0] ss); 
	
// //     wire ena_ss1, ena_mm0, ena_mm1, ena_hh;
// //     assign ena_ss1 = ena & (ss[3:0] == 9);
// //     assign ena_mm0 = ena_ss1 & (ss[7:0] == 8'h59);
// //     assign ena_mm1 = ena_mm0 & (mm[3:0] == 9);
// //     assign ena_hh = ena_mm1 & (mm == 8'h59);
// // 	bcdclock ss0(.limit(9), .reset_val(0), .clk(clk), .reset(reset), .ena(ena), .q(ss[3:0]));
// //     bcdclock ss1(.limit(5), .reset_val(0), .clk(clk), .reset(reset), .ena(ena_ss1), .q(ss[7:4]));
// //     bcdclock mm0(.limit(9), .reset_val(0), .clk(clk), .reset(reset), .ena(ena_mm0), .q(mm[3:0]));
// //     bcdclock mm1(.limit(5), .reset_val(0), .clk(clk), .reset(reset), .ena(ena_mm1), .q(mm[7:4]));
    
// //     bcdclockhours(.clk(clk), .reset(reset), .ena(ena_hh), .q(hh));
// //     assign pm = ({hh, mm, ss} == 24'h115959) & ena_hh | reset ? 1 : 0;
        

    
    
// // endmodule
module 1hztick(
    input clk,
    input reset,
    output reg ena_1hz 
);
    reg [25:0] counter;

    always @(posedge clk) begin
        if(reset) begin
            counter <= 25'd0;
            ena_1hz <= 1'd0;
        end

        else begin 
            if(counter == 50000000 - 1) begin
                ena_1hz <= 1'd1;
                counter <= 25'd0;
            end

            else begin
                counter <= counter + 1;
                ena_1hz <= 1'd0;
            end
        end
    end
endmodule 

module bcdclock(
    input [3:0] limit,
    input [3:0] reset_val,
    input clk,
    input reset,
    input ena,
    output reg [3:0] q);
	
    always @(posedge clk) begin
        if(reset || q == limit && ena) begin
        	q <= reset_val;
        end
        
        else begin
            if(ena) begin
            	q <= q + 4'd1;
            end
		end
    end
    
endmodule

module bcdclockhours(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] q
);
    
    always @(posedge clk) begin 
        if(reset) begin
        	pm <= 0;
            q <= 8'h12;
        end
        
        else if(ena) begin
            if(q == 8'h9) begin
            	q <= 8'h10;
            end

            else if(q == 8'h12) begin
            	q <= 8'h01;
            end 
            
            else if(q == 8'h11) begin
            	q <= 8'h12;
                pm <= ~pm;
            end
            
            else begin
            	q <= q + 8'h01;
            end
        end
    end

endmodule

module top_module(
    input CLOCK_50,
    input [1:0] KEY,
    output pm,
    output [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss); 
	
    wire reset;
    wire ena_1hz;

    assign reset = ~KEY[0];

    1hztick tick_gen(
        .clk(CLOCK_50),
        .reset(reset),
        .ena_1hz(ena_1hz)
    );

    wire ena_ss1, ena_mm0, ena_mm1, ena_hh;
    assign ena_ss1 = ena_1hz & (ss[3:0] == 9);
    assign ena_mm0 = ena_ss1 & (ss[7:0] == 8'h59);
    assign ena_mm1 = ena_mm0 & (mm[3:0] == 9);
    assign ena_hh = ena_mm1 & (ss[7:4] == 5) & (ss[3:0] == 9);

	bcdclock ss0(.limit(9), .reset_val(0), .clk(CLOCK_50), .reset(reset), .ena(ena_1hz), .q(ss[3:0]));
    bcdclock ss1(.limit(5), .reset_val(0), .clk(CLOCK_50), .reset(reset), .ena(ena_ss1), .q(ss[7:4]));
    bcdclock mm0(.limit(9), .reset_val(0), .clk(CLOCK_50), .reset(reset), .ena(ena_mm0), .q(mm[3:0]));
    bcdclock mm1(.limit(5), .reset_val(0), .clk(CLOCK_50), .reset(reset), .ena(ena_mm1), .q(mm[7:4]));
    
    bcdclockhours hrs(.clk(CLOCK_50), .reset(reset), .ena(ena_hh), .q(hh), .pm(pm));
    
        

    
    
endmodule






























module tick_1hz(
    input clk,
    input reset,
    output reg ena_1hz 
);
    reg [25:0] counter;

    always @(posedge clk) begin
        if(reset) begin
            counter <= 25'd0;
            ena_1hz <= 1'd0;
        end

        else begin 
            if(counter == 50000000 - 1) begin
                ena_1hz <= 1'd1;
                counter <= 25'd0;
            end

            else begin
                counter <= counter + 1;
                ena_1hz <= 1'd0;
            end
        end
    end
endmodule 

module bcdclock(
    input [3:0] limit,
    input [3:0] reset_val,
    input clk,
    input reset,
    input ena,
    output reg [3:0] q);
	
    always @(posedge clk) begin
        if(reset || q == limit && ena) begin
        	q <= reset_val;
        end
        
        else begin
            if(ena) begin
            	q <= q + 4'd1;
            end
		end
    end
    
endmodule

module bcdclockhours(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] q
);
    
    always @(posedge clk) begin 
        if(reset) begin
        	pm <= 0;
            q <= 8'h12;
        end
        
        else if(ena) begin
            if(q == 8'h9) begin
            	q <= 8'h10;
            end

            else if(q == 8'h12) begin
            	q <= 8'h01;
            end 
            
            else if(q == 8'h11) begin
            	q <= 8'h12;
                pm <= ~pm;
            end
            
            else begin
            	q <= q + 8'h01;
            end
        end
    end

endmodule

module seven_seg(
    input [3:0] bcd,
    output reg [6:0] seg
);
    always @(*) begin
        case(bcd)
            4'd0: seg = 7'b1000000;
            4'd1: seg = 7'b1111001;
            4'd2: seg = 7'b0100100;
            4'd3: seg = 7'b0110000;
            4'd4: seg = 7'b0011001;
            4'd5: seg = 7'b0010010;
            4'd6: seg = 7'b0000010;
            4'd7: seg = 7'b1111000;
            4'd8: seg = 7'b0000000;
            4'd9: seg = 7'b0010000;
            default: seg = 7'b1111111; // all off
        endcase
    end
endmodule

module digitalclock(
    input CLOCK_50,
    input [1:0] KEY, // reset a 
    output pm,
    output [6:0] hours1,
    output [6:0] minutes1,
    output [6:0] seconds1,
    output [6:0] hours2,
    output [6:0] minutes2,
    output [6:0] seconds2); 
	
    wire reset;
    wire ena_1hz;

    assign reset = ~KEY[0];

    tick_1hz tick_gen(
        .clk(CLOCK_50),
        .reset(reset),
        .ena_1hz(ena_1hz)
    );

    wire ena_ss1, ena_mm0, ena_mm1, ena_hh;
    assign ena_ss1 = ena_1hz & (ss[3:0] == 9);
    assign ena_mm0 = ena_ss1 & (ss[7:0] == 8'h59);
    assign ena_mm1 = ena_mm0 & (mm[3:0] == 9);
    assign ena_hh = ena_mm1 & (ss[7:4] == 5) & (ss[3:0] == 9);

    wire [7:0] ss, mm, hh;
	bcdclock ss0(.limit(9), .reset_val(0), .clk(CLOCK_50), .reset(reset), .ena(ena_1hz), .q(ss[3:0]));
    bcdclock ss1(.limit(5), .reset_val(0), .clk(CLOCK_50), .reset(reset), .ena(ena_ss1), .q(ss[7:4]));
    bcdclock mm0(.limit(9), .reset_val(0), .clk(CLOCK_50), .reset(reset), .ena(ena_mm0), .q(mm[3:0]));
    bcdclock mm1(.limit(5), .reset_val(0), .clk(CLOCK_50), .reset(reset), .ena(ena_mm1), .q(mm[7:4]));
    
    bcdclockhours hrs(.clk(CLOCK_50), .reset(reset), .ena(ena_hh), .q(hh), .pm(pm));
    
    seven_seg second0 (ss[3:0], seconds1);
    seven_seg second1 (ss[7:4], seconds2);
    seven_seg minute0 (mm[3:0], minutes1);
    seven_seg minute1 (mm[7:4], minutes2);
    seven_seg hour0 (hh[3:0], hours1);
    seven_seg hour1 (hh[7:4], hours2);
    
endmodule

