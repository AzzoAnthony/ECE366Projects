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