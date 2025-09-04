module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
    parameter left = 0, right = 1, fall_left = 2, fall_right = 3;
    reg [1:0] state, next;
    
    always @(*) begin
        case(state)
            left: next = ground ? (bump_left ? right : left) : fall_left;
            right: next = ground ? (bump_right ? left : right) : fall_right;
            fall_left: next = ground ? left : fall_left;
            fall_right: next = ground ? right : fall_right;
        endcase
    end
    
    always @(posedge clk, posedge areset) begin
        if(areset) state <= left;
        else state <= next;
    end
    
    assign walk_left = state == left ;
    assign walk_right = state == right ;
    assign aaah = (state == fall_left) | (state == fall_right);

endmodule