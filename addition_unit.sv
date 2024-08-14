module addition_unit(input[7:0] A,B,
							input cin,
							output[8:0] S,
							output cout);

logic cout0, cout1, cout2, cout3, cout4, cout5, cout6, cout7;


full_adder FA0(.x(A[0]), .y(B[0]), .z(cin), .s(S[0]), .c(cout0));
full_adder FA1(.x(A[1]), .y(B[1]), .z(cout0), .s(S[1]), .c(cout1));
full_adder FA2(.x(A[2]), .y(B[2]), .z(cout1), .s(S[2]), .c(cout2));
full_adder FA3(.x(A[3]), .y(B[3]), .z(cout2), .s(S[3]), .c(cout3));
full_adder FA4(.x(A[4]), .y(B[4]), .z(cout3), .s(S[4]), .c(cout4));
full_adder FA5(.x(A[5]), .y(B[5]), .z(cout4), .s(S[5]), .c(cout5));
full_adder FA6(.x(A[6]), .y(B[6]), .z(cout5), .s(S[6]), .c(cout6));
full_adder FA7(.x(A[7]), .y(B[7]), .z(cout6), .s(S[7]), .c(cout7));

full_adder FA8(.x(A[7]), .y(B[7]), .z(cout7), .s(S[8]), .c(cout));

endmodule

module add_sub(input[7:0] A,B,
							input cin, Sub_En, Add_En,
							output[8:0] S,
							output cout);
logic[7:0] invert;
logic cin_new;
logic [7:0] orig_S;

addition_unit sub(.A(A), .B(invert), .cin(cin_new), .S(S), .cout(cout));

always_comb begin
	if(Sub_En) begin
		invert= ~B;
		cin_new = 1'b1;
	end else begin
		invert= B;
		cin_new = 1'b0;
	end
end



							
endmodule
