library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity lab2_tb is
end lab2_tb;

architecture TB of lab2_tb is
    signal co: std_logic;
    signal bo: std_logic;
    signal input: std_logic_vector(7 downto 0);

begin
    lab2_inst : entity work.Lab2(Behavioral)
    port map (
    CO => co,
    BO => bo,
    CLR => input(0),
    UP => input(1),
    DOWN => input(2),
    LOAD => input(3),
    A => input(4),
    B => input(5),
    C => input(6),
    D => input(7)
    );
    simulation : process
        begin
            input <= "00000000";
            wait for 20ns;
            for i in 0 to 4096 loop
                input<=input+"1";
                wait for 10ns;
            end loop;
            wait;
        end process;                 
end TB;













--    input(0)<='0';
--            input(1)<='0';
--            input(2)<='0';
--            input(3)<='0';
--            input(4)<='0';
--            input(5)<='0';
--            input(6)<='0';
--            input(7)<='0';
--            input(8)<='0';
--            input(9)<='0';
--            input(10)<='0';
--            input(11)<='0';