--library work;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.testbench_view_package.all;


entity tb_ram is
end;

architecture bench of tb_ram is


    -- declaration of register_file interface
    -- INSERT COMPONENT DECLARATION HERE
	component ram_file
	port(
	        clk    : in  std_logic;
        	cs      : in  std_logic;
        	read    : in  std_logic;
        	write   : in  std_logic;
        	address : in  std_logic_vector(9 downto 0);
        	wrdata  : in  std_logic_vector(31 downto 0);
        	rddata  : out std_logic_vector(31 downto 0)
	);
	end component;

    signal address		 	: std_logic_vector(9 downto 0);
    signal rddata, wrdata		: std_logic_vector(31 downto 0);
    signal clk, cs, read, write, stop	: std_logic := '0';

    signal i : integer :=0;
    -- clk period definition
    constant CLK_PERIOD : time      := 40 ns;

begin

    	reg_file : component ram_file
	port map(
	clk => clk,
	cs => cs,
	read => read,
	write => write,
	address => address,
	wrdata => wrdata,
	rddata =>rddata
	);

    clock_gen : process
    begin
        -- it only works if clk has been initialized
        if stop = '0' then
            clk <= not clk;
            wait for (CLK_PERIOD / 2);
        else
            wait;
        end if;
    end process;

    process
    begin
        -- init
        cs	<= '0';
        read    <= '0';
        write   <= '0';
        address <= (others => '0');
        wrdata  <= (others => '0');
	rddata  <= (others => '0');
        wait for 5 ns;

        -- write in the register file
--        write <= '1';
--	cs    <= '1';
--        for i in 0 to 31 loop
--            -- std_logic_vector(to_unsigned(number, bitwidth))
--            address<= std_logic_vector(to_unsigned(i, 5));
--            wrdata <= std_logic_vector(to_unsigned(i + 1, 32));
--            wait for CLK_PERIOD;
--       end loop;

        -- read in the register file
        -- INSERT CODE THAT READS THE REGISTER FILE HERE
--	write 	<= '0';
--	read 	<= '1';
--	address	<= (others => '0');
--	wrdata	<= (others => '0');
--	while(i<15) loop
--		wrdata <= std_logic_vector(to_unsigned(i, 5));
--		i <= i+2;
--		wait for CLK_PERIOD;
--	end loop;
-- write some values in the RAM
	cs <= '1';
        write <= '1';
        for i in 0 to 31 loop
            address <= std_logic_vector(to_unsigned(i * 4, 10) + "0000000000");
            wrdata  <= std_logic_vector(to_unsigned(i, 32) + X"AAAA0000");
            wait for CLK_PERIOD;
        end loop;
        write <= '0';
	wrdata <= (others => '0');

        -- read back in the RAM
        read <= '1';
--        for i in 0 to 31 loop
--            address <= std_logic_vector(to_unsigned(i * 4, 10) + "0000000000");
--            wait for CLK_PERIOD;
--	    ASSERT rddata = (std_logic_vector(to_unsigned(i, 32) + X"AAAA0000"))
--                REPORT "Did not read or write correctly in RAM"
--                SEVERITY ERROR;
--		report "RAM Value = " & integer'image(to_integer(unsigned(rddata)));
--        end loop;
	while(i<32) loop
		address <= std_logic_vector(to_unsigned(i * 4, 10) + "0000000000");
		i <= i+1;
		wait for CLK_PERIOD;
	end loop;
        stop <= '1';
        wait;
    end process;
end bench;