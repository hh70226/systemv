module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z);

    typedef enum logic [2:0] {A,B,C,D,E,F, ERROR} state_t;
    state_t next, state;
    
    always_comb begin
        case(state)
            A: next = w ? A : B;
            B: next = w ? D : C;
            C: next = w ? D : E;
            D: next = w ? A : F;
            E: next = w ? D : E;
            F: next = w ? D : C;
            default: next = ERROR;
        endcase
    end
    
    always_ff @(posedge clk) begin
        if(reset) state <= A;
        else state <= next;
    end
    assign z = (state == E) | (state == F);
endmodule