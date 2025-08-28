module decade_counter(
	input clk,
    input enable,
    input reset, 
    output [3:0] q);
    
    always @(posedge clk) begin
        if(reset || q == 4'd9 & enable) begin
            q <= 4'd0;
        end
        else begin
            if(enable) begin
                q <= q + 4'd1;
            end
        end
    end
endmodule

module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
    
    assign ena[1] = (q[3:0] == 4'd9) ? 1'd1 : 1'd0;
    assign ena[2] = (q[7:4] == 4'd9 & ena[1]) ? 1'd1 : 1'd0;
    assign ena[3] = (q[11:8] == 4'd9 & ena[2]) ? 1'd1 : 1'd0;
    
    decade_counter count0(clk, 1'b1, reset, q[3:0]);
    decade_counter count1(clk, ena[1], reset, q[7:4]);
    decade_counter count2(clk, ena[2], reset, q[11:8]);
    decade_counter count3(clk, ena[3], reset, q[15:12]);
    

endmodule
    