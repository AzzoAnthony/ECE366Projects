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
