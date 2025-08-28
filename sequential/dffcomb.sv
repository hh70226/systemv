module top_module (
    input clk,
    input x,
    output z
); 
   	reg dff_xor, dff_and, dff_or;
    wire notqxor, notqand, notqor;
    assign z = ~(dff_xor | dff_and | dff_or);
    assign notqxor = ~dff_xor;
    assign notqand = ~dff_and;
    assign notqor = ~dff_or;
    
	always @(posedge clk) begin
    	dff_xor <= x ^ dff_xor;
        dff_and <= x & notqand;
        dff_or <= x | notqor;
    end

endmodule
