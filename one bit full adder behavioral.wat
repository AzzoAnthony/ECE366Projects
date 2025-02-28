// Write Some Verilog Code Here!
module full_adder(A, B, Cin, S, Cout);
  input A, B, Cin;
  output S, Cout;
  
  wire x1, t1, t2, t3, t4;
  
  assign x1 = A ^ B;
  assign S = x1^ Cin;
  
  assign t1 = A & B;
  assign t2 = B & Cin;
  assign t3 = Cin & A;
  assign Cout = t1 | t2 | t3;
  
endmodule