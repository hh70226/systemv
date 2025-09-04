module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    
    parameter 	START = 4'd0, ONE = 4'd1, TWO = 4'd2, 
    			THREE = 4'd3, FOUR = 4'd4, FIVE = 4'd5, 
    			SIX = 4'd6, DISCARD = 4'd7, FLA = 4'd8, ERROR = 4'd9;
    reg [3:0] state, next;
    always @(*) begin
        case(state)
            START: next <= in ? ONE : START;
            ONE: next <= in ? TWO : START; 
            TWO: next <= in ? THREE : START;
            THREE: next <= in ? FOUR : START;
            FOUR: next <= in ? FIVE : START;
            FIVE: next <= in ? SIX : DISCARD;
            SIX: next <= in ? ERROR : FLA; 
            DISCARD: next <= in ? ONE : START;
            FLA: next <= in ? ONE : START;
            ERROR: next <= in ? ERROR : START;
        endcase
    end
    
    always @(posedge clk) begin
        if(reset) state <= START;
        else state <= next;
    end
    
	assign disc = state == DISCARD;
    assign flag = state == FLA;
    assign err = state == ERROR;
        
endmodule