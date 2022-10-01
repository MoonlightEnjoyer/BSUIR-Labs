library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity lab1 is
  Port ( 
    y1: out std_logic;
    y2: out std_logic;
    G1: in std_logic;
    G2: in std_logic;
    C01: in std_logic;
    C11: in std_logic;
    C21: in std_logic;
    C31: in std_logic;
    C02: in std_logic;
    C12: in std_logic;
    C22: in std_logic;
    C32: in std_logic;
    A: in std_logic;
    B: in std_logic
  );
end lab1;

architecture Behavioral of lab1 is
  signal and1: std_logic;
  signal and2: std_logic;
  signal and3: std_logic;
  signal and4: std_logic;
  signal and5: std_logic;
  signal and6: std_logic;
  signal and7: std_logic;
  signal and8: std_logic;
begin
  and1<= (not G1) and (not A) and (not B) and C01;
  and2<= (not G1) and (not B) and A and C11;
  and3<= (not G1) and (not A) and B and C21;
  and4<= (not G1) and A and B and C31;
  and5<= (not G2) and (not A)and (not B) and C02;
  and6<= (not G2) and (not B) and A and C12;
  and7<= (not G2) and (not A) and B and C22;
  and8<= (not G2) and A and B and C32;
  y1<=and1 or and2 or and3 or and4;
  y2<=and5 or and6 or and7 or and8;
end Behavioral;

architecture Behavioral2 of lab1 is
  signal and1: std_logic;
  signal and2: std_logic;
  signal and3: std_logic;
  signal and4: std_logic;
  signal and5: std_logic;
  signal and6: std_logic;
  signal and7: std_logic;
  signal and8: std_logic;
begin
  and1<= (not G1) and (not A) and (not B) and C01;
  and2<= (not G1) and (not B) and A and C11;
  and3<= (not G1) and (not A) and B and C21;
  and4<= (not G1) and A and B and C31;
  and5<= (not G2) and (not A)and (not B) and C02;
  and6<= (not G2) and (not B) and A and C12;
  and7<= (not G2) and (not A) and B and C22;
  and8<= (not G2) and A and B and C32;
  process(and1, and2, and3, and4, and5, and6, and7, and8)
  begin
    y1<='0';
    y2<='0';
    if and1='1' or and2='1' or and3='1' or and4='1' then
        y1<='1';
    end if;
    if and5='1' or and6='1' or and7='1' or and8='1' then
        y2<='1';
    end if;
  end process;
end Behavioral2;
