module top_module (
    input clk,
    input reset,        // Synchronous active-high reset
    output [3:0] q);
    
     always @(posedge clk) begin
         if(reset || q == 4'd9) begin
            q <= 4'd0;
        end
        
        else begin
        	q <= q + 4'd1;
        end
    end
    

endmodule

module reset_1(
    input clk,
    input reset,
    output reg [3:0] q);
	
    always @(posedge clk) begin
        if(reset || q == 4'd10) begin
            q <= 4'd1;
        end
        
        else 
            q <= q + 4'd1;
    end
endmodule
