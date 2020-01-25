`timescale 1ns / 1ps

//******************************************************************//
//  File Name:  clk_60Hz.v                                          //
//                                                                  //
//  Created by Vince Nguyen on October 15th, 2019.                  //
//  Copyright © 2019 Vince Nguyen.  All rights reserved.            //
//                                                                  //
//                                                                  //
//  This file creates a 60Hz clock from the 100MHz signal of the    //
//  Nexys 4 FPGA.  The module is used for the screen refresh rate   //
//  on the monitor that displays the game.                          //
//******************************************************************//


module clk_60Hz(
    input       clk,
    input       rst,
    output  reg refr_tick
    );
    
    reg     [20:0]   Q;
    
    always @(posedge clk, posedge rst)
        if(rst)
            Q <= 21'b0;
        else
            Q <= Q + 21'b1;
    
    always @(*)
        if(Q == 21'b110010110111001101011)
            refr_tick = 1'b1;
        else
            refr_tick = 1'b0;
            
endmodule
