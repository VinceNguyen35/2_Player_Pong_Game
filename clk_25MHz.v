`timescale 1ns / 1ps

//******************************************************************//
//  File Name:  clk_25MHz.v                                         //
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
