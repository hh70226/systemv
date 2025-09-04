x
module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
  ); 

	localparam [2:0] IDLE 	 = 3'b000,
					 START 	 = 3'b001,
					 READ = 3'b010,
					 WAIT	 = 3'b011,
					 STOP    = 3'b100;

	reg [2:0] state, next;
    reg [3:0] i = 0;

    always @(*) begin
        case(state)
            IDLE: next = in ? IDLE : START;
            START: next = READ;
            READ: next = (i > 7) ? ((in) ? STOP : WAIT) : READ;
            WAIT: next = (in) ? IDLE : WAIT;
            STOP: next = (in) ? IDLE : START;
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
                STOP: if(state != WAIT) begin
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

endmodule