module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    
    reg [399:0] sum_reg;
    reg cout_reg;
    
    assign sum = sum_reg;
    assign cout = cout_reg;
    
    reg [4:0] temp_sum;
    reg carry;
    
    always @(*) begin
        carry = cin; 
        cout_reg = 0;
        
        for(int i = 0; i < 400; i = i + 4) begin
            temp_sum = a[i +: 4] + b[i +: 4] + carry;
            
            if(temp_sum > 9) begin
                temp_sum = temp_sum + 5'd6;
            end
            
            sum_reg[i +: 4] = temp_sum[3:0];
            carry = temp_sum[4];
            
            if(i == 396) begin 
                cout_reg = carry;
            end
        end
    end
endmodule