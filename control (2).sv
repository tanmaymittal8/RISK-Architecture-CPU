//simple state machine to convert a switch input to one clock cycle long event
//similar to the hold->reset portion of the serial logic processor


//Two-always example for state machine

module control (input  logic Clk, Reset, Execute, M, 
					  input logic LoadA, LoadB, LoadS
                output logic Shift_En, Add_En, Sub_En,
					output logic Ld_A, Ld_B );

    // Declare signals curr_state, next_state of type enum
    // with enum values of A, B, ..., F as the state values
	 // Note that the length implies a max of 8 states, so you will need to bump this up for 8-bits
    enum logic [3:0] {Start, Shift1, Shift2, Shift3, Shift4, Shift5, Shift6, Shift7, Last_Shift, Halt}   curr_state, next_state; 
	 logic load_A, load_B, X;

	//updates flip flop, current state is the only one
    always_ff @ (posedge Clk)  
    begin
        if (Reset)
            curr_state <= Start;
        else 
            curr_state <= next_state;
    end

    // Assign outputs based on state
	always_comb
    begin
        
		  next_state  = curr_state;	//required because I haven't enumerated all possibilities below
        unique case (curr_state) 

            Start :    if (Execute) begin
									if(M==1'b0) 
										next_state = Shift1;
									else if(M==1'b1)
										next_state = Add1;
							  end
				Add1: 		next_state=Shift1;
            Shift1 :    if(M==1'b0) 
										next_state = Shift2;
									else if(M==1'b1)
										next_state = Add2;
				Add2: 		next_state=Shift2;
				
				Shift2 :    if(M==1'b0) 
										next_state = Shift3;
									else if(M==1'b1)
										next_state = Add3;
				Add3: 		next_state=Shift3;
				
           
				Shift3 :    if(M==1'b0) 
										next_state = Shift4;
									else if(M==1'b1)
										next_state = Add4;
				Add4: 		next_state=Shift4;
            
				Shift4 :    if(M==1'b0) 
										next_state = Shift5;
									else if(M==1'b1)
										next_state = Add5;
				Add5: 		next_state=Shift5;
				
				Shift5 :    if(M==1'b0) 
										next_state = Shift6;
									else if(M==1'b1)
										next_state = Add6;
				Add6: 		next_state=Shift6;
				
				
				Shift6 :    if(M==1'b0) 
										next_state = Shift7;
									else if(M==1'b1)
										next_state = Add7;
				Add7: 		next_state=Shift7;
				
            Shift7 :    if(M==1'b0) 
										next_state = Last_Shift;
									else if(M==1'b1)
										next_state = Sub;
				Sub: 		next_state=Last_Shift;
            Last_Shift :    next_state = Halt;
            Halt :    if (Execute) 
                       next_state = Start;
							  else
								next_state=Halt;
							  
        endcase
   
		  // Assign outputs based on ‘state’
        case (curr_state) 
	   	   Start: 
	         begin
//					 temp_loadA=LoadA;
//				   	temp_loadB=LoadB;
                Ld_A = 1'b0;
                Ld_B = 1'b1;
                Shift_En = 1'b0;
					 Sub_En=1'b0;
					 Add_En=1'b0;
		      end
//								assign B = {A[0],B[7:1]}
//				//Add1				
				
				//d1, Add2, Add3...:
					Add_En=1'b1;
					Shift_En=1'b0;
					Sub_En=1'b0;
					Ld_A = LoadA;
               Ld_B = LoadB;

				//shift 1
				Shift1:
				begin
					Sub_En=1'b0;
					Add_En=1'b0;
//					if(M==1'b1)
//						Add_En=1'b1;	
//					else
//						Add_En=1'b0;			
					Shift_En=1'b1;
//					temp_loadA={temp_loadA[7], temp_loadA[7:1]};
//					temp_loadB={temp_loadA[0], temp_loadB[7:1]};
					Ld_A=LoadA;
					Ld_B=LoadB;
				end
				
				Add2:
					Add_En=1'b1;
					Shift_En=1'b0;
					Sub_En=1'b0;
					Ld_A = LoadA;
               Ld_B = LoadB;
				
				//shift 2
				Shift2:
				begin
					Sub_En=1'b0;
//					if(M==1'b1)
//						Add_En=1'b1;	
//					else
//						Add_En=1'b0;
						
					Add_En=1'b0;
					Shift_En=1'b1;
//					temp_loadA={temp_loadA[7], temp_loadA[7:1]};
//					temp_loadB={temp_loadA[0], temp_loadB[7:1]};
					Ld_A=LoadA;
					Ld_B=LoadB;
				end
				
				Add3:
					Add_En=1'b1;
					Shift_En=1'b0;
					Sub_En=1'b0;
					Ld_A = LoadA;
               Ld_B = LoadB;
					
				//shift 3
				Shift3:
				begin
					Sub_En=1'b0;
					Add_En=1'b0;
//					if(M==1'b1)
//						Add_En=1'b1;	
//					else
//						Add_En=1'b0;
						
					Shift_En=1'b1;
//					temp_loadA={temp_loadA[7], temp_loadA[7:1]};
//					temp_loadB={temp_loadA[0], temp_loadB[7:1]};
					Ld_A=temp_loadA;
					Ld_B=temp_loadB;
				end
				
				Add4:
					Add_En=1'b1;
					Shift_En=1'b0;
					Sub_En=1'b0;
					Ld_A = LoadA;
               Ld_B = LoadB;
					
				//shift 4
				Shift4:
				begin
					Sub_En=1'b0;
//					if(M==1'b1)
//						Add_En=1'b1;	
//					else
//						Add_En=1'b0;
//					
					Add_En=1'b0;
					Shift_En=1'b1;
//					temp_loadA={temp_loadA[7], temp_loadA[7:1]};
//					temp_loadB={temp_loadA[0], temp_loadB[7:1]};
					Ld_A=temp_loadA;
					Ld_B=temp_loadB;
				end
				
				Add5:
					Add_En=1'b1;
					Shift_En=1'b0;
					Sub_En=1'b0;
					Ld_A = LoadA;
               Ld_B = LoadB;
					
				//shift 5
				Shift5:
				begin
					Sub_En=1'b0;
//					if(M==1'b1)
//						Add_En=1'b1;	
//					else
//						Add_En=1'b0;
						
					Shift_En=1'b1;
//					temp_loadA={temp_X, temp_loadA[7:1]};
//					temp_loadB={temp_loadA[0], temp_loadB[7:1]};
					Ld_A=temp_loadA;
					Ld_B=temp_loadB;
				end
				
				Add6
					Add_En=1'b1;
					Shift_En=1'b0;
					Sub_En=1'b0;
					Ld_A = LoadA;
               Ld_B = LoadB;
					
				//shift 6
				Shift6:
				begin
					Sub_En=1'b0;
//					if(M==1'b1)
//						Add_En=1'b1;	
//					else
//						Add_En=1'b0;	
					Add_En=1'b1;
					Shift_En=1'b1;
//					temp_loadA={temp_X, temp_loadA[7:1]};
//					temp_loadB={temp_loadA[0], temp_loadB[7:1]};
					Ld_A=temp_loadA;
					Ld_B=temp_loadB;
				end
				
				Add7:
					Add_En=1'b1;
					Shift_En=1'b0;
					Sub_En=1'b0;
					Ld_A = LoadA;
               Ld_B = LoadB;
	   	   //shift 7
				
				Shift7:
				begin
					Sub_En=1'b0;
					Add_En=1'b0;
//					if(M==1'b1)
//						Add_En=1'b1;	
//					else
//						Add_En=1'b0;		
					Shift_En=1'b1;
//					temp_loadA={temp_X, temp_loadA[7:1]};
//					temp_loadB={temp_loadA[0], temp_loadB[7:1]};
					Ld_A=temp_loadA;
					Ld_B=temp_loadB;
				end
				//final shift
				
				Sub:
					Add_En=1'b0;
					Shift_En=1'b0;
					Sub_En=1'b1;
					Ld_A = LoadA;
               Ld_B = LoadB;
					
				Last_Shift:
				begin
					Add_En=1'b0;
//					if(M==1'b1)
//						Sub_En=1'b1;
//						//~temp_loadA
//						
//					else
						Sub_En=1'b0;	
					Shift_En=1'b1;
//					temp_loadA={temp_X, temp_loadA[7:1]};
//					temp_loadB={temp_loadA[0], temp_loadB[7:1]};
					Ld_A=temp_loadA;
					Ld_B=temp_loadB;
				end
				
				//reset
				Halt:
				begin
					Ld_A=8'b0;
					Ld_B=8'b0;
					Add_En=1'b0;
					Sub_En=1'b0;
					Shift_En=1'b0;
				
					
				end
				
				
	   	   default:  //default case, can also have default assignments for Ld_A and Ld_B before case
		      begin 
                Ld_A = 8'b0;
                Ld_B = 8'b0;
                Shift_En = 1'b1;
					 Add_En=1'b0;
					 Sub_En=1'b0;
		      end
        endcase
    end

endmodule
