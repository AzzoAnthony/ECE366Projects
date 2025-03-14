// 1a

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

// 1b

module one_bit_full_adder(A, B, Cin, S, Cout);
  input A, B, Cin;
  output S, Cout;
  assign S=A^B^Cin; // S = A XOR B XOR Cin
  assign Cout = (A&&B) || (B&&Cin) || (A&&Cin);
endmodule
	  

// 1c

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

// 1d

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

// 1e



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



// 2a

module Full_Adder(
    input A, B, Cin,
    output Sum, Cout
);
    assign Sum = A ^ B ^ Cin;
    assign Cout = (A & B) | (B & Cin) | (A & Cin);
endmodule

// ==================== 4-bit Ripple Carry Adder ====================
module RCA_4bit(
  	input [3:0] A, B,
    input Cin,
  	output [3:0] Sum,
    output Cout
);
    wire C1, C2, C3;

    Full_Adder FA0 (A[0], B[0], Cin,  Sum[0], C1);
    Full_Adder FA1 (A[1], B[1], C1,   Sum[1], C2);
    Full_Adder FA2 (A[2], B[2], C2,   Sum[2], C3);
    Full_Adder FA3 (A[3], B[3], C3,   Sum[3], Cout);
endmodule

// ==================== 4-bit CLA Block Generator ====================
module CLA_Block_Generator(
    input [3:0] A, B,
    input Cin,
    output [3:0] P, G,
    output C4
);
    // Compute propagate and generate signals
    assign P = A | B;  // P_i = A_i OR B_i
    assign G = A & B;  // G_i = A_i AND B_i

    // Compute carries using lookahead logic
    assign C4 = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | 
                (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & Cin);
endmodule

// ==================== 4-bit CLA Adder ====================
module CLA_4bit(
    input [3:0] A, B,
    input Cin,
    output [3:0] Sum,
    output Cout
);
    wire [3:0] P, G;
    wire C4;

    // Generate carry signals
    CLA_Block_Generator CLA_Block (.A(A), .B(B), .Cin(Cin), .P(P), .G(G), .C4(C4));

    // Compute sum using RCA
    RCA_4bit RCA (.A(A), .B(B), .Cin(Cin), .Sum(Sum), .Cout());

    assign Cout = C4;
endmodule

// ==================== 32-bit CLA Adder ====================
module CLA_32bit(
    input [31:0] A, B,
    input Cin,
    output [31:0] Sum,
    output Cout
);
    wire [7:0] c;

    // Instantiate 8 CLA_4bit blocks
    CLA_4bit CLA0 (A[3:0],   B[3:0],   Cin,  Sum[3:0],   c[0]);
    CLA_4bit CLA1 (A[7:4],   B[7:4],   c[0], Sum[7:4],   c[1]);
    CLA_4bit CLA2 (A[11:8],  B[11:8],  c[1], Sum[11:8],  c[2]);
    CLA_4bit CLA3 (A[15:12], B[15:12], c[2], Sum[15:12], c[3]);
    CLA_4bit CLA4 (A[19:16], B[19:16], c[3], Sum[19:16], c[4]);
    CLA_4bit CLA5 (A[23:20], B[23:20], c[4], Sum[23:20], c[5]);
    CLA_4bit CLA6 (A[27:24], B[27:24], c[5], Sum[27:24], c[6]);
    CLA_4bit CLA7 (A[31:28], B[31:28], c[6], Sum[31:28], Cout);
endmodule

// 2b

module CLA_32bit_tb;
  // Input
  reg [31:0] A,B;
  reg Cin;
  // output
  wire [31:0] Sum;
  wire Cout;
  
  CLA_32bit DUT(.A(A), .B(B), .Cin(Cin), .Sum(Sum), .Cout(Cout));
  
    initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
      
      A = 32'h00000000;
      B = 32'h00000000;
      Cin = 1'b0;
      #10
      // Test Case 1: 0 + 0 + 0 = 0
      // Input: A = 32'h00000000, B = 32'h00000000, Cin = 0
      // Expected Output: Sum = 32'h00000000, Cout = 0
      $display("S, Cout = %h %b", Sum, Cout); 
      
      A = 32'h00000001;
      B = 32'h00000001;
      Cin = 1'b0;
      #10
      // Test Case 2: 1 + 1 + 0 = 2
    // Input: A = 32'h00000001, B = 32'h00000001, Cin = 0
    // Expected Output: Sum = 32'h00000002, Cout = 0
      $display("S, Cout = %h %b", Sum, Cout); 
      
      A = 32'h00000001;
      B = 32'h00000001;
      Cin = 1'b1;
      #10
      // Test Case 3: 1 + 1 + 1 = 3
    // Input: A = 32'h00000001, B = 32'h00000001, Cin = 1
    // Expected Output: Sum = 32'h00000003, Cout = 0
      $display("S, Cout = %h %b", Sum, Cout); 
      
      A = 32'h0000000F;
      B = 32'h00000001;
      Cin = 1'b0;
      #10
      // Test Case 4: F + 1 + 0 = 10
    // Input: A = 32'h0000000F, B = 32'h00000001, Cin = 0
    // Expected Output: Sum = 32'h00000010, Cout = 0
      $display("S, Cout = %h %b", Sum, Cout); 
      
      A = 32'h0000FFFF;
      B = 32'h00000001;
      Cin = 1'b0;
      #10
       // Test Case 5: FFFF + 1 + 0 = 10000
    // Input: A = 32'h0000FFFF, B = 32'h00000001, Cin = 0
    // Expected Output: Sum = 32'h00010000, Cout = 0
      $display("S, Cout = %h %b", Sum, Cout); 
      
      A = 32'hFFFFFFFF;
      B = 32'h00000001;
      Cin = 1'b0;
      #10
      // Test Case 6: FFFFFFFF + 1 + 0 = 0 (with carry-out)
    // Input: A = 32'hFFFFFFFF, B = 32'h00000001, Cin = 0
    // Expected Output: Sum = 32'h00000000, Cout = 1
      $display("S, Cout = %h %b", Sum, Cout); 
      
      A = 32'hA5A5A5A5;
      B = 32'h5A5A5A5A;
      Cin = 1'b1;
      #10
      // Test Case 7: A5A5A5A5 + 5A5A5A5A + 1 = 0 (with carry-out)
    // Input: A = 32'hA5A5A5A5, B = 32'h5A5A5A5A, Cin = 1
    // Expected Output: Sum = 32'h00000000, Cout = 1
      $display("S, Cout = %h %b", Sum, Cout); 
      
      A = 32'hFFFFFFFF;
      B = 32'hFFFFFFFF;
      Cin = 1'b0;
      #10
     //Test Case 8: FFFFFFFF + FFFFFFFF + 0 = FFFFFFFE (with carryout)
    // Input: A = 32'hFFFFFFFF, B = 32'hFFFFFFFF, Cin = 0
    // Expected Output: Sum = 32'hFFFFFFFE, Cout = 1
      $display("S, Cout = %h %b", Sum, Cout); 
      
      A = 32'h00000000;
      B = 32'h12345678;
      Cin = 1'b0;
      #10
      // Test Case 9: 0 + 12345678 + 0 = 12345678
    // Input: A = 32'h00000000, B = 32'h12345678, Cin = 0
    // Expected Output: Sum = 32'h12345678, Cout = 0
      $display("S, Cout = %h %b", Sum, Cout); 
      
      $finish;
      
    end
endmodule

// 3a

module PPA(A, B, Cin, S, Cout);
  
  input [15:0] A, B;
  input Cin;
  output [15:0] S;
  output Cout;
  
  wire [15:0] P;
  wire [15:0] G;
  // wire [15:0] c;
  
  wire P_negative1 = 0; // P[-1] = 0
  wire G_negative1 = Cin; // G[-1] = Cin
  
  // computing the solid white square blocks (pre-computation block)
  assign P = A | B;
  assign G = A & B;
  /*assign P[0] = A[0] | B[0]; 
  assign G[0] = A[0] & B[0];
  assign P[1] = A[1] | B[1]; 
  assign G[1] = A[1] & B[1];
  assign P[2] = A[2] | B[2]; 
  assign G[2] = A[2] & B[2];
  assign P[3] = A[3] | B[3]; 
  assign G[3] = A[3] & B[3];
  assign P[4] = A[4] | B[4]; 
  assign G[4] = A[4] & B[4];
  assign P[5] = A[5] | B[5]; 
  assign G[5] = A[5] & B[5];
  assign P[6] = A[6] | B[6]; 
  assign G[6] = A[6] & B[6];
  assign P[7] = A[7] | B[7]; 
  assign G[7] = A[7] & B[7];
  assign P[8] = A[8] | B[8]; 
  assign G[8] = A[8] & B[8];
  assign P[9] = A[9] | B[9]; 
  assign G[9] = A[9] & B[9];
  assign P[10] = A[10] | B[10]; 
  assign G[10] = A[10] & B[10];
  assign P[11] = A[11] | B[11]; 
  assign G[11] = A[11] & B[11];
  assign P[12] = A[12] | B[12]; 
  assign G[12] = A[12] & B[12];
  assign P[13] = A[13] | B[13]; 
  assign G[13] = A[13] & B[13];
  assign P[14] = A[14] | B[14]; 
  assign G[14] = A[14] & B[14];
  assign P[15] = A[15] | B[15]; 
  assign G[15] = A[15] & B[15];*/
  
  // computing the solid black square blocks
  wire [15:0] P_block;
  wire [15:0] G_block;
  
  // level 1 (k = 0)
  assign P_block[0] = P[0] & P_negative1; // block 0:-1
  assign G_block[0] = G[0] | (P[0] & G_negative1); // 0:-1
  
  assign P_block[1] = P[2] & P[1]; // block 2:1
  assign G_block[1] = G[2] | (P[2] & G[1]); // 2:1
  
  assign P_block[2] = P[4] & P[3]; // block 4:3
  assign G_block[2] = G[4] | (P[4] & G[3]);
  
  assign P_block[3] = P[6] & P[5]; // block 6:5
  assign G_block[3] = G[6] | (P[6] & G[5]);

  assign P_block[4] = P[8] & P[7]; // block 8:7
  assign G_block[4] = G[8] | (P[8] & G[7]);

  assign P_block[5] = P[10] & P[9]; // block 10:9
  assign G_block[5] = G[10] | (P[10] & G[9]);

  assign P_block[6] = P[12] & P[11]; // block 12:11
  assign G_block[6] = G[12] | (P[12] & G[11]);

  assign P_block[7] = P[14] & P[13]; // block 14:13
  assign G_block[7] = G[14] | (P[14] & G[13]);
  
  
  // level 2
  assign P_block[8] = P_block[0] & P[1]; // block 1:-1
  assign G_block[8] = G[1] | (P[1] & G_block[0]);
  
  assign P_block[9] = P_block[0] & P_block[1];// block 2:-1
  assign G_block[9] = G_block[1] | (P_block[1] & G_block[0]);
  
  assign P_block[10] = P_block[2] & P[5]; // block 5:3
  assign G_block[10] = G[5] | (P[5] & G_block[2]);
  
  assign P_block[11] = P_block[2] & P_block[3];// block 6:3
  assign G_block[11] = G_block[3] | (P_block[3] & G_block[2]);
  
  assign P_block[12] = P_block[4] & P[9]; // block 9:7
  assign G_block[12] = G[9] | (P[9] & G_block[4]);
  
  assign P_block[13] = P_block[4] & P_block[5]; // block 10:7
  assign G_block[13] = G_block[5] | (P_block[5] & G_block[4]);
  
  assign P_block[14] = P_block[6] & P[13]; // block 13:11
  assign G_block[14] = G[13] | (P[13] & G_block[6]);
  
  assign P_block[15] = P_block[6] & P_block[7]; // block 14:11
  assign G_block[15] = G_block[7] | (P_block[7] & G_block[6]);
  
  // level 3
  wire [15:0] P_block2;
  wire [15:0] G_block2;
  
  assign P_block2[0] = P_block[9] & P[3]; // block 3:-1
  assign G_block2[0] = G[3] | (P[3] & G_block[9]);
  
  assign P_block2[1] = P_block[9] & P_block[2]; // block 4:-1
  assign G_block2[1] = G_block[2] | (P_block[2] & G_block[9]);
  
  assign P_block2[2] = P_block[9] & P_block[10]; // block 5:-1
  assign G_block2[2] = G_block[10] | (P_block[10] & G_block[9]);
  
  assign P_block2[3] = P_block[9] & P_block[11]; // block 6:-1
  assign G_block2[3] = G_block[11] | (P_block[11] & G_block[9]);
  
  assign P_block2[4] = P_block[13] & P[11]; // block 11:7
  assign G_block2[4] = G[11] | (P[11] & G_block[13]);
  
  assign P_block2[5] = P_block[13] & P_block[6]; // block 12:7
  assign G_block2[5] = G_block[6] | (P_block[6] & G_block[13]);
  
  assign P_block2[6] = P_block[13] & P_block[14]; // block 13:7
  assign G_block2[6] = G_block[14] | (P_block[14] & G_block[13]);
  
  assign P_block2[7] = P_block[13] & P_block[15]; // block 14:7
  assign G_block2[7] = G_block[15] | (P_block[15] & G_block[13]);
  
  
  // level 4
  assign P_block2[8] = P[7] & P_block2[3]; // block 7:-1
  assign G_block2[8] = G[7] | (P[7] & G_block2[3]);
  
  assign P_block2[9] = P_block[4] & P_block2[3]; // block 8:-1
  assign G_block2[9] = G_block[4] | (P_block[4] & G_block2[3]);
  
  assign P_block2[10] = P_block[12] & P_block2[3]; // block 9:-1
  assign G_block2[10] = G_block[12] | (P_block[12] & G_block2[3]);
  
  assign P_block2[11] = P_block[13] & P_block2[3]; // block 10:-1
  assign G_block2[11] = G_block[13] | (P_block[13] & G_block2[3]);
  
  assign P_block2[12] = P_block2[4] & P_block2[3]; // block 11:-1
  assign G_block2[12] = G_block2[4] | (P_block2[4] & G_block2[3]);
  
  assign P_block2[13] = P_block2[5] & P_block2[3]; // block 12:-1
  assign G_block2[13] = G_block2[5] | (P_block2[5] & G_block2[3]);
  
  assign P_block2[14] = P_block2[6] & P_block2[3]; // block 13:-1
  assign G_block2[14] = G_block2[6] | (P_block2[6] & G_block2[3]);
  
  assign P_block2[15] = P_block2[7] & P_block2[3]; // block 14:-1
  assign G_block2[15] = G_block2[7] | (P_block2[7] & G_block2[3]);
  
  // Post computation block
  assign S[0] = G_negative1 ^ A[0] ^ B[0];
  assign S[1] = G_block[0] ^ A[1] ^ B[1]; 
  assign S[2] = G_block[8] ^ A[2] ^ B[2]; 
  assign S[3] = G_block[9] ^ A[3] ^ B[3]; 
  assign S[4] = G_block2[0] ^ A[4] ^ B[4]; 
  assign S[5] = G_block2[1] ^ A[5] ^ B[5]; 
  assign S[6] = G_block2[2] ^ A[6] ^ B[6]; 
  assign S[7] = G_block2[3] ^ A[7] ^ B[7]; 
  assign S[8] = G_block2[8] ^ A[8] ^ B[8]; 
  assign S[9] = G_block2[9] ^ A[9] ^ B[9]; 
  assign S[10] = G_block2[10] ^ A[10] ^ B[10]; 
  assign S[11] = G_block2[11] ^ A[11] ^ B[11]; 
  assign S[12] = G_block2[12] ^ A[12] ^ B[12]; 
  assign S[13] = G_block2[13] ^ A[13] ^ B[13]; 
  assign S[14] = G_block2[14] ^ A[14] ^ B[14]; 
  assign S[15] = G_block2[15] ^ A[15] ^ B[15];
  
  assign Cout = G[15] | (P[15] & G_block2[15]);


endmodule

// 3b


module PPA_tb;
  
  reg [15:0] A, B;
  reg Cin;
  wire [15:0] S;
 
  PPA DUT (
    .A(A), 
    .B(B), 
    .Cin(Cin), 
    .S(S), 
    .Cout(Cout)
  );
  
  initial begin
    
    A = 16'b0000000000000001; // with no carry in
    B = 16'b0000000000000010; 
    Cin = 0;
    #10;
    $display("%b %b \n", S, Cout);
    
    A = 16'b0000000000000001; // with carry in
    B = 16'b0000000000000001; 
    Cin = 1;
    #10;
    $display("%b %b \n", S, Cout);
    
    A = 16'b0111111111111111; // 0x7FFF + 0x7FFF
    B = 16'b0111111111111111; // should equal 0xFFFE
    Cin = 0;
    #10;
    $display("%b %b \n", S, Cout);

    
    A = 16'b1111111111111111; // 0xFFFF + 0xFFFF
    B = 16'b1111111111111111; // should equal 1xFFFE
    Cin = 0;
    #10;
    $display("%b %b \n", S, Cout);

    

  end
 
endmodule

// 4a

`timescale 1ns/1ps

module sum_stage (pi, prev_ci, sum1);
   input pi, prev_ci;
   output sum1;
   wire n1, n2, n3;

   assign n1 = pi | prev_ci;     // A OR B
   assign n2 = pi & prev_ci;     // A AND B
   assign n3 = ~n2;              // NOT (A AND B)
   assign sum1 = n1 & n3;        // (A OR B) AND (NOT (A AND B))

endmodule

module pg_stage (pi, gi, prev_pi, prev_gi, p, g);
   input pi, gi, prev_pi, prev_gi;
   output p, g;
   wire   pi, gi, prev_pi, prev_gi, p, g;

   assign p = pi & prev_pi;
   assign g = gi | (pi & prev_gi);
endmodule // pg_stage

module pre_adder(a, b, p, g);
   input a, b;
   output p, g;
   wire n1, n2;

   assign g = a & b;      // Generate term (AND)
   assign n1 = a | b;     // OR operation
   assign n2 = ~g;        // NOT g
   assign p = n1 & n2;    // XOR using AND and OR

endmodule

module kogge_stone (carry_in, a, b, carry_out, sum_out);
   parameter nbits = 16;
   localparam depth = $clog2(nbits);

   input wire carry_in;
   input wire [nbits-1:0] a, b;
   output wire carry_out;
   output wire [nbits-1:0] sum_out;

   wire [nbits:0] p [depth:0];
   wire [nbits:0] g [depth:0];
   wire [nbits-1:0] sum;

   genvar x, y;

   function integer flog2;
      input integer in;
      begin
         in = in >> 1;
         for (flog2 = 0 ; in != 0 ; flog2 = flog2 + 1)
           in = in >> 1;
      end
   endfunction // flog2

   assign g[0][0] = carry_in;
   assign p[0][0] = 0;

   generate
      for (x = 0 ; x < nbits ; x = x+1) begin
         pre_adder pa (.a(a[x]), .b(b[x]), .p(p[0][x+1]), .g(g[0][x+1]));
        sum_stage so (.pi(p[0][x+1]), .prev_ci(g[depth][x]), .sum1(sum[x]));
      end
   endgenerate

   generate
      for (x = 0 ; x <= nbits ; x = x+1) begin
         for (y = 0 ; y < depth ; y = y+1) begin
            if ((x > 0) && (flog2(x) >= y)) begin
               pg_stage pg (.pi(p[y][x]), .gi(g[y][x]),
                            .prev_pi(p[y][x-(2**y)]),
                            .prev_gi(g[y][x-(2**y)]),
                            .p(p[y+1][x]), .g(g[y+1][x]));
            end else begin
               assign p[y+1][x] = p[y][x];
               assign g[y+1][x] = g[y][x];
            end
         end
      end
   endgenerate

   assign carry_out = g[depth][nbits];
   assign sum_out = sum;
endmodule // kogge_stone


// 4b

`timescale 1ns/1ps

module kogge_stone_tb;
    parameter nbits = 16;
    
    // Testbench signals
    reg carry_in;
    reg [nbits-1:0] a, b;
    wire carry_out;
    wire [nbits-1:0] sum_out;
    
    // Instantiate the Kogge-Stone adder
    kogge_stone uut (
        .carry_in(carry_in),
        .a(a),
        .b(b),
        .carry_out(carry_out),
        .sum_out(sum_out)
    );
    
    // Test process
    initial begin
        $dumpfile("kogge_stone_tb.vcd");
        $dumpvars(0, kogge_stone_tb);
        
        // Test Case 1: Zero inputs
        a = 16'b0000000000000000;
        b = 16'b0000000000000000;
        carry_in = 0;
        #10;
        $display("TC1 - a: %b, b: %b, carry_in: %b => sum_out: %b, carry_out: %b", a, b, carry_in, sum_out, carry_out);
        
        // Test Case 2: Add small numbers
        a = 16'b0000000000000011;  // 3
        b = 16'b0000000000000101;  // 5
        carry_in = 0;
        #10;
        $display("TC2 - a: %b, b: %b, carry_in: %b => sum_out: %b, carry_out: %b", a, b, carry_in, sum_out, carry_out);
        
        // Test Case 3: Add with carry-in
        a = 16'b0000000000001100;  // 12
        b = 16'b0000000000000011;  // 3
        carry_in = 1;
        #10;
        $display("TC3 - a: %b, b: %b, carry_in: %b => sum_out: %b, carry_out: %b", a, b, carry_in, sum_out, carry_out);
        
        // Test Case 4: Add large numbers
        a = 16'b1111000011110000;  // 0xF0F0
        b = 16'b0000111100001111;  // 0x0F0F
        carry_in = 0;
        #10;
        $display("TC4 - a: %b, b: %b, carry_in: %b => sum_out: %b, carry_out: %b", a, b, carry_in, sum_out, carry_out);
        
        // Test Case 5: All ones
        a = 16'b1111111111111111;
        b = 16'b1111111111111111;
        carry_in = 0;
        #10;
        $display("TC5 - a: %b, b: %b, carry_in: %b => sum_out: %b, carry_out: %b", a, b, carry_in, sum_out, carry_out);
        
        // End simulation
        $display("Testbench complete");
        $finish;
    end
endmodule
