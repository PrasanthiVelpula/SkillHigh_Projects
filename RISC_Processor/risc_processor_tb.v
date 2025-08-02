module risc_processor_tb;
    reg clk = 0;
    wire [3:0] alu_result, R0, R1, R2, R3;
    wire [7:0] ins_out;

    CPU uut(clk, alu_result, R0, R1, R2, R3, ins_out);

    initial begin
        $dumpfile("risc_processor.vcd");
        $dumpvars(0,risc_processor_tb);
    end

    always #5 clk = ~clk;

    initial begin
        $display("Time | INS      | ALU | R0 R1 R2 R3");
        $monitor("%4t | %b | %2d  | %2d %2d %2d %2d", $time, ins_out, alu_result, R0, R1, R2, R3);
        #100 $finish;
    end
endmodule
