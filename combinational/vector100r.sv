module top_module( 
    input  [99:0] in,
    output reg [99:0] out
);
    integer i;  // Declare loop variable outside

    always @(*) begin
        for (i = 0; i < 100; i = i + 1) begin
            out[i] = in[99 - i];  // Reverses the bit order
        end
    end
endmodule