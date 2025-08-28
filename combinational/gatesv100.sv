module top_module( 
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different );
    
    reg [98:0] reg_out_both;
    reg [99:1] reg_out_any;
    reg [99:0] reg_out_different;
    
    assign out_both = reg_out_both;
    assign out_any = reg_out_any;
    assign out_different = reg_out_different;
    
    always @(*) begin
    	for(int i = 0; i < 99; i = i + 1) begin
        	reg_out_both[i] = in[i + 1] & in[i];
            reg_out_any[99 - i] = in[99 - i] | in[98 - i];
            reg_out_different[i] = in[i + 1] ^ in [i];
            
   	 	end
        reg_out_different[99] = in[99] ^ in[0];
    end
    

endmodule




module top_module2( 
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different );
    
    reg [98:0] reg_out_both;
    reg [99:1] reg_out_any;
    reg [99:0] reg_out_different;
    
    assign out_both = reg_out_both;
    assign out_any = reg_out_any;
    assign out_different = reg_out_different;
    
    always @(*) begin
    	for(int i = 0; i < 99; i = i + 1) begin
        	reg_out_both[i] = in[i + 1] & in[i];
            reg_out_any[i + 1] = in[i] | in[i + 1];
            reg_out_different[i] = in[i + 1] ^ in [i];
            
   	 	end
        reg_out_different[99] = in[99] ^ in[0];
    end
    

endmodule
