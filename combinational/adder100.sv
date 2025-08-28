module top_module( 
    input [99:0] a, b,
    input cin,
    output cout,
    output [99:0] sum );
    wire [100:0] total;
    assign total = a[99:0] + b[99:0] + cin;
    assign cout = total[100];
    assign sum = total[99:0];

endmodule


module top_module2 (
	input [99:0] a,
	input [99:0] b,
	input cin,
	output cout,
	output [99:0] sum
);

	// The concatenation {cout, sum} is a 101-bit vector.
	assign {cout, sum} = a+b+cin;

endmodule