 
`timescale 1ns/1ps

module RandomPoint(VGA_clk, randX, randY);
	input VGA_clk;
	output reg [9:0]randX;
	output reg [8:0]randY;
	reg [5:0]pointX, pointY = 10;

	always @(posedge VGA_clk)
		pointX <= pointX + 2;	
	always @(posedge VGA_clk)
		pointY <= pointY + 1;
	always @(posedge VGA_clk)
	begin	
		if(pointX>62)
			randX <= 620;
		else if (pointX<2)
			randX <= 20;
		else
			randX <= (pointX * 10);
	end
	
	always @(posedge VGA_clk)
	begin	
		if(pointY>469)
			randY <= 460;
		else if (pointY<2)
			randY <= 20;
		else
			randY <= (pointY * 10);
	end
endmodule

