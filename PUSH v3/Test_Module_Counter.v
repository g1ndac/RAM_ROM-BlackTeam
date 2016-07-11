module Test_Module_Counter();

		parameter 					  		REGISTER_SIZE = 1;
		parameter 					  		PERIOD 		  = 2;
		
		reg 										control_clock;
		reg 											  	  reset;
		reg 											 	 enable;
		wire 										overflow_flag;
		wire [REGISTER_SIZE - 1: 0]	  	  counter_out;
	
	Counter #(REGISTER_SIZE) DUT(
		.control_clock				 		 (control_clock),
		.reset											(reset),
		.enable								  		  (enable),
		.overflow_flag				 		 (overflow_flag),
		.counter_out							(counter_out)
	);
	
		initial begin
			control_clock = 0;
			# (PERIOD / 2)
			forever 
				# (PERIOD / 2) 
							control_clock = ~control_clock;
		end
		
		initial begin
				reset  = 0;
			#4 enable = 1;
			#8 reset  = 1;
			#5 reset  = 0;
		end

endmodule 