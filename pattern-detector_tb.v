module pattern_detector_tb;
    parameter clk_period = 10ns;
	parameter state_reg_width = 3;
	parameter [state_reg_width - 1 : 0] found_0 = 3'b000,
	                                    found_1 = 3'b001,
										found_2 = 3'b010,
										found_3 = 3'b011,
										found_4 = 3'b100,
										found_5 = 3'b101;
	reg clk_tb = 0;
	always #(clk_period / 2) clk_tb = ~clk_tb;
	
	reg rst_tb;
	reg stream_in_tb;
	wire pattern_found_tb;
    
	pattern_detector dut(
	    .clk(clk_tb),
		.rst(rst_tb),
		.stream_in(stream_in_tb),
		.pattern_found(pattern_found_tb)
	);
	
	task pattern_detector_rst ();
	    rst_tb = 1;
		#(clk_period);
		$display("reset the pattern... the output is %d",pattern_found_tb);
	endtask
	
  task pattern_detector_stream (input reg [0:19] num);
        pattern_detector_rst();
	    rst_tb = 0;
		for(int i=0; i<20; i++)begin
		    stream_in_tb = num[i];
		    #(clk_period); 
			$display("the output is %d",pattern_found_tb);
		end
	endtask
	
	
	initial begin
	    
        pattern_detector_stream(20'b01101011111010011010);
	
	
	    $finish();
	end    
endmodule