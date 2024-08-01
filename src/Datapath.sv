module Datapath(Multiplicand,Multiplier,clk,rst,Product,Qo_Q1,mux_sel_Mul,mux_sel_Shift,clear,count_comp);
input logic [15:0] Multiplicand,Multiplier;  
input logic clk,rst,mux_sel_Mul,clear;
input logic [1:0] mux_sel_Shift;
output logic count_comp;
output logic [1:0] Qo_Q1;
output logic [31:0] Product;

// intermediate wires
logic [31:0] shifted,combined;
logic [15:0] M,A,Q,Q_in,A_in,mux_out;
logic [4:0] counter;
logic Q1,Q1_in;

//mux to choose Q from in or shifted value
assign Q_in = ( ~mux_sel_Mul)? Multiplier:shifted[15:0];

//assigning Q1 in to 0th bit shifted
assign Q1_in = combined[0];

//assigning A in from bit 32:17 of shifted
assign A_in = ( ~mux_sel_Mul)? 0 :shifted[31:16];

//Registers for storing Accumulator,multiplier,multiplicand
always@( posedge clk or negedge rst) begin
    if (!rst)
    begin
        M <= 0;
        A <= 0;
        Q <= 0;
        Q1<= 0;
   counter<= 0;
    end
    else if ( clear == 1'b1)
    begin
        M <= 0;
        A <= 0;
        Q <= 0; 
        Q1<= 0;
   counter<= 0;
    end
    else 
    begin
        M <= Multiplicand;
        A <= A_in;
        Q <= Q_in;
        Q1<= Q1_in;
   counter<= counter + 1; 
    end    
end

//Now making an output wire so controller can choose what to perform
assign Qo_Q1 = { Q[0],Q1 };

//now choosing logic for shifing
always@(*)
begin
    case (mux_sel_Shift)
         2'b01 : mux_out = A + M;
         2'b10 : mux_out = A - M;
        default: mux_out = A; 
    endcase 
end

//concatinating wires for shifting
assign combined = { mux_out,Q};

//now shifting right
assign shifted = {combined[31],combined[31:1]};

//output signal for counting
assign count_comp = ( counter == 16 ) ? 1:0;


  assign  Product = shifted;



endmodule