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