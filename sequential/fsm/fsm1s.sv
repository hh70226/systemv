// Note the Verilog-1995 module declaration syntax here:
module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;//  
    reg out;

    // Fill in state name declarations

    reg present_state, next_state;
    always @(*) begin
        case(present_state)     
        	1'b0: next_state = in == 1 ? 0 : 1;
            1'b1: next_state = in == 1 ? 1 : 0;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) begin  
            // Fill in reset logic
            present_state <= 1;
        end 
        else begin
            present_state <= next_state;
        end
    end
    assign out = present_state;

endmodule
