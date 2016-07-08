module ChipSelectDecoder(
		input 	 						chipSelect,
		output reg					 mtChipEnable,
		output reg					 stChipEnable
    );

	always @ (*) begin
		if(chipSelect) begin
			ramSelected = 1;
		end
		else begin
			ramSelected = 0;
		end
	end

endmodule
