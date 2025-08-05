library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_mux2_1 is
end tb_mux2_1;

architecture behavior of tb_mux2_1 is
    signal a, b, sel, y : std_logic;

    component mux2_1
        Port (
            a     : in  STD_LOGIC;
            b     : in  STD_LOGIC;
            sel   : in  STD_LOGIC;
            y     : out STD_LOGIC
        );
    end component;

begin
    uut: mux2_1 port map (a => a, b => b, sel => sel, y => y);

    stim_proc: process
    begin
        a <= '0'; b <= '1'; sel <= '0'; wait for 10 ns;
        report "MUX sel=0 | a=0 b=1 => y=" & std_logic'image(y);

        sel <= '1'; wait for 10 ns;
        report "MUX sel=1 | a=0 b=1 => y=" & std_logic'image(y);

        a <= '1'; b <= '0'; sel <= '0'; wait for 10 ns;
        report "MUX sel=0 | a=1 b=0 => y=" & std_logic'image(y);

        sel <= '1'; wait for 10 ns;
        report "MUX sel=1 | a=1 b=0 => y=" & std_logic'image(y);

        wait;
    end process;
end behavior;
