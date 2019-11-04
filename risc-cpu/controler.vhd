LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY controler IS
    PORT (
          CLK: IN STD_LOGIC;	
          RST: IN STD_LOGIC;
          IDR: IN STD_LOGIC_VECTOR(4 DOWNTO 0);   -- current micro address
          IRD: IN STD_LOGIC_VECTOR(7 DOWNTO 4);   -- current instruction
          ODR : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)  -- output next micro address
    );
END controler;
ARCHITECTURE behav OF controler IS
    SIGNAL M:STD_LOGIC_VECTOR(4 DOWNTO 0);
BEGIN
   PROCESS(RST,CLK,IDR,IRD)
   BEGIN
		IF RST='1' THEN M<="00001";
		ELSIF IDR="00011" THEN  -- current micro address
			CASE IRD IS    -- current instruction
			WHEN "0000" => M<="00011";
			WHEN "0001" => M<="00100";
			WHEN "0010" => M<="00110";  -- M: next micro address
			WHEN "0011" => M<="01000";
			WHEN "0100" => M<="01011";
			WHEN "0101" => M<="01110";
			WHEN "0110" => M<="10001";
			WHEN "0111" => M<="10011";
			WHEN "1000" => M<="10101";
			WHEN "1001" => M<="10110";
			WHEN OTHERS => M<="00001";
			END CASE;
		
		ELSE M<=IDR;
		END IF;      
    ODR<=M;
   END PROCESS;
END behav;