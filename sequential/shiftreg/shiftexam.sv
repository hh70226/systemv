module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //
    //clk = key0, E = key1, L = key2, w = key3 out[3:0] = LDR[3:0], R = SW
    MUXDFF ins1(KEY[0], KEY[1], KEY[2], KEY[3], SW[3], LEDR[3]);
    MUXDFF ins2(KEY[0], KEY[1], KEY[2], LEDR[3], SW[2], LEDR[2]);
    MUXDFF ins3(KEY[0], KEY[1], KEY[2], LEDR[2], SW[1], LEDR[1]);
    MUXDFF ins4(KEY[0], KEY[1], KEY[2], LEDR[1], SW[0], LEDR[0]);
endmodule

module MUXDFF (
    input clk,
    input E,
	input L,
    input w,
    input R,
    output q
);
    wire muxout1, muxout2;
    assign muxout1 = E ? w : q;
    assign muxout2 = L ? R : muxout1;
    
    always @(posedge clk) begin
    	q <= muxout2;
    end

endmodule