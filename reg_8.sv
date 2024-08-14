module reg_8(input logic Clk, Reset, Shift_In, 
								 Load, Shift_En,
				 input logic[7:0] D,
				 output logic		 Shift_Out,
				 output logic[7:0] Data_Out);

logic[7:0] Data_Next;

//synchronous reset
always_ff @ (posedge Clk) begin
	Data_Out<=Data_Next;
end

always_comb begin
Data_Next=Data_Out;
	if(Reset)
		Data_Next=0;
	else if(Load)
		Data_Next=D;
	else if(Shift_En)
		Data_Next={Shift_In, Data_Out[7:1]};
end

assign Shift_Out=Data_Out[0];

endmodule


module reg_1(input logic Clk, Reset, Shift_In, 
								 Load, Shift_En,
				 input logic D,
				 output logic Shift_Out,
				 output logic Data_Out);

logic Data_Next;

//synchronous reset
always_ff @ (posedge Clk) begin
	Data_Out<=Data_Next;
end

always_comb begin
Data_Next=Data_Out;
	if(Reset)
		Data_Next=0;
	else if(Load)
		Data_Next=D;
	else if(Shift_En)
		Data_Next=Shift_In;
end

assign Shift_Out=Data_Out;

endmodule
