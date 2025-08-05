library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux1_2 is
    Port (
        din : in  STD_LOGIC;
        sel : in  STD_LOGIC;
        y0  : out STD_LOGIC;
        y1  : out STD_LOGIC
    );
end demux1_2;

architecture rtl of demux1_2 is
begin
    y0 <= din when sel = '0' else '0';
    y1 <= din when sel = '1' else '0';
end rtl;
