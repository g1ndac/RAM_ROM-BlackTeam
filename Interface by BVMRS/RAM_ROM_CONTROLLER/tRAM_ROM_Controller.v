module tRAM_ROM_Controller 
		#(parameter ADDRESS_SIZE = 24, // address bus size
						DATA_SIZE 	 = 15  // data bus size
						)(					
	// Signals from FPGA	- mai trebuie un semnal care imi zice cum vreau sa organizez memoria, pe 
	//							  cuvinte de 8 sau 16 biti 
		input 													  clk,
		input														  rst,
		input		[ADDRESS_SIZE - 1: 0]			  	  inAddr, // address from FPGA
		inout 	[	 DATA_SIZE - 1: 0]				  inData, // data from / to FPGA
		input												 chipSelect, // RAM / ROM select 	 1 - RAM   0 - ROM
		input											  lengthSelect, // 16 bit or 8 bit word 1 - word  0 - byte 
		input 												opSelect, // write or read 		 1 - write 0 - read
	// Signals to FPGA
		output													  ack, // operation succesful
 		output 													ready  // FPGA can initiate next operation
	 );
	 
	// General purpose signals
		wire 												 outAddress; // adress 
		wire 													 outData; // data from / to memory
		wire 												  lowerByte; // access MSB of address
		wire 												  upperByte; // access LSB of address
		wire 											  outputEnable; // ??
		wire 												writeEnable; // validate write to address
	
	// Signals for RAM	
		wire 													  mt_clk; // clock 
		wire 													  mt_adv; // address valid
		wire 														mt_ce; // chip enable
		wire 													 mt_wait; // ready
	// Signals for ROM	
		wire 															rp; // reset_ROM
		wire 														st_ce; // chip enable
		wire 													  st_sts; // status
	 
RAM_ROM_Controller #(ADDRESS_SIZE, DATA_SIZE) RAM_ROM_Controller (
	// Signals from FPGA	
		.clk														(clk),
		.rst														(rst),
		.inAddr												(inAddr), // address from FPGA
		.inData												(inData), // data from / to FPGA
		.chipSelect									  (chipSelect), // RAM / ROM select
		.lenghtSelect								(lengthSelect), // 8 bit or 16 bit word
		.opSelect										 (opSelect), // read or write
	// Signals to FPGA
		.ack														(ack), // operation succesful
 		.ready												 (ready), // FPGA can initiate next operation
	// Signals to Memory (general purpose)
		.outAddress									  (outAddress), // memory address from interface
		.outData											  (outData), // data from / to memory
		.lowerByte										(lowerByte), // access LSB of address
		.upperByte										(upperByte), // access MSB of address
		.outputEnable								(outputEnable), // 
		.writeEnable								 (writeEnable), // 
	// Signals to RAM
		.mt_clk												(mt_clk), // RAM clock
		.mt_adv												(mt_adv), // RAM address valid
		.mt_cre												(mt_cre), // RAM counter register enable - black magic i think
		.mt_ce												 (mt_ce), // RAM chip enable
	// Signals from RAM
		.mt_wait											  (mt_wait), // RAM ready (wait for ready)
	// Signals to ROM
		.rp														 (rp), // ROM reset
		.st_ce												 (st_ce), // ROM chip enable
	// Signals from ROM
		.st_sts												(st_sts)  // ROM ready
	 );

ROM_Interface #(ADDRESS_SIZE, DATA_SIZE)	ROM_interface(
	// General purpose signals
		.outAddress									  (outAddress), // memory address from interface
		.outData											  (outData), // data from / to ROM
		.lowerByte										(lowerByte), // access LSB
		.upperByte										(upperByte), // access MSB
		.outputEnable								(outputEnable), // ??
		.writeEnable								 (writeEnable), // ?? 
	// Signals to ROM
		.rp														 (rp), // ROM reset 
		.st_ce												 (st_ce), // ROM chip enable
	// Signals from ROM
		.st_sts												(st_sts)  // ROM status
    );

RAM_Interface #(ADDRESS_SIZE, DATA_SIZE)	RAM_Interface(
	// General purpose signals
		.outAddress									  (outAddress), // memory address from controller
		.outData											  (outData), // memory address from controller
		.lowerByte										(lowerByte), // access LSB
		.upperByte										(upperByte), // access MSB
		.outputEnable								(outputEnable), // ??
		.writeEnable								 (writeEnable), // ??
		.mt_clk												(mt_clk), // RAM clock
		.mt_adv												(mt_adv), // RAM address valid
		.mt_cre												(mt_cre), // RAM control register enable
		.mt_ce												 (mt_ce), // RAM counter enable
	// Signals from RAM
		.mt_wait											  (mt_wait)	 // RAM ready
	 );
	 
endmodule 