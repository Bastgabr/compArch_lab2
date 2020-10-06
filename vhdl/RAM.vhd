library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RAM is
    port(
        clk     : in  std_logic;
        cs      : in  std_logic;
        read    : in  std_logic;
        write   : in  std_logic;
        address : in  std_logic_vector(9 downto 0);
        wrdata  : in  std_logic_vector(31 downto 0);
        rddata  : out std_logic_vector(31 downto 0));
end RAM;

architecture synth of RAM is
type reg_type is array(0 to 4095) of std_logic_vector(31 downto 0);
signal reg : reg_type := (others => x"00000000");
begin
	clk_proc : process(clk, cs, read, write, address, wrdata)
	begin
		if cs='1' then
		--Max address 0x3FF corresponds to 0x1FFC starting from the third LSB
		if falling_edge(clk) and write='1' and to_integer(unsigned(address))<= 1023 then 
			reg(to_integer(unsigned(address))) <= wrdata;
		end if;

		--Reading register on rising clk
		if rising_edge(clk) and read='1' and to_integer(unsigned(address))<= 1023 then
			rddata <= reg(to_integer(unsigned(address)));
		end if;		
		else 
			rddata <= (others => 'Z');
		end if;
	end process clk_proc;
end synth;
