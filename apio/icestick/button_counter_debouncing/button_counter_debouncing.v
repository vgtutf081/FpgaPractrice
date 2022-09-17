// count up on each button press and display on LEDs
module button_counter (

	input		[1:0]	pmod,
	input 				clk,
	
	output	reg	[3:0]	led	
);

	wire rst;
	wire button;
	
	assign rst = ~pmod[0];
	assign button = ~pmod[1];
	
	reg [23:0]  delay_count = 24'b0;
	reg		 	state = 1'b0;
	reg			count = 1'b0;
	
	localparam STATE_LOW = 1'b0;
	localparam STATE_HIGH = 1'b1;
	
	always @ (posedge count or posedge rst) begin
		if (rst == 1'b1) begin
			led <= 4'b0;
		end	else begin	
			led <= led + 1'b1;
		end
	end
	
	always @ (posedge clk) begin
	
		if (button == 1'b1) begin
			state <= STATE_HIGH;
		end else begin 
			state <= STATE_LOW;
		end
		
		case (state)
			STATE_LOW: begin
				delay_count <= 24'b0;
				count <= 1'b0;
			end
			
			STATE_HIGH: begin
				if (count == 1'b0) begin
					delay_count <= delay_count + 1'b1;
				end
			end
			
		endcase
		
		if (delay_count == 600000) begin
			count <= 1'b1;
		end
		
	end
		
endmodule	