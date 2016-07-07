module ROM_Interface #(parameter ADDRESS_SIZE = 24,
											DATA_SIZE 	 = 15 )(
	// General purpose signals
		input		[ADDRESS_SIZE - 1: 0]			 outAddress, // memory address from interface
		inout		[	 DATA_SIZE - 1: 0]			 	 outData, // 
		input 											  lowerByte, //
		input 											  upperByte, // 
		input 										  outputEnable, //
		input 											writeEnable, //
	// Signals to ROM
		input 														rp,
		input 													st_ce,
	// Signals from ROM
		output 												  st_sts
    );


endmodule
