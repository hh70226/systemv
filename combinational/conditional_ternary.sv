// module top_module (
//     input [7:0] a, b, c, d,
//     output [7:0] min);//
//     // compare a < b and then compare the result of that with <c and then c < d
//     wire [7:0] lesser_a_b, lesser_a_b_c, least;
    
//     assign lesser_a_b = a < b ? a : b;
//     assign lesser_a_b_c = lesser_a_b < c ? lesser_a_b : c;
//     assign least = lesser_a_b_c < d ? lesser_a_b_c : d;
    
//     assign min = least;
        
//     // assign intermediate_result1 = compare? true: false;

// endmodule
module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);//
    // compare a < b and then compare the result of that with <c and then c < d
    wire [7:0] lesser_a_b, lesser_a_b_c;
    
    assign lesser_a_b = a < b ? a : b;
    assign lesser_a_b_c = lesser_a_b < c ? lesser_a_b : c;
    assign min = lesser_a_b_c < d ? lesser_a_b_c : d;
    
    
        
    // assign intermediate_result1 = compare? true: false;

endmodule