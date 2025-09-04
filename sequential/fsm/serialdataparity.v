module parityy (
    input clk,
    input [2:0] state,
    input in,
    output reg odd);

    always @(posedge clk) begin
        if (state == 1) odd <= 0;
        else if (in && ((state == 2) || (state == 3))) odd <= ~odd;
    end
endmodule

module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //
    
	parameter IDLE = 0, START = 1, READ = 2, PARITY = 3, WAIT = 4, STOP = 5;
    reg odd, parity_bit; 
    reg [2:0] state, next;
    reg [3:0] i;
    reg [7:0] out;
	
    parityy inst1(clk, state, in, odd);
    // Modify FSM and datapath from Fsm_serialdata
    always @(*) begin
        case(state)
            IDLE: next = in ? IDLE : START;
            START: next = READ;
            READ: next = (i > 7) ? PARITY : READ;
            PARITY: next = in ? STOP : WAIT;
            WAIT: next = in ? STOP : WAIT;
            STOP: next = in ? IDLE : START;
        endcase
	end
            
    always @(posedge clk) begin 
        if(reset) state <= IDLE;
        else begin
            state <= next;
            if(state == PARITY) parity_bit <= in;
            else if(state == READ) out[i] <= in;
        end
    end
    
    always @(posedge clk) begin
        if(reset) begin
        	done <= 0;
            i <= 0;
        end
        else begin
            case(next)
                STOP: if(odd == parity_bit) begin
                    done <= 1;
                    i <= 0;
                end
                else done <= 0;
                READ: begin
                    done <= 0;
                    i <= i + 1;
                end
                default: begin
                    done <= 0;
                    i <= 0;
                end
            endcase
        end
    end
    
 	assign out_byte = done ? out : 0;
	
    // New: Add parity checking.

endmodule


module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Use FSM from Fsm_serial
	localparam [2:0] IDLE 	 = 3'b000,
					 START 	 = 3'b001,
					 READ = 3'b010,
					 WAIT	 = 3'b011,
					 STOP    = 3'b100,
    				 PARITY_CHECK = 3'b101;

	reg [2:0] state, next;
    reg [3:0] i = 0;
    reg parity;
    wire odd;

    always @(*) begin
        case(state)
            IDLE: next = in ? IDLE : START;
            START: next = READ;
            READ: next = (i > 7) ? PARITY_CHECK : READ;
            WAIT: next = (in) ? IDLE : WAIT;
            STOP: next = (in) ? IDLE : START;
            PARITY_CHECK: next = in ? STOP : WAIT;
        endcase
    end
    
    always @(posedge clk) begin
        if(reset) begin
            state <= IDLE;
        end
        
        else begin
            state <= next;
        end
    end
    
    always @(posedge clk) begin
        if(reset) begin
            done <= 0;
            i <= 0; 
        end
        else begin
            case(next)
                READ: begin
                    done <= 0;
                    i <= i + 1;
                end
                STOP: if(odd) begin
                	done <= 1;
                    i <= 0;
                end
                default: begin
                	done <= 0;
                    i <= 0;
                end
            endcase
        end
    end

    // New: Datapath to latch input bits.
    reg [7:0] reg_out;
    
    always @(posedge clk) begin
        if(reset) reg_out <= 8'b0;
        else begin
            if(next == READ) reg_out[i] <= in;
            else if(next == PARITY_CHECK) parity <= in;
        end
    end
    assign odd = ^{reg_out, parity};
    assign out_byte = done ? reg_out : 8'b0;
	// parity check 
    
    
endmodule
