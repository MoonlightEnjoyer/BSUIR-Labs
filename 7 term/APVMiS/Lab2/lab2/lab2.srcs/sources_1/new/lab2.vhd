library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity lab2 is
    Port (
    C0: out std_logic;
    B0: out std_logic;
    
    Q0: out std_logic;
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
end lab2;

architecture Behavioral of lab2 is
    signal nand01: std_logic;
    signal nand02: std_logic;
    signal nand03: std_logic;
    signal nand04: std_logic;
    
    signal and1: std_logic;
    signal and2: std_logic;
    signal and3: std_logic;
    signal and4: std_logic;
    signal nand11: std_logic;
    signal nand12: std_logic;
    signal nand13: std_logic;
    signal nand14: std_logic;
    
    
    signal and11: std_logic;
    signal and12: std_logic;
    signal and13: std_logic;
    signal and14: std_logic;
       
    signal xor1: std_logic;
    signal xor2: std_logic;
    signal xor3: std_logic;
    signal xor4: std_logic;
    signal xor5: std_logic;
    signal xor6: std_logic;
    
    signal nand21: std_logic;
    signal nand22: std_logic;
    signal nand23: std_logic;
    signal nand24: std_logic;
    signal nand25: std_logic;
    signal nand26: std_logic;
    
    signal nand31: std_logic;
    signal or1: std_logic;
    signal or2: std_logic;
    signal or3: std_logic;
    signal or1not: std_logic;
    signal or2not: std_logic;
    signal or3not: std_logic;
    
    signal Qa0: std_logic:='0';
    signal Qb0: std_logic:='0';
    signal Qc0: std_logic:='0';
    signal Qd0: std_logic:='0';
    signal Q00: std_logic:='0';
    signal Qa0not: std_logic;
    
    signal CLK: std_logic;

begin
    Qa<=Qa0;
    Qb<=Qb0;
    Qc<=Qc0;
    Qd<=Qd0;
    Qa0not<=not Qa0;
    Q0<=Q00;
    
    nand01<= not ((not A) and (not LOAD));--yes
    nand02<= not ((not B) and (not LOAD));--yes
    nand03<= not ((not C) and (not LOAD));--yes
    nand04<= not ((not D) and (not LOAD));--yes
    
    nand11<= not ((not CLR) and (not LOAD) and A);--yes
    and1<= (not CLR) and nand01;--yes
    nand12<= not ((not CLR) and (not LOAD) and B);--yes
    and2<= (not CLR) and nand02;--yes
    nand13<= not ((not CLR) and (not LOAD) and C);--yes
    and3<= (not CLR) and nand03;--yes
    nand14<= not ((not CLR) and (not LOAD) and D);--yes
    and4<= (not CLR) and nand04;--yes
    
    and11<= Qa0 and Qb0;--yes
    and12<= (not Qa0) and (not Qb0);--yes
    and13<= Qa0 and Qb0 and Qc0;--yes
    and14<= (not Qa0) and (not Qb0) and (not Qc0);--yes
    
    xor1<= Qa0 xor Qb0; --yes
    xor2<= (not Qa0) xor Qb0; --yes
    xor3<= Qc0 xor and11; --yes
    xor4<= Qc0 xor and12; --yes
    xor5<= Qd0 xor and13; --yes
    xor6<= Qd0 xor and14; --yes
        
    nand21<= Q00 nand xor1;--yes
    nand22<= (not Q00) nand xor2;--yes
    nand23<= Q00 nand xor3;--yes
    nand24<= (not Q00) nand xor4;--yes
    nand25<= Q00 nand xor5; --yes
    nand26<= (not Q00) nand xor6;--yes
    
    or1<= (not nand21) or (not nand22);--yes
    or2<= (not nand23) or (not nand24);--yes
    or3<= (not nand25) or (not nand26);--yes
    or1not<=not or1;
    or2not<=not or2;
    or3not<=not or3;
    
    C0<= not (Qa0 and Qb0 and Qc0 and Qd0 and (not UP));
    B0<= not ((not Qa0) and (not Qb0) and (not Qc0) and (not Qd0) and (not DOWN));
    
    CLK<= not(UP nand DOWN);
    
    jk0: entity work.jk_trigger(Behavioral) port map(
        CLK=>'0',
        J=>'0',
        K=>'0',
        R=>DOWN,
        S=>UP,
        Q=>Q00
    );
    jk1: entity work.jk_trigger(Behavioral) port map(
        CLK=>CLK,
        J=>Qa0not,
        K=>Qa0,
        R=>and1,
        S=>nand11,
        Q=>Qa0
    );
    jk2: entity work.jk_trigger(Behavioral) port map(
        CLK=>CLK,
        J=>or1,
        K=>or1not,
        R=>and2,
        S=>nand12,
        Q=>Qb0
    );
    jk3: entity work.jk_trigger(Behavioral) port map(
        CLK=>CLK,
        J=>or2,
        K=>or2not,
        R=>and3,
        S=>nand13,
        Q=>Qc0
    );
    jk4: entity work.jk_trigger(Behavioral) port map(
        CLK=>CLK,
        J=>or3,
        K=>or3not,
        R=>and4,
        S=>nand14,
        Q=>Qd0
    );    
end Behavioral;
