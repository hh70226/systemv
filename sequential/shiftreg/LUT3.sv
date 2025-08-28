module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z ); 
	
    reg [7:0] Q;
    
    always @(posedge clk) begin 
        if (enable) begin 
            Q <= {Q[6], Q[5], Q[4], Q[3], Q[2], Q[1], Q[0], S};
        end
    end
    assign Z = Q[{A,B,C}];
endmodule