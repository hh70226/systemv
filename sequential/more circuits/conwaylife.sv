module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);
    integer r, c;
    integer neighbors;
    reg [255:0] next;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (r = 0; r < 16; r = r + 1) begin
                for (c = 0; c < 16; c = c + 1) begin
                    neighbors = 0;
                    neighbors = neighbors + q[((r-1+16)%16)*16 + c];       // up
                    neighbors = neighbors + q[((r+1)%16)*16 + c];          // down
                    neighbors = neighbors + q[r*16 + (c-1+16)%16];        // left
                    neighbors = neighbors + q[r*16 + (c+1)%16];           // right
                    neighbors = neighbors + q[((r-1+16)%16)*16 + (c-1+16)%16]; // up-left
                    neighbors = neighbors + q[((r-1+16)%16)*16 + (c+1)%16];     // up-right
                    neighbors = neighbors + q[((r+1)%16)*16 + (c-1+16)%16];     // down-left
                    neighbors = neighbors + q[((r+1)%16)*16 + (c+1)%16];         // down-right

                    if (neighbors <= 1)
                        next[r*16 + c] = 0;
                    else if (neighbors == 2)
                        next[r*16 + c] = q[r*16 + c];
                    else if (neighbors == 3)
                        next[r*16 + c] = 1;
                    else // neighbors >= 4
                        next[r*16 + c] = 0;
                end
            end
            q <= next; // update grid
        end
    end
endmodule
