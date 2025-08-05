library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_demux1_2 is
end tb_demux1_2;

architecture behavior of tb_demux1_2 is
    signal din, sel, y0, y1 : std_logic;

    component demux1_2
        Port (
            din   : in  STD_LOGIC;
            sel   : in  STD_LOGIC;
            y0    : out STD_LOGIC;
            y1    : out STD_LOGIC
        );
    end component;

begin
    uut: demux1_2 port map (din => din, sel => sel, y0 => y0, y1 => y1);

    stim_proc: process
    begin
        din <= '1'; sel <= '0'; wait for 10 ns;
        report "DEMUX sel=0 | din=1 => y0=" & std_logic'image(y0) & " y1=" & std_logic'image(y1);

        sel <= '1'; wait for 10 ns;
        report "DEMUX sel=1 | din=1 => y0=" & std_logic'image(y0) & " y1=" & std_logic'image(y1);

        din <= '0'; sel <= '0'; wait for 10 ns;
        report "DEMUX sel=0 | din=0 => y0=" & std_logic'image(y0) & " y1=" & std_logic'image(y1);

        sel <= '1'; wait for 10 ns;
        report "DEMUX sel=1 | din=0 => y0=" & std_logic'image(y0) & " y1=" & std_logic'image(y1);

        wait;
    end process;
end behavior;
