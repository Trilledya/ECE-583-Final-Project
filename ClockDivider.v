//Divides internal 100 MHz clock into 25 MHz 
module ClockDivider(
input wire clk,
output reg VGA_clk
);

    integer check = 3;
    integer a = 0;
	always@(posedge clk)
    begin 
        if(a<check) begin
            a <= a + 1;
            VGA_clk <= 0;
        end
        else begin
            a <= 0;
            VGA_clk <= 1;
        end
        //VGA_clk = clk;
	end
	
endmodule