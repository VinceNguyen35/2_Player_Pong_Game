`timescale 1ns / 1ps

//******************************************************************//
//  File Name:  Horizontal_Scan_Count.v                             //
//                                                                  //
//  Created by Vince Nguyen on October 15th, 2019.                  //
//  Copyright © 2019 Vince Nguyen.  All rights reserved.            //
//                                                                  //
//                                                                  //
//  This file scans the display of a monitor from left to right,    //
//  pixel by pixel.  The purpose of counting the pixels is to       //
//  designate a horizontal coordinate for each pixel.  The file     //
//  assumes there are at least 640 pixels available horizontally on //
//  the display.  The pixel count updates at a rate of 25MHz.       //
//******************************************************************//


module Horizontal_Scan_Count(
    input               clk_100MHz,
    input               clk_VGA,
    input               rst,
    output  reg         h_sync,
    output  reg         h_scan,
    output  reg         h_vid_on,
    output  reg [9:0]   H_count
    );
    
    reg     [9:0]   D;
    
    always @(posedge clk_100MHz, posedge rst)
        if(rst)
            H_count <= 10'b0;
        else
            H_count <= D;
    
    always @(*) begin
        case({clk_VGA,h_scan})
            2'b00:      D = H_count;
            2'b01:      D = H_count;
            2'b10:      D = H_count + 10'b0000000001;
            2'b11:      D = 10'b0;
            default:    D = 10'b0;
        endcase
        
        if(H_count == 799)
            h_scan = 1'b1;
        else
            h_scan = 1'b0;
        
        h_sync =    ~((H_count > 655)  & (H_count < 752));
        h_vid_on =   ((H_count == 0)   | (H_count < 640));
    end      
endmodule
