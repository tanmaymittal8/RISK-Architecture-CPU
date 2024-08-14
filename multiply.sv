//Top level for ECE 385 adders lab
//modified for Spring 2023

//Note: lowest 2 HEX digits will reflect lower 8 bits of switch input
//Upper 4 HEX digits will reflect value in the accumulator
//Top level for ECE 385 adders lab
//modified for Spring 2023

//Note: lowest 2 HEX digits will reflect lower 8 bits of switch input
//Upper 4 HEX digits will reflect value in the accumulator


module multiply (input logic [7:0] SW,
					  input logic Clk, Reset_Load_Clear, Run,
					  output logic [6:0] HEX0,HEX1,HEX2,HEX3,
					  output logic [7:0] Aval, Bval,LED,
					  output logic Xval);

		//local logic variables go here
		//synchronizer execute and reset
		logic Reset_SH, Execute_SH;
		
		//asynchronous execute and reset
		logic Reset_h, Run_h;
		
		//enables
		logic Add_En, Sub_En, Shift_En;
		
		//x data input
		logic x;
		
		
		//bits that will be inputted into registers
		logic [7:0] A, B;
		assign B=SW;
		//assign A=8'b0;
		//assign B=8'b11000101;
		//assign SW=8'b00000111;
		always_comb	
		begin
				Reset_h = ~Reset_Load_Clear;
				Run_h = ~Run;

		end
	
	 //synchronizer loads
	 logic LoadA, LoadB;// LoadA_SH, LoadB_SH;
	 
	 
	 logic [2:0] F_S;
	 logic [1:0] R_S;
	 logic Ld_A, Ld_B, Ld_X, newA, newB, opA, opB, bitA, bitB, F_A_B;
	 logic [3:0]  Din, Din_S;
	 
	 assign Ld_X=1'b1;
	 
	 logic reg_out_A, reg_out_B, reg_out_X, adder_cout, reg_shift_out_A, reg_shift_out_B, reg_shift_out_X;
	 logic reg_shift_in_X;
	 logic [8:0] S_out;
	
	 
	 
	 //We can use the "assign" statement to do simple combinational logic
//	 assign Aval = A;
//	 assign Bval = B;
//	 assign LED = {Execute_SH,LoadA_SH,LoadB_SH,Reset_SH}; //Concatenate is a common operation in HDL
	 
	 //Note that you can hardwire F and R here with 'assign'. What to assign them to? Check the demo points!
	 //Remember that when you comment out the ports above, you will need to define F and R as variables
	 //uncomment the following lines when you hardwaire F and R (This was the solution to the problem during Q/A)
	 //logic [2:0] F;
	 //logic [1:0] R;
	 //assign F = something;
	 //assign R = something;
	 

	 
	 //Instantiation of modules here
	 
	 reg_8 A_reg(.Clk(Clk), .Reset(~Reset_Load_Clear), .Shift_In(reg_shift_out_X), .Load(Add_En|Sub_En), .Shift_En(Shift_En), .D(S_out), .Shift_Out(reg_shift_out_A), .Data_Out(Aval)); //aval here or adder
	 reg_8 B_reg(.Clk(Clk), .Reset(1'b0), .Shift_In(reg_shift_out_A), .Load(~Reset_Load_Clear), .Shift_En(Shift_En), .D(SW), .Shift_Out(reg_shift_out_B), .Data_Out(Bval));
	
	
	//what to add for D?
    reg_1 X(.Clk(Clk), .Reset(Reset_h), .Shift_In(S_out[8]), .Load(Add_En|Sub_En), .Shift_En(Shift_En), 
				.D(S_out[8]), .Shift_Out(reg_shift_out_X), .Data_Out(Xval)); 
	 
	 add_sub adder(.A(Aval), .B(SW), .cin(1'b0), .Sub_En(Sub_En), .Add_En(Add_En), .S(S_out), 
						.cout(adder_cout));   //aval here or register
	 
	 
	 control control_unit(.Clk(Clk), .Reset(Reset_h), .Execute(Run_h), .M(reg_shift_out_B), 
								.Shift_En(Shift_En), .Add_En(Add_En), .Sub_En(Sub_En));
	 
	 HexDriver        HexAL (
                        .In0(A[3:0]),
                        .Out0(HEX2) );
	 HexDriver        HexAU (
                        .In0(A[7:4]),
                        .Out0(HEX3) );
								
//	HexDriver        HexAH (
//                        .In0(A[7:4]),
//                        .Out0(AhexL) );
//	 HexDriver        HexBH (
//                        .In0(B[7:4]),
//                        .Out0(BhexL) );
								
								
	 //When you extend to 8-bits, you will need more HEX drivers to view upper nibble of registers, for now set to 0
	 HexDriver        HexBL (
                        .In0(B[3:0]),
                        .Out0(HEX0));	
	 HexDriver        HexBU (
                       .In0(B[7:4]),
                        .Out0(HEX1));
								
	  //Input synchronizers required for asynchronous inputs (in this case, from the switches)
	  //These are array module instantiations
	  //Note: S stands for SYNCHRONIZED, H stands for active HIGH
	  //Note: We can invert the levels inside the port assignments
//	  sync button_sync[3:0] (Clk, {~Reset_Load_Clear, LoadA, LoadB, ~Run}, {Reset_SH, LoadA_SH, LoadB_SH, Execute_SH});
//	  sync Din_sync[3:0] (Clk, Din, Din_S);
//	  sync F_sync[2:0] (Clk, F, F_S);
//	  sync R_sync[1:0] (Clk, R, R_S);
	  
endmodule
