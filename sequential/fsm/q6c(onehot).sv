module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4);

    localparam A = 6'b000001, B = 6'b000010, C = 6'b000100, D = 6'b001000, E = 6'b010000, F = 6'b100000, ERROR = 6'b0;
    reg[5:0] next;
    
    /*always_comb begin
        unique case(y)
            6'b?????1: next = w ? A : B;
            6'b????1?: next = w ? D : C;
            6'b???1??: next = w ? D : E;
            6'b??1???: next = w ? A : F;
            6'b?1????: next = w ? D : E;
            6'b1?????: next = w ? D : C;
            default: next = A;
        endcase
    end*/
    
    always_comb begin
        next[0] = (w & y[1]) | (w & y[4]); // A
        next[1] = (~w & y[1]); // B
        next[2] = (~w & y[2]) | (~w & y[6]); // C
        next[3] = (w & y[2]) | (w & y[3]) | (w & y[5]) | (w & y[6]); //D
        next[4] = (~w & y[3]) | (~w & y[6]); // E
        next[5] = (~w & y[4]);
    end
        
        assign Y2 = next[1];
        assign Y4 = next[3];
endmodule