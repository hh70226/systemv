module top_module(
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);
    
    always @(*) begin
        case(state) 
            10'b0000000001: next_state = (in) ? 10'b0000000010 : 10'b0000000001; //0
            10'b0000000010: next_state = (in) ? 10'b0000000100 : 10'b0000000001; //1
            10'b0000000100: next_state = (in) ? 10'b0000001000 : 10'b0000000001; //2
            10'b0000001000: next_state = (in) ? 10'b0000010000 : 10'b0000000001; //3
            10'b0000010000: next_state = (in) ? 10'b0000100000 : 10'b0000000001; //4
            10'b0000100000: next_state = (in) ? 10'b0001000000 : 10'b0100000000; //5
            10'b0001000000: next_state = (in) ? 10'b0010000000 : 10'b1000000000; //6
            10'b0010000000: next_state = (in) ? 10'b0010000000 : 10'b0000000001; //7
            10'b0100000000: next_state = (in) ? 10'b0000000010 : 10'b0000000001; //8
            10'b1000000000: next_state = (in) ? 10'b0000000010 : 10'b0000000001; //9
            default: next_state = 10'b0000000001;
        endcase
    end
    
    assign out1 = (state == 10'b0100000000) | (state == 10'b1000000000);
    assign out2 = (state == 10'b0010000000) | (state == 10'b1000000000);
    
    

endmodule // wrong as im meant to process independently



module top_module(
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2
  );

	//states
    assign next_state[0] = (~in & state[0]) | (~in & state[1]) | (~in & state[2]) | (~in & state[3])
        | (~in & state[4]) | (~in & state[7])  | (~in & state[8]) | (~in & state[9]);
    assign next_state[1] = (in & state[0]) | (in & state[8]) | (in & state[9]);
    assign next_state[2] = in & state[1];
    assign next_state[3] = in & state[2];
    assign next_state[4] = in & state[3]; 
    assign next_state[5] = in & state[4];
    assign next_state[6] = in & state[5];
    assign next_state[7] = (in & state[6]) | (in & state[7]);
    assign next_state[8] = ~in & state[5];
    assign next_state[9] = ~in & state[6];
    
    assign out1 = state[8] | state[9];
    assign out2 = state[7] | state[9];

endmodule