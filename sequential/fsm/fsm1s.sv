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


module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    // each state for each of the water levels theres the basic 4 and then the ones to detect 
    //whether theres a higher level before so another 4 states
    parameter A = 0, // below S1 
    		B0 = 1, // S2 ~ S1 and previous was C 
   			B1 = 2, // S2 ~ S1 
    		C0 = 3, // S3 ~ S2 and previous was D
    		C1 = 4, // S3 ~ S2
    		D = 5; // above S3
    reg [2:0] state, next_state;
    
    always @(*) begin
        case(state) 
            A: next_state = (s[1]) ? B1 : A;
            B0: next_state = (s[2]) ? C1 : ((s[1]) ? B0 : A);
            B1: next_state = (s[2]) ? C1 : ((s[1]) ? B1 : A);
            C0: next_state = (s[3]) ? D : ((s[2]) ? C0 : B0);
            C1: next_state = (s[3]) ? D : ((s[2]) ? C1 : B0);
            D: next_state = (s[3]) ? D : C0;
        endcase
    end
    
    always @(posedge clk) begin
        if(reset) state <= A;
        else state <= next_state;
    end
    
    always @(*) begin
    	 case(state)
            A: {fr3, fr2, fr1, dfr} = 4'b1111;
             B0: {fr3, fr2, fr1, dfr} = 4'b0111;
             B1: {fr3, fr2, fr1, dfr} = 4'b0110;
             C0: {fr3, fr2, fr1, dfr} = 4'b0011;
             C1: {fr3, fr2, fr1, dfr} = 4'b0010;
            D: {fr3, fr2, fr1, dfr} = 4'b0000;
            default: {fr3, fr2, fr1, dfr} = 'x;
        endcase
    end
    
endmodule