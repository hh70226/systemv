module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
); 
    wire [511:0] left, right, centre;
    assign left = {1'b0, q[511:1]};
    assign right = {q[510:0], 1'b0};
    assign centre = q[511:0];
    always @(posedge clk) begin
        if(load) begin
        	q <= data;
        end
        else begin
            q[511:0] <= (centre & ~left) | (centre & ~ right) | (~centre & right);
        end
    end
endmodule
