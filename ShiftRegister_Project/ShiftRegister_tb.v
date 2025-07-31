module shftregtb;

    reg clk, rst, ld, shft_en, mode, dir;
    reg se_in;
    reg [3:0] pa_in;
    wire [3:0] shft_reg;
    wire [3:0] pa_out;
    wire se_out;

    // Instantiate the shift register module
    ShiftRegister uut (
        .clk(clk),
        .rst(rst),
        .ld(ld),
        .shft_en(shft_en),
        .mode(mode),
        .dir(dir),
        .se_in(se_in),
        .pa_in(pa_in),
        .shft_reg(shft_reg),
        .pa_out(pa_out),
        .se_out(se_out)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        $dumpfile("ShiftRegister.vcd");
        $dumpvars(0, shftregtb);
    end

    initial begin
        // Monitor internal and external signals
        $monitor("Time=%0t : clk = %b : Mode=%b : Dir=%b : Ld=%b : ShftEn=%b : se_in=%b : pa_in=%b : pa_out=%b : se_out=%b : shftreg=%b",
                 $time, clk, mode, dir, ld, shft_en, se_in, pa_in, pa_out, se_out, shft_reg);

        // Initialize inputs
        clk = 0;
        rst = 1;
        ld = 0;
        shft_en = 0;
        mode = 0;   // 0 = PISO
        dir = 0;    // 0 = shift right, 1 = shift left
        se_in = 0;
        pa_in = 4'b0000;

        // Release reset
        #10 rst = 0;

        // --- PISO Test: Load 1011 and shift right ---
        mode = 0;
        ld = 1; pa_in = 4'b1011; #10;
        ld = 0; shft_en = 1; dir = 0; // Shift right
        #40;

        // Reset before SIPO test
        rst = 1; #10; rst = 0;

        // --- SIPO Test: shift in 1101 left ---
        mode = 1; dir = 1; shft_en = 1;
        se_in = 1; #10;
        se_in = 1; #10;
        se_in = 0; #10;
        se_in = 1; #10;

        $finish;
    end

endmodule
