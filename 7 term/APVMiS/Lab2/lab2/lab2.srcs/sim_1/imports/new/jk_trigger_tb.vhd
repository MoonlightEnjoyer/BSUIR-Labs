library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity jk_trigger_tb is
end jk_trigger_tb;

architecture Behavioral of jk_trigger_tb is
    component jk_trigger is
    port( 
        J: in std_logic;
        K: in std_logic;
        CLK: in std_logic;
        R: in std_logic;
        S: in std_logic;
        Q: out std_logic
        );
    end component;
    
    signal R:  std_logic:='1';
    signal S:  std_logic:='1';
    signal CLK:  std_logic:='0';
    signal J: std_logic:='1';
    signal K: std_logic:='1';  
    signal Q:  std_logic;
            
begin
    jk_trigger_inst: jk_trigger
        port map(J=>J, K=>K, CLK=>CLK, R=>R, S=>S, Q=>Q);
        
        CLK <= not CLK after 50ns;

    simulation: process
    begin
        wait for 100ns;
        R<='0';
        wait for 100ns;
        R<='1';
        wait for 200ns;
        S<='0';
        wait for 100ns;
        S<='1';
        J<='0';
        wait for 100 ns;
        K<='0';
        J<='1';
        wait for 100 ns;
        K<='1';
        wait;
    end process;
        

end Behavioral;
