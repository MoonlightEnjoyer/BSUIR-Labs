library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Lab1 is
Port (x1: in std_logic;
 x2: in std_logic;
 y: out std_logic);
end Lab1;

architecture Behavioral of Lab1 is

begin
y<=x1 and x2;

end Behavioral;
