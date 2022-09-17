// count up on each clock 1Hz and display on LEDs
module button_counter (

	input				pmod,
	input				clock_in,
	
	output	reg	[3:0]	led	

);
	reg[31:0] counter = 32'd0;

	wire rst;
	wire clock_out;
	
	assign clock_out = (counter == (12000000 - 1));
	assign rst = ~pmod;
	
	always @ (posedge clock_out or posedge rst) begin
		if (rst == 1'b1) begin
			led <= 4'b0;
		end	else begin	
			led <= led + 1'b1;
		end
	end
	
	always @(posedge clock_in) begin
		if (clock_out) begin
			counter <= 0;
		end else if (rst == 1'b1) begin
			counter <= 32'b0;
		end else begin
			counter <= counter + 1;
		end
	end

endmodule	