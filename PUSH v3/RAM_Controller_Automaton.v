module RAM_Controller_Automaton
	  #(
		parameter 			CLOCK_TICKS_FOR_READ_DELAY = 1
		)(
		input														clk,
		input														rst,
		input 											 opSelect,
		input				[23: 0]							addrIn,
		inout 			[15: 0]	 						dataIn,
		output			[23: 0] 					  	  addrOut,
		inout				[15: 0]						  dataOut,
		output	reg								  chipEnable,
		output	reg								outputEnable,
		output	reg								 writeEnable,
		output	reg									lowerByte,
		output	reg									upperByte
		);
		
		parameter HIGH 										= 1;
		parameter LOW  										= 0;
		
		`include "RD_WR_RAM_CONTROLLER_STATES.v"
		
		reg		[7 : 0] 		  currentState = IDLE_STATE; 
		reg 													enable;
		
		wire 												nextClock;
		wire								  		  overflow_flag;
		wire									 		 counter_out;
		wire 											  check_flag;
		
	Counter #(CLOCK_TICKS_FOR_READ_DELAY) Clock2Ticks(
		.control_clock										 (clk),
		.reset												 (rst),
		.enable											 (enable), // signal output from FSM
		.overflow_flag						   (overflow_flag),
		.counter_out							  (counter_out)
	);
	
		wire [15: 0] dataOutIn, dataOutOut;
		wire [15: 0] dataInIn, dataInOut;
		/*
		assign check_flag = (addrIn != 24'bz && dataInIn != 16'bz);
		*/
		assign addrOut		= (currentState != IDLE_STATE)?
								  (addrIn)	 					   :
								  (24'b0);
												
		assign dataInIn	= (opSelect)  ? (dataIn) 	 : (16'bz);
		assign dataInOut	= (!opSelect) ? (dataOut)	 : (16'bz);
		assign dataIn		= (!opSelect) ? (dataInOut) : (16'bz);
		assign dataOutIn	= (!opSelect) ? (dataOut) 	 : (16'bz);
		
		assign dataOut		= (opSelect 									&& (
									currentState == WRITE_STATE 			||
									currentState == PREP_WRITE_STATE 	||
									currentState == GO_TO_IDLE		  ))  ? 
								  (dataInIn)	 								: 
								  (16'b0);
		
		always @ (posedge clk) begin
			if(rst)
				currentState <= IDLE_STATE;
			else case(currentState)
					IDLE_STATE: 
									if(opSelect == 1'bz) begin
										currentState <= IDLE_STATE;
									end
									else begin
											if(opSelect) 
												currentState <= START_WRITE_STATE;
											else
											currentState <= START_READ_STATE;
									end
									
					START_WRITE_STATE:
									if(~chipEnable && ~writeEnable) begin
										currentState <= PREP_WRITE_STATE;
									end
									else begin
										currentState <= START_WRITE_STATE;
									end
									
					PREP_WRITE_STATE:
									if(overflow_flag) begin
										currentState <= WRITE_STATE;
									end
									else begin
										currentState <= PREP_WRITE_STATE;
									end
					WRITE_STATE:
									currentState <= GO_TO_IDLE;
									
					START_READ_STATE:
									if(~chipEnable && ~outputEnable) begin
										currentState <= PREP_WRITE_STATE;
									end
									else begin
										currentState <= START_READ_STATE;
									end
									
					PREP_READ_STATE:
									if(addrIn != 24'bz && dataOut != 16'bz) begin
										currentState <= READ_STATE;
									end
									else begin
										currentState <= PREP_READ_STATE;
									end
									
					READ_STATE:
									currentState <= (GO_TO_IDLE);
									
					GO_TO_IDLE:
									if(chipEnable && writeEnable && outputEnable) begin
										currentState <= IDLE_STATE;
									end
									else begin
										currentState <= GO_TO_IDLE;
									end
					endcase
			end // if

		always @ (*) begin
			case(currentState)
				IDLE_STATE: begin
									chipEnable 				= 	 HIGH;
									outputEnable 			= 	 HIGH;
									writeEnable 			= 	 HIGH;
									lowerByte 				= 1'b1;
									upperByte 				= 1'b1;
								end
								
				START_WRITE_STATE: 
								begin
									enable 					= 	 HIGH;
									chipEnable 				=    LOW;
									outputEnable			=   HIGH;
								if(overflow_flag) begin
									writeEnable				= 	  LOW;
								end // if			
								end
								
				PREP_WRITE_STATE:
								begin
									enable					= 	 HIGH;
								if(overflow_flag) begin
									enable					=    LOW;
									lowerByte = 1'b0;
									upperByte = 1'b0;
								end // if
								end
									
				WRITE_STATE:
								begin
									enable					= 	 HIGH;
								if(overflow_flag) begin
									enable					=    LOW;
									lowerByte = 1'b0;
									upperByte = 1'b0;
								end // if
								end
				
				START_READ_STATE:
								begin
									enable 					= 	 HIGH;
									chipEnable 				=    LOW;
									outputEnable			=    LOW;
								if(overflow_flag) begin
									outputEnable			= 	  LOW;
									lowerByte				=	  LOW;
									upperByte				=	  LOW;
									enable					= 	  LOW;
								end // if
								end
								
				PREP_READ_STATE:
								begin
								
								end
				
				READ_STATE:
								begin
									
								end
								
				GO_TO_IDLE:
								begin
									chipEnable 				= 	 HIGH;
									outputEnable 			= 	 HIGH;
									writeEnable 			= 	 HIGH;
									lowerByte 				=	 1'b1;
									upperByte 				=	 1'b1;
								end
			endcase
		end

endmodule 