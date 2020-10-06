library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity tb_decoder is
end;

architecture bench of tb_decoder is


    -- declaration of register_file interface
    -- INSERT COMPONENT DECLARATION HERE
	component decoder
	port(
	        address : in  std_logic_vector(15 downto 0);
        	cs_LEDS : out std_logic;
        	cs_RAM  : out std_logic;
        	cs_ROM  : out std_logic
	);
	end component;

    signal address	: std_logic_vector(15 downto 0);
    --signal clk, stop	: std_logic := '0';
    signal cs_LEDS, cs_RAM, cs_ROM : std_logic;

    signal i : integer :=0;
    -- clk period definition
    constant CLK_PERIOD : time      := 40 ns;

begin

    	decoder_file : component decoder
	port map(
	--clk => clk,
	address => address,
	cs_LEDS => cs_LEDS,
	cs_RAM  => cs_RAM,
	cs_ROM  => cs_ROM
	);

--    clock_gen : process
--    begin
--        -- it only works if clk has been initialized
--        if stop = '0' then
--            clk <= not clk;
--            wait for (CLK_PERIOD / 2);
--        else
--            wait;
--        end if;
--    end process;

    process
    begin
        -- init
        address <= x"0000";
        wait for 5 ns;

	address <= x"03FF";
        wait for 5 ns;

	address <= x"0FFC";
        wait for 5 ns;

	address <= x"1000";
        wait for 5 ns;

	address <= x"012F";
        wait for 5 ns;

	address <= x"1FFC";
        wait for 5 ns;

	address <= x"2000";
        wait for 5 ns;

	address <= x"2005";
        wait for 5 ns;

	address <= x"200C";
        wait for 5 ns;

	address <= x"2010";
        wait for 5 ns;

        wait;
    end process;
end bench;