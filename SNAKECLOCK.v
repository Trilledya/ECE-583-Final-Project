`timescale 1ns / 1ps
//Divides internal 100 MHz clock to 25 Hz for the snake movement
module SNAKECLOCK(
input wire clk,
output reg update_clk
);
 

    reg [21:0] check;
    
    always @ (posedge clk) begin
        if(check < 4000000) begin
            check <= check + 1;
            update_clk <= 0;
        end
        else begin 
            check <= 0;
            update_clk <= 1;
        end
    end
            
endmodule