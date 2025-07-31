module ShiftRegister (
    input clk,
    input rst,
    input ld,
    input shft_en,
    input mode,       // 0: PISO, 1: SIPO
    input dir,        // 0: Right, 1: Left
    input se_in,
    input [3:0] pa_in,
    output reg [3:0] shft_reg,
    output reg [3:0] pa_out,
    output reg se_out
);


always @(posedge clk or posedge rst) begin
    if (rst) begin
        shft_reg <= 4'b0000;
        se_out <= 0;
        pa_out <= 4'b0000;
    end else if (ld) begin
        shft_reg <= pa_in;
    end else if (shft_en) begin
        if (mode == 1'b0) begin  // PISO
            if (dir == 1'b0) begin  // Right shift
                se_out <= shft_reg[0];
                shft_reg <= {1'b0, shft_reg[3:1]};
            end else begin         // Left shift
                se_out <= shft_reg[3];
                shft_reg <= {shft_reg[2:0], 1'b0};
            end
        end else begin  // SIPO
            if (dir == 1'b0) begin  // Right shift-in
                shft_reg <= {se_in, shft_reg[3:1]};
            end else begin         // Left shift-in
                shft_reg <= {shft_reg[2:0], se_in};
            end
        end
    end
    pa_out <= shft_reg;
end

endmodule
