module top_module (
    input clk,
    input j,
    input k,
    output Q); 
    reg reg_q;
    assign Q = reg_q;
    
    wire [1:0] jk;
    assign jk = {j, k};
    
    always @(posedge clk) begin 
        case(jk)
            2'b00: reg_q <= Q;
            2'b01: reg_q <= 1'b0;
            2'b10: reg_q <= 1'b1;
            2'b11: reg_q <= ~Q;
            
        endcase
    end
    

endmodule


module jk_ff (
    input clk,
    input j,
    input k,
    output reg Q
);

    always @(posedge clk) begin
        case ({j, k})
            2'b00: Q <= Q;      // hold
            2'b01: Q <= 1'b0;   // reset
            2'b10: Q <= 1'b1;   // set
            2'b11: Q <= ~Q;     // toggle
        endcase
    end

endmodule