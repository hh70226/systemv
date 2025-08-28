module sub_moduleA (input x, input y, output z);
    assign z = (x^y) & x;
endmodule 



module top_module (input x, input y, output z);
    wire za, za2, zb, z1, z2;
	
    sub_moduleA instance1(x, y, za);
    
    
    assign zb = ~(x ^ y);
    assign z1 = za | zb;
    assign z2 = za & zb;
    assign z = z1 ^ z2;

endmodule