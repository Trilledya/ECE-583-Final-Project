`timescale 1ns / 1ps

module Buttons (
input wire clk,
input left,
input right,
input up,
input down,
output reg [3:0] movement
);
     
     
    always@(posedge clk) begin
    
        if(left == 1) begin 
            movement <= 4'b0001; //move left
        end 
        else if(right == 1) begin 
            movement <= 4'b0010; //move right
        end 
        else if(up == 1) begin 
            movement <= 4'b0100; //move up
        end 
        else if(down == 1) begin 
            movement <=4'b1000; //move down
        end 
        else begin 
            movement <= movement; //else keeps direction if no button input
        end 
    end

endmodule