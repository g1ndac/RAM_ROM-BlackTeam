module RAM_ROM_Controller 
		#(parameter ADDRESS_SIZE = 24,
						DATA_SIZE 	 = 15 )(
	// Signals from FPGA	
		input 													  clk,
		input														  rst,
		input		[ADDRESS_SIZE - 1: 0]			  	  inAddr, // address from FPGA
		inout 	[	 DATA_SIZE - 1: 0]				  inData, // data from / to FPGA
		input												 chipSelect, // RAM / ROM select
		input											  lengthSelect, // 8 bit or 16 bit word
		input 												opSelect,	 // read or write
	// Signals to FPGA
		output													  ack, // operation succesful
 		output 													ready, // FPGA can initiate next operation
	// Signals to Memory (general purpose)
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
		input 												 mt_wait,	
	// Signals to ROM
		output 														rp,
		output 													st_ce,
	// Signals from ROM
		input 												  st_sts
	 );
	 
	 assign rp = (rst)?(1):(0);

ChipSelectDecoder ChipSelectDecoder(
		.chipSelect									  (chipSelect),
		.mtChipEnable										 (mt_ce),
		.stChipEnable										 (st_ce)
		);

LengthSelectControl LengthSelectControl(
		.lengthSelect								(lengthSelect),
		.lowerByte										(lowerByte),
		.upperByte										(upperByte)
		);

OperationSelectDecoder OperationSelectDecoder(
		.opSelect										 (opSelect),
		.outputEnable								(outputEnable),
		.writeEnable								 (writeEnable)
		);
		
endmodule 