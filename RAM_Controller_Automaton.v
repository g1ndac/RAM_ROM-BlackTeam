module RAM_Controller_Automaton(
		input														clk,
		input														rst,
		input 											 opSelect,
		input		[24: 0]								inAddress,
		inout 	[15: 0]	 								inData,
		output	[23: 0] 							  outAddress,
		inout		[15: 0]								  outData,
		output										  chipEnable,
		output										outputEnable,
		output										 writeEnable
		);

		`include "RD_WR_RAM_CONTROLLER_STATES.v"
		
		reg		[3 : 0] stateCurrent = IDLE_STATE; 
		reg		[3 : 0] 	  stateNext = IDLE_STATE; 
		/*
		localparam IDLE_STATE 				= 8'b00000001;
localparam START_WRITE_STATE		= 8'b00000010;
localparam PREP_WRITE_STATE		= 8'b00000100;
localparam WRITE_STATE				= 8'b00001000;
localparam START_READ_STATE		= 8'b00010000;
localparam PREP_READ_STATE			= 8'b00100000;
localparam READ_STATE				= 8'b01000000;
localparam GO_TO_IDLE				= 8'b10000000;
		*/
		always @ (posedge clock) begin
			stateCurrent <= stateNext; 
		end
		
		always @ (*) begin
			case(stateCurrent)
				IDLE_STATE: if( opSelect) begin
									nextState = START_WRITE_STATE;
								end 
								else 
								if(~opSelect) begin
									nextState = START_READ_STATE;
								end
				START_WRITE_STATE: 
								if(
			endcase
		end

endmodule
