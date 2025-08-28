module top_module (
    input clk,
    input d,
    output reg q
);
    reg pos, neg;
    always @(negedge clk) begin
        neg <= d;
    end
    
    always @(posedge clk) begin
        pos <= d;
    end
    
    assign q = clk ? pos : neg;

endmodule
