`timescale 1ns / 1ps

	module VGA(
	input wire VGA_clk,
	output reg [9:0] CountxAxis, CountyAxis, 
	output reg displayArea,
    output VGA_hSync, VGA_vSync
    ); 
    reg p_hSync, p_vSync;
	
	integer porchHF = 640; //horizntal front porch
	integer syncH = 656;//horizontal sync
	integer porchHB = 752; //horizontal back porch
	integer maxH = 800; //total length

	integer porchVF = 480; //vertical front porch 
	integer syncV = 490; //vertical sync
	integer porchVB = 492; //vertical back porch
	integer maxV = 525; //total rows 

	always@(posedge VGA_clk)
    begin
		if(CountxAxis == maxH)
			CountxAxis <= 0;
		else
			CountxAxis <= CountxAxis + 1'b1;
	end

	always@(posedge VGA_clk)
    begin
		if(CountxAxis == maxH)
    begin
			if(CountyAxis == maxV)
				CountyAxis <= 0;
			else
			CountyAxis <= CountyAxis + 1'b1;
		end
	end
	
	always@(posedge VGA_clk)
    begin
		displayArea <= ((CountxAxis < porchHF) && (CountyAxis < porchVF)); 
	end

	always@(posedge VGA_clk)
    begin
		p_hSync <= ((CountxAxis >= syncH) && (CountxAxis < porchHB)); 
		p_vSync <= ((CountyAxis >= syncV) && (CountyAxis < porchVB)); 
	end
 
	assign VGA_vSync = ~p_vSync; 
	assign VGA_hSync = ~p_hSync;

endmodule		
