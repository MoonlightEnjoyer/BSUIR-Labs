library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Lab2 is
    Port (
        CO: out std_logic;
        BO: out std_logic;
        Qa: out std_logic;
        Qb: out std_logic;
        Qc: out std_logic;
        Qd: out std_logic;
        CLR: in std_logic;
        UP: in std_logic;
        DOWN: in std_logic;
        LOAD: in std_logic;
        A: in std_logic;
        B: in std_logic;
        C: in std_logic;
        D: in std_logic
    );
end Lab2;

architecture Behavioral of Lab2 is
    signal and00: std_logic;
    signal and01: std_logic;
    signal and02: std_logic;
    signal and03: std_logic;
    signal and10: std_logic;
    signal and11: std_logic;
    signal and12: std_logic;
    signal and13: std_logic;
    signal and14: std_logic;
    signal and15: std_logic;
    signal and16: std_logic;
    signal and17: std_logic;
    signal and20: std_logic;
    signal and21: std_logic;
    signal and22: std_logic;
    signal and23: std_logic;
    signal xor30: std_logic;
    signal xor31: std_logic;
    signal xor32: std_logic;
    signal xor33: std_logic;
    signal xor34: std_logic;
    signal xor35: std_logic;
    signal and40: std_logic;
    signal and41: std_logic;
    signal and42: std_logic;
    signal and43: std_logic;
    signal and44: std_logic;
    signal and45: std_logic;
    signal and50: std_logic;
    signal and51: std_logic;
    signal and52: std_logic;
    signal or53: std_logic;
    signal or54: std_logic;
    signal or55: std_logic;
begin
    and00 <= not(A) and not(LOAD);
    and01 <= not(B) and not(LOAD);
    and02 <= not(C) and not(LOAD);
    and03 <= not (D) and not(LOAD);
    
    and10 <= A and not(CLR) and not(LOAD);
    and11 <= not(and00) and not(CLR);
    and12 <= B and not(CLR) and not(LOAD);
    and13 <= not(and01) and not(CLR);
    and14 <= C and not(CLR) and not(LOAD);
    and15 <= not(and02) and not(CLR);
    and16 <= D and not(CLR) and not(LOAD);
    and17 <= not(and03) and not(CLR);
    
    
    
end Behavioral;
