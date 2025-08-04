module crypto_tb;
    reg clk = 0, rst = 0, enable = 0;
    reg [7:0] plain_data;
    wire [7:0] encrypted_data, decrypted_data;

    crypto uut (.clk(clk), .rst(rst), .enable(enable), .plain_data(plain_data), .encrypted_data(encrypted_data), .decrypted_data(decrypted_data));
    always #5 clk = ~clk;

    initial begin
        $dumpfile("crypto.vcd");
        $dumpvars(0, crypto_tb);
    end
    initial begin
        $display("Time\tPlain\tEncrypted\tDecrypted");
        $monitor("%0dns\t%h\t%h\t\t%h", $time, plain_data, encrypted_data, decrypted_data);
    end
    initial begin
      
        rst = 1; enable = 0; plain_data = 8'h00;
        #5 rst = 0; enable = 1;

        #5 plain_data = 8'hA5; 
        #5 plain_data = 8'h3C; 
        #5 plain_data = 8'hFF; 
        #5 plain_data = 8'h00; 
        #5 plain_data = 8'h69; 
        #10 $finish;
    end

endmodule
