module RAM_interface #(parameter ADDRESS_SIZE = 24,
											DATA_SIZE 	 = 15 )(
	// General purpose signals
		input		[ADDRESS_SIZE - 1: 0]			 outAddress, // memory address from interface
		inout		[	 DATA_SIZE - 1: 0]			 	 outData, // 
		input 											  lowerByte, //
		input 											  upperByte, // 
		input 										  outputEnable, //
		input 											writeEnable, //
	// Signals to RAM
		output 												  mt_clk,
		output 												  mt_adv,
		output 												  mt_cre,
		output 													mt_ce,
	// Signals from RAM
		input 												 mt_wait
	);


endmodule
