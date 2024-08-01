module controller(clk,rst,ready,start,clear,count_comp,Qo_Q1,mux_sel_Mul,mux_sel_Shift);
input logic clk,rst,start,count_comp;
input logic [1:0] Qo_Q1;
output logic ready,mux_sel_Mul,clear;
output logic [1:0] mux_sel_Shift;

parameter S0 = 1'b0, S1 = 1'b1;
logic state,n_state;

always @(posedge clk or negedge rst) 
    begin
        if (!rst) 
        begin
            state <= S0;
        end 
        else 
        begin
            state <= n_state;
        end
    end
always @(*) 
    begin
        case (state) 
            S0 : begin
                if (!start)begin
                    clear   = 1'b1;
                    ready   = 1'b0;
                mux_sel_Mul = 1'bx;
              mux_sel_Shift = 2'bx;
                    n_state = S0;
                end
                else begin
                    clear   = 1'b0;
                    ready   = 1'b0;
                mux_sel_Mul = 1'b0;
              mux_sel_Shift = 2'bx;
                    n_state = S1;
                end   
            end
            S1 : begin
                if ( count_comp == 1'b1)begin
                    clear   = 1'b1;
                    ready   = 1'b1;
                mux_sel_Mul = 1'bx;
                    n_state = S0;
                     case (Qo_Q1)
                    2'b01 : mux_sel_Shift = 2'b01 ;
                    2'b10 : mux_sel_Shift = 2'b10;
                    2'b00 : mux_sel_Shift = 2'b00;
                    2'b11 : mux_sel_Shift = 2'b11;
                    endcase
                end
                else begin
                    clear   = 1'b0;
                    ready   = 1'b0;
                mux_sel_Mul = 1'b1;
                    n_state = S1;
                    case (Qo_Q1)
                    2'b01 : mux_sel_Shift = 2'b01 ;
                    2'b10 : mux_sel_Shift = 2'b10;
                    2'b00 : mux_sel_Shift = 2'b00;
                    2'b11 : mux_sel_Shift = 2'b11;
                    endcase
                end
                
            end   
        endcase
    end



endmodule