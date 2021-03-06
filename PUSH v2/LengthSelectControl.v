module LengthSelectControl(
		input 							lengthSelect,
		output reg							lowerByte,
		output reg							upperByte
    );

	always @ (*) begin
		if(lengthSelect) begin
			lowerByte = 1;
			upperByte = 1;
		end 
		else begin 
			lowerByte = 1;
			upperByte = 0;
		end	
	end

endmodule
