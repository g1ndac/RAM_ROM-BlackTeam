module RAM_Controller(
		input 													  clk,
		input														  rst,
		input		[ADDRESS_SIZE - 1: 0]			  	  inAddr, // address from FPGA
		inout 	[	 DATA_SIZE - 1: 0]				  inData, // data from / to FPGA
		input												 chipSelect, // RAM / ROM select
		input											  lengthSelect, // 8 bit or 16 bit word											
		input 												opSelect,	 // read or write
		output	[ADDRESS_SIZE - 1: 0]			 outAddress, // memory address from interface
		inout		[	 DATA_SIZE - 1: 0]			 	 outData, // 
		output 											  lowerByte, //
		output 											  upperByte, // 
		output 										  outputEnable, //
		output 											writeEnable, //
	// Signals to RAM
		output 												  mt_clk,
		output 												  mt_adv,
		output 												  mt_cre,
		output 													mt_ce,
	// Signals from RAM
		input 												 mt_wait
    );


endmodule
