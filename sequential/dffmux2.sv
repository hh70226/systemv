module top_module (
    input clk,
    input w, R, E, L,
    output Q
);
    wire mux_outE, mux_outL;
    assign mux_outE = (E ? w : Q);
    assign mux_outL = (L ? R : mux_outE);
    
    reg reg_Q;
    assign Q = reg_Q;
    always @(posedge clk) begin
    	reg_Q = mux_outL;
    end
    
endmodule