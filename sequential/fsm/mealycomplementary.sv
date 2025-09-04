module top_module (
    input clk,
    input areset,
    input x,
    output z
); 

    typedef enum logic [1:0] {A = 2'd01, B = 2'd10} state_t;
    state_t next, state;
    
    always_comb begin
        case(state) 
            A: next <= x ? B : A;
            B: next <= B;
        endcase
    end
    
    always_ff @(posedge clk, posedge areset) begin
        if(areset) state <= A;
        else state <= next;
    end
    
    assign z = ((state == A)&x) | ((state == B)&~x);
endmodule