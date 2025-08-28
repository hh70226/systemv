module fulladd( 
    input a, b, cin,
    output cout, sum );
    assign sum = a ^ b ^ cin;
    assign cout = a & b | a & cin | b & cin;

endmodule

module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );
    
    fulladd instance1(a[0], b[0], cin, cout[0], sum[0]);
    fulladd instance2(a[1], b[1], cout[0], cout[1], sum[1]);
    fulladd instance3(a[2], b[2], cout[1], cout[2], sum[2]);               
                              
endmodule

//another 

module fulladd( 
    input a, b, cin,
    output cout, sum );
    assign sum = a ^ b ^ cin;
    assign cout = a & b | a & cin | b & cin;

endmodule
module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    wire cout0, cout1, cout2, cout3;
    fulladd instance0(x[0], y[0], 1'b0, cout0, sum[0]); 
    fulladd instance1(x[1], y[1], cout0, cout1, sum[1]); 
    fulladd instance2(x[2], y[2], cout1, cout2, sum[2]); 
    fulladd instance3(x[3], y[3], cout2, cout3, sum[3]);
    assign sum[4] = cout3;
    
    

endmodule