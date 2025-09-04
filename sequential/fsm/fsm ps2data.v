module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //
	
    parameter A = 0, B = 1, C = 2, D = 3;
    reg [1:0] state, next;
    
    // FSM from fsm_ps2
    always @(*) begin
        case(state) 
            A: next = in[3] ? B : A;
            B: next = C;
            C: next = D;
            D: next = in[3] ? B : A;
        endcase
    end
    always @(posedge clk) begin
        if(reset) state <= A;
        else begin
        	state <= next;
        end
    end
    
    assign done = (state == D);
    
    // New: Datapath to store incoming bytes.
    
    reg [1:0] counter;
    reg[23:0] data;
    
    always @(posedge clk) begin
        if(reset) data <= 24'b0;
        else data <= {data[15:8], data[7:0], in};
    end
    
    assign out_bytes = done ? data : 0;
    
    

endmodule
