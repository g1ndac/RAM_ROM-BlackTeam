module OperationSelectDecoder(
		input 								opSelect,
		output reg 					  outputEnable,
		output reg 						writeEnable
    );

	always @ (*) begin
		if(opSelect) begin
			outputEnable = 0;
			writeEnable  = 1;
		end
		else begin
			outputEnable = 0;
			writeEnable  = 1;
		end
	end

endmodule
