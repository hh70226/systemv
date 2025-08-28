module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
); 

    //assign c_enable = c_load ? 0 : enable;
    //assign c_d = c_load ? 1 : 0;
    //assign c_load = (reset || Q == 12) ? 1 : 0;
    
    assign c_enable = enable;
    
	assign c_d = 1;
    assign c_load = (reset || Q == 12 & enable) ? 1 : 0;
    always @(posedge clk) begin
        if(c_load) begin 
            Q <= c_d;
        end
        
        else begin
            if(c_enable) begin
                Q <= Q + 1;
            end
        end
    end


endmodule