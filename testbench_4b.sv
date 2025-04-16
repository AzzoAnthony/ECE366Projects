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
