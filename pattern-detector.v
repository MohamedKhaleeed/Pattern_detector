module pattern_detector(
    input clk,
	input rst,
	input stream_in,
	output reg pattern_found
);

    parameter state_reg_width = 3;
	parameter [state_reg_width - 1 : 0] found_0 = 3'b000,
	                                    found_1 = 3'b001,
										found_2 = 3'b010,
										found_3 = 3'b011,
										found_4 = 3'b100,
										found_5 = 3'b101;
    
	reg [state_reg_width - 1 : 0] curr_state, next_state;

	always @(posedge clk) begin
	    if(rst) begin
            curr_state <= found_0;
		end
        else begin
            curr_state <= next_state;		
		end
	end
	
	always @(*) begin
        pattern_found = 0; //default value
         
        case (curr_state)
			found_0: begin
			pattern_found = 0;
			
			if(stream_in == 0)
			    next_state = found_0; 
			else
			    next_state = found_1;
			end
			
			found_1: begin
			pattern_found = 0;
			
			if(stream_in == 0)
			    next_state = found_0; 
			else
			    next_state = found_2;
			end
			
			found_2: begin
			pattern_found = 0;
			
			if(stream_in == 0)
			    next_state = found_3; 
			else
			    next_state = found_2;
			end
			
			found_3: begin
			pattern_found = 0;
			
			if(stream_in == 0)
			    next_state = found_0; 
			else
			    next_state = found_4;
			end
			
			found_4: begin
			pattern_found = 0;
			
			if(stream_in == 0)
			    next_state = found_5; 
			else
			    next_state = found_2;
			end
			
			found_5: begin
			pattern_found = 1;
			
			if(stream_in == 0)
			    next_state = found_0; 
			else
			    next_state = found_1;
			end
        endcase		
	end
endmodule