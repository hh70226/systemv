module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q ); 
	
    always @(posedge clk) begin
        if(load) begin
        	q <= data;
        end
        
        else begin
            for(int i = 0; i < 512; i = i + 1) begin
                if(i == 0) begin
                    q[0] <= 1'b0 ^ q[1];
                end
                else if(i == 511) begin
                    q[511] <= q[510] ^ 1'b0;
                end
                else begin
                    q[i] <= q[i - 1] ^ q[i + 1];
                end
            end
        end
    end
endmodule


module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q ); 
	
    always @(posedge clk) begin
        if(load) begin
        	q <= data;
        end
        
        else begin
            // At each clock, the DFF storing each bit position becomes the XOR of its left neighbour
			// and its right neighbour. Since the operation is the same for every
			// bit position, it can be written as a single operation on vectors.
			// The shifts are accomplished using part select and concatenation operators.
			
			//     left           right
			//  neighbour       neighbour
            q[511:0] <= {1'b0, q[511:1]} ^ {q[510:0], 1'b0};
        end
    end
endmodule