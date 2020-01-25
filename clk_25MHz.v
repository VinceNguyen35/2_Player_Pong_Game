`timescale 1ns / 1ps

//******************************************************************//
//  File Name:  clk_25MHz.v                                         //
//                                                                  //
//  Created by Vince Nguyen on October 15th, 2019.                  //
//  Copyright © 2019 Vince Nguyen.  All rights reserved.            //
//                                                                  //
//                                                                  //
//  This file generates a 25MHz clock from the 100MHz signal of the //
//  Nexys 4 FPGA.  The module will be used for counting the pixels  //
//  in the horizontal_scan_count.v file.                            //
//******************************************************************//


module clk_25MHz(
    input       clk,
    input       rst,
    output  reg clk_out25MHz
    );
    
    reg     [1:0]   Q;
    
    always @(posedge clk, posedge rst)
        if(rst)
            Q <= 2'b0;
        else
            Q <= Q + 2'b01;
    
    always @(*)
        if(Q == 2'b11)
            clk_out25MHz = 1'b1;
        else
            clk_out25MHz = 1'b0;
            
endmodule
