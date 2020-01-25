`timescale 1ns / 1ps

//******************************************************************//
//  File Name:  VGA_Sync.v                                          //
//                                                                  //
//  Created by Vince Nguyen on October 15th, 2019.                  //
//  Copyright © 2019 Vince Nguyen.  All rights reserved.            //
//                                                                  //
//                                                                  //
//  This file interconnects the main modules needed for the game to //
//  be displayed on a monitor through a VGA connection.             //
//******************************************************************//


module VGA_Sync(
    input           clk,
    input           rst,
    output          h_sync,
    output          v_sync,
    output  [9:0]   pixel_x,
    output  [9:0]   pixel_y,
    output          video_on
    );
    
    wire            clk_VGA, h_vid_on, v_vid_on, h_scan;
    
    clk_25MHz               u0( .clk(clk),
                                .rst(rst),
                                .clk_out25MHz(clk_VGA));
    Horizontal_Scan_Count   u1( .clk_100MHz(clk),
                                .clk_VGA(clk_VGA),
                                .rst(rst),
                                .h_sync(h_sync),
                                .h_scan(h_scan),
                                .h_vid_on(h_vid_on),
                                .H_count(pixel_x));
    Vertical_Scan_Count     u2( .clk_100MHz(clk),
                                .clk_VGA(clk_VGA),
                                .h_scan(h_scan),
                                .rst(rst),
                                .v_sync(v_sync),
                                .v_vid_on(v_vid_on),
                                .V_count(pixel_y));
    
    assign video_on = h_vid_on && v_vid_on;
    
endmodule
