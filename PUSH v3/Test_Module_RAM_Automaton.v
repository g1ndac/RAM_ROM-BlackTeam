module Test_Module();
	
		`include 				"RAM_Write_Value.v"

		parameter CLOCK_TICKS_FOR_READ_DELAY = 1;
		parameter PERIOD					 		 = 2;

		reg 											 clk;
		reg 											 rst;
		reg 									  opSelect;
		reg 	[23:0]						  	 addrIn;
		reg 	[15:0]						  dataInIn;
		reg 	[15:0]						 dataInOut;
		wire 	[23:0]							addrOut;
		reg	[15:0]						 dataOutIn;
		reg	[15:0]						dataOutOut;
		wire	[15:0]							 dataIn;
		wire 	[15:0]							dataOut;
		wire 									chipEnable;
		wire 								  writeEnable;
		wire 									 lowerByte;
		wire 									 upperByte;
		
		 assign dataIn =  (opSelect) ? (dataInIn) : (dataInOut);
		 
		RAM_Controller_Automaton
	  #(
		CLOCK_TICKS_FOR_READ_DELAY
		)	
		DUT(
		.clk										  (clk),
		.rst										  (rst),
		.opSelect						   (opSelect),
		.addrIn								  (addrIn),
		.dataIn								  (dataIn),
		.addrOut								 (addrOut),
		.dataOut								 (dataOut),
		.chipEnable						 (chipEnable),
		.outputEnable				  (outputEnable),
		.writeEnable				   (writeEnable),
		.lowerByte						  (lowerByte),
		.upperByte						  (upperByte)
		);
		
		
   initial begin
      clk = 1'b0;
      #(PERIOD/2);
      forever
         #(PERIOD/2) clk = ~clk;
   end
				
	initial begin
		opSelect = 1;
		dataInIn = 16'bz;
		addrIn   = 24'd100;
	#10 dataInIn = 16'd101;
	#20 dataInIn = 16'bz;
		addrIn   = 24'bz;
	end
endmodule
