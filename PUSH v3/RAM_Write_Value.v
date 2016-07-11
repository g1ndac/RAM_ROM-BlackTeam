task RAM_Write_Value;
	input [15 : 0] dataToWrite;
	input [23 : 0] addressToWrite;
	
	begin
		opSelect 	= 1;
		dataInIn 	= 16'bz;
		addrIn 		= 16'bz;
	@(posedge clk)
		addrIn		= addressToWrite;
	#2 dataInIn    = dataToWrite;
	#40 addrIn		= 16'bz;
	end
	
endtask 