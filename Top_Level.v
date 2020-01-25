`timescale 1ns / 1ps

//******************************************************************//
//  File Name:  Top_Level.v                                         //
//                                                                  //
//  Created by Vince Nguyen on October 15th, 2019.                  //
//  Copyright © 2019 Vince Nguyen.  All rights reserved.            //
//                                                                  //
//                                                                  //
//  In submitting this file for class work at CSULB                 //
//  I am confirming that this is my work and the work               //
//  of no one else.  In submitting this code I acknowledge that     //
//  plagiarism in student project work is subject to dismissal      //
//  from the class.                                                 //
//******************************************************************//


module Top_Level(
    input           clk,
    input           rst,
    input           incdec1,
    input           incdec2,
    output          h_sync,
    output          v_sync,
    output  [11:0]  RGB
    );
    
    wire            Reset_S, video_on, refr_tick;
    wire    [9:0]   pixel_x, pixel_y;
    
    AISO                u0( .clk(clk),
                            .rst(rst),
                            .Reset_S(Reset_S));
                            
    VGA_Sync            u1( .clk(clk),
                            .rst(Reset_S),
                            .h_sync(h_sync),
                            .v_sync(v_sync),
                            .pixel_x(pixel_x),
                            .pixel_y(pixel_y),
                            .video_on(video_on));
    
    clk_60Hz            u2( .clk(clk),
                            .rst(Reset_S),
                            .refr_tick(refr_tick));
    
    Pixel_Generation    u3( .clk(clk),
                            .rst(Reset_S),
                            .refr_tick(refr_tick),
                            .incdec1(incdec1),
                            .incdec2(incdec2),
                            .video_on(video_on),
                            .pixel_x(pixel_x),
                            .pixel_y(pixel_y),
                            .RGB(RGB));
    
endmodule
