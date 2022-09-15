library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Testbench is
end Testbench;

architecture Behavioral of Testbench is
    signal a,b: std_logic;
    signal result: std_logic;
begin
UUT: entity work.Lab1 port map (x1=>a,x2=>b,y=>result);
a <= '0', '1' after 20 ns, '0' after 40 ns, '1' after 60 ns;
b <= '0', '1' after 40 ns;   

end Behavioral;
