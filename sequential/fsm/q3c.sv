module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
    typedef enum logic [2:0] {A,B,C,D,E, ERROR} state_t;
    state_t next_y, state;
    

    always_comb begin
        case(y)
            A: next_y = x ? B : A;
            B: next_y = x ? E : B;
            C: next_y = x ? B : C;
            D: next_y = x ? C : B;
            E: next_y = x ? E : D;
            default: next_y = ERROR;
        endcase
    end
    
    assign Y0 = next_y[0];
    assign z = (y == D) | (y == E);
endmodule
