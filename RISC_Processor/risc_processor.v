// CPU
module CPU (clk, alu_result, R0, R1, R2, R3, ins_out);
    input clk;
    output [3:0] alu_result;
    output [3:0] R0, R1, R2, R3;
    output [7:0] ins_out;

    reg [3:0] pc = 0;
    wire [7:0] instruction;
    wire [3:0] opcode;
    wire [1:0] rd, rs;
    wire [3:0] rs_data;
    wire [3:0] rd_data;
    wire write_enable = (opcode != 4'b0000);

    Memory mem(pc, instruction);
    ControlUnit cu(instruction, opcode, rd, rs);
    RegisterFile RF(.clk(clk), .rd_addr(rd), .rs_addr(rs), .write_data(alu_result), .write_enable(write_enable), .rd_data(rd_data), .rs_data(rs_data), .R0(R0), .R1(R1), .R2(R2), .R3(R3));
    ALU alu(rd_data, rs_data, opcode, alu_result);

    assign ins_out = instruction;

    always @(posedge clk) begin
        pc <= pc + 1;
    end
endmodule

// Control Unit
module ControlUnit (instruction, opcode, rd, rs);
    input [7:0] instruction;
    output [3:0] opcode;
    output [1:0] rd;
    output [1:0] rs;
    assign opcode = instruction[7:4];
    assign rd = instruction[3:2];
    assign rs = instruction[1:0];
endmodule

// Memory Unit
module Memory (address, instruction);
    input [3:0] address;
    output reg [7:0] instruction;

    reg [7:0] mem [0:15];

    always @(*) begin
        instruction = mem[address];
    end

    initial begin
        mem[0] = 8'b00000000; 
        mem[1] = 8'b00111101; 
        mem[2] = 8'b00101000; 
        mem[3] = 8'b00011001; 
        mem[4] = 8'b01001101; 
        mem[5] = 8'b01010100; 
        mem[6] = 8'b01100101; 
        mem[7] = 8'b00000100; 
    end
endmodule

// Register file
module RegisterFile (clk, rd_addr, rs_addr, write_data, write_enable, rd_data, rs_data, R0, R1, R2, R3);
    input clk;
    input [1:0] rd_addr, rs_addr;
    input [3:0] write_data;
    input write_enable;
    output [3:0] rd_data;  
    output [3:0] rs_data;
    output [3:0] R0, R1, R2, R3;

    reg [3:0] regfile [3:0];

    assign rd_data = regfile[rd_addr];  
    assign rs_data = regfile[rs_addr];
    assign R0 = regfile[0];
    assign R1 = regfile[1];
    assign R2 = regfile[2];
    assign R3 = regfile[3];

    always @(posedge clk) begin
        if (write_enable)
            regfile[rd_addr] <= write_data;
    end

    initial begin
        regfile[0] = 4'd2;
        regfile[1] = 4'd8;
        regfile[2] = 4'd0;
        regfile[3] = 4'd1;
    end
endmodule

module ALU (a, b, opcode, result);
    input [3:0] a, b;
    input [3:0] opcode;
    output reg [3:0] result;

    always @(*) begin
        case (opcode)
            4'b0001: result = a + b;   
            4'b0010: result = b;        
            4'b0011: result = a - b;                
            4'b0100: result = a & b;         
            4'b0101: result = a | b;         
            4'b0110: result = a ^ b;        
            default: result = 4'b0000;
        endcase
    end
endmodule
