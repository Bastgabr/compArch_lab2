library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder is
    port(
        address : in  std_logic_vector(15 downto 0);
        cs_LEDS : out std_logic;
        cs_RAM  : out std_logic;
        cs_ROM  : out std_logic
    );
end decoder;

architecture synth of decoder is
signal ram_cs: std_logic := '1';
signal rom_cs: std_logic := '1';
signal leds_cs: std_logic := '1';
begin
	decode_proc: process(address) is
	begin
--		if address <= x"0FFC" and ram_cs='0' and leds_cs='0' then 
--			rom_cs <= '1';
--		elsif address <= x"1FFC" and rom_cs='0' and leds_cs='0' then 
--			ram_cs <= '1';
--		elsif address <= x"200C" and rom_cs='0' and ram_cs='0' then 
--			leds_cs <= '1';
--		end if;

		if address <= x"0FFC" then
			rom_cs <= '1'; ram_cs <= '0'; leds_cs <= '0';
		elsif address <= x"1FFC" then 
			ram_cs <= '1'; rom_cs <= '0'; leds_cs <= '0';
		elsif address <= x"200C" then 
			leds_cs <= '1'; ram_cs <= '0'; rom_cs <= '0';
		else
			rom_cs <= '0'; ram_cs <= '0'; leds_cs <= '0';
		end if;
	end process decode_proc;
cs_ROM <= rom_cs;
cs_RAM <= ram_cs;
cs_LEDS <= leds_cs;
end synth;
