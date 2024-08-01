
module Seq_Mul_top_tb;

    // Inputs
    logic signed [15:0] Multiplicand;
    logic signed [15:0] Multiplier;
    logic clk;
    logic rst;
    logic start;

    //refernce model output
    logic signed [31:0] exp;

    // Outputs
    logic ready;
    logic signed [31:0] Product;

    // Instantiate the Unit Under Test (UUT)
    Seq_Mul_top uut (
        .Multiplicand(Multiplicand),
        .Multiplier(Multiplier),
        .clk(clk),
        .rst(rst),
        .start(start),
        .ready(ready),
        .Product(Product)
    );

    // Clock generation
    initial begin
        clk = 1;
        forever #5 clk = ~clk; // 10 ns period clock
    end

    // Dump file for waveform
    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, Seq_Mul_top_tb);
    end

    // Task for driving inputs
    task drive_inputs(input logic signed [15:0] in1, input logic signed [15:0] in2);
        begin
            Multiplicand = in1;
            Multiplier = in2;
            start = 1;
            @(posedge clk);
            start = 0;
        end
    endtask

    // Task for monitoring outputs
    task monitor_outputs;
        begin
            wait (ready == 1);
            exp = Multiplicand * Multiplier;
            if(exp != Product)begin
                $display("Fail");
                $display("A = %0h, B = %0h, P = %0h,E= %0h", Multiplicand, Multiplier, Product,exp);
            end
            else
            begin
                $display("pass");
                $display("A = %0h, B = %0h, P = %0h,E= %0h", Multiplicand, Multiplier, Product,exp);
            end
        end
    endtask

    // Stimulus process
    initial begin
        // Initialize Inputs
        Multiplicand = 0;
        Multiplier = 0;
        rst = 0;
        start = 0;
        @(posedge clk);
        rst = 1;
        for(int i=0;i<30;i++)begin 
            //Non Random testing
            drive_inputs(0+i,10+i); 
            monitor_outputs();
            @(posedge clk);
            //Random Testing
            drive_inputs($random % 65536,$random % 65536); 
            monitor_outputs();
            @(posedge clk);

        end
        $finish;
    end
endmodule
