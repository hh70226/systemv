module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
    reg [5:0] next;
    
    /*always_comb begin
        case(state)
            A: next = w ? B : A;
            B: next = w ? C : D;
            C: next = w ? E : D;
            D: next = w ? F : A;
            E: next = w ? E : D;
            F: next = w ? C : D;
            default: next = ERROR;
        endcase
    end*/
    
    always_comb begin
        next[0] = (~w & y[0]) | (~w & y[0]);
        next[1] = (w & y[0]);
        next[2] = (w & y[1]) | (w & y[5]);
        next[3] = (~w & y[1]) | (~w & y[2]) | (~w & y[4]) | (~w & y[5]);
        next[4] = (w & y[2]) | (w & y[4]);
        next[5] = (w & y[3]);
    end
    
    assign Y1 = next[1];
    assign Y3 = next[3];
    

endmodule