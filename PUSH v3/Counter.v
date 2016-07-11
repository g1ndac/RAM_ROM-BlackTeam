module Counter #(parameter REGISTER_SIZE = 1)(
		input 														control_clock,
		input 																  reset,
		input 																 enable,
		output 														overflow_flag,
		output [REGISTER_SIZE - 1 : 0]	 					  counter_out
    );
	 
	 reg [REGISTER_SIZE - 1 : 0] 					 internal_register = 0;
	 reg 								  					 overflow		 	 = 0;
	 
	 assign counter_out 				 					= internal_register;
	 assign overflow_flag 			 					= 			  overflow;
	 
	 always @ (posedge control_clock)
		if(reset) begin
			internal_register <= 0;
		end // if
		else
		if(enable) begin
			internal_register <= internal_register + 1;
			if(internal_register == 1) 
				overflow <= 1;
			else 
				overflow <= 0;
		end // if

endmodule
