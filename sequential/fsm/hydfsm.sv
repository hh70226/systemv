module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    localparam A = 0, B = 1, C = 2, D = 3;
    reg [1:0] state, next_state; 

    always @(*) begin
        next_state = state; // default (avoid X states)
        case(state)
            A: begin
                if(s == 3'b001) next_state = B;
                else if(s == 3'b000) next_state = A;
            end
            B: begin
                if(s == 3'b011) next_state = C;
                else if(s == 3'b000) next_state = A;
                else if(s == 3'b001) next_state = B;
            end
            C: begin
                if(s == 3'b111) next_state = D;
                else if(s == 3'b001) next_state = B;
                else if(s == 3'b011) next_state = C;
            end
            D: begin
                if(s == 3'b011) next_state = C;
                else if(s == 3'b111) next_state = D;
            end
        endcase
    end
    
    always @(posedge clk or posedge reset) begin
        if(reset) state <= A;
        else state <= next_state;
    end
    
    assign fr1 = (state == A) | (state == B) | (state == C);
    assign fr2 = (state == A) | (state == B);
    assign fr3 = (state == A);
    assign dfr = (state < next_state);
endmodule
