module top_module( 
    input [2:0] in,
    output [1:0] out );
    reg [1:0] count;
    assign out = count;
    always @(*) begin
        count = 0;
        case(in [2:0])	
            3'b000: count = 0;
            3'b001: count = 1;
            3'b010: count = 1;
            3'b011: count = 2;
            3'b100: count = 1;
            3'b101: count = 2;
            3'b110: count = 2;
            3'b111: count = 3;
        endcase
    end
    

endmodule


module top_module( 
    input [2:0] in,
    output [1:0] out );
    
    assign out = in[0] + in[1] + in[2];

endmodule