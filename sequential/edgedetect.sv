module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    
    reg [7:0] reg_pedge, in_reg;
    assign pedge = reg_pedge;
    always @(posedge clk) begin
        
        if(in_reg != in) begin
            reg_pedge <= in & ~in_reg;
            in_reg <= in;
		end
        else begin
        	reg_pedge <= 0;
        end
    end

endmodule



module top_module2(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);
	
	reg [7:0] d_last;	
			
	always @(posedge clk) begin
		d_last <= in;			// Remember the state of the previous cycle
		pedge <= in & ~d_last;	// A positive edge occurred if input was 0 and is now 1.
	end
	
endmodule











// module top_module (
//     input clk,
//     input [7:0] in,
//     output [7:0] pedge
// );
    
//     reg [7:0] reg_pedge, in_reg;
//     assign pedge = reg_pedge;
//     always @(posedge clk) begin
//         if (in != in_reg) begin
//             reg_pedge <= in;
//            	in_reg <= in;
//         end
//         else begin
//         	reg_pedge <= 0;
//         end
        
//     end

// endmodule