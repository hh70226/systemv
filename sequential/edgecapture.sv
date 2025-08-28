module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);
    reg [31:0] in_last, set_out;
    
    always @(posedge clk) begin
        in_last <= in;
        if(reset) begin
        	out <= 32'd0;
        end
        else begin
            out <= out | ~in & in_last;
        end
    end
endmodule



module top_module2(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);
    reg [31:0] in_last, set_out;
    assign set_out = ~in & in_last;
    always @(posedge clk) begin
        in_last <= in;
        if(reset) begin
        	out <= 32'd0;
        end
        else begin
            out <= out | set_out;
        end
    end
endmodule
