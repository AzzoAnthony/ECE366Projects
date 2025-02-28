// PartC
module one_bit_full_adder(A, B, Cin, S, Cout);
  input A, B, Cin;
  output S, Cout;
  assign S=A^B^Cin; // S = A XOR B XOR Cin
  assign Cout = (A&B) | (B&Cin) | (A&Cin);
endmodule

module four_bit_RCA_RCS(A, B, Cin, S, Cout);
  input [3:0] A, B;
  input Cin;
  output [3:0] S;
  output Cout;
  
  wire c0, c1, c2;
  
  one_bit_full_adder FA0(A[0], B[0], Cin, S[0], c0);
  one_bit_full_adder FA1(A[1], B[1], c0, S[1], c1);
  one_bit_full_adder FA2(A[2], B[2], c1, S[2], c2);
  one_bit_full_adder FA3(A[3], B[3], c2, S[3], Cout);
 
endmodule