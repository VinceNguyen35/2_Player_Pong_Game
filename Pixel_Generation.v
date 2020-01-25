`timescale 1ns / 1ps

//******************************************************************//
//  File Name:  Pixel_Generation.v                                  //
//                                                                  //
//  Created by Vince Nguyen on October 15th, 2019.                  //
//  Copyright © 2019 Vince Nguyen.  All rights reserved.            //
//                                                                  //
//                                                                  //
//  This file creates the objects for the pong game and their       //
//  animations.  The ball moves on its own, while both paddles move //
//  using switches controlled by the players.                       //
//******************************************************************//


module Pixel_Generation(
    input               clk,
    input               rst,
    input               refr_tick,
    input               incdec1,
    input               incdec2,
    input               video_on,
    input       [9:0]   pixel_x,
    input       [9:0]   pixel_y,
    output  reg [11:0]  RGB
    );
    
    reg         [9:0]   paddle_top1;
    reg         [9:0]   paddle_top2;
    reg         [9:0]   ball_left;
    reg         [9:0]   ball_top;
    
    reg                 ball_goingRight;
    reg                 ball_goingDown;
    
    always @(posedge clk, posedge rst) begin
        if(rst) begin
            paddle_top1 <= 10'd204;
            paddle_top2 <= 10'd204;
            ball_left <= 10'd36;
            ball_top <= 10'd0;
            ball_goingRight <= 1'b1;
            ball_goingDown <= 1'b1;
        end
        else    if(refr_tick) begin
                    ///////////////////////////////////////////////////
                    // This section changes the position of the paddle1
                    ///////////////////////////////////////////////////
                    if((~incdec1) && (paddle_top1 != 408))
                        paddle_top1 <= paddle_top1 + 10'd4;
                    if(incdec1 && (paddle_top1 != 0))
                        paddle_top1 <= paddle_top1 - 10'd4;
                    ///////////////////////////////////////////////////
                    // This section changes the position of the paddle2
                    ///////////////////////////////////////////////////
                    if((~incdec2) && (paddle_top2 != 408))
                        paddle_top2 <= paddle_top2 + 10'd4;
                    if(incdec2 && (paddle_top2 != 0))
                        paddle_top2 <= paddle_top2 - 10'd4;
                    ///////////////////////////////////////////////////
                    // This section changes the direction of the ball
                    ///////////////////////////////////////////////////
                    if(ball_top == 0)
                        ball_goingDown <= 1'b1;
                    if(ball_top == 472)
                        ball_goingDown <= 1'b0;
                    ///////////////////////////////////////////////////
                    // This section determines if the ball hits
                    // paddle1 and what to do if it does/does not
                    ///////////////////////////////////////////////////
                    if(((ball_left + 10'd8) == 600)) begin
                        if((ball_top > paddle_top1) && (ball_top < (paddle_top1 + 72)))
                            ball_goingRight <= 1'b0;
                        else    if(ball_left == 632) begin
                                    paddle_top1 <= 10'd204;
                                    paddle_top2 <= 10'd204;
                                    ball_left <= 10'd36;
                                    ball_top <= 10'd0;
                                    ball_goingRight <= 1'b1;
                                    ball_goingDown <= 1'b1;
                                end
                    end
                    ///////////////////////////////////////////////////
                    // This section determines if the ball hits
                    // paddle2 and what to do if it does/does not
                    ///////////////////////////////////////////////////
                    if((ball_left == 36)) begin
                        if((ball_top > paddle_top2) && (ball_top < (paddle_top2 + 72)))
                            ball_goingRight <= 1'b1;
                        else    if(ball_left == 0) begin
                                    paddle_top1 <= 10'd204;
                                    paddle_top2 <= 10'd204;
                                    ball_left <= 10'd36;
                                    ball_top <= 10'd0;
                                    ball_goingRight <= 1'b1;
                                    ball_goingDown <= 1'b1;
                                end
                    end
                    ///////////////////////////////////////////////////
                    // This section determines the next location of
                    // the ball
                    ///////////////////////////////////////////////////        
                    case({ball_goingRight, ball_goingDown})
                        2'b00:      {ball_left, ball_top} <= {ball_left - 10'd4, ball_top - 10'd4};
                        2'b01:      {ball_left, ball_top} <= {ball_left - 10'd4, ball_top + 10'd4};
                        2'b10:      {ball_left, ball_top} <= {ball_left + 10'd4, ball_top - 10'd4};
                        2'b11:      {ball_left, ball_top} <= {ball_left + 10'd4, ball_top + 10'd4};
                        
                        default:    {ball_left, ball_top} = {ball_left, ball_top};
                    endcase
                end
    end
    
    always @(*) begin
        if(~video_on)
            RGB = 12'b0;
        ///////////////////////////////////////////////////
        // This section makes paddle1 for the Pong Game
        ///////////////////////////////////////////////////
        else if((pixel_x > 599) && (pixel_x < 604) && (pixel_y > paddle_top1) && (pixel_y < (paddle_top1 + 10'd72)))
            RGB = 12'b1111_1111_0000;
        ///////////////////////////////////////////////////
        // This section makes paddle2 for the Pong Game
        ///////////////////////////////////////////////////
        else if((pixel_x > 31) && (pixel_x < 36) && (pixel_y > paddle_top2) && (pixel_y < (paddle_top2 + 10'd72)))
            RGB = 12'b1111_0000_1111;
        ///////////////////////////////////////////////////
        // This section makes the ball for the Pong Game
        ///////////////////////////////////////////////////
        else if((pixel_x > ball_left) && (pixel_x < (ball_left + 10'd8)) && (pixel_y > ball_top) && (pixel_y < (ball_top + 10'd10)))
            RGB = 12'b1111_0000_0000;
        else
            RGB = 12'b0;
    end
    
endmodule
