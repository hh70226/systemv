module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
); 
    assign out_sop = ~a & ~ b & c | c & d;
    assign out_pos = c & (~b | d) & (~a | b) ;

endmodule 

/* in pos (product of sum), you group the 0s and any variable 
which is 0 is non-inverted A and 1s are inverted ~A */ 