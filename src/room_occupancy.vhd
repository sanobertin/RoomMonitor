-- ID: 40157663 
-- Name: Bertin Mihigo Sano 
-- Project is due for submission on April 5th, 2024
library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity room_occupancy is
    Port ( X : in  STD_LOGIC; --  input from the photocell. detects entrance
           Y : in  STD_LOGIC; --  input from the photocell. detects exiting
           reset : in  STD_LOGIC; -- sets max occupancy to 0
           current_occupancy : out unsigned(7 downto 0);
           max_capacity: out  STD_LOGIC -- output to the LED. indicates if the room is full or not aka '1' if full, '0' if not
           );
end room_occupancy;

architecture rtl of room_occupancy is
    constant max_occupancy : unsigned(7 downto 0) := (others => '1'); -- note that 11111111 is 255 in decimal
    signal temp: unsigned(7 downto 0):= (others => '0'); 
    begin
    process(X, Y, reset)
    begin
        if reset = '1' then
            temp <= (others => '0');
            max_capacity <= '0';
            -- current_occupancy <= temp;
        end if;
        if temp = max_occupancy then 
            max_capacity <= '1';
            -- current_occupancy <= temp;
        end if;
        if temp >0 and rising_edge(Y) then
        if  reset = '1' then temp <= (others => '0'); else temp <= temp - 1; end if;
            -- current_occupancy <= temp;
        end if;
        if(temp < max_occupancy) and rising_edge(X) then
        if  reset = '1' then temp <= (others => '0'); else temp <=  temp + 1; end if;
                -- current_occupancy <= temp;
        end if;
    end process; 
    current_occupancy <= temp; 
end rtl;

-- end of my code