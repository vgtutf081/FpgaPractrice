module mux
(
  input  d0, d1,
  input  sel,
  output y
);

  assign y = sel ? d1 : d0;

endmodule

//----------------------------------------------------------------------------

module xor_gate_using_mux
(
    input  a,
    input  b,
    output o
); 

	localparam false = 0;
	localparam true = 1;

	wire or_out;
	
	wire and1_out;
	
	wire not_out;

    mux mux_or (a, true, b, or_out);
	
	mux mux_and1 (false, a, b, and1_out);
	
	mux nor_gate (true, false, and1_out, not_out);
	
	mux mux_and2 (false, or_out, not_out, o);
	

  // TODO

  // Implement xor gate using instance(s) of mux,
  // constants 0 and 1, and wire connections


endmodule

//----------------------------------------------------------------------------

module testbench;

  logic a, b, o;
  int i, j;

  xor_gate_using_mux inst (a, b, o);

  initial
    begin
      for (i = 0; i <= 1; i++)
      for (j = 0; j <= 1; j++)
      begin
        a = i;
        b = j;

        # 1;

        $display ("TEST %b ^ %b = %b", a, b, o);
    
        if (o !== (a ^ b))
          begin
            $display ("%s FAIL: %h EXPECTED", `__FILE__, a ^ b);
            $finish;
          end
      end
      
      $display ("%s PASS", `__FILE__);
      $finish;
    end

endmodule
