module ALU_tb;
reg [1:0] A,B;
reg [2:0] opcode;
wire [1:0] Out;

main_ALU uut(.A(A), .B(B), .opcode(opcode), .Out(Out));

initial begin
$dumpfile("ALU.vcd");
$dumpvars(0,ALU_tb);
end

initial begin
	A = 2'b01; B = 2'b10;

	opcode = 3'b000;
	#10; opcode = 3'b001;
	#10; opcode = 3'b010;
	#10; opcode = 3'b011;
	#10; opcode = 3'b100;
	#10; opcode = 3'b101;

	A = 2'b11; B = 2'b00;

	opcode = 3'b000;
	#10; opcode = 3'b001;
	#10; opcode = 3'b010;
	#10; opcode = 3'b011;
	#10; opcode = 3'b100;
	#10; opcode = 3'b101;
	
	#60; $finish;
end
initial begin
	$monitor("%t, A = %b, B = %b, Opcode = %b, Output = %b",$time, A, B, opcode, Out); 
end
endmodule

