-- ID: 40157663 
-- Name: Bertin Mihigo Sano 
-- Project is due for submission on April 5th, 2024
-- This is a testbench for room_occupancy.vhd
library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity tb is
end tb;

architecture testbench of tb is

signal X_tb, Y_tb, reset_tb, max_capacity_tb: std_logic := '0' ; 
constant max_occupancy_tb : unsigned(7 downto 0) := (others => '1');
signal current_occupancy_tb : unsigned(7 downto 0):= (others => '0');
signal i: integer:=0;


begin
    room_occupancy_tb: entity work.room_occupancy(rtl) port map ( 
    X => X_tb, 
    Y => Y_tb, 
    reset => reset_tb, 
    max_capacity => max_capacity_tb, 
    current_occupancy => current_occupancy_tb);

    process
        begin
        report("start simulation here:");
        --wait until reset_tb = '0';
        X_tb <= not X_tb after 10 ms; 
        Y_tb <= not Y_tb after 30 ms;
        reset_tb <= not reset_tb after 100ms; 
        i <= i+1 after 10 ms;
        
        
        assert  (i<=500) report "I ended simulation after 300ms" severity ERROR; 
        wait for 10 ms;
    end process;    
end testbench;

-- end of my code