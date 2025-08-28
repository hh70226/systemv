module top_module (
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q);
    
    always @(posedge clk) begin
        if(reset) begin
            q <= 0;
        end
        
        else begin
            if(!slowena) begin
                q <= q;
            end
            
            else begin
                if(q == 9) begin
                	q <= 0;
                end
                else begin
                    q <= q + 1;
                end
            end
        end
    end
endmodule   





module top_module (
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q);
    
    always @(posedge clk) begin
        if (reset) begin
            q <= 0;
        end
        
        else if(slowena) begin
            q <= q == 9 ? 0 : q + 1;
        end // q holds its value automatically so no need for q = q
    end
endmodule //optimised 