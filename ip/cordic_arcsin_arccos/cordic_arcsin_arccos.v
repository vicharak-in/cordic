// =============================================================================
// Generated by efx_ipmgr
// Version: 2023.2.307
// IP Version: 5.0
// =============================================================================

////////////////////////////////////////////////////////////////////////////////
// Copyright (C) 2013-2023 Efinix Inc. All rights reserved.              
//
// This   document  contains  proprietary information  which   is        
// protected by  copyright. All rights  are reserved.  This notice       
// refers to original work by Efinix, Inc. which may be derivitive       
// of other work distributed under license of the authors.  In the       
// case of derivative work, nothing in this notice overrides the         
// original author's license agreement.  Where applicable, the           
// original license agreement is included in it's original               
// unmodified form immediately below this header.                        
//                                                                       
// WARRANTY DISCLAIMER.                                                  
//     THE  DESIGN, CODE, OR INFORMATION ARE PROVIDED “AS IS” AND        
//     EFINIX MAKES NO WARRANTIES, EXPRESS OR IMPLIED WITH               
//     RESPECT THERETO, AND EXPRESSLY DISCLAIMS ANY IMPLIED WARRANTIES,  
//     INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF          
//     MERCHANTABILITY, NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR    
//     PURPOSE.  SOME STATES DO NOT ALLOW EXCLUSIONS OF AN IMPLIED       
//     WARRANTY, SO THIS DISCLAIMER MAY NOT APPLY TO LICENSEE.           
//                                                                       
// LIMITATION OF LIABILITY.                                              
//     NOTWITHSTANDING ANYTHING TO THE CONTRARY, EXCEPT FOR BODILY       
//     INJURY, EFINIX SHALL NOT BE LIABLE WITH RESPECT TO ANY SUBJECT    
//     MATTER OF THIS AGREEMENT UNDER TORT, CONTRACT, STRICT LIABILITY   
//     OR ANY OTHER LEGAL OR EQUITABLE THEORY (I) FOR ANY INDIRECT,      
//     SPECIAL, INCIDENTAL, EXEMPLARY OR CONSEQUENTIAL DAMAGES OF ANY    
//     CHARACTER INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS OF      
//     GOODWILL, DATA OR PROFIT, WORK STOPPAGE, OR COMPUTER FAILURE OR   
//     MALFUNCTION, OR IN ANY EVENT (II) FOR ANY AMOUNT IN EXCESS, IN    
//     THE AGGREGATE, OF THE FEE PAID BY LICENSEE TO EFINIX HEREUNDER    
//     (OR, IF THE FEE HAS BEEN WAIVED, $100), EVEN IF EFINIX SHALL HAVE 
//     BEEN INFORMED OF THE POSSIBILITY OF SUCH DAMAGES.  SOME STATES DO 
//     NOT ALLOW THE EXCLUSION OR LIMITATION OF INCIDENTAL OR            
//     CONSEQUENTIAL DAMAGES, SO THIS LIMITATION AND EXCLUSION MAY NOT   
//     APPLY TO LICENSEE.                                                
//
////////////////////////////////////////////////////////////////////////////////

`define IP_UUID _cac133300f6b46cab90b77948311ec41
`define IP_NAME_CONCAT(a,b) a``b
`define IP_MODULE_NAME(name) `IP_NAME_CONCAT(name,`IP_UUID)
module cordic_arcsin_arccos (
input clk,
input reset_n,
input i_call,
input [31:0] i_data,
output o_done,
output [31:0] o_arccos,
output [31:0] o_arcsin,
output [31:0] o_deg,
output [31:0] o_y,
output [31:0] o_x
);
`IP_MODULE_NAME(efx_cordic) #(
.MODE (2)
) u_efx_cordic(
.clk ( clk ),
.reset_n ( reset_n ),
.i_call ( i_call ),
.i_data ( i_data ),
.o_done ( o_done ),
.o_arccos ( o_arccos ),
.o_arcsin ( o_arcsin ),
.o_deg ( o_deg ),
.o_y ( o_y ),
.o_x ( o_x )
);

endmodule

`timescale 1ns / 1ps

module `IP_MODULE_NAME(efx_cordic) (
    clk,
    reset_n,
    i_call,
    i_data,
    i_x,
    i_y,
    o_done,
    o_cos,
    o_sin,
    o_arccos,
    o_arcsin,
    o_arctan,
    o_cosh,
    o_sinh,
    o_tanh,
    o_exp,
    o_ln,
    o_sqrt,
    o_deg,
    o_alpha,
    o_y,
    o_x	
	
);

     parameter MODE = 1;


     //input
     input clk;
     input reset_n;
	 input i_call; 
	 input signed [31:0] i_data;
	 input signed [31:0] i_x; 
     input signed [31:0] i_y; 

	 //output
	 output o_done;
	 output signed [31:0] o_deg; //equal to o_alpha
	 output signed [31:0] o_alpha;
	 output signed [31:0] o_y;
	 output signed [31:0] o_x;
	 //MODE 1
     output signed [31:0] o_cos; 
	 output signed [31:0] o_sin;
	 //MODE 2
	 output signed [31:0] o_arccos;
	 output signed [31:0] o_arcsin;
	 //MODE 3
	 output signed [31:0] o_arctan;
	 //MODE 4
	 output signed [31:0] o_cosh;
	 output signed [31:0] o_sinh;
	 //MODE 5
	 output signed [31:0] o_tanh;
	 //MODE 6
	 output signed [31:0] o_exp;
	 //MODE 7
	 output signed [31:0] o_ln;
	 //MODE 8
	 output signed [31:0] o_sqrt;
	 
	 
	 generate
	 	 if (MODE == 1)
	 	 `IP_MODULE_NAME(sin_cos) u_sin_cos (
		   .clk(clk),
		   .reset_n(reset_n),
		   .i_call(i_call),		
		   .o_done(o_done),
		   .i_data(i_data),
		   .o_cos(o_cos),
		   .o_sin(o_sin),
		   .o_deg( o_deg ),
		   .o_y( o_y ),
		   .o_x( o_x ));
		 else if (MODE == 2)
		 `IP_MODULE_NAME(arcsin_arccos) u_arcsin_arccos (
		   .clk(clk),
		   .reset_n(reset_n),
		   .i_call(i_call),		
		   .o_done(o_done),
		   .i_data(i_data),
		   .o_arccos(o_arccos),
		   .o_arcsin(o_arcsin),
		   .o_deg( o_deg ),
		   .o_y( o_y ),
		   .o_x( o_x ));
		 else if (MODE == 3)
		 `IP_MODULE_NAME(arctan) u_arctan (
		   .clk(clk),
		   .reset_n(reset_n),
		   .i_call(i_call),
		   .i_x(i_x),
		   .i_y(i_y),
		   .o_arctan(o_arctan),
		   .o_done(o_done),
		   .o_deg( o_deg ),
		   .o_y( o_y ),
		   .o_x( o_x ));
		 else if (MODE == 4)
		 `IP_MODULE_NAME(sinh_cosh) u_sinh_cosh (
		   .clk(clk),
		   .reset_n(reset_n),
		   .i_call(i_call),
		   .i_data(i_data),
		   .o_cosh(o_cosh),
		   .o_sinh(o_sinh),
		   .o_done(o_done),
		   .o_alpha( o_alpha ),
		   .o_y( o_y ),
		   .o_x( o_x ));
		 else if (MODE == 5)
		 `IP_MODULE_NAME(tanh) u_tanh (
		   .clk(clk),
		   .reset_n(reset_n),
		   .i_call(i_call),
		   .o_done(o_done),
		   .i_data(i_data),	   
		   .o_cosh(o_cosh),
		   .o_sinh(o_sinh),
		   .o_tanh(o_tanh),
		   .o_alpha( o_alpha ),
		   .o_y( o_y ),
		   .o_x( o_x ));
		 else if (MODE == 6)
		 `IP_MODULE_NAME(exp) u_exp (
		   .clk(clk),
		   .reset_n(reset_n),
		   .i_call(i_call),
		   .o_done(o_done),
		   .i_data(i_data),
		   .o_exp(o_exp),
		   .o_alpha( o_alpha ),
		   .o_y( o_y ),
		   .o_x( o_x ));
		 else if (MODE == 7)
		 `IP_MODULE_NAME(ln) u_ln (
		   .clk(clk),
		   .reset_n(reset_n),
		   .i_call(i_call),
		   .o_done(o_done),
		   .i_data(i_data),
		   .o_ln(o_ln),
		   .o_alpha( o_alpha ),
		   .o_y( o_y ),
		   .o_x( o_x ));
		 else
		 `IP_MODULE_NAME(sqrt) u_sqrt (
		   .clk(clk),
		   .reset_n(reset_n),
		   .i_call(i_call),
		   .i_data(i_data),
		   .o_sqrt(o_sqrt),
		   .o_done(o_done),
		   .o_alpha( o_alpha ),
		   .o_y( o_y ),
		   .o_x( o_x ));
     endgenerate
     
endmodule

`timescale 1ns / 1ps

module `IP_MODULE_NAME(ln)(
	clk,
	reset_n,
	i_call,
	o_done,
	i_data,
	o_ln,
	o_alpha,
	o_y,
	o_x
);

    input clk;
    input reset_n;
	input i_call;
	input signed [31:0]i_data;   // α 
	output o_done;
	output signed [31:0]o_ln;  // o_ln(α)	 
	output signed [31:0] o_alpha;
	output signed[31:0] o_y;
	output signed [31:0] o_x;

	reg [31:0] atanh [15:0];
	 
	 initial 
	 begin  
	    atanh[0] = 32'd35999; atanh[1] = 32'd16739; atanh[2] = 32'd 8235; atanh[3] = 32'd4101;
		atanh[4] = 32'd2049; atanh[5] = 32'd1024; atanh[6] = 32'd512; atanh[7] = 32'd256; 
		atanh[8] = 32'd128; atanh[9] = 32'd64; atanh[10] = 32'd32; atanh[11] = 32'd16; 
		atanh[12] = 32'd8;  atanh[13] = 32'd4; atanh[14] = 32'd2; atanh[15] = 32'd1;
	 end
	 
	 reg signed [31:0]x,y,tx,ty,alpha;
	 reg signed [31:0]f,e;
	 reg [7:0]i,k;
	 reg isdone;
	 
	 always @ ( posedge clk or negedge reset_n )
	 if( !reset_n )
	 begin
	 	{ x,y,tx,ty,alpha } <= { 32'd0,32'd0,32'd0,32'd0,32'd0 };
	 	{ f,e } <= {32'd0,32'd0};
	 	{ i,k } <= { 8'd0,8'd0 };
	 	isdone <= 1'b0;
	 end
	 else if( i_call )
	 case( i )       
	 	0:
	 	begin 
	 	   f <= i_data; 
	 	   e <= 32'd0; 
	 	   i <= i + 1'b1; 
	 	end			 
	 	1:
	 	begin 
	 	   if( f >= 65536 ) 
	 	   begin 
	 	   	  f = f >>> 1; 
	 	   	  e = e + 1'b1; 
	 	   end
	 	   else if( f < 32768 ) 
	 	   begin 
	 	   	  f = f <<< 1; 
	 	   	  e = e - 1'b1; 
	 	   end
	 	   if( f < 32768 | f >= 65536 ) 
	 	   	  i <= i;
	 	   else 
	 	   	  i <= i + 1'b1;
	    end			 
	    2:
	 	begin 
	 	   x <= f + (1 * 65536); 
	 	   y = f - (1 * 65536); 
	 	   alpha <= 32'd0; k = 8'd0; 
	 	   i <= i + 1'b1; 
	 	end		 
	    3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18:
	 	if( y < 0 )
	 	begin
	 	   ty = y >>> i-2;
	 	   tx = x >>> i-2;
	 	   x <= x + ty;
	 	   y <= y + tx;
	 	   alpha <= alpha - atanh[i-3];			  
	 	   k = k+1'b1;
	 	   if( k == 4 ) 
	 	   begin 
	 	   	  k <= 8'd1; 
	 	   	  i <= i; 
	 	   end
	 	   else 
	 	   	  i <= i + 1'b1;
	 	end
	 	else
	 	begin
	 	   ty = y >>> i-2;
	 	   tx = x >>> i-2;
	 	   x <= x - ty ;
	 	   y <= y - tx ;
	 	   alpha <= alpha + atanh[i-3];					  
           k = k+1'b1;
	 	   if( k == 4 ) 
	 	   begin 
	 	   	  k <= 8'd1; 
	 	   	  i <= i; 
	 	   end
	 	   else 
	 	   	  i <= i + 1'b1;
	 	end
	    19:
	 	begin 
	 	   isdone <= 1'b1; 
	 	   i <= i + 1'b1; 
	 	end			
	    20:
	 	begin 
	 	   isdone <= 1'b0; 
	 	   i <= 8'd0; 
	 	end			   
	 endcase
			  
     assign o_done = isdone;
	 assign o_ln = (alpha * 2) + ( e*45426 );
     assign { o_alpha,o_y,o_x } = { alpha,y,x };
    
endmodule

`timescale 1ns / 1ps

module `IP_MODULE_NAME(sin_cos)(
    clk,
    reset_n,
    i_call,
    i_data,
    o_done,
    o_cos,
    o_sin,
    o_deg,
    o_y,
    o_x
);

     //input
     input clk;
     input reset_n;
	 input i_call; 
	 input signed [31:0] i_data;
	 
	 output o_done;
	 output signed [31:0] o_cos;
	 output signed [31:0] o_sin;	 
	 output signed [31:0] o_deg;
	 output signed [31:0] o_y;
	 output signed [31:0] o_x;
	 
	 
	 reg [31:0] atan [15:0];
	 
	 initial 
	 begin
	    atan[0] = 32'd2949120; atan[1] = 32'd1740992; atan[2] = 32'd919872; atan[3] = 32'd466944;
		atan[4] = 32'd234368; atan[5] = 32'd117312; atan[6] = 32'd58688; atan[7] = 32'd29312; 
		atan[8] = 32'd14656; atan[9] = 32'd7360; atan[10] = 32'd3648; atan[11] = 32'd1856; 
		atan[12] = 32'd896;  atan[13] = 32'd448; atan[14] = 32'd256; atan[15] = 32'd128;
	 end
	 
	 reg signed [31:0]x,y,tx,ty,deg,rcos,rsin;
	 reg [7:0]i,seg;
	 reg isdone,isnegcos,isnegsin,isswap;
	 
	 always @ ( posedge clk or negedge reset_n )
	 if( !reset_n )
	 begin
	    { x,y,tx,ty,deg,rcos,rsin } <= { 32'd0,32'd0,32'd0,32'd0,32'd0,32'd0,32'd0};
		{ i,seg } <= { 8'd0,8'd0 };
		{ isdone,isnegcos,isnegsin,isswap } <= { 1'b0,1'b0,1'b0,1'b0 };
	 end
	 else if( i_call )
	 case( i )       
  	    0:
		begin
		   seg = i_data / 90;
		   if( seg == 0 ) 
		   begin 
		   	  deg <= i_data; 
		   	  isnegcos <= 0; 
		   	  isnegsin <= 0; 
		   	  isswap <= 0; 
		   end
		   else if( seg == 1 ) 
		   begin 
		   	  deg <= i_data - 90; 
		   	  isnegcos <= 1; 
		   	  isnegsin <= 0; 
		   	  isswap <= 1; 
		   end
		   else if( seg == 2 ) 
		   begin 
		   	  deg <= i_data - 180; 
		   	  isnegcos <= 1; 
		   	  isnegsin <= 1; 
		   	  isswap <= 0; 
		   end
		   else if( seg == 3 ) 
		   begin 
		   	  deg <= i_data - 270; 
		   	  isnegcos <= 0; 
		   	  isnegsin <= 1; 
		   	  isswap <= 1;  
		   end 
		   i <= i + 1'b1;
	    end		 
		1:
		begin 
		   x <= 32'd39797; 
		   y <= 32'd0; 
		   deg <= deg << 16; 
		   i <= i + 1'b1; 
		end					 
		2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17:
		if( deg > 0 )
		begin
		   ty = y >>> i-2;
		   tx = x >>> i-2;
		   x <= x - ty;
		   y <= y + tx;
		   deg <= deg - atan[i-2];
		   i <= i + 1'b1;
		end
		else
		begin
		   ty = y >>> i-2;
		   tx = x >>> i-2;
		   x <= x + ty ;
		   y <= y - tx ;
		   deg <= deg + atan[i-2];
		   i <= i + 1'b1;
		end
		18:
		begin 
		   {rcos,rsin} <= isswap ? { y,x } : { x,y }; 
		   i <= i + 1'b1; 
		end			
		19:
		begin 
		   isdone <= 1'b1; 
		   i <= i + 1'b1; 
		end		
		20:
		begin 
		   isdone <= 1'b0; 
		   i <= 8'd0; 
		end		   
	 endcase
			  
	 assign o_done = isdone;
	 assign o_cos = isnegcos ? -(rcos) : rcos;
	 assign o_sin = isnegsin ? -(rsin) : rsin;
	 assign { o_deg,o_y,o_x } = { deg,y,x };
    
endmodule


`timescale 1ns / 1ps

module `IP_MODULE_NAME(sinh_cosh) (
	clk,
	reset_n,
	i_call,
	o_done,
	i_data,
	o_cosh,
	o_sinh,
	o_alpha,
	o_y,
	o_x
);
    input clk;
    input reset_n;
	input i_call;
	input signed [31:0] i_data;  // α < 1.13
	output signed [31:0] o_cosh;  // o_cosh（α）
	output signed [31:0] o_sinh;  // o_sinh（α）
	output o_done;
	output signed [31:0] o_alpha;
	output signed [31:0] o_y;
	output signed [31:0] o_x;
	
	reg [31:0] atanh [15:0];
	 
    initial 
    begin  
	   atanh[0] = 32'd35999; atanh[1] = 32'd16739; atanh[2] = 32'd 8235; atanh[3] = 32'd4101;
	   atanh[4] = 32'd2049; atanh[5] = 32'd1024; atanh[6] = 32'd512; atanh[7] = 32'd256; 
	   atanh[8] = 32'd128; atanh[9] = 32'd64; atanh[10] = 32'd32; atanh[11] = 32'd16; 
	   atanh[12] = 32'd8;  atanh[13] = 32'd4; atanh[14] = 32'd2; atanh[15] = 32'd1;
	end
	 
	reg signed [31:0]x,y,tx,ty,alpha;
	reg signed [31:0]w,q,r,t;
	reg [7:0]i,k;
	reg isdone,issign;
	 
	always @ ( posedge clk or negedge reset_n )
	if( !reset_n )
	begin
	   { x,y,tx,ty,alpha } <= { 32'd0,32'd0,32'd0,32'd0,32'd0 };
	   { w,q,r,t } <= { 32'd0,32'd0,32'd0 };
	   { i,k } <= { 8'd0,8'd0 };
	   { isdone,issign } <= { 1'b0,1'b0 };
    end
	else if( i_call )
	   case( i )
		  0:
		  begin 
		  	 issign <= i_data[31]; 
		  	 w <= i_data[31] ? -(i_data) : i_data; 
		  	 i <= i + 1'b1; 
		  end
					     
		  1:
		  begin		 
			 q = w / 45426; 
			 r <= w - (q * 45426); 
			 i <= i + 1'b1; 
		  end				
			    
		  2:
	      begin 
	      	 x <= 1.207534 * 65536; 
	      	 y = 0; 
	      	 alpha <= r; 
	      	 k = 8'd0; 
	      	 i <= i + 1'b1; 
	      end 
		  3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18:
		  if( alpha > 0 )
		  begin
			 ty = y >>> i-2;
			 tx = x >>> i-2;
			 x <= x + ty;
			 y <= y + tx;
			 alpha <= alpha - atanh[i-3];	  
			 k = k+1'b1;
			 if( k == 4 ) 
			 begin 
			 	k <= 8'd1; 
			 	i <= i; 
			 end
			 else 
			 	i <= i + 1'b1;
		  end
		  else
		  begin
			 ty = y >>> i-2;
			 tx = x >>> i-2;
			 x <= x - ty ;
			 y <= y - tx ;
			 alpha <= alpha + atanh[i-3];			  
             k = k+1'b1;
			 if( k == 4 ) 
			 begin 
			 	k <= 8'd1; 
			 	i <= i; 
			 end
			 else i <= i + 1'b1;
		  end		
		  19:
		  begin 
			 t = (x - y) >>> (q<<<1);
			 x <= q ? ( x + y + t) <<< (q-1) : ( x + y + t) >>> 1;
			 y <= q ? ( x + y - t) <<< (q-1) : ( x + y - t) >>> 1;
			 i <= i + 1'b1;
		  end				 
		  20:
		  begin 
		  	 isdone <= 1'b1; 
		  	 i <= i + 1'b1; 
		  end
		  21:
		  begin 
		  	 isdone <= 1'b0; 
		  	 i <= 8'd0; 
		  end
					   
		endcase
			  
		assign o_done = isdone;
		assign o_cosh = x;
		assign o_sinh = issign ? -(y) : y;
		assign { o_alpha,o_y,o_x } = { alpha,y,x };
    
endmodule

`timescale 1ns / 1ps

module `IP_MODULE_NAME(sqrt)(
	clk,
	reset_n,
	i_call,
	o_done,
	i_data,
	o_sqrt,
	o_alpha,
	o_y,
	o_x
);

    input clk;
    input reset_n;
	input i_call;
	input signed [31:0] i_data;// α
	output o_done;    
	output signed [31:0] o_sqrt;  // o_sqrt(α)
	output signed [31:0] o_alpha;
    output signed [31:0] o_y;
    output signed [31:0] o_x;
	
    reg [31:0] atanh [15:0];
	 
	initial 
	begin  
	   atanh[0] = 32'd35999; atanh[1] = 32'd16739; atanh[2] = 32'd 8235; atanh[3] = 32'd4101;
	   atanh[4] = 32'd2049; atanh[5] = 32'd1024; atanh[6] = 32'd512; atanh[7] = 32'd256; 
	   atanh[8] = 32'd128; atanh[9] = 32'd64; atanh[10] = 32'd32; atanh[11] = 32'd16; 
	   atanh[12] = 32'd8;  atanh[13] = 32'd4; atanh[14] = 32'd2; atanh[15] = 32'd1;
    end
	 
	reg signed [31:0]x,y,tx,ty,alpha;
	reg signed [31:0]f,e;
	reg [7:0]i,k;
	reg isdone,issign;
	 
	always @ ( posedge clk or negedge reset_n )
	if( !reset_n )
	begin
	   { x,y,tx,ty,alpha } <= { 32'd0,32'd0,32'd0,32'd0,32'd0 };
	   { f,e } <= {32'd0,32'd0};
	   { i,k } <= { 8'd0,8'd0 };
	   { isdone,issign } <= { 1'b0,1'b0 };
    end
	else if( i_call )
	case( i )	       
	   0:
	   begin 
	   	  f <= i_data; 
	   	  e <= 32'd0; 
	   	  i <= i + 1'b1; 
	   end			 
	   1:
	   begin 
		  if( f >= 65536 ) 
		  begin 
		  	 f = f >>> 1; 
		  	 e = e + 1'b1; 
		  end
		  else if( f < 32768 ) 
		  begin 
		  	 f = f <<< 1; 
		  	 e = e - 1'b1; 
		  end				
		  if( f < 32768 | f >= 65536 ) 
		  	 i <= i;
		  else 
		  	 i <= i + 1'b1;
	   end
					 
	   2:
	   begin 
	   	  f <= e[0] == 1 ? f >>> 1 : f; 
	   	  i <= i + 1'b1; 
	   end			 
	   3:
	   begin 
	   	  x <= f + 16384; 
	   	  y <= f - 16384; 
	   	  alpha <= 32'd0; 
	   	  k <= 8'd0; 
	   	  i <= i + 1'b1; 
	   end			 
	   4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19:
	   if( y < 0 )
	   begin
		  ty = y >>> i-3;
		  tx = x >>> i-3;
		  x <= x + ty;
		  y <= y + tx;
		  alpha <= alpha - atanh[i-4];		  
		  k = k+1'b1;
		  if( k == 4 ) 
		  begin 
		  	 k <= 8'd1; 
		  	 i <= i; 
		  end
		  else 
		  	 i <= i + 1'b1;
	   end
	   else
	   begin
		  ty = y >>> i-3;
		  tx = x >>> i-3;
		  x <= x - ty ;
	      y <= y - tx ;
		  alpha <= alpha + atanh[i-4];				  
          k = k+1'b1;
		  if( k == 4 ) 
		  begin 
		  	 k <= 8'd1; 
		  	 i <= i; 
		  end
		  else 
		  	 i <= i + 1'b1;
	   end
	   20: // x * 1.207534
	   begin 
	   	  alpha <= (x*79137) >> 16; 
	   	  i <= i + 1'b1; 
	   end			
       21:
       begin 
       	  e <= e[0] ? (e+1) >>> 1 : e >>> 1; 
       	  i <= i + 1'b1; 
       end 								
	   22:
	   begin 
	   	  issign <= e[31]; 
	   	  e <= e[31] ? -(e) : e; 
	   	  i <= i + 1'b1; 
	   end			
	   23:
	   begin 
	   	  isdone <= 1'b1; 
	   	  i <= i + 1'b1; 
	   end			
	   24:
	   begin 
	   	  isdone <= 1'b0; 
	   	  i <= 8'd0; 
	   end
					   
	endcase
			  
	assign o_done = isdone;
	assign o_sqrt =  issign ? ( alpha >>> e ) : ( alpha <<< e );
	assign { o_alpha,o_y,o_x } = { alpha,y,x };
    
endmodule

module `IP_MODULE_NAME(tanh) (
    clk,
    reset_n,
    i_call,
    o_done,
	i_data,
	o_cosh,
	o_sinh,
	o_tanh,
	o_alpha,
	o_y,
	o_x
);
     input clk;
     input reset_n;
	 input i_call; 
	 input signed [31:0] i_data;  // α < 1.13
	 
	 output o_done;
	 output signed [31:0] o_cosh;  // o_cosh（α）
	 output signed [31:0] o_sinh;  // o_sinh（α）
	 output signed [31:0] o_tanh;  // o_tanh（α）	 
	 output signed [31:0] o_alpha;
	 output signed [31:0] o_y;
	 output signed [31:0] o_x;
	 
	 reg [31:0] atanh [15:0];
	 
	 initial 
	 begin  
	    atanh[0] = 32'd35999; atanh[1] = 32'd16739; atanh[2] = 32'd 8235; atanh[3] = 32'd4101;
		atanh[4] = 32'd2049; atanh[5] = 32'd1024; atanh[6] = 32'd512; atanh[7] = 32'd256; 
		atanh[8] = 32'd128; atanh[9] = 32'd64; atanh[10] = 32'd32; atanh[11] = 32'd16; 
		atanh[12] = 32'd8;  atanh[13] = 32'd4; atanh[14] = 32'd2; atanh[15] = 32'd1;
	 end
	 
	 reg signed [31:0]x,y,tx,ty,alpha,t;
	 reg [7:0]i,k;
	 reg isdone;
	 
	 always @ ( posedge clk or negedge reset_n )
	 if( !reset_n )
	 begin
	 	{ x,y,tx,ty,alpha,t } <= { 32'd0,32'd0,32'd0,32'd0,32'd0,32'd0 };
	 	{ i,k } <= { 8'd0,8'd0 };
	 	isdone <= 1'b0;
	 end
	 else if( i_call )
	 case( i )	  
	    0:
		begin 
		   x <= 1.207534 * 65536; 
		   y = 0; 
		   alpha <= i_data; 
		   k = 8'd0; 
		   i <= i + 1'b1; 
		end 
		1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16:
		if( alpha > 0 )
		begin
		   ty = y >>> i;
		   tx = x >>> i;
		   x <= x + ty;
		   y <= y + tx;
		   alpha <= alpha - atanh[i-1];			  
		   k = k+1'b1;
		   if( k == 4 ) 
		   begin 
		   	  k <= 8'd1; 
		   	  i <= i; 
		   end
		   else 
		   	  i <= i + 1'b1;
	    end
		else
		begin
		   ty = y >>> i;
		   tx = x >>> i;
		   x <= x - ty ;
		   y <= y - tx ;
		   alpha <= alpha + atanh[i-1];		  
           k = k+1'b1;
		   if( k == 4 ) 
		   begin 
		   	  k <= 8'd1; 
		   	  i <= i; 
		   end
		   else 
		   	  i <= i + 1'b1;
		end			
	    17:
	    begin 
	       tx <= x; 
	       ty <= y; 
	       alpha <= 32'd0;  
	       t <= 1 * 65536; 
	       i <= i + 1'b1; 
	    end			 
		18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33:
	    if( ty < 0 )
		begin
		   ty <= ty + ( tx >>> i-18 );
		   alpha <= alpha - t;
		   t <= t / 2;
		   i <= i + 1'b1;
		end
		else
		begin
		   ty <= ty - ( tx >>> i-18 );
		   alpha <= alpha + t;
		   t <= t / 2;
		   i <= i + 1'b1;
	    end			
		34:
	    begin 
	       isdone <= 1'b1; 
	       i <= i + 1'b1; 
	    end			
	    35:
	    begin 
	       isdone <= 1'b0; 
	       i <= 8'd0; 
	    end	   
	 endcase
			  
	 assign o_done = isdone;
	 assign o_cosh = x;
	 assign o_sinh = y;
	 assign o_tanh = alpha;
	 assign { o_alpha,o_y,o_x } = { alpha,y,x };
    
endmodule

`timescale 1ns / 1ps

module `IP_MODULE_NAME(arcsin_arccos) (
    clk,
    reset_n,
    i_call,
    i_data,
    o_done,
    o_arccos,
    o_arcsin,
    o_deg,
    o_y,
    o_x
);
     input clk;
     input reset_n;
	 input i_call;
	 input signed [31:0] i_data;
	 
	 
	 output o_done;
	 output signed [31:0] o_arcsin;
	 output signed [31:0] o_arccos;
	 output signed [31:0] o_deg;
	 output signed [31:0] o_y;
	 output signed [31:0] o_x;
	 
	 reg [31:0] atan [15:0];
	 
	 initial 
	 begin
	    atan[0] = 32'd2949120; atan[1] = 32'd1740992; atan[2] = 32'd919872; atan[3] = 32'd466944;
	 	atan[4] = 32'd234368; atan[5] = 32'd117312; atan[6] = 32'd58688; atan[7] = 32'd29312; 
	 	atan[8] = 32'd14656; atan[9] = 32'd7360; atan[10] = 32'd3648; atan[11] = 32'd1856; 
	 	atan[12] = 32'd896;  atan[13] = 32'd448; atan[14] = 32'd256; atan[15] = 32'd128;
	 end
	 
	 reg signed [31:0]x,y,tx,ty,deg,gamma;
	 reg [7:0]i,k;
	 reg isdone,sigma;
	 
	 always @ ( posedge clk or negedge reset_n )
	     if( !reset_n )
		 begin
			{ x,y,tx,ty,deg,gamma } <= { 32'd0,32'd0,32'd0,32'd0,32'd0,32'd0 };
			{ i,k } <= { 8'd0,8'd0 };
			{ isdone,sigma } <= { 1'b0,1'b0 };
		 end
		 else if( i_call )
		 case( i )
			0:
			begin 
			   x <= 1 << 16; 
			   y = 32'd0; 
			   deg <= 32'd0; 
			   k <= 1'b0; 
			   gamma <= i_data; 
			   i <= i + 1'b1; 
			end
			1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16:
			begin
			   sigma = !k ? (y < 0)^(gamma < x) : sigma;
			   gamma = !k ? gamma + ((gamma >>> i-1) >>> i-1) : gamma;			
		       if( sigma )
			   begin
			   	  ty = y >>> i-1;
				  tx = x >>> i-1;
				  x <= x - ty;
				  y <= y + tx;
				  deg <= deg + atan[i-1];
			   end
			   else
			   begin
				  ty = y >>> i-1;
				  tx = x >>> i-1;
				  x <= x + ty ;
				  y <= y - tx ;
				  deg <= deg - atan[i-1];
			   end		 
			   if( k == 0 ) 
			   begin 
			   	  k <= 1'b1; 
			   	  i <= i; 
			   end
			   else 
			   begin 
			   	  k <= 1'b0; 
			   	  i <= i + 1'b1; 
			   end
		    end		
		    17:
			begin 
			   isdone <= 1'b1; 
			   i <= i + 1'b1; 
			end
		    18:
			begin 
			   isdone <= 1'b0; 
			   i <= 8'd0; 
			end
	     endcase
			  
		 assign o_done = isdone;
		 assign o_arcsin = 5898240 - deg;
		 assign o_arccos = deg;
		 assign { o_deg,o_y,o_x } = { deg,y,x };
    
endmodule

`timescale 1ns / 1ps

module `IP_MODULE_NAME(arctan) (
    clk,
	reset_n,
	i_call,
	o_done,
	i_x,
	i_y,
	o_arctan,
	o_deg,
	o_y,
	o_x
);
    input clk;
    input reset_n;
    input i_call;
    input signed [31:0] i_x;
    input signed [31:0] i_y;
    
	output o_done;
	output signed [31:0] o_arctan;
	output signed [31:0] o_deg;
    output signed [31:0] o_y;
	output signed [31:0] o_x;
	 
	reg [31:0] atan [15:0];
	 
	initial 
    begin
	   atan[0] = 32'd2949120; atan[1] = 32'd1740992; atan[2] = 32'd919872; atan[3] = 32'd466944;
	   atan[4] = 32'd234368; atan[5] = 32'd117312; atan[6] = 32'd58688; atan[7] = 32'd29312; 
	   atan[8] = 32'd14656; atan[9] = 32'd7360; atan[10] = 32'd3648; atan[11] = 32'd1856; 
	   atan[12] = 32'd896;  atan[13] = 32'd448; atan[14] = 32'd256; atan[15] = 32'd128;
    end
	 
	reg signed [31:0]x,y,tx,ty,deg;
	reg [7:0]i;
	reg isdone;
	 
	 always @ ( posedge clk or negedge reset_n )
	     if( !reset_n )
		 begin
		    { x,y,tx,ty,deg } <= { 32'd0,32'd0,32'd0,32'd0,32'd0 };
		    i <= 8'd0;
		    isdone <= 1'b0;
	     end
		 else if( i_call )
		 case( i )		  
			0:
			begin 
			   if (i_x >= 0)
			   begin
			   	   x <= i_x; 
			   	   y <= i_y; 
			   	   deg <= 32'd0;
			   end
			   else if(i_y >= 0)
			   begin
			   	   x <= i_y; 
			   	   y <= -i_x; 
			   	   deg <= 32'd5898240;
			   end
			   else
			   begin
			   	   x <= -i_y; 
			   	   y <= i_x; 
			   	   deg <= -32'd5898240;
			   end 
			   i <= i + 1'b1; 
		    end		 
			1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16:
		    if( y > 0 )
		    begin
			   ty = y >>> i-1;
			   tx = x >>> i-1;
			   x <= x + ty;
			   y <= y - tx;
			   deg <= deg + atan[i-1];
			   i <= i + 1'b1;
			end
		    else
			begin
			   ty = y >>> i-1;
			   tx = x >>> i-1;
			   x <= x - ty ;
			   y <= y + tx ;
			   deg <= deg - atan[i-1];
			   i <= i + 1'b1;
		    end		
		    17:
			begin 
			   isdone <= 1'b1; 
			   i <= i + 1'b1; 
			end			
			18:
			begin 
			   isdone <= 1'b0; 
			   i <= 8'd0; 
			end		   
		 endcase
			  
		assign o_done = isdone;
		assign o_arctan = deg ;
		assign { o_deg,o_y,o_x } = { deg,y,x };
    
endmodule


`timescale 1ns / 1ps

module `IP_MODULE_NAME(exp)(
	clk,
	reset_n,
	i_call,
	o_done,
	i_data,
	o_exp,
	o_alpha,
	o_y,
	o_x
);
    input clk;
    input reset_n;
	input i_call;
	input signed [31:0]i_data;  // α 
	output o_done;
	output signed [31:0]o_exp;  // o_exp（α）
	output signed [31:0]o_alpha;
	output signed [31:0]o_y;
	output signed [31:0]o_x;
	
	reg [31:0] atanh [15:0];
	 
	 initial 
	 begin  
	    atanh[0] = 32'd35999; atanh[1] = 32'd16739; atanh[2] = 32'd 8235; atanh[3] = 32'd4101;
		atanh[4] = 32'd2049; atanh[5] = 32'd1024; atanh[6] = 32'd512; atanh[7] = 32'd256; 
		atanh[8] = 32'd128; atanh[9] = 32'd64; atanh[10] = 32'd32; atanh[11] = 32'd16; 
		atanh[12] = 32'd8;  atanh[13] = 32'd4; atanh[14] = 32'd2; atanh[15] = 32'd1;
	 end
	 
	 reg signed [31:0]x,y,tx,ty,alpha;
	 reg signed [31:0]w,q,r;
	 reg [7:0]i,k;
	 reg isdone,issign;
	 
	 always @ ( posedge clk or negedge reset_n )
	 if( !reset_n )
	 begin
		{ x,y,tx,ty,alpha } <= { 32'd0,32'd0,32'd0,32'd0,32'd0 };
		{ w,q,r } <= { 32'd0,32'd0,32'd0 };
		{ i,k } <= { 8'd0,8'd0 };
		{ isdone,issign } <= {1'b0,1'b0};
     end
	 else if( i_call )
	 case( i )      
		0:
		begin 
		   issign <= i_data[31];  
		   w <= i_data[31] ? -(i_data) : i_data; i <= i+ 1'b1; 
		end		 
	    1:
        begin 
           q = w / 45426; 
           r <= w - (q*45426); 
           i <= i + 1'b1; 
        end	  
		2:
		begin 
		   x <= 1.207534 * 65536; 
		   y = 0; 
		   alpha <= issign ? -(r):r; k = 8'd0; 
		   i <= i + 1'b1; 
		end			 
		3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18:
		if( alpha > 0 )
		begin
		   ty = y >>> i-2;
		   tx = x >>> i-2;
		   x <= x + ty;
		   y <= y + tx;
		   alpha <= alpha - atanh[i-3];			  
		   k = k+1'b1;
		   if( k == 4 ) 
		   begin 
		   	  k <= 8'd1; i <= i; 
		   end
           else 
           	  i <= i + 1'b1;
	    end
		else
		begin
		   ty = y >>> i-2;
		   tx = x >>> i-2;
		   x <= x - ty ;
		   y <= y - tx ;
		   alpha <= alpha + atanh[i-3];		  
           k = k+1'b1;
		   if( k == 4 ) 
		   begin 
		   	  k <= 8'd1; 
		   	  i <= i; 
		   end
		   else 
		   	  i <= i + 1'b1;
		end			
		19:
		begin 
		   isdone <= 1'b1; 
		   i <= i + 1'b1; 
		end		
		20:
		begin 
		   isdone <= 1'b0; 
		   i <= 8'd0; 
		end			   
	 endcase
			  
	 assign o_done = isdone;
	 assign o_exp = issign ? (x+y) >>> q : (x+y) <<< q;
	 assign { o_alpha,o_y,o_x } = { alpha,y,x };
    
endmodule
`undef IP_UUID
`undef IP_NAME_CONCAT
`undef IP_MODULE_NAME
