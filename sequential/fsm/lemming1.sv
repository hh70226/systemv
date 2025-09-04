module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  

    // parameter LEFT=0, RIGHT=1, ...
    parameter LEFT = 0, RIGHT = 1;
    reg state, next_state;

    always @(*) begin
        // State transition logic
        case(state)
            LEFT: next_state = (bump_left && !bump_right) ? RIGHT : ((bump_right && bump_left) ? RIGHT : ((bump_right && !bump_left) ? LEFT : ((!bump_left && !bump_right) ? LEFT : RIGHT)));
            RIGHT: next_state = (bump_left && !bump_right) ? RIGHT : ((bump_right && bump_left) ? LEFT : ((bump_right && !bump_left) ? LEFT : ((!bump_left && !bump_right) ? RIGHT : LEFT)));
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if(areset) state <= LEFT;
        else state <= next_state;
    end
	
    // Output logic
    // assign walk_left = (state == ...);
    // assign walk_right = (state == ...);
    assign walk_left = (state == LEFT); 
    assign walk_right = (state == RIGHT);

endmodule


module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);

	// Give state names and assignments. I'm lazy, so I like to use decimal numbers.
	// It doesn't really matter what assignment is used, as long as they're unique.
	parameter WL=0, WR=1;
	reg state;
	reg next;
    
    
    // Combinational always block for state transition logic. Given the current state and inputs,
    // what should be next state be?
    // Combinational always block: Use blocking assignments.    
    always@(*) begin
		case (state)
			WL: next = bump_left  ? WR : WL;
			WR: next = bump_right ? WL : WR;
		endcase
    end
    
    
    // Combinational always block for state transition logic. Given the current state and inputs,
    // what should be next state be?
    // Combinational always block: Use blocking assignments.    
    always @(posedge clk, posedge areset) begin
		if (areset) state <= WL;
        else state <= next;
	end
		
		
	// Combinational output logic. In this problem, an assign statement are the simplest.
	// In more complex circuits, a combinational always block may be more suitable.		
	assign walk_left = (state==WL);
	assign walk_right = (state==WR);

	
endmodule
