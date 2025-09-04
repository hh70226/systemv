module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 

    parameter left = 0, right = 1, dig_left = 2, dig_right = 3, fall_right = 4, fall_left = 5;
    reg [2:0] state, next;
    
    always @(*) begin
        case(state)
            left: next = ~ground ? fall_left : (dig ? dig_left : (bump_left ? right : left));
            right: next = ~ground ? fall_right : (dig ? dig_right : (bump_right ? left : right));
            dig_left: next = ground ? dig_left : fall_left;
            dig_right: next = ground ? dig_right : fall_right;
            fall_right: next = ground ? right : fall_right;
            fall_left: next = ground ? left : fall_left;
            default: next = 'x;
        endcase
    end
     
    always @(posedge clk, posedge areset) begin
        if(areset) state <= left;
        else state <= next;
	end
    
    assign walk_left = state == left;
    assign walk_right = state == right;
    assign digging = (state == dig_left) | (state == dig_right);
    assign aaah = (state == fall_right) | (state == fall_left);
    
endmodule
