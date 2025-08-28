// synthesis verilog_input_version verilog_2001
module top_module(
    input a,
    input b,
    input sel_b1,
    input sel_b2,
    output wire out_assign,
    output reg out_always
); 
    assign out_assign = (sel_b1 == 1'b1 && sel_b2 == 1'b1) ? b:
         a;
    
    always @* begin 
        if(sel_b2 && sel_b1) begin 
            out_always = b;
        end 
        
        else begin
            out_always = a;
        end
    end 

endmodule

/* only selects b when both b2 and b1 select is high
else selects a */ 