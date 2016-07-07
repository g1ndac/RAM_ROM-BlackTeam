module tRAM_ROM_Controller 
		#(parameter ADDRESS_SIZE = 24,
						DATA_SIZE 	 = 15 )(
	// Signals from FPGA	
		input 													  clk,
		input														  rst,
		input		[ADDRESS_SIZE - 1: 0]			  	  inAddr, // address from FPGA
		inout 	[	 DATA_SIZE - 1: 0]				  inData, // data from / to FPGA
		input												 chipSelect, // RAM / ROM select
		input											  lenghtSelect, // 8 bit or 16 bit word
		input 												opSelect,	 // read or write
	// Signals to FPGA
		output													  ack, // operation succesful
 		output 													ready // FPGA can initiate next operation
	 );
	 
	// General purpose signals
		wire 												 outAddress;
		wire 													 outData;
		wire 												  lowerByte;
		wire 												  upperByte;
		wire 											  outputEnable;
		wire 												writeEnable;
	
	// Signals for RAM	
		wire 													  mt_clk; // clock 
		wire 													  mt_adv; // address valid
		wire 														mt_ce; // chip enable
		wire 													 mt_wait;
	// Signals for ROM	
		wire 															rp; // reset_ROM
		wire 														st_ce;
		wire 													  st_sts;
	 
RAM_ROM_Controller #(ADDRESS_SIZE, DATA_SIZE) RAM_ROM_Controller (
	// Signals from FPGA	
		.clk														(clk),
		.rst														(rst),
		.inAddr												(inAddr), // address from FPGA
		.inData												(inData), // data from / to FPGA
		.chipSelect									  (chipSelect), // RAM / ROM select
		.lenghtSelect								(lenghtSelect), // 8 bit or 16 bit word
		.opSelect										 (opSelect),	 // read or write
	// Signals to FPGA
		.ack														(ack), // operation succesful
 		.ready												 (ready), // FPGA can initiate next operation
	// Signals to Memory (general purpose)
		.outAddress									  (outAddress), // memory address from interface
		.outData											  (outData), // 
		.lowerByte										(lowerByte), //
		.upperByte										(upperByte), // 
		.outputEnable								(outputEnable), //
		.writeEnable								 (writeEnable), //
	// Signals to RAM
		.mt_clk												(mt_clk),
		.mt_adv												(mt_adv),
		.mt_cre												(mt_cre),
		.mt_ce												 (mt_ce),
	// Signals from RAM
		.mt_wait											  (mt_wait),	
	// Signals to ROM
		.rp														 (rp),
		.st_ce												 (st_ce),
	// Signals from ROM
		.st_sts												(st_sts)
	 );

ROM_Interface #(ADDRESS_SIZE, DATA_SIZE)	ROM_interface(
	// General purpose signals
		.outAddress									  (outAddress), // memory address from interface
		.outData											  (outData), // 
		.lowerByte										(lowerByte), //
		.upperByte										(upperByte), // 
		.outputEnable								(outputEnable), //
		.writeEnable								 (writeEnable), //
	// Signals to ROM
		.rp														 (rp),
		.st_ce												 (st_ce),
	// Signals from ROM
		.st_sts												(st_sts)
    );

RAM_Interface #(ADDRESS_SIZE, DATA_SIZE)	RAM_interface(
	// General purpose signals
		.outAddress									  (outAddress), // memory address from interface
		.outData											  (outData), // 
		.lowerByte										(lowerByte), //
		.upperByte										(upperByte), // 
		.outputEnable								(outputEnable), //
		.writeEnable								 (writeEnable), //
		.mt_clk(mt_clk),
		.mt_adv(mt_adv),
		.mt_cre(mt_cre),
		.mt_ce(mt_ce),
	// Signals from RAM
		.mt_wait(mt_wait)
	 );
	 
endmodule 