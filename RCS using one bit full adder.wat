// partd
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
  
  wire[2:0] c;
  wire [3:0] B_complement;
  
  assign B_complement = ~B;
  
  one_bit_full_adder FA0(A[0], B_complement[0], 1'b1 , S[0], c[0]); // Cin = 1
  one_bit_full_adder FA1(A[1], B_complement[1], c[0], S[1], c[1]);
  one_bit_full_adder FA2(A[2], B_complement[2], c[1], S[2], c[2]);
  one_bit_full_adder FA3(A[3], B_complement[3], c[2], S[3], Cout);
  
endmodule