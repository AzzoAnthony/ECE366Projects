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