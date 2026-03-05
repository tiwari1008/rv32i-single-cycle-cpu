`timescale 1ns / 1ps

module riscv_tb();
    reg clk;
    reg rst;

    // Instantiate Top Module
    riscv_top uut (
        .clk(clk),
        .rst(rst)
    );

    // Clock Generation (100MHz)
    always #5 clk = ~clk;

    initial begin
        // Initialize
        clk = 0;
        rst = 1;
        
        // Hold reset for 20ns
        #20;
        rst = 0;

        // Monitor Register Writes
        $display("Time\t PC \t\t Instr \t\t Result");
        $monitor("%0t\t %h\t %h\t %h", $time, uut.DP.pc_current, uut.instruction_wire, uut.DP.write_back_data);

        // Run for 200ns (enough to cover the pre-loaded instructions)
        #500;
        
        $display("Simulation Finished. Check waves for register values.");
        $stop;
    end

    // Helper to see inside the Register File during simulation
    integer j;
    initial begin
        #480; // Wait until near the end
        $display("\n--- Final Register File State ---");
        for (j = 0; j < 15; j = j + 1) begin
            $display("x%0d = %h", j, uut.DP.RF.reg_mem[j]);
        end
    end

endmodule