module top_module (
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);
    reg [7:0] in_last;
    wire [7:0] abs_in;

    assign abs_in = in ^ in_last;  // detect any bit change

    always @(posedge clk) begin
        in_last <= in;
        anyedge <= abs_in;
    end
endmodule