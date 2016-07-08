module ChipSelectDecoder(
		input 	 						chipSelect,
		output reg					 mtChipEnable,
		output reg					 stChipEnable
    );

	always @ (*) begin
		if(chipSelect) begin
			mtChipEnable = 0;
			stChipEnable = 1;
		end
		else begin
			mtChipEnable = 1;
			stChipEnable = 0;
		end
	end

endmodule
