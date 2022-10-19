library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity lab2_tb is
end lab2_tb;

architecture Behavioral of lab2_tb is
    component lab2 is
    port( 
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
    end component;
    
        signal C0: std_logic;
        signal B0: std_logic;
        signal Q0: std_logic;
        signal Qa: std_logic;
        signal Qb: std_logic;
        signal Qc: std_logic;
        signal Qd: std_logic;
        signal CLR: std_logic:='0';
        signal UP: std_logic:='1';
        signal DOWN: std_logic:='1';
        signal LOAD: std_logic:='1';
        signal A: std_logic;
        signal B: std_logic;
        signal C: std_logic;
        signal D: std_logic;
            
begin
    lab2_inst: lab2
        port map(C0=>C0, B0=>B0, Q0=>Q0, Qa=>Qa, Qb=>Qb, Qc=>Qc, Qd=>Qd, CLR=>CLR, UP=>UP, DOWN=>DOWN, LOAD=>LOAD, A=>A, B=>B, C=>C, D=>D);
        
--        CLK <= not CLK after 50ns;

    simulation: process
    begin
        wait for 100ns;
            for i in 0 to 1000 loop
                if i<28 then
                    UP<=not UP;
                else
                    DOWN<=not DOWN;
                end if;
                if i=9 then
                    A<='1';
                    B<='0';
                    C<='0';
                    D<='1';
                end if;
                if i=10 then
                    LOAD<='0';
                end if;
                if i=12 then
                    LOAD<='1';
                end if;
                if i=13 then
                    CLR<='1';
                end if;
                if i=16 then
                    CLR<='0';
                end if;
--                DOWN<=not DOWN;
--                wait for 100 ns;
--                CLR<='1';
                wait for 100ns;
            end loop;
        wait;
    end process;
        

end Behavioral;
