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
    signal nand00: std_logic;
    signal nand01: std_logic;
    signal nand02: std_logic;
    signal nand03: std_logic;
    
    signal nand10: std_logic;
    signal and11: std_logic;
    signal nand12: std_logic;
    signal and13: std_logic;
    signal nand14: std_logic;
    signal and15: std_logic;
    signal nand16: std_logic;
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
    
    signal jk36: std_logic;
    signal notjk36: std_logic;
    
    signal nand40: std_logic;
    signal nand41: std_logic;
    signal nand42: std_logic;
    signal nand43: std_logic;
    signal nand44: std_logic;
    signal nand45: std_logic;
    
    signal nand50: std_logic;
    signal nand51: std_logic;
    signal nand52: std_logic;
    signal or53: std_logic;
    signal or54: std_logic;
    signal or55: std_logic;
    
    signal jk60: std_logic;
    signal notjk60: std_logic;
    
    signal jk61: std_logic;
    signal notjk61: std_logic;
    
    signal jk62: std_logic;
    signal notjk62: std_logic;
    
    signal jk63: std_logic;
    signal notjk63: std_logic;
begin
    nand00 <= not(not(A) and not(LOAD));
    nand01 <= not(not(B) and not(LOAD));
    nand02 <= not(not(C) and not(LOAD));
    nand03 <= not(not(D) and not(LOAD));
    
    nand10 <= not(A and not(CLR) and not(LOAD));
    and11 <= nand00 and not(CLR);
    nand12 <= not(B and not(CLR) and not(LOAD));
    and13 <= nand01 and not(CLR);
    nand14 <= not(C and not(CLR) and not(LOAD));
    and15 <= nand02 and not(CLR);
    nand16 <= not(D and not(CLR) and not(LOAD));
    and17 <= nand03 and not(CLR);
    
    and20 <= not(notjk60) and not(notjk61);
    and21 <= notjk60 and notjk61;
    and22 <= not(notjk60) and not(notjk61) and not(notjk62);
    and23 <= notjk60 and notjk61 and notjk62;
    
    xor30 <= not(notjk60) xor not(notjk61);
    xor31 <= not(notjk61) xor notjk60;
    xor32 <= and20 xor not(notjk62);
    xor33 <= and21 xor not(notjk62);
    xor34 <= and22 xor not(notjk63);
    xor35 <= and23 xor not(notjk63);
    
    nand40 <= not(jk36 and xor30);
    nand41 <= not(notjk36 and xor31);
    nand42 <= not(jk36 and xor32);
    nand43 <= not(notjk36 and xor33);
    nand44 <= not(jk36 and xor34);
    nand45 <= not(notjk36 and xor35);
    
    nand50 <= not(not(notjk60) and not(notjk61) and not(notjk62) and not(notjk63) and not(UP));
    nand51 <= not(notjk60 and notjk61 and notjk62 and notjk63 and not(DOWN));
    nand52 <= not(not(DOWN) and not(UP));
    or53 <= not(nand40) or not(nand41);
    or54 <= not(nand42) or not(nand43);
    or55 <= not(nand44) or not(nand45);
    
    CO <= nand50;
    BO <= nand51;
    Qa <= jk60;
    Qb <= jk61;
    Qc <= jk62;
    Qd <= jk63;
    
    --trigger 60
    --s, clk, r
    process(nand10, nand52, and11)
        begin
        if (not(nand10) = '1') then
            jk60 <= '1';
        elsif (not(and11) = '1') then
            jk60 <= '0';
        elsif (notjk60 = '1') then
            jk60 <= jk60 xor '1';
            notjk60 <= not(jk60);
        else
            jk60 <= '0';
            notjk60 <= not(jk60);
        end if;
    end process;
    
    --trigger 61
    --s, clk, r
    process(nand12, nand52, and13)
        begin
        if (not(nand12) = '1') then
                    jk61 <= '1';
                elsif (not(and13) = '1') then
                    jk61 <= '0';
                elsif (notjk61 = '1') then
                    jk61 <= jk61 xor '1';
                    notjk61 <= not(jk61);
                else
                    jk61 <= '0';
                    notjk61 <= not(jk61);
                end if;
    end process;
        
    --trigger 62
    --s, clk, r
    process(nand14, nand52, and15)
        begin
        if (not(nand14) = '1') then
                jk62 <= '1';
            elsif (not(and15) = '1') then
                jk62 <= '0';
            elsif (notjk62 = '1') then
                jk62 <= jk62 xor '1';
                notjk62 <= not(jk62);
            else
                jk62 <= '0';
                notjk62 <= not(jk62);
        end if;
    end process;
    
    --trigger 63
    --s, clk, r
    process(nand16, nand52, and17)
        begin
        if (not(nand16) = '1') then
                jk63 <= '1';
            elsif (not(and17) = '1') then
                jk63 <= '0';
            elsif (notjk63 = '1') then
                jk63 <= jk63 xor '1';
                notjk63 <= not(jk63);
            else
                jk63 <= '0';
                notjk63 <= not(jk63);
        end if;
    end process;
    
    --trigger 36
    --s, r
    process(UP, DOWN)
        begin
        if (not(UP) = '1') then
            jk36 <= '1';
        elsif (not(DOWN) = '1') then
            jk36 <= '0';
        end if;
        notjk36 <= not(jk36);
    end process;
            
end Behavioral;
