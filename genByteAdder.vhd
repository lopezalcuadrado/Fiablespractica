library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity genbyteAdder is
	port ( 	A		: in 	std_logic_vector (7 downto 0);
			B		: in 	std_logic_vector (7 downto 0);
			S		: out 	std_logic_vector (7 downto 0);
			C_out	: out 	std_logic
	);
end genbyteAdder;

architecture Behavioural of genbyteAdder is
	signal C : std_logic_vector (7 downto 0);
	component halfAdder is
		port ( 	A		: in 	std_logic;
				B		: in    std_logic;
				S		: out   std_logic;
				C_out	: out	std_logic
			);
	end component;
	component fullAdder is 
		port( 	A		: in 	std_logic;
				B		: in    std_logic;
				C_in 	: in 	std_logic;	
				S		: out   std_logic;
				C_out	: out	std_logic
		);
	end component;
	
begin
	GEN_ADD: for I in 0 to 7 generate

    HA_GEN: if I = 0 generate
        HA0: halfAdder
        port map (
            A     => A(0),
            B     => B(0),
            S     => S(0),
            C_out => C(0)
        );
    end generate;

    FA_GEN: if I > 0 generate
        FA_inst: fullAdder
        port map (
            A     => A(I),
            B     => B(I),
            C_in  => C(I-1),
            S     => S(I),
            C_out => C(I)
        );
    end generate;

end generate GEN_ADD;


  C_out <= C(7);
end	Behavioural;
	