module testbench();

timeunit 10ns;
timeprecision 1ns;


logic Clk;
logic Reset,Execute;
logic [7:0] SW;
logic [6:0] AhexL, AhexU, BhexL, BhexU;
logic [7:0] Aval,Bval;
logic Xval;
logic [16:0] XAB;
//must set the inputs manually
multiply mult0(.SW(SW),.Clk(Clk), .Reset_Load_Clear(Reset), .Run(Execute), .HEX0(AhexL), .HEX1(AhexU), .HEX2(BhexL), .HEX3(BhexU), .Aval(Aval), .Bval(Bval), .Xval(Xval));

assign XAB={Xval, Aval, Bval};


// Toggle the clock
// #1 means wait for a delay of 1 timeunit
always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end

initial begin: CLOCK_INITIALIZATION
    Clk = 0;
end 


initial begin: TEST_VECTORS
//reset run start low
Reset = 1'b0;
SW = 8'b11000101;
Execute = 1'b1;


#2

Reset= 1'b1;
SW = 8'h7;
Execute = 1'b0;



//
////next case
//Reset = 1'b0;
//Execute = 1'b1;
//
//#2
//
//Execute = 1'b1;
//SW = 8'b10011000;
//Reset = 1'b0;
//
//#2
//
//Execute = 1'b1;
//
//#2
//
//Execute = 1'b0;
//
//#2
//
//Execute = 1'b1;
//
//
////next case
//Reset = 1'b0;
//Execute = 1'b1;
//
//#2
//
//Reset = 1'b1;
//SW = 8'b11111000;
//Execute = 1'b0;
//
//#2
//
//Execute = 1'b1;
//
//#2
//
//Execute = 1'b0;
//
//#2
//
//Execute = 1'b1;
//
////next case
//Reset = 1'b0;
//Execute= 1'b1;
//
//#2
//
//Reset = 1'b1;
//SW = 8'b10111001;
//Execute = 1'b0;
//
//#2
//
//Execute = 1'b1;
//
//#2
//
//Execute = 1'b0;
//
//#2
//
//Execute = 1'b1;



end

endmodule
