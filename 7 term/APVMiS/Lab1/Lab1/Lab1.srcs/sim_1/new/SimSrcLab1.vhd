----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.09.2022 19:06:52
-- Design Name: 
-- Module Name: lab1_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lab1_tb is
end lab1_tb;

architecture TB of lab1_tb is
--    component lab1 is
--        port(
--          y1: out std_logic;
--          y2: out std_logic;
--          y11: out std_logic;
--          y22: out std_logic;
--          G1: in std_logic;
--          G2: in std_logic;
--          C01: in std_logic;
--          C11: in std_logic;
--          C21: in std_logic;
--          C31: in std_logic;
--          C02: in std_logic;
--          C12: in std_logic;
--          C22: in std_logic;
--          C32: in std_logic;
--          A: in std_logic;
--          B: in std_logic
--        );
--    end component;
    signal y11: std_logic;
    signal y22: std_logic;
    signal y1: std_logic;
    signal y2: std_logic;
    signal input: std_logic_vector(11 downto 0);

begin
    lab1_inst1 : entity work.lab1(Behavioral)
    port map (y1=>y1,
              y2=>y2,
              G1=>input(0),
              G2=>input(1),
              C01=>input(2),
              C11=>input(3),
              C21=>input(4),
              C31=>input(5),
              C02=>input(6),
              C12=>input(7),
              C22=>input(8),
              C32=>input(9),
              A=>input(10),
              B=>input(11)
    );
    lab1_inst2 : entity work.lab1(Behavioral2)
        port map (y1=>y11,
                  y2=>y22,
                  G1=>input(0),
                  G2=>input(1),
                  C01=>input(2),
                  C11=>input(3),
                  C21=>input(4),
                  C31=>input(5),
                  C02=>input(6),
                  C12=>input(7),
                  C22=>input(8),
                  C32=>input(9),
                  A=>input(10),
                  B=>input(11)
        );
    simulation : process
        begin
            input <= "000000000000";
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