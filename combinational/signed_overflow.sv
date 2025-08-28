module fulladd( 
    input a, b, cin,
    output cout, sum );
    assign sum = a ^ b ^ cin;
    assign cout = a & b | a & cin | b & cin;

endmodule

module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
); //
    wire cout;
    fulladd overflow_add(a[6], b[6], );
        
	assign s = a + b; 
    assign overflow = a[7] & b[7] & ~s[7] | ~a[7] & ~b[7] & s[7];
    // assign s = ...
    // assign overflow = ...

endmodule /* only accounts in 2 negatives or adding 2 positives
            if there is a sign change signed overflow has occurred*/