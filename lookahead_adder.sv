//needs to be converted to 4 bit adder/subtractor
//then there should eb a separate module to implement 9-bit subtraction and addition 

module lookahead_adder (
	input  [15:0] A, B,
	input         cin,
	output [15:0] S,
	output        cout
);
    /* TODO
     *
     * Insert code here to implement a CLA adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
	  
	  logic [3:0] pg0_temp, pg1_temp, pg2_temp, pg3_temp, gg0_temp, gg1_temp, gg2_temp, gg3_temp;
	  logic [3:0] c_temp;
	  logic [3:0] next_pg, next_gg;
	  
	  
	  calc_PandG FE0(.x2(A[3:0]), .y2(B[3:0]), .p(pg0_temp), .g(gg0_temp), .pg(next_pg[0]), .gg(next_gg[0]));
	  calc_PandG FE1(.x2(A[7:4]), .y2(B[7:4]), .p(pg1_temp), .g(gg1_temp), .pg(next_pg[1]), .gg(next_gg[1]));
	  calc_PandG FE2(.x2(A[11:8]), .y2(B[11:8]), .p(pg2_temp), .g(gg2_temp), .pg(next_pg[2]), .gg(next_gg[2]));
	  calc_PandG FE3(.x2(A[15:12]), .y2(B[15:12]), .p(pg3_temp), .g(gg3_temp), .pg(next_pg[3]), .gg(next_gg[3]));
	   
	  carry_lookahead_unit FC9(.p(next_pg), .g(next_gg), .cin(cin), .c_subout(c_temp));
	  
	  four_bit_adder FD0(.aa(A[3:0]), .bb(B[3:0]), .cin1(c_temp[0]), .s(S[3:0]));
	  four_bit_adder FD1(.aa(A[7:4]), .bb(B[7:4]), .cin1(c_temp[1]), .s(S[7:4]));
	  four_bit_adder FD2(.aa(A[11:8]), .bb(B[11:8]), .cin1(c_temp[2]), .s(S[11:8]));
	  four_bit_adder FD3(.aa(A[15:12]), .bb(B[15:12]), .cin1(c_temp[3]), .s(S[15:12]));
	  
	  assign cout = (A[15]&B[15]) | (B[15]&c_temp[3]) | (A[15]&c_temp[3]);
	  
endmodule

module modified_fulladder (
	input logic x1, y1, z1,
	output logic s );
	
	assign s = x1^y1^z1;
	
endmodule 

module calc_PandG ( 
	input [3:0] x2, y2,
	output [3:0] p, g,
	output 			pg, gg);
	
	assign p[0] = x2[0]^y2[0];
	assign p[1] = x2[1]^y2[1];
	assign p[2] = x2[2]^y2[2];
	assign p[3] = x2[3]^y2[3];
	
	assign g[0] = x2[0]&y2[0];
	assign g[1] = x2[1]&y2[1];
	assign g[2] = x2[2]&y2[2];
	assign g[3] = x2[3]&y2[3];
	
	assign pg = p[3]&p[2]&p[1]&p[0];
	assign gg = g[3] | (g[2]&p[3]) | (g[1]&p[2]&p[3]) | (g[0]&p[1]&p[2]&p[3]);
	
endmodule


module carry_lookahead_unit (
	input [3:0] p, g,
	input 		cin,
	output [3:0] c_subout,
	output 		 pg, gg);

	assign c_subout[0] = cin;
	assign c_subout[1] = (cin&p[0]) 	| g[0];
	assign c_subout[2] = (cin&p[0]&p[1])| (g[0]&p[1])	| g[1];
	assign c_subout[3] = (cin&p[0]&p[1]&p[2]) 	| (g[0]&p[1]&p[2]) 	| (g[1]&p[2]) | g[2];
	assign pg= p[3]&p[2]&p[1]&p[0];
	assign gg= g[3] | (g[2]&p[3]) | (g[1]&p[2]&p[3]) | (g[0]&p[1]&p[2]&p[3]);
	
endmodule 
	
	
module four_bit_adder (
	input [3:0]  aa, bb,
	input 		 cin1,
	output [3:0] s);
	
	logic [3:0] p_temp;
	logic [3:0] g_temp;
	logic [3:0] c_temp;
	
	logic pg1, gg1		;
	
	
	calc_PandG FT1(.x2(aa), .y2(bb), .p(p_temp), .g(g_temp), .pg(pg1), .gg(gg1));

	carry_lookahead_unit FC9(.p(p_temp), .g(g_temp), .cin(cin1), .c_subout(c_temp));
	
	modified_fulladder FB0(.x1(aa[0]), .y1(bb[0]), .z1(cin1), .s(s[0]));
	modified_fulladder FB1(.x1(aa[1]), .y1(bb[1]), .z1(c_temp[1]), .s(s[1]));
   modified_fulladder FB2(.x1(aa[2]), .y1(bb[2]), .z1(c_temp[2]), .s(s[2]));
	modified_fulladder FB3(.x1(aa[3]), .y1(bb[3]), .z1(c_temp[3]), .s(s[3]));
	
	
endmodule

//module lookahead_adder (
//	input  [15:0] A, B,
//	input         cin,
//	output [15:0] S,
//	output        cout
//);
//    /* TODO
//     *
//     * Insert code here to implement a CLA adder.
//     * Your code should be completly combinational (don't use always_ff or always_latch).
//     * Feel free to create sub-modules or other files. */
//	  
//	  logic [3:0] pg0_temp, pg1_temp, pg2_temp, pg3_temp, gg0_temp, gg1_temp, gg2_temp, gg3_temp;
//	  logic [3:0] c_temp;
//	  logic [3:0] next_pg, next_gg;
//	  
//	  
//	  calc_PandG FE0(.x2(A[3:0]), .y2(B[3:0]), .p(pg0_temp), .g(gg0_temp), .pg(next_pg[0]), .gg(next_gg[0]));
//	  calc_PandG FE1(.x2(A[7:4]), .y2(B[7:4]), .p(pg1_temp), .g(gg1_temp), .pg(next_pg[1]), .gg(next_gg[1]));
//	  calc_PandG FE2(.x2(A[11:8]), .y2(B[11:8]), .p(pg2_temp), .g(gg2_temp), .pg(next_pg[2]), .gg(next_gg[2]));
//	  calc_PandG FE3(.x2(A[15:12]), .y2(B[15:12]), .p(pg3_temp), .g(gg3_temp), .pg(next_pg[3]), .gg(next_gg[3]));
//	   
//	  carry_lookahead_unit FC9(.p(next_pg), .g(next_gg), .cin(cin), .c_subout(c_temp));
//	  
//	  four_bit_adder FD0(.aa(A[3:0]), .bb(B[3:0]), .cin1(c_temp[0]), .s(S[3:0]));
//	  four_bit_adder FD1(.aa(A[7:4]), .bb(B[7:4]), .cin1(c_temp[1]), .s(S[7:4]));
//	  four_bit_adder FD2(.aa(A[11:8]), .bb(B[11:8]), .cin1(c_temp[2]), .s(S[11:8]));
//	  four_bit_adder FD3(.aa(A[15:12]), .bb(B[15:12]), .cin1(c_temp[3]), .s(S[15:12]));
//	  
//	  assign cout = (A[15]&B[15]) | (B[15]&c_temp[3]) | (A[15]&c_temp[3]);
//	  
//endmodule
//
//module modified_fulladder (
//	input logic x1, y1, z1,
//	output logic s );
//	
//	assign s = x1^y1^z1;
//	
//endmodule 
//
//module calc_PandG ( 
//	input [3:0] x2, y2,
//	output [3:0] p, g,
//	output 			pg, gg);
//	
//	assign p[0] = x2[0]^y2[0];
//	assign p[1] = x2[1]^y2[1];
//	assign p[2] = x2[2]^y2[2];
//	assign p[3] = x2[3]^y2[3];
//	
//	assign g[0] = x2[0]&y2[0];
//	assign g[1] = x2[1]&y2[1];
//	assign g[2] = x2[2]&y2[2];
//	assign g[3] = x2[3]&y2[3];
//	
//	assign pg = p[3]&p[2]&p[1]&p[0];
//	assign gg = g[3] + g[2]&p[3] + g[1]&p[2]&p[3] + g[0]&p[1]&p[2]&p[3];
//	
//endmodule
//
//
//module carry_lookahead_unit (
//	input [3:0] p, g,
//	input 		cin,
//	output [3:0] c_subout,
//	output 		 pg, gg);
//
//	assign c_subout[0] = cin;
//	assign c_subout[1] = cin&p[0] 				+ g[0];
//	assign c_subout[2] = cin&p[0]&p[1] 			+ g[0]&p[1] 		+ g[1];
//	assign c_subout[3] = cin&p[0]&p[1]&p[2] 	+ g[0]&p[1]&p[2] 	+ g[1]&p[2] + g[2];
//	
//endmodule 
//	
//	
//module four_bit_adder (
//	input [3:0]  aa, bb,
//	input 		 cin1,
//	output [3:0] s);
//	
//	logic [3:0] p_temp;
//	logic [3:0] g_temp;
//	logic [3:0] c_temp;
//	
//	logic pg1, gg1		;
//	
//	
//	calc_PandG FT1(.x2(aa), .y2(bb), .p(p_temp), .g(g_temp), .pg(pg1), .gg(gg1));
//
//	carry_lookahead_unit FC9(.p(p_temp), .g(g_temp), .cin(cin1), .c_subout(c_temp));
//	
//	modified_fulladder FB0(.x1(aa[0]), .y1(bb[0]), .z1(cin1), .s(s[0]));
//	modified_fulladder FB1(.x1(aa[1]), .y1(bb[2]), .z1(c_temp[1]), .s(s[1]));
//   modified_fulladder FB2(.x1(aa[2]), .y1(bb[2]), .z1(c_temp[2]), .s(s[2]));
//	modified_fulladder FB3(.x1(aa[3]), .y1(bb[3]), .z1(c_temp[3]), .s(s[3]));
//	
//	
//endmodule

