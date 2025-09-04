module top_module (
    input [3:1] y,
    input w,
    output Y2);
	
    typedef enum logic [2:0] {A,B,C,D,E,F, ERROR} state_t;
    state_t next;
    
    always_comb begin
        case(y)
            A: next = w ? A : B;
            B: next = w ? D : C;
            C: next = w ? D : E;
            D: next = w ? A : F;
            E: next = w ? D : E;
            F: next = w ? D : C;
            default: next = ERROR;
        endcase
    end
    
    assign Y2 = next[1];
            
    
endmodule