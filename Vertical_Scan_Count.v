`timescale 1ns / 1ps

//******************************************************************//
//  File Name:  Vertical_Scan_Count.v                               //
//                                                                  //
//  Created by Vince Nguyen on October 15th, 2019.                  //
//  Copyright © 2019 Vince Nguyen.  All rights reserved.            //
//                                                                  //
//                                                                  //
//  This file scans the display of a monitor from top to bottom,    //
//  line by line.  The purpose of counting the pixels is to         //
//  designate a vertical coordinate for each pixel.  The file       //
//  assumes there are at least 480 pixels available vertically on   //
//  the display.  The pixel count updates when the horizontal count //
//  is completed.                                                   //
//******************************************************************//


module Vertical_Scan_Count(
    input               clk_100MHz,
    input               clk_VGA,
    input               h_scan,
    input               rst,
    output  reg         v_sync,
    output  reg         v_vid_on,
    output  reg [9:0]   V_count
    );
    
    reg     [9:0]   D;
    reg             v_scan;
    
    always @(posedge clk_100MHz, posedge rst)
        if(rst)
            V_count <= 10'b0;
        else if(clk_VGA)
                V_count <= D;
             else
                V_count <= V_count;
    
    always @(*) begin
        case({h_scan,v_scan})
            2'b00:      D = V_count;
            2'b01:      D = V_count;
            2'b10:      D = V_count + 10'b0000000001;
            2'b11:      D = 10'b0;
            default:    D = 10'b0;
        endcase
        
        if(V_count == 524)
            v_scan = 1'b1;
        else
            v_scan = 1'b0;
        
        v_sync =    ~((V_count > 489)  & (V_count < 492));
        v_vid_on =   ((V_count == 0)   | (V_count < 480));
    end      
    
endmodule
