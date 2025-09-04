module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
parameter A = 0, B = 1;

 reg state, next;
    reg [1:0] count;
    reg [1:0] count1;

    always @(*) begin
  		case(state)
   			A : next = (s) ? B : A;
   			B : next = B;
  endcase
 end

 always @(posedge clk) begin
  if (reset) begin
   state <= A;
            count=0;
            count1=0;
  end
  else begin 
      state <= next;
        
        if(state==B)
            begin
                if(count1==3)begin
                    count=0;
                    count1=0;
                end
                count= w ? count+1 : count;
                count1=count1+1;
             end
    end
 end    

 

    assign z = (count == 2) & (count1 == 3);
endmodulemodule top_module (
    input clk,
    input areset,
    input x,
    output z
); 

    typedef enum logic [1:0] {A = 2'd01, B = 2'd10} state_t;
    state_t next, state;
    
    always_comb begin
        case(state) 
            A: next <= x ? B : A;
            B: next <= B;
        endcase
    end
    
    always_ff @(posedge clk, posedge areset) begin
        if(areset) state <= A;
        else state <= next;
    end
    
    assign z = ((state == A)&x) | ((state == B)&~x);
endmodule