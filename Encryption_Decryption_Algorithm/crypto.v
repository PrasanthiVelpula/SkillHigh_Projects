//Top module
module crypto (clk, rst, enable, plain_data, encrypted_data, decrypted_data);
input clk, rst, enable;
input  [7:0] plain_data;
output [7:0] encrypted_data;
output [7:0] decrypted_data;
wire [7:0] key;

LFSR Keygeneration(.clk(clk), .rst(rst), .enable(enable), .keystream(key));
encrypt enc(.d_in(plain_data), .key(key), .d_out(encrypted_data));
decrypt dec(.d_in(encrypted_data), .key(key), .d_out(decrypted_data));
endmodule

// Linear Feedback Shift Register
module LFSR(clk, rst, enable, keystream);
input clk, rst, enable;
output reg [7:0] keystream;
reg [7:0] lfsr;
always @(posedge clk or posedge rst) 
begin
    if(rst)
        lfsr <= 8'b10101100;
    else if(enable)
        lfsr <= {lfsr[6:0], lfsr[7]^lfsr[6]^lfsr[5]^lfsr[4]^lfsr[3]};
end
always @(*)
begin
    keystream = lfsr;
end
endmodule

// S-Box module for encryption
module sbox_encrypt(d_in, d_out);
input  [7:0] d_in;
output [7:0] d_out;
function [3:0] sbox;
    input [3:0] nibble;
    case (nibble)
        4'h0: sbox = 4'h6;  4'h1: sbox = 4'h4;  4'h2: sbox = 4'hC;  4'h3: sbox = 4'h5;
        4'h4: sbox = 4'h0;  4'h5: sbox = 4'h7;  4'h6: sbox = 4'h2;  4'h7: sbox = 4'hE;
        4'h8: sbox = 4'h1;  4'h9: sbox = 4'hF;  4'hA: sbox = 4'h3;  4'hB: sbox = 4'hD;
        4'hC: sbox = 4'h8;  4'hD: sbox = 4'hA;  4'hE: sbox = 4'h9;  4'hF: sbox = 4'hB;
        default: sbox = 4'h0;
    endcase
endfunction
assign d_out = {sbox(d_in[7:4]), sbox(d_in[3:0])};
endmodule

// S-Box for decryption
module sbox_decrypt(d_in, d_out);
input  [7:0] d_in;
output [7:0] d_out;
function [3:0] inv;
    input [3:0] nibble;
    case (nibble)
        4'h6: inv = 4'h0;  4'h4: inv = 4'h1;  4'hC: inv = 4'h2;  4'h5: inv = 4'h3;
        4'h0: inv = 4'h4;  4'h7: inv = 4'h5;  4'h2: inv = 4'h6;  4'hE: inv = 4'h7;
        4'h1: inv = 4'h8;  4'hF: inv = 4'h9;  4'h3: inv = 4'hA;  4'hD: inv = 4'hB;
        4'h8: inv = 4'hC;  4'hA: inv = 4'hD;  4'h9: inv = 4'hE;  4'hB: inv = 4'hF;
        default: inv = 4'h0;
    endcase
endfunction
assign d_out = {inv(d_in[7:4]), inv(d_in[3:0])};
endmodule

//Encryption Module
module encrypt(d_in, key, d_out);
input  [7:0] d_in;
input  [7:0] key;
output [7:0] d_out;
wire [7:0] xor_out, rot_out, sbox_out;

assign xor_out = d_in ^ key;
assign rot_out = {xor_out[6:0], xor_out[7]}; // Left rotate by 1
sbox_encrypt SBOX(.d_in(rot_out), .d_out(sbox_out));
assign d_out = sbox_out;
endmodule

//Decryption Module
module decrypt (d_in, key, d_out);
input  [7:0] d_in;
input  [7:0] key;
output [7:0] d_out;
wire [7:0] invsbox_out, rot_out;

sbox_decrypt INV(.d_in(d_in), .d_out(invsbox_out));
assign rot_out = {invsbox_out[0], invsbox_out[7:1]}; // Right rotate by 1
assign d_out = rot_out ^ key;
endmodule

