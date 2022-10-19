library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity jk_trigger is
  Port ( 
    J: in std_logic;
    K: in std_logic;
    R: in std_logic;
    S: in std_logic;
    CLK: in std_logic;
    Q: out std_logic
  );
end jk_trigger;

architecture Behavioral of jk_trigger is
    signal q_out: std_logic:='0';
begin
    
    Q<=q_out;
    process(CLK, R, S)
    begin
        if R='0' then
            q_out<='0';
        elsif S='0' then
            q_out<='1';
        elsif CLK'event and CLK='1' then
            if (J='0' and K='0') then
                q_out <= q_out;
            elsif (J='0' and K='1') then
                q_out <= '0';
            elsif (J='1' and K='0') then
                q_out <= '1';
            elsif (J='1' and K='1') then
                q_out <= not (q_out);
            end if;
        end if;
    end process;
            
end Behavioral;
