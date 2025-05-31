library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_genbyteAdder is 
end tb_genbyteAdder;

architecture Testbench of tb_genbyteAdder is
    signal A     : std_logic_vector(7 downto 0) := (others => '0');
    signal B     : std_logic_vector(7 downto 0) := (others => '0');
    signal S     : std_logic_vector(7 downto 0);
    signal C_out : std_logic;

    constant delay : time := 10 ns;

    component genbyteAdder is
        port (
            A     : in  std_logic_vector(7 downto 0);
            B     : in  std_logic_vector(7 downto 0);
            S     : out std_logic_vector(7 downto 0);
            C_out : out std_logic
        );
    end component;

    function to_int(v : std_logic_vector) return integer is
    begin
        return to_integer(unsigned(v));
    end function;

begin

    UUT: genbyteAdder
        port map (
            A     => A,
            B     => B,
            S     => S,
            C_out => C_out
        );

    stimulus: process
        procedure check(a_val, b_val, expected_sum : integer; expected_c : std_logic) is
        begin
            A <= std_logic_vector(to_unsigned(a_val, 8));
            B <= std_logic_vector(to_unsigned(b_val, 8));
            wait for delay;

            assert to_int(S) = expected_sum
                report "Error en suma: A=" & integer'image(a_val) &
                       " B=" & integer'image(b_val) &
                       " -> Esperado=" & integer'image(expected_sum) &
                       " Obtenido=" & integer'image(to_int(S))
severity note;

            assert C_out = expected_c
                report "Error en acarreo: A=" & integer'image(a_val) &
                       " B=" & integer'image(b_val) &
                       " -> Esperado=" & std_logic'image(expected_c) &
                       " Obtenido=" & std_logic'image(C_out)
severity note;

            report "Correcto: A=" & integer'image(a_val) &
                   " B=" & integer'image(b_val) &
                   " -> Suma=" & integer'image(expected_sum) &
                   " Carry=" & std_logic'image(expected_c);
        end procedure;
    begin
        check(0, 0, 0, '0');
        check(1, 0, 1, '0');
        check(255, 100, 99, '1');
        check(128, 128, 0, '1');
        check(200, 55, 255, '0');
        check(200, 56, 0, '1');

        report "Testbench finalizado correctamente." severity note;
        wait;
    end process;

end Testbench;
