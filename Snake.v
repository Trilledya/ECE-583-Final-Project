              
  module Snake (
  input wire clk,
  input reset, left, right, up, down,
  output h_sync, v_sync,
  output reg [3:0] red, green, blue
  );
  
  
  wire VGA_clk;
  wire update_clock; 
  wire[9:0] CountxAxis;
  wire[9:0] CountyAxis;
  wire[3:0] movement;
  wire[9:0] randX;
  reg[9:0] randomX;
  wire[8:0] randY;
  reg[8:0] randomY;
  wire displayArea;
  reg [9:0] appleX;
  reg [9:0] appleY;
  reg inX, inY;
  reg [9:0] snakeX[0:10];
  reg [8:0] snakeY[0:10];
  reg [9:0] headX;
  reg [9:0] headY;
  reg snake;
  reg stop;
  reg gameOver;
  reg SnakeHead;
  reg apple;
  reg border;
  reg R, G, B;
  
 
  
  ClockDivider VGAclkDivider(clk, VGA_clk);
  SNAKECLOCK UpdateSnakeMovementCLK(clk, update_clock);
  VGA VGAoutput(VGA_clk, CountxAxis, CountyAxis, displayArea, h_sync, v_sync);
  RandomPoint randompointgen(VGA_clk, randX, randY);
  Buttons buttonInpu(clk,left,right,up,down,movement);
  
  always @(*) begin//THIS PART MIGHT NOT WORK
  
  randomX = randX;
   randomY = randY;
   
   end
           
  always @(posedge VGA_clk) begin
          inX <= (CountxAxis > appleX & CountxAxis < (appleX + 10));
          inY <= (CountyAxis > appleY & CountyAxis < (appleY + 10));
          apple <= inX & inY;
  end
                      
  always@(posedge VGA_clk) begin
         border <= (((CountxAxis >= 0) & (CountxAxis < 15) | (CountxAxis >= 630) & (CountxAxis < 641)) | ((CountyAxis >= 0) & (CountyAxis < 15) | (CountyAxis >= 465) & (CountyAxis < 481)));
  end
    
  always@(posedge VGA_clk) begin    
      if(reset) begin
        appleX = 350;
        appleY = 300;
      end 
     if(apple & SnakeHead) begin 
        appleX <= randomX % 400;
        appleY <= randomY % 250;
     end                        
  end
 
  always@(posedge update_clock) begin
  
  snakeX[10] <= snakeX[9];
  snakeY[10] <= snakeY[9];
  snakeX[9] <= snakeX[8];
  snakeY[9] <= snakeY[8];
  snakeX[8] <= snakeX[7];
  snakeY[8] <= snakeY[7];
  snakeX[7] <= snakeX[6];
  snakeY[7] <= snakeY[6];
  snakeX[6] <= snakeX[5];
  snakeY[6] <= snakeY[5];
  snakeX[5] <= snakeX[4];
  snakeY[5] <= snakeY[4];
  snakeX[4] <= snakeX[3];
  snakeY[4] <= snakeY[3];
  snakeX[3] <= snakeX[2];
  snakeY[3] <= snakeY[2];
  snakeX[2] <= snakeX[1];
  snakeY[2] <= snakeY[1];
  snakeX[1] <= snakeX[0];
  snakeY[1] <= snakeY[0];
                        
  if(movement == 4'b0001) begin snakeX[0] = snakeX[0] - 5; end // button input left
     else if (movement == 4'b0010) begin snakeX[0] = snakeX[0] + 5; end //button input right
     else if (movement == 4'b0100) begin snakeY[0] = snakeY[0] - 5; end //button input up
     else if(movement == 4'b1000) begin snakeY[0] = snakeY[0] + 5; end //button input down
     
  end

always@(posedge VGA_clk) begin
    snake = ((CountxAxis > snakeX[1] & CountxAxis < snakeX[10]+10) & (CountyAxis > snakeY[1] & CountyAxis < snakeY[10]+10));
end   
always@(posedge VGA_clk) begin
     SnakeHead  <= (CountxAxis > snakeX[0] & CountxAxis < (snakeX[0]+10)) & (CountyAxis > snakeY[0] & CountyAxis < (snakeY[0]+10));
end
            
always @(posedge VGA_clk) begin
   if((border & (snake|SnakeHead)) | reset) gameOver<=1;
   else gameOver=0;
end
always @(*) begin       //assigns the display area border snake etc to the R,G,B color array.
R = (displayArea & (apple & ~gameOver));
G = (displayArea & (snake & ~gameOver));
B = (displayArea & (border | SnakeHead | gameOver));
end
always@(posedge VGA_clk) begin      //sends the RGB array to the red, green, and blue through VGA to the monitor
       red = {4{R}};
       green = {4{G}};
       blue = {4{B}};
end          
  
endmodule 

