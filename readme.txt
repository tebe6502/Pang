https://www.pouet.net/prod.php?which=68501

Silly Venture 2016 GAME COMPO
-----------------------------

tytuł:		PANG
wersja:		4.5 build 38

wymagania:	Atari XE/XL
		GTIA PAL
		192 kB dodatkowej pamięci
		POKEY Stereo (opcjonalnie)

		pozostałe potencjalnie wykryte rozszerzenia VBXE, 65816, MapRam
		nie są wykorzystywane przez grę
		(kod źródłowy programu detekcji dołączony jest do MadPascal-a)

Program:	Tomasz Biela (Tebe / Madteam)

Grafika: 	Kamil Walaszek (Vidol)
		ekran ATASCII, ekran tytułowy
		postać bohatera
		elementy pola gry

		Adam Powroźnik (Ooz / Agenda)
		tekstury pola gry (12)

		Maciej Hauke (Rocky / Madteam)
		mapa świata
		konwersja postaci bohatera kiedy ginie

Muzyka:		Michał Radecki (String / Agenda)
		muzyka, efekty dźwiękowe

Sterowanie:	Joystick w porcie 1

		klawisze:
		A	ruch w lewo
		D	ruch w prawo
		W	ruch w górę
		S	ruch w dół
		Shift	fire
		ESC	restart poziomu, tracimy jedno życie
		SPACE	pauza gry
		V, B	głośność efektów dźwiękowych w grze
		N, M	głośność ścieżki dźwiękowej w grze
		O, P	włączenie / wyłączenie muzyki w grze
		HELP	podgląd ekranu z najlepszymi wynikami (TOUR, PANIC)
		


Prawie 10 lat zajęło ukończenie PANG-a dla 8-bit Atari XE/XL.
Dziesięć lat z dużymi przerwami, 02.07.2007 - 15.12.2016 :)

Poziomy gry projektowali: String, Xeen, Urborg, Ja-reck, Ediman, Pajero, Emilka

Linki do stron z konkursem na projekt poziomów do gry Pang:

http://atarionline.pl/v01/index.php?ct=nowinki&ucat=1&subaction=showfull&id=1313789007
http://atarionline.pl/forum/comments.php?DiscussionID=1500
http://atarionline.pl/v01/index.php?subaction=showfull&id=1321903963&ucat=1&ct=nowinki
http://www.atari.org.pl/forum/viewtopic.php?id=9160


zmiany w porównaniu do wersji zaprezentowanej na Silly Venture 2016:

- tryb PANIC na początku charakteryzuje się większą liczbą bonusów (serduszko, tarcza), potem jest tych bonusów coraz mniej
- po przejściu 9 poziomu trybu PANIC zobaczymy ekran z gratulacjami
- dodany datamatrix, można zapisywać wyniki high_score na stronie XXL-a
- możliwość podejrzenia najlepszych wyników, klawisz HELP (potem trzeba wybrać TOUR, PANIC)
- obsługa ruchów joysticka "na ukos", teraz nie będzie blokowany ruch postaci
- możliwość wyłączenia muzyki podczas gry, to dla tych z NTSC
- gra sprawdzona pod Rapidusem, wszystko działa oprócz tytułowego obrazka, gdzie wykorzystane są zmiany rastra
- różne inne poprawki zauważonych błędów, testował do oporu TDC :)
