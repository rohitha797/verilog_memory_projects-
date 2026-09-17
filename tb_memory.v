`timescale 1ns / 1ps

module tb_memory;

    // Inputs
    reg clk;
    reg we;
    reg [3:0] addr;
    reg [7:0] din;

    // Outputs
    wire [7:0] dout;

    // Instantiate the Unit Under Test (UUT)
    single_port_ram uut (
        .clk(clk),
        .we(we),
        .addr(addr),
        .din(din),
        .dout(dout)
    );

    // Clock generation (Period = 10ns)
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        we = 0;
        addr = 0;
        din = 0;

        // Wait 20ns for global reset
        #20;
        
        // --- TEST CASE 1: Writing Data ---
        $display("--- Writing Data to Memory ---");
        we = 1; 
        
        addr = 4'h0; din = 8'hAA; #10; // Write AA to address 0
        addr = 4'h1; din = 8'hBB; #10; // Write BB to address 1
        addr = 4'h5; din = 8'hCC; #10; // Write CC to address 5
        
        // --- TEST CASE 2: Reading Data ---
        $display("--- Reading Data from Memory ---");
        we = 0; // Disable write, enable read
        
        addr = 4'h0; #10; // Read from address 0 (Expected: AA)
        addr = 4'h1; #10; // Read from address 1 (Expected: BB)
        addr = 4'h5; #10; // Read from address 5 (Expected: CC)
        addr = 4'h2; #10; // Read from empty address 2 (Expected: Unknown/0)

        // End Simulation
        $display("--- Simulation Finished ---");
        $finish;
    end
      
endmodule
