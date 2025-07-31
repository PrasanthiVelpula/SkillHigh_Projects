module main_ALU(A, B, opcode, Out); // Top main ALU
input [1:0] A;
input [1:0] B;
input [2:0] opcode;
output [1:0] Out;
wire [2:0] ctrl;

CtrlUnit CU(.opcode(opcode), .ctrl(ctrl));
ALU a1(.A(A), .B(B), .ctrl(ctrl), .Out(Out));

endmodule

module CtrlUnit(opcode, ctrl); // Control Unit
input [2:0] opcode;
output reg [2:0] ctrl;

always @(*) 
begin
	case(opcode)
		3'b000: ctrl = 3'b000;
		3'b001: ctrl = 3'b001;
		3'b010: ctrl = 3'b010;
		3'b011: ctrl = 3'b011;
		3'b100: ctrl = 3'b100;
		default: ctrl = 3'bxxx;
	endcase
end
endmodule

module ALU(A, B, ctrl, Out); // ALU
input [1:0] A;
input [1:0] B;
input [2:0] ctrl;
output reg [1:0] Out;

always @(*) 
begin
	case(ctrl)
		3'b000: Out = A+B;
		3'b001: Out = A-B;
		3'b010: Out = A&B;
		3'b011: Out = A|B;
		3'b100: Out = A^B;
		default: Out = 2'bxx;
	endcase
end
endmodule







		
