// Code your testbench here
// or browse Examples



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