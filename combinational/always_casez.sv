// synthesis verilog_input_version verilog_2001
module top_module (
    input [7:0] in,
    output reg [2:0] pos );

    always @(*) begin
        casez(in[7:0])
            8'b???????1: pos = 3'd0;
            8'b??????1?: pos = 3'd1;
            8'b?????1??: pos = 3'd2;
            8'b????1???: pos = 3'd3;
            8'b???1????: pos = 3'd4;
            8'b??1?????: pos = 3'd5;
            8'b?1??????: pos = 3'd6;
            8'b1???????: pos = 3'd7;
            default:     pos = 3'd0; // or some other value to signal "no 1 found"
        endcase
    end

endmodule
