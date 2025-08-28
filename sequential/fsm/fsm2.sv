module top_module(
    input clk,
    input areset,    // Asynchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=0, ON=1; 
    reg state, next_state;

    always @(*) begin
        // State transition logic
        case(state)
        	1'b0: next_state = j ? ON : OFF;
            1'b1: next_state = k ? OFF : ON;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if(areset) begin
        	state <= 0;
        end
        else begin
        	state <= next_state;
        end
    end

    // Output logic
    // assign out = (state == ...);
    assign out = state == ON;

endmodule