

module behavioral_full_adder_tb;
  reg A, B, Cin;
  wire S, Cout;
  
  full_adder DUT(.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout));
  
  initial begin
    
    {A,B,Cin} = 3'b101;
    #10;
    $display("Behavioral Modelling: \n Inputs: A, B, Cin = %b %b %b \n Outputs: S, Cout = %b, %b\n", A, B, Cin, S, Cout);

  end
endmodule




module structural_full_adder_tb;
  reg A, B, Cin;
  wire S, Cout;
  
  one_bit_full_adder DUT(.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout));
  
  initial begin
    
    {A,B,Cin} = 3'b101;
    #10;
    $display("Structural Modeling: \n Inputs: A, B, Cin = %b %b %b \n Outputs: S, Cout = %b, %b\n", A, B, Cin, S, Cout);
  end
  
endmodule


module ripple_carry_adder_tb;
  reg [3:0] A, B;
  reg Cin;
  wire [3:0] S;
  wire Cout;
  
  four_bit_RCA DUT(.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout));
  
  initial begin
    // Unsigned
    {A,B,Cin} = {4'b0111, 4'b0001, 1'b0};
    #10;
    $display("4-bit Ripple Carry Adder: \n Inputs: A, B, Cin = %b %b %b \n Outputs: S, Cout = %b, %b\n", A, B, Cin, S, Cout);
    
    //Signed
    {A,B,Cin} = {4'b1111, 4'b1110, 1'b0};
    #10;
    $display("4-bit Ripple Carry Adder: \n Inputs: A, B, Cin = %b %b %b \n Outputs: S, Cout = %b, %b\n", A, B, Cin, S, Cout);
  end
endmodule


module ripple_carry_subtractor_tb;
  reg [3:0] A, B;
  reg Cin;
  wire [3:0] S;
  wire Cout;
  
  four_bit_RCS DUT(.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout));
  
  initial begin
    // Unsigned
    {A,B,Cin} = {4'b0111, 4'b0011, 1'b1};
    #10;
    $display("4-bit Ripple Carry Subtractor: \n Inputs: A, B, Cin = %b %b %b \n Outputs: S, Cout = %b, %b\n", A, B, Cin, S, Cout);
    
    // Signed
    {A,B,Cin} = {4'b1001, 4'b1010, 1'b1};
    #10;
    $display("4-bit Ripple Carry Subtractor: \n Inputs: A, B, Cin = %b %b %b \n Outputs: S, Cout = %b, %b\n", A, B, Cin, S, Cout);
  end
endmodule

