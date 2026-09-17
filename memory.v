module single_port_ram (
    input clk,
    input we,                  // Write Enable
    input [3:0] addr,          // 4-bit Address (16 locations)
    input [7:0] din,           // 8-bit Data Input
    output reg [7:0] dout      // 8-bit Data Output
);

    // Memory array declaration (16 words of 8-bits each)
    reg [7:0] ram [15:0];

    always @(posedge clk) begin
        if (we) begin
            ram[addr] <= din;  // Write operation
        end
        dout <= ram[addr];     // Read operation
    end

endmodule
