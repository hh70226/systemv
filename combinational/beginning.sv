module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire [31:0] xorsub_b;
    wire [15:0] out_add15_0, out_add31_16;
    wire cout1, cout2;
    
    assign xorsub_b = b ^ {32{sub}};
    
    add16 add16(.a(a[15:0]), .b(xorsub_b[15:0]), .cin(sub), .sum(out_add15_0), .cout(cout1));
    add16 add32(.a(a[31:16]), .b(xorsub_b[31:16]), .cin(cout1), .sum(out_add31_16), .cout(cout2));
   
    assign sum[15:0] = out_add15_0;
    assign sum[31:16] = out_add31_16;
    
    
endmodule