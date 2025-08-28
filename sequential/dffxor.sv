module top_module (
    input clk,
    input in, 
    output out);
	
    wire d;
    reg reg_out;
    assign d = in ^ out;
    assign out = reg_out;
    
    always @(posedge clk) begin
    	reg_out = d;
    end
    
    
endmodule