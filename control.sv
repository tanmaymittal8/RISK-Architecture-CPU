//simple state machine to convert a switch input to one clock cycle long event
//similar to the hold->reset portion of the serial logic processor


//Two-always example for state machine

module control (input  logic Clk, Reset, Execute, M, 
                output logic Shift_En, Add_En, Sub_En);

    // Declare signals curr_state, next_state of type enum
    // with enum values of A, B, ..., F as the state values
	 // Note that the length implies a max of 8 states, so you will need to bump this up for 8-bits
    enum logic [4:0] {Start, Add1, Add2, Add3, Add4, Add5, Add6, Add7, Sub, Shift1, Shift2, Shift3, Shift4, Shift5, Shift6, Shift7, Last_Shift, Halt}   curr_state, next_state; 
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
            Halt :    if (~Execute) 
                       next_state = Start;
							  else
								next_state=Halt;
				
							  
        endcase
   
		  // Assign outputs based on ‘state’
        case (curr_state) 
	   	   Start: 
	         begin
					 
                
                Shift_En = 1'b0;
					 Sub_En=1'b0;
					 Add_En=1'b0;
		      end
			
				
				Add1, Add2, Add3, Add4, Add5, Add6, Add7:
				begin
					Add_En=1'b1;
					Shift_En=1'b0;
					Sub_En=1'b0;
					
				end
					
				Shift1, Shift2, Shift3, Shift4, Shift5, Shift6, Shift7, Last_Shift:
				begin
					Sub_En=1'b0;
					Add_En=1'b0;			
					Shift_En=1'b1;
						
				end
				
				Sub:
				begin
					Add_En=1'b0;
					Sub_En=1'b1;
					Shift_En=1'b0;
					
				end

				Halt:
				begin
					Add_En=1'b0;
					Sub_En=1'b0;
					Shift_En=1'b0;
				
				end
				
	   	   default:  //default case, can also have default assignments for Ld_A and Ld_B before case
		      begin 
               
                Shift_En = 1'b0; 
					 Add_En=1'b0;
					 Sub_En=1'b0;
					
		      end
        endcase
    end

endmodule
