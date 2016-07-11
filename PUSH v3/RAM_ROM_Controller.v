
module RAM_ROM_Controller 
		#(parameter ADDRESS_SIZE = 24,
						DATA_SIZE 	 = 15 )(
	// Signals from FPGA	
		input 													  clk,
		input														  rst,
		input		[ADDRESS_SIZE - 1: 0]			  	  inAddr, // address from FPGA
		inout 	[	 DATA_SIZE - 1: 0]				  inData, // data from / to FPGA 
		input												 chipSelect, // RAM / ROM select							X
		input											  lengthSelect, // 8 bit or 16 bit word					X						
		input 												opSelect,	 // read or write							X
	// Signals to FPGA
		output													  ack, // operation succesful
 		output 													ready, // FPGA can initiate next operation
	// Signals to Memory (general purpose)
		output	[ADDRESS_SIZE - 1: 0]			 outAddress, // memory address from interface
		inout		[	 DATA_SIZE - 1: 0]			 	 outData, // 
		output 											  lowerByte, //												X
		output 											  upperByte, // 												X
		output 										  outputEnable, //
		output 											writeEnable, //
	// Signals to RAM
		output 												  mt_clk, //
		output 												  mt_adv, //
		output 												  mt_cre, //												X
		output 													mt_ce, //												X
	// Signals from RAM
		input 												 mt_wait, // ramane in Z								X
	// Signals to ROM
		output 														rp, //												X
		output 													st_ce, //												X
	// Signals from ROM
		input 												  st_sts  // nu stiu ce face
	 );
	 
	 assign rp = (rst)?(1):(0);
	 assign cre = 0;

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
		
	/* Functia asta este implementata si in FSM
OperationSelectDecoder OperationSelectDecoder(
		.opSelect										 (opSelect),
		.outputEnable								(outputEnable),
		.writeEnable								 (writeEnable)
		);
		*/
		
RAM_Controller_Automaton	#(1) RAM_Controller_Automaton(
		.clk													  	(clk),
		.rst														(rst),
		.opSelect										 (opSelect),
		.addrIn												(addrIn),
		.dataIn												(dataIn),
		.addrOut											  (addrOut),
		.dataOut											  (dataOut),
		.chipEnable									  (chipEnable),
		.outputEnable								(outputEnable),
		.writeEnable								 (writeEnable),
		.lowerByte										(lowerByte),
		.upperByte										(upperByte)
		);
		
endmodule 