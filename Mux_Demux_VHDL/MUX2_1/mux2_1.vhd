library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2_1 is
    Port (
        a   : in  STD_LOGIC;
        b   : in  STD_LOGIC;
        sel : in  STD_LOGIC;
        y   : out STD_LOGIC
    );
end mux2_1;

architecture rtl of mux2_1 is
begin
    y <= a when sel = '0' else b;
end rtl;
