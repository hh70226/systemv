module top_module (
    input clk,
    input d, 
    input ar,   // asynchronous reset
    output q);
    
    reg reg_q;
    assign q = reg_q;
    always @(posedge clk or posedge ar) begin
        if(ar) begin
        	reg_q <= 1'b0;
        end
        else begin
        	reg_q <= d;
        end
        
	end

endmodule
