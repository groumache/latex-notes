library ieee;
use ieee.std_logic_1164.all;

entity TicTacToe is
	port
	(
		-- Input ports
		clk	  : in std_logic;

		button0 : in std_logic;
		button1 : in std_logic;
		button2 : in std_logic;

		-- Output ports
		ledTurnGreen	: buffer std_logic;
		ledTurnRed		: buffer std_logic;

		ledGreen	: out std_logic_vector (8 downto 0);
		ledRed	: out std_logic_vector (8 downto 0);

		seg1	:	buffer std_logic := '0'; -- seg = segment display
		seg2	:	buffer std_logic := '1';
		seg3	:	buffer std_logic := '1';
		seg4	:	buffer std_logic := '1';
		seg5	:	buffer std_logic := '1';
		seg6	:	buffer std_logic := '1';
		seg7	:	buffer std_logic := '1'

	);
end entity TicTacToe;



architecture TTT_arch of TicTacToe is

	signal ledVert		: std_logic_vector (8 downto 0) := "000000000";
	signal ledRouge	: std_logic_vector (8 downto 0) := "000000000";

	signal TourRouge : std_logic := '1';

	signal VictoireRouge : std_logic := '0';
	signal VictoireVert	: std_logic := '0';

	-- Signaux anti-rebond (1 pour chaque bouton)
	signal SUPERcounter0 : integer range 0 to 500 := 0;
	signal SUPERcounter1 : integer range 0 to 500 := 0;
	signal SUPERcounter2 : integer range 0 to 500 := 0;

	signal ledSelect : integer range 0 to 9 := 0;





begin -- architecture TTT_arch

	process(clk)

	begin -- process 

		-- Assignement des signaux aux sorties
		ledGreen 	<= ledVert;
		ledRed 		<= ledRouge;
		ledTurnRed 	<= TourRouge;
		ledTurnGreen <= not(TourRouge);


		if( rising_edge(clk)) then




	-- Utilisation du button0 pour selectionner la led
			if(button0 = '0') then
				SUPERCOUNTER0 <= SUPERcounter0 + 1;
			else
				SUPERcounter0 <= 0;
			end if;

			if(SUPERcounter0 = 250) then

				ledSelect <= ledSelect + 1;
				if(ledSelect = 9) then
					ledSelect <= 0;
				end if;

			end if;



	-- Utilisation du button1 pour confirmer la led
			if(button1 = '0') then
				SUPERcounter1 <= SUPERcounter1 + 1;
			else
				SUPERcounter1 <= 0;
			end if;

			if(SUPERcounter1 = 250) then

				if(ledSelect = 0 and ledVert(0) = '0' and ledRouge(0) = '0') then
					if(TourRouge = '1') then
						TourRouge 	<= '0';
						ledRouge(0) <= '1';
					else
						TourRouge 	<= '1';
						ledVert(0) 	<= '1';
					end if;

				elsif(ledSelect = 1 and ledVert(1) = '0' and ledRouge(1) = '0') then
					if(TourRouge = '1') then
						TourRouge 	<= '0';
						ledRouge(1) <= '1';
					else
						TourRouge 	<= '1';
						ledVert(1) 	<= '1';
					end if;

				elsif(ledSelect = 2 and ledVert(2) = '0' and ledRouge(2) = '0') then
					if(TourRouge = '1') then
						TourRouge 	<= '0';
						ledRouge(2) <= '1';
					else
						TourRouge 	<= '1';
						ledVert(2) 	<= '1';
					end if;

				elsif(ledSelect = 3 and ledVert(3) = '0' and ledRouge(3) = '0') then
					if(TourRouge = '1') then
						TourRouge 	<= '0';
						ledRouge(3) <= '1';
					else
						TourRouge 	<= '1';
						ledVert(3) 	<= '1';
					end if;

				elsif(ledSelect = 4 and ledVert(4) = '0' and ledRouge(4) = '0') then
					if(TourRouge = '1') then
						TourRouge 	<= '0';
						ledRouge(4) <= '1';
					else
						TourRouge 	<= '1';
						ledVert(4) 	<= '1';
					end if;

				elsif(ledSelect = 5 and ledVert(5) = '0' and ledRouge(5) = '0') then
					if(TourRouge = '1') then
						TourRouge 	<= '0';
						ledRouge(5) <= '1';
					else
						TourRouge 	<= '1';
						ledVert(5) 	<= '1';
					end if;

				elsif(ledSelect = 6 and ledVert(6) = '0' and ledRouge(6) = '0') then
					if(TourRouge = '1') then
						TourRouge 	<= '0';
						ledRouge(6) <= '1';
					else
						TourRouge 	<= '1';
						ledVert(6) 	<= '1';
					end if;

				elsif(ledSelect = 7 and ledVert(7) = '0' and ledRouge(7) = '0') then
					if(TourRouge = '1') then
						TourRouge 	<= '0';
						ledRouge(7) <= '1';
					else
						TourRouge 	<= '1';
						ledVert(7) 	<= '1';
					end if;

				elsif(ledSelect = 8 and ledVert(8) = '0' and ledRouge(8) = '0') then
					if(TourRouge = '1') then
						TourRouge 	<= '0';
						ledRouge(8) <= '1';
					else
						TourRouge 	<= '1';
						ledVert(8) 	<= '1';
					end if;

				end if;

			end if;



	-- Utilisation du button2 pour commencer une nouvelle partie
			if(button2 = '0') then
				SUPERcounter2 <= SUPERcounter2 + 1;
			else
				SUPERcounter2 <= 0;
			end if;

			if(SUPERcounter2 = 250) then

				TourRouge <= '1';
				ledSelect <= 0;

				VictoireRouge	<= '0';
				VictoireVert	<= '0';

				for index in 0 to 8 loop
					ledVert(index)	 <= '0';
					ledRouge(index) <= '0';
				end loop;

			end if;





	-- Check si 3 led de meme couleur sont alignees
			-- horizontal VERT
				if (ledVert(0) = '1' AND ledVert(1) = '1' AND ledVert(2) = '1') then
					VictoireVert <= '1';
				elsif (ledVert(3) = '1' AND ledVert(4) = '1' AND ledVert(5) = '1') then
					VictoireVert <= '1';
				elsif (ledVert(6) = '1' AND ledVert(7) = '1' AND ledVert(8) = '1') then
					VictoireVert <= '1';
			-- vertical VERT
				elsif (ledVert(0) = '1' AND ledVert(3) = '1' AND ledVert(6) = '1') then
					VictoireVert <= '1';
				elsif (ledVert(1) = '1' AND ledVert(4) = '1' AND ledVert(7) = '1') then
					VictoireVert <= '1';
				elsif (ledVert(2) = '1' AND ledVert(5) = '1' AND ledVert(8) = '1') then
					VictoireVert <= '1';
			-- diagonal VERT
				elsif (ledVert(0) = '1' AND ledVert(4) = '1' AND ledVert(8) = '1') then
					VictoireVert <= '1';
				elsif (ledVert(2) = '1' AND ledVert(4) = '1' AND ledVert(6) = '1') then
					VictoireVert <= '1';
				end if;
				
			-- horizontal ROUGE
				if (ledRouge(0) = '1' AND ledRouge(1) = '1' AND ledRouge(2) = '1') then
					VictoireRouge <= '1';	
				elsif (ledRouge(3) = '1' AND ledRouge(4) = '1' AND ledRouge(5) = '1') then
					VictoireRouge <= '1';	
				elsif (ledRouge(6) = '1' AND ledRouge(7) = '1' AND ledRouge(8) = '1') then
					VictoireRouge <= '1';	
			-- vertical ROUGE
				elsif (ledRouge(0) = '1' AND ledRouge(3) = '1' AND ledRouge(6) = '1') then
					VictoireRouge <= '1';	
				elsif (ledRouge(1) = '1' AND ledRouge(4) = '1' AND ledRouge(7) = '1') then
					VictoireRouge <= '1';	
				elsif (ledRouge(2) = '1' AND ledRouge(5) = '1' AND ledRouge(8) = '1') then
					VictoireRouge <= '1';	
			-- diagonal ROUGE
				elsif (ledRouge(0) = '1' AND ledRouge(4) = '1' AND ledRouge(8) = '1') then
					VictoireRouge <= '1';	
				elsif (ledRouge(2) = '1' AND ledRouge(4) = '1' AND ledRouge(6) = '1') then
					VictoireRouge <= '1';	
				end if;




	-- Allume l'afficheur 7-segements (en fonction du compteur)
	if(ledSelect = 0) then
		seg1 <= '0';
		seg2 <= '1';
		seg3 <= '1';
		seg4 <= '1';
		seg5 <= '1';
		seg6 <= '1';
		seg7 <= '1';

	elsif(ledSelect = 1) then
		seg1 <= '0';
		seg2 <= '0';
		seg3 <= '0';
		seg4 <= '1';
		seg5 <= '0';
		seg6 <= '0';
		seg7 <= '1';
	
	elsif(ledSelect = 2) then
		seg1 <= '1';
		seg2 <= '0';
		seg3 <= '1';
		seg4 <= '1';
		seg5 <= '1';
		seg6 <= '1';
		seg7 <= '0';
	
	elsif(ledSelect = 3) then
		seg1 <= '1';
		seg2 <= '0';
		seg3 <= '1';
		seg4 <= '1';
		seg5 <= '0';
		seg6 <= '1';
		seg7 <= '1';
	
	elsif(ledSelect = 4) then
		seg1 <= '1';
		seg2 <= '1';
		seg3 <= '0';
		seg4 <= '1';
		seg5 <= '0';
		seg6 <= '0';
		seg7 <= '1';
	
	elsif(ledSelect = 5) then
		seg1 <= '1';
		seg2 <= '1';
		seg3 <= '1';
		seg4 <= '0';
		seg5 <= '0';
		seg6 <= '1';
		seg7 <= '1';
	
	elsif(ledselect = 6) then
		seg1 <= '1';
		seg2 <= '1';
		seg3 <= '1';
		seg4 <= '0';
		seg5 <= '1';
		seg6 <= '1';
		seg7 <= '1';
	
	elsif(ledSelect = 7) then
		seg1 <= '0';
		seg2 <= '0';
		seg3 <= '1';
		seg4 <= '1';
		seg5 <= '0';
		seg6 <= '0';
		seg7 <= '1';
	
	elsif(ledSelect = 8) then
		seg1 <= '1';
		seg2 <= '1';
		seg3 <= '1';
		seg4 <= '1';
		seg5 <= '1';
		seg6 <= '1';
		seg7 <= '1';
	end if;





	-- En cas de victoire
	if(VictoireVert = '1') then

		seg1 <= '0';
		seg2 <= '0';
		seg3 <= '0';
		seg4 <= '0';
		seg5 <= '0';
		seg6 <= '0';
		seg7 <= '0';

		for index in 0 to 8 loop
			ledVert(index)	 <= '1';
			ledRouge(index) <= '0';
		end loop;

		TourRouge <= '0';

	end if;

	if(VictoireRouge = '1') then

		seg1 <= '0';
		seg2 <= '0';
		seg3 <= '0';
		seg4 <= '0';
		seg5 <= '0';
		seg6 <= '0';
		seg7 <= '0';

		for index in 0 to 8 loop
			ledVert(index)	 <= '0';
			ledRouge(index) <= '1';
		end loop;

		TourRouge <= '1';

	end if;



		end if; -- end if ( rising_edge( clk ) )
	end process;
end architecture TTT_arch;

