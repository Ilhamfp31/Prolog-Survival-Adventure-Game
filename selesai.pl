/* 	PROGRESS 20 NOVEMBER 2017 KELOMPOK 11 
	M. NURRAIHAN NAUFAL 13516017
	AHMAD FAIZ SAHUPALA 13516065
	INTAN NURJANNAH 13516131 
	ILHAM FIRDAUSI PUTRA 13516140 */


/* Deklarasi predikat dynamic */

:- dynamic(posisi/2). 
:- dynamic(at/3).
:- dynamic(musuh/3).
:- dynamic(health/1). 
:- dynamic(hunger/1). 
:- dynamic(thirst/1). 
:- dynamic(gameOver/1).
:- dynamic(goal/1).
:- dynamic(statusGame/1). 


/* Deklarasi tempat barang */

at(sepatu,3,4).
at(pedang,1,2).
at(katana,10,3).
at(senter,9,7).
at(rakit,5,9).
at(kapal,14,9).
at(radar,14,1).
at(teleportscroll,19,2).

/* Deklarasi usable items: makanan, minuman, dan obat */
/* Item makanan: untuk menambah hunger */
at(roti,2,3).
at(sup,5,9).
at(ayam,2,13).
at(daging,8,5).
at(jagung,10,9).
at(apel,5,15).
at(bayam,10,16).
/* Item minuman: untuk menambah thirst */
at(airminum,5,5).
at(botolsusu,1,9).
at(jusmelon,6,10).
at(esteh,6,2).
at(susukotak,9,12).
at(esjeruk,8,20).
at(airmineral,4,17).
/* Item obat: untuk menambah health */
at(obat1,2,5).
at(obat2,5,12).
at(obat3,8,7).
at(obat4,10,4).
at(obat5,9,14).
at(obat6,10,20).
at(obat7,2,19).

/* Deklarasi titik awal */
posisi(1,1).


/* Deklarasi titik musuh */
/* musuh(MusuhKe,KoordinatX,KoordinatY) */
musuh(1,1,3).
musuh(2,12,7).
musuh(3,11,3).
musuh(4,1,9).
musuh(5,2,10).
musuh(6,8,10).
musuh(7,11,9).
musuh(8,13,10).
musuh(9,16,8).
musuh(10,19,4).

/* Deklarasi Atribut */
health(100).
hunger(100).
thirst(100).

/* Deklarasi awal permainan */
gameOver(0).
goal(0).
statusGame(0).

/* Cek status game */
cek_status_game:-
	gameOver(A),
	goal(B),
	statusGame(C),
	A == 0,
	B == 0,
	C == 1,!.

cek_status_game:-
	gameOver(A),
	goal(B),
	statusGame(C),
	A == 0,
	B == 0,
	C == 0,
	write('Kamu belum memulai game! Masukan perintah \'start.\' untuk memulai permainan.'),nl,!,fail.

cek_status_game:-
	gameOver(A),
	goal(B),
	statusGame(C),
	A == 1,
	B == 0,
	C == 1,
	write('Kamu kalah! Tulis \'start.\' untuk memulai game baru.'),nl,!,
	retract(statusGame(_)), 
	asserta(statusGame(0)),fail.

cek_status_game:-
	gameOver(A),
	goal(B),
	statusGame(C),
	A == 0,
	B == 1,
	C == 1,
	write('Selamat kamu telah memenangkan permainan ini! Tulis \'start.\' untuk memulai game baru.'),nl,!,
	retract(statusGame(_)), 
	asserta(statusGame(0)),fail.

cek_status_game:-
	gameOver(A),
	goal(B),
	statusGame(C),
	A == 1,
	B == 0,
	C == 0,
	write('Kamu kalah! Tulis \'start.\' untuk memulai game baru.'),nl,!,fail.

cek_status_game:-
	gameOver(A),
	goal(B),
	statusGame(C),
	A == 0,
	B == 1,
	C == 0,
	write('Selamat kamu telah memenangkan permainan ini! Tulis \'start.\' untuk memulai game baru.'),nl,!,fail.

/* Cek isi petak */

cek_petak :-
	posisi(X,Y),
	at(teleportscroll,X,Y),!,
	write('Anda telah menemukan '),write('Teleportation Scroll'),write('! tulis take('),write('teleportscroll'),write(') untuk mengambil barang. '),nl,
	write('Barang sakral ini dijatuhkan oleh para pendahulu yang telah melewati tempat ini. Barang sakral ini dapat memindahkan kalian ke lokasi yang anda inginkan! gunakan command teleports(LokasiX,LokasiY). untuk pindah ke lokasi yang ditujukan'),nl.

cek_petak :-
	posisi(X,Y),
	at(katana,X,Y),!,
	write('Anda telah menemukan'),write(' Katana '),write('! tulis take('),write('katana'),write(') untuk mengambil barang. '),nl,
	write('Barang sakral ini dijatuhkan oleh para pendahulu yang telah melewati tempat ini. Dengan barang ini, kamu dapat melakukan fungsi lockAttack(X,Y). yang akan menyebabkan kamu pindah ke posisi(X,Y) lalu membunuh monster yang ada di sana jika ada.'),nl.


cek_petak :-
	posisi(X,Y),
	at(Z,X,Y),!,
	write('Ada '),write(Z),write(' di tempat kamu berdiri. tulis take('),write(Z),write(') untuk mengambil barang'),nl.

cek_petak:-!.

/* Cek Kondisi Menang atau Kalah */	
cekKondisi:-
		goal(X),
		X == 1,
		write('Selamat kamu telah memenangkan permainan ini! Tulis \'start.\' untuk memulai game baru.'),nl,!.

cekKondisi:-
		gameOver(X),
		X == 1,
		write('Kamu kalah! Tulis \'start.\' untuk memulai game baru.'),nl,!.

cekKondisi :- 
		health(X),
		X =< 0,
		retract(gameOver(_)),
		asserta(gameOver(1)),!.
		
cekKondisi :- 
		hunger(X),
		X =< 0,
		retract(gameOver(_)),
		asserta(gameOver(1)),!.

cekKondisi :- 
		thirst(X),
		X =< 0,
		retract(gameOver(_)),
		asserta(gameOver(1)),!.

cekKondisi :-
		musuh(1, 0, 0),
		musuh(2, 0, 0),
		musuh(3, 0, 0),
		musuh(4, 0, 0),
		musuh(5, 0, 0),
		musuh(6, 0, 0),
		musuh(7, 0, 0),
		musuh(8, 0, 0),
		musuh(9, 0, 0),
		musuh(10, 0, 0),
		retract(goal(_)),
		asserta(goal(1)),!.

/* Map */
peta :-
	at(radar,0,0),!,
	cek_status_game,
	write('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'),nl,write('X'),
	printer(1,1).

peta :-
	cek_status_game,
	write('Anda memerlukan radar untuk melihat peta!'),nl.

printer(X,Y):-
	X=21,
	Y=10,write(' X'),nl,write('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'),nl,
	!.

printer(X,Y):-
	X=21, write(' X'),nl,write('X'),
	X1 is 1,
	Y1 is (Y+1),!,
	printer(X1,Y1).

printer(X,Y):-
	musuh(_,X,Y),
	write(' E'),
	X1 is X+1,!,
	printer(X1,Y).


printer(X,Y):-
	at(_,X,Y),
	write(' I'),
	X1 is X+1,!,
	printer(X1,Y).

printer(X,Y):-
	posisi(X,Y),
	write(' P'),
	X1 is X+1,!,
	printer(X1,Y).

printer(X,Y):-
	write(' -'),
	X1 is X+1,!,
	printer(X1,Y).

/* Look */

look:-
	cek_status_game,
	posisi(A,B),
	X is (A-1),
	Y is (B-1),!,
	printerLook(X,Y).

printerLook(X,Y):-
	posisi(A,B),
	A1 is A+2,
	B1 is B+1,
	X = A1,
	Y = B1,!.

printerLook(X,Y):-
	posisi(A,_),
	A1 is A+2,
	X=A1,nl,
	X1 is A-1,
	Y1 is Y+1,!,
	printerLook(X1,Y1).

printerLook(X,Y):-
	X<1,
	write(' X'),
	X1 is X+1,!,
	printerLook(X1,Y).

printerLook(X,Y):-
	Y<1,
	write(' X'),
	X1 is X+1,!,
	printerLook(X1,Y).

printerLook(X,Y):-
	musuh(_,X,Y),
	write(' E'),
	X1 is X+1,!,
	printerLook(X1,Y).

printerLook(X,Y):-
	posisi(X,Y),
	write(' P'),
	X1 is X+1,!,
	printerLook(X1,Y).

printerLook(X,Y):-
	at(_,X,Y),
	write(' I'),
	X1 is X+1,!,
	printerLook(X1,Y).


printerLook(X,Y):-
	write(' -'), 
	X1 is X+1,!,
	printerLook(X1,Y).


/* Rule pengurangan darah */
kurang_health :-
	retract(health(X)),
	Y is X-15,
	asserta(health(Y)),
	write('Darahmu berkurang sebanyak 15 hp, Sisa Darah : '),write(Y),nl.

/* Command attack. */
lockAttack(X,Y):-
	cek_status_game,
	at(katana,0,0),
	posisi(A,B),
	TestX is abs(X-A),
	TestY is abs(Y-B),
	TestX =< 1,
	TestY =< 1,
	musuh(_,X,Y),!,
	retract(posisi(_,_)),
	asserta(posisi(X,Y)),
	retract(musuh(Q,X,Y)),
	asserta(musuh(Q,0,0)),
	kurang_health,
	write('Berhasil membunuh musuh dengan lockAttack!.'),nl,!.

lockAttack(X,Y):-
	cek_status_game,
	at(katana,0,0),
	posisi(A,B),
	TestX is abs(X-A),
	TestY is abs(Y-B),
	TestX =< 1,
	TestY =< 1,!,
	write('Tidak berhasil menggunakan command lockAttack. Tidak ada musuh di lokasi ini'),nl.


lockAttack(_,_):-
	cek_status_game,
	at(katana,0,0),!,
	write('Terlalu jauh! lockAttack hanya bisa dilakukan ke area sekelilng player!').


lockAttack(_,_):-
	write('Anda memerlukan katana untuk menggunakan command ini!'),nl.

attackKedua :-
	posisi(X,Y),
	musuh(A,X,Y),
	at(pedang,0,0),
	write('Kamu berhasil membunuh sebuah monster!'),nl,
	retract(musuh(A,X,Y)),
	asserta(musuh(A,0,0)),
	kurang_health,cekKondisi,
	cekKondisi,attackKedua.

attack :-
	cek_status_game,
	posisi(X,Y),
	musuh(A,X,Y),
	at(pedang,0,0),!,
	write('Kamu berhasil membunuh sebuah monster!'),nl,
	retract(musuh(A,X,Y)),
	asserta(musuh(A,0,0)),
	kurang_health,gerakMusuh(1),attackKedua,cekKondisi,
	cekKondisi.

attack :-
	posisi(X,Y),
	musuh(_,X,Y),
	at(pedang,_,_),!,
	write('Kamu memerlukan pedang untuk membunuh monster!'),nl.

attack :-
	write('Tidak ada musuh di sini!'),nl.

/* Mulai */
start:- 
	retract(statusGame(_)),
	asserta(statusGame(1)),
	retract(posisi(_,_)),
	asserta(posisi(1,1)),
	retract(health(_)),
	asserta(health(100)),
	retract(hunger(_)),
	asserta(hunger(100)),
	retract(thirst(_)),
	asserta(thirst(100)),
	retract(gameOver(_)),
	asserta(gameOver(0)),
	retract(goal(_)),
	asserta(goal(0)),

	retract(at(teleportscroll,_,_)), asserta(at(teleportscroll,19,2)),
	retract(at(katana,_,_)), asserta(at(katana,10,3)),
	retract(at(radar,_,_)), asserta(at(radar,14,1)),
	
	retract(at(sepatu,_,_)), asserta(at(sepatu,3,4)),
	retract(at(pedang,_,_)), asserta(at(pedang,2,2)),
	retract(at(senter,_,_)), asserta(at(senter,9,7)),
	retract(at(rakit,_,_)), asserta(at(rakit,5,9)),
	retract(at(kapal,_,_)), asserta(at(kapal,14,9)),
	retract(at(roti,_,_)), asserta(at(roti,2,3)),
	retract(at(sup,_,_)), asserta(at(sup,5,9)),
	retract(at(ayam,_,_)), asserta(at(ayam,2,13)),
	retract(at(daging,_,_)), asserta(at(daging,8,5)),
	retract(at(jagung,_,_)), asserta(at(jagung,10,9)),
	retract(at(apel,_,_)), asserta(at(apel,5,15)),
	retract(at(bayam,_,_)), asserta(at(bayam,10,16)),
	retract(at(airminum,_,_)), asserta(at(airminum,5,5)),
	retract(at(botolsusu,_,_)), asserta(at(botolsusu,1,9)),
	retract(at(jusmelon,_,_)), asserta(at(jusmelon,6,10)),
	retract(at(esteh,_,_)), asserta(at(esteh,6,2)),
	retract(at(susukotak,_,_)), asserta(at(susukotak,9,12)),
	retract(at(esjeruk,_,_)), asserta(at(esjeruk,8,20)),
	retract(at(airmineral,_,_)), asserta(at(airmineral,4,17)),
	retract(at(obat1,_,_)), asserta(at(obat1,2,5)),
	retract(at(obat2,_,_)), asserta(at(obat2,5,12)),
	retract(at(obat3,_,_)), asserta(at(obat3,8,7)),
	retract(at(obat4,_,_)), asserta(at(obat4,10,4)),
	retract(at(obat5,_,_)), asserta(at(obat5,9,14)),
	retract(at(obat6,_,_)), asserta(at(obat6,10,20)),
	retract(at(obat7,_,_)), asserta(at(obat7,2,19)),
	retract(musuh(1,_,_)), asserta(musuh(1,1,3)),
	retract(musuh(2,_,_)), asserta(musuh(2,12,7)),
	retract(musuh(3,_,_)), asserta(musuh(3,11,3)),
	retract(musuh(4,_,_)), asserta(musuh(4,1,9)),
	retract(musuh(5,_,_)), asserta(musuh(5,2,10)),
	retract(musuh(6,_,_)), asserta(musuh(6,8,10)),
	retract(musuh(7,_,_)), asserta(musuh(7,11,9)),
	retract(musuh(8,_,_)), asserta(musuh(8,13,10)),
	retract(musuh(9,_,_)), asserta(musuh(9,16,8)),
	retract(musuh(10,_,_)), asserta(musuh(10,19,4)),
	help,
	repeat,
	write('>'),
	read(MasukanCommand),
	catch(MasukanCommand, error(existence_error(procedure, _), _), format('Tidak ada command ~w.~n', [MasukanCommand])),nl,
	MasukanCommand == quit.

	
help :-
        nl,
        write('Enter commands using standard Prolog syntax.'), nl,
        write('Available commands are:'), nl,
        write('start.                             -- start the game!'), nl,
        write('help.                              -- show available commands'), nl,
        write('quit.                              -- quit the game'), nl,
        write('look.                              -- look around you'), nl,
        write('utara. selatan. timur. barat.      -- move'), nl,
        write('peta.                              -- look at the map and detect enemies'), nl,
        write('take(Object).                      -- pick up an object'), nl,
        write('drop(Object).                      -- drop an object'), nl,
        write('use(Object).                       -- use an object'), nl,
        write('attack.                            -- attack enemy that crosses your path'), nl,
        write('status.                            -- show your status'), nl,
        write('cekLokasi.                         -- print lokasi'), nl,
        write('lockAttack(LokasiX,LokasiY)        -- Secret Item'), nl,
        write('teleport(LokasiX,LokasiY)          -- Secret Item'), nl,
        write('save(Filename).                    -- save your game'), nl,
        write('loadFile(Filename).                -- load previously saved game'), nl,nl,
        write('Legends:'), nl,
        write('P = Player'), nl,
        write('I = Item'), nl,
        write('E = Enemy'), nl,
        write('- = Tile Kosong'), nl,
        write('X = Pagar'), nl,
        nl.

/*Deklarasi tempat */
/* Timur */

tempat(X,Y,timur):- 
			X=5,
			Y=<5,
			at(sepatu, 0, 0 ),
			write('BERHASIL MEMASUKI AREA PADANG RUMPUT'),nl.
			
			
tempat(X,Y,timur):- 
			X=5,
			Y=<8,
			at(sepatu, _, _),
			write('Diperlukan sepatu untuk ke padang rumput'), nl,
			!, fail.
			
tempat(X,_, timur):-
			X = 14,
			at(kapal, 0, 0),
			write('BERHASIL MEMASUKI AREA LAUT'),nl.

tempat(X,_, timur):-
			X = 14,
			at(kapal, _, _),
			write('Diperlukan kapal untuk ke laut'),nl,
			!, fail.
tempat(X,Y, timur):-
			X = 5,
			Y>=9,
			Y=<10,
			at(rakit,0,0),
			write('BERHASIL MEMASUKI AREA SUNGAI'),nl.
tempat(X,Y, timur):-
			X = 5,
			Y>=9,
			Y=<10,
			at(rakit,_,_),
			write('Diperlukan rakit untuk ke sungai'),nl,
			!, fail.

/* Utara */
tempat(X,Y,utara):- 
			X=<5,
			Y=6,
			at(_, _, _ ),
			write('BERHASIL MEMASUKI AREA BASE'),nl.
			
			
tempat(X,Y,utara):- 
			X>=6,
			X=<14,
			Y=9,
			at(sepatu, 0, 0),
			write('BERHASIL MEMASUKI AREA PADANG RUMPUT'), nl,
			!, fail.

tempat(X,Y,utara):- 
			X>=6,
			X=<14,
			Y=9,
			at(sepatu, _, _),
			write('Diperlukan sepatu untuk ke padang rumput'), nl,
			!, fail.

/* Selatan */
tempat(X,Y,selatan):-
			X=<5,
			Y=5,
			at(senter, 0, 0),
			write('BERHASIL MEMASUKI AREA HUTAN GELAP'),nl.

tempat(X,Y,selatan):-
			X=<5,
			Y=5,
			at(senter, _, _),
			write('Diperlukan senter untuk ke hutan gelap'), nl,
			!, fail.

tempat(X,Y,selatan):-
			X>5,
			X=<15,
			Y=8,
			at(rakit, 0, 0),
			write('BERHASIL MEMASUKI AREA SUNGAI'), nl.

tempat(X,Y,selatan):-
			X>5,
			X=<15,
			Y=8,
			at(rakit, _, _),
			write('Diperlukan rakit untuk ke sungai'), nl,
			!, fail.

/* Barat */
tempat(X,Y,barat):-
			X=6,
			Y>5,
			at(senter, 0, 0),
			write('BERHASIL MEMASUKI AREA HUTAN GELAP'),nl.

tempat(X,Y,barat):-
			X=6,
			Y>5,
			at(senter, _, _),
			write('Diperlukan senter untuk ke hutan gelap'), nl,
			!, fail.

tempat(X,Y,barat):-
			X=15,
			Y>8,
			at(rakit, 0, 0),
			write('BERHASIL MEMASUKI AREA SUNGAI'), nl.

tempat(X,Y,barat):-
			X=15,
			Y>8,
			at(rakit, _, _),
			write('Diperlukan rakit untuk ke sungai'), nl,
			!, fail.

tempat(X,Y,barat):- 
			X=15,
			Y=<8,
			at(sepatu, 0, 0),
			write('BERHASIL MEMASUKI AREA PADANG RUMPUT'), nl,
			!, fail.

tempat(X,Y,barat):- 
			X=15,
			Y=<8,
			at(sepatu, _, _),
			write('Diperlukan sepatu untuk ke padang rumput'), nl,
			!, fail.
			
/* Gerak ketempat selain titik-titik bersyarat */
tempat(_,_,_):-!.

/* Deklarasi gerak */

utara :- go(utara).

selatan :- go(selatan).

timur :- go(timur).

barat :- go(barat).

go(Masukan) :-
		cek_status_game,
		posisi(X,Y),
		musuh(_,LokasiMusuhX,LokasiMusuhY),
		LokasiMusuhX == X,
		LokasiMusuhY == Y,write('Kamu tidak menyerang! Sebuah monster menyerang mu!'),!,
		kurang_health,nl,
		tempat(X,Y,Masukan),
		path(X, Y, Masukan, X1, Y1),
		retract(posisi(X,Y)),
		asserta(posisi(X1,Y1)),
		gerakMusuh(1),
		cek_petak,
		hunger(Lapar),
		thirst(Haus),
		LaparBaru is Lapar-2,
		HausBaru is Haus-2,
		retract(hunger(_)),
		asserta(hunger(LaparBaru)),
		retract(thirst(_)),
		asserta(thirst(HausBaru)),cekKondisi,
		cekKondisi.

go(Masukan) :-
		cek_status_game,
		posisi(X,Y),
		tempat(X,Y,Masukan),
		path(X, Y, Masukan, X1, Y1),
		retract(posisi(X,Y)),
		asserta(posisi(X1,Y1)),!,
		gerakMusuh(1),
		cek_petak,
		hunger(Lapar),
		thirst(Haus),
		LaparBaru is Lapar-2,
		HausBaru is Haus-2,
		retract(hunger(_)),
		asserta(hunger(LaparBaru)),
		retract(thirst(_)),
		asserta(thirst(HausBaru)),cekKondisi,
		cekKondisi.

/* Deklarasi rule cek status */
printInventory:-
	at(Barang,0,0),
	write(Barang),nl,fail.

status:-
	cek_status_game,
	health(Darah),
	hunger(Lapar),
	thirst(Haus),
	format('Health: ~w ~n', [Darah]),
	format('Hunger: ~w ~n', [Lapar]),
	format('Thirst: ~w ~n', [Haus]),
	write('Inventory:'),nl,
	printInventory.
	



/* Deklarasi gerak random musuh */
	
randomGerak(XAwal,YAwal,XAkhir,YAkhir):-
	random(-1,2,XPlus),
	random(-1,2,YPlus),
	XAkhir is XAwal+XPlus,
	YAkhir is YAwal+YPlus,
	XAkhir \== 0,
	YAkhir \== 0,
	XAkhir \== 21,
	YAkhir \== 11,!.

randomGerak(XAwal,YAwal,XAkhir,YAkhir):-
	!,randomGerak(XAwal,YAwal,XAkhir,YAkhir).




gerakMusuh(X) :-
	X==11,!.

gerakMusuh(X) :-
	musuh(X,CekX,CekY),
	CekX \== 0,
	CekY \== 0,
	posisi(A,B),
	CekX == A,
	CekY == B,!,
	write('Musuh ditemukan!'),nl.

gerakMusuh(X) :-
	musuh(X,CekX,CekY),
	CekX \== 0,
	CekY \== 0,
	retract(musuh(X,XAwal,YAwal)),
	randomGerak(XAwal,YAwal,XAkhir,YAkhir),
	asserta(musuh(X,XAkhir,YAkhir)),
	X1 is X+1,!,
	gerakMusuh(X1).

gerakMusuh(X) :-
	X1 is X+1,
	gerakMusuh(X1).


		

/* Gerak utara */
path(X, Y, Masukan, X1, Y1):-
							Y > 1,
							Masukan == utara,
							X1 is X,
							Y1 is (Y-1).

path(X, Y, Masukan, X1, Y1):-
							(Y = 1),
							Masukan == utara,
							X1 is X,
							Y1 is Y,
							nl, write('Tidak bisa ke utara lagi.'), nl,!,fail.
							
/* Gerak selatan */
path(X, Y, Masukan, X1, Y1):-
							Y < 10,
							Masukan == selatan,
							X1 is X,
							Y1 is (Y+1).

path(X, Y, Masukan, X1, Y1):-
							(Y = 10),
							Masukan == selatan,
							X1 is X,
							Y1 is Y,
							nl, write('Tidak bisa ke selatan lagi.'), nl,!,fail.
							
/* Gerak timur */
path(X, Y, Masukan, X1, Y1):-
							X < 20,
							Masukan == timur,
							Y1 is Y,
							X1 is (X+1).

path(X, Y, Masukan, X1, Y1):-
							(X = 20),
							Masukan == timur,
							X1 is X,
							Y1 is Y,
							nl, write('Tidak bisa ke timur lagi.'), nl,!,fail.
							
/* Gerak barat */
path(X, Y, Masukan, X1, Y1):-
							X > 1,
							Masukan == barat,
							Y1 is Y,
							X1 is (X-1).

path(X, Y, Masukan, X1, Y1):-
							(X = 1),
							Masukan == barat,
							X1 is X,
							Y1 is Y,
							nl, write('Tidak bisa ke barat lagi.'), nl,!,fail.

		
/* Deklarasi take */

take(A) :-
		cek_status_game,
        at(A, 0,0 ),
		write(A),
        write(' sudah di tangan!'),
        nl, gerakMusuh(1),!.

take(A) :-
        posisi(X,Y),
        at(A, X,Y),
        retract(at(A, X,Y)),
        asserta(at(A, 0 , 0)),
        write('Barang berhasil diambil.'),
        nl, gerakMusuh(1),!.

take(_) :-
        write('Barang tidak ada di sini.'),gerakMusuh(1),
        nl.

drop(A) :-
		cek_status_game,
        at(A, 0,0 ),
        posisi(X,Y),
        retract(at(A, 0 , 0)),
        asserta(at(A, X, Y)),
        write('Barang berhasil dijatuhkan!'),
        nl,gerakMusuh(1), !.

drop(_) :-
        write('Kamu tidak memegang barang tersebut!'),gerakMusuh(1),
        nl.

quit :- 
	write('Terima kasih telah bermain'),
	halt.



/* Rule untuk usable items */
/* Rule untuk usable items */
pakai(roti) :-
        at(roti, 0,0 ),
        retract(at(roti, 0, 0)),
        asserta(at(roti, -1, -1)),
        hunger(H),
        H1 is H+10,
        retract(hunger(_)),
        asserta(hunger(H1)),
        write('Kamu telah memakan roti.'),gerakMusuh(1),
        nl, !.
pakai(sup) :-
        at(sup, 0,0 ),
        retract(at(sup, 0, 0)),
        asserta(at(sup, -1, -1)),
        hunger(H),
        H1 is H+15,
        retract(hunger(_)),
        asserta(hunger(H1)),
        write('Kamu telah memakan sup.'),gerakMusuh(1),
        nl, !.
pakai(ayam) :-
        at(ayam, 0,0 ),
        retract(at(ayam, 0, 0)),
        asserta(at(ayam, -1, -1)),
        hunger(H),
        H1 is H+15,
        retract(hunger(_)),
        asserta(hunger(H1)),
        write('Kamu telah memakan ayam.'),gerakMusuh(1),
        nl, !.
pakai(daging) :-
        at(daging, 0,0 ),
        retract(at(daging, 0, 0)),
        asserta(at(daging, -1, -1)),
        hunger(H),
        H1 is H+20,
        retract(hunger(_)),
        asserta(hunger(H1)),
        write('Kamu telah memakan daging.'),gerakMusuh(1),
        nl, !.
pakai(jagung) :-
        at(jagung, 0,0 ),
        retract(at(jagung, 0, 0)),
        asserta(at(jagung, -1, -1)),
        hunger(H),
        H1 is H+15,
        retract(hunger(_)),
        asserta(hunger(H1)),
        write('Kamu telah memakan jagung.'),gerakMusuh(1),
        nl, !.
pakai(apel) :-
        at(apel, 0,0 ),
        retract(at(apel, 0, 0)),
        asserta(at(apel, -1, -1)),
        hunger(H),
        H1 is H+10,
        retract(hunger(_)),
        asserta(hunger(H1)),
        write('Kamu telah memakan apel.'),gerakMusuh(1),
        nl, !.
pakai(bayam) :-
        at(bayam, 0,0 ),
        retract(at(bayam, 0, 0)),
        asserta(at(bayam, -1, -1)),
        hunger(H),
        H1 is H+15,
        retract(hunger(_)),
        asserta(hunger(H1)),
        write('Kamu telah memakan bayam.'),gerakMusuh(1),
        nl, !.
pakai(airminum) :-
        at(airminum, 0,0 ),
        retract(at(airminum, 0, 0)),
        asserta(at(airminum, -1, -1)),
        thirst(H),
        H1 is H+10,
        retract(thirst(_)),
        asserta(thirst(H1)),
        write('Kamu telah meminum air.'),gerakMusuh(1),
        nl, !.
pakai(botolsusu) :-
        at(botolsusu, 0,0 ),
        retract(at(botolsusu, 0, 0)),
        asserta(at(botolsusu, -1, -1)),
        thirst(H),
        H1 is H+15,
        retract(thirst(_)),
        asserta(thirst(H1)),
        write('Kamu telah meminum sebotol susu.'),gerakMusuh(1),
        nl, !.
pakai(jusmelon) :-
        at(jusmelon, 0,0 ),
        retract(at(jusmelon, 0, 0)),
        asserta(at(jusmelon, -1, -1)),
        thirst(H),
        H1 is H+15,
        retract(thirst(_)),
        asserta(thirst(H1)),
        write('Kamu telah meminum jus melon.'),gerakMusuh(1),
        nl, !.
pakai(esteh) :-
        at(esteh, 0,0 ),
        retract(at(esteh, 0, 0)),
        asserta(at(esteh, -1, -1)),
        thirst(H),
        H1 is H+15,
        retract(thirst(_)),
        asserta(thirst(H1)),
        write('Kamu telah meminum es teh.'),gerakMusuh(1),
        nl, !.
pakai(susukotak) :-
        at(susukotak, 0,0 ),
        retract(at(susukotak, 0, 0)),
        asserta(at(susukotak, -1, -1)),
        thirst(H),
        H1 is H+15,
        retract(thirst(_)),
        asserta(thirst(H1)),
        write('Kamu telah meminum sekotak susu.'),gerakMusuh(1),
        nl, !.
pakai(esjeruk) :-
        at(esjeruk, 0,0 ),
        retract(at(esjeruk, 0, 0)),
        asserta(at(esjeruk, -1, -1)),
        thirst(H),
        H1 is H+15,
        retract(thirst(_)),
        asserta(thirst(H1)),
        write('Kamu telah meminum es jeruk.'),gerakMusuh(1),
        nl, !.
pakai(airmineral) :-
        at(airmineral, 0,0 ),
        retract(at(airmineral, 0, 0)),
        asserta(at(airmineral, -1, -1)),
        thirst(H),
        H1 is H+15,
        retract(thirst(_)),
        asserta(thirst(H1)),
        write('Kamu telah meminum air mineral.'),gerakMusuh(1),
        nl, !.
pakai(obat1) :-
        at(obat1, 0,0 ),
        retract(at(obat1, 0, 0)),
        asserta(at(obat1, -1, -1)),
        health(H),
        H1 is H+15,
        retract(health(_)),
        asserta(health(H1)),
        write('Kamu telah mengobati lukamu dengan obat ini.'),gerakMusuh(1),
        nl, !.
pakai(obat2) :-
        at(obat2, 0,0 ),
        retract(at(obat2, 0, 0)),
        asserta(at(obat2, -1, -1)),
        health(H),
        H1 is H+15,
        retract(health(_)),
        asserta(health(H1)),
        write('Kamu telah mengobati lukamu dengan obat ini.'),gerakMusuh(1),
        nl, !.
pakai(obat3) :-
        at(obat3, 0,0 ),
        retract(at(obat3, 0, 0)),
        asserta(at(obat3, -1, -1)),
        health(H),
        H1 is H+15,
        retract(health(_)),
        asserta(health(H1)),
        write('Kamu telah mengobati lukamu dengan obat ini.'),gerakMusuh(1),
        nl, !.
pakai(obat4) :-
        at(obat4, 0,0 ),
        retract(at(obat4, 0, 0)),
        asserta(at(obat4, -1, -1)),
        health(H),
        H1 is H+15,
        retract(health(_)),
        asserta(health(H1)),
        write('Kamu telah mengobati lukamu dengan obat ini.'),gerakMusuh(1),
        nl, !.
pakai(obat5) :-
        at(obat5, 0,0 ),
        retract(at(obat5, 0, 0)),
        asserta(at(obat5, -1, -1)),
        health(H),
        H1 is H+15,
        retract(health(_)),
        asserta(health(H1)),
        write('Kamu telah mengobati lukamu dengan obat ini.'),gerakMusuh(1),
        nl, !.
pakai(obat6) :-
        at(obat6, 0,0 ),
        retract(at(obat6, 0, 0)),
        asserta(at(obat6, -1, -1)),
        health(H),
        H1 is H+15,
        retract(health(_)),
        asserta(health(H1)),
        write('Kamu telah mengobati lukamu dengan obat ini.'),gerakMusuh(1),
        nl, !.
pakai(obat7) :-
        at(obat7, 0,0 ),
        retract(at(obat7, 0, 0)),
        asserta(at(obat7, -1, -1)),
        health(H),
        H1 is H+15,
        retract(health(_)),
        asserta(health(H1)),
        write('Kamu telah mengobati lukamu dengan obat ini.'),gerakMusuh(1),
        nl, !.
pakai(_) :-
        write('Kamu tidak memiliki barang tersebut!'),gerakMusuh(1),
        nl.

        
save(Filename):-

		cek_status_game,

		open(Filename, write, Stream),
		/* save atribut pemain */
		posisi(X, Y),
		hunger(H), thirst(T), health(Ht),
		write2TermToFile(Stream, X, Y),
		writeToFileWithNl(Stream, H),
		writeToFileWithNl(Stream, T),
		writeToFileWithNl(Stream, Ht),
		/* save musuh yang ada di manapun */
		forall(musuh(MusuhKe, A, B), write3TermToFile(Stream, MusuhKe, A, B)),
		/* save inventory di tangan atau di manapun*/
		forall(at(Barang, C, D), write3TermToFile(Stream, Barang, C, D)),

		close(Stream),
		quit.

writeToFileWithNl(Stream, Var) :-
		write(Stream, Var),write(Stream, '.'),
		nl(Stream), !.
		
write3TermToFile(Stream, Sesuatu, X, Y):-
		write(Stream, Sesuatu),write(Stream, '.'), nl(Stream),
		write(Stream, X),write(Stream, '.'), nl(Stream),
		write(Stream, Y),write(Stream, '.'),
		nl(Stream), !.

write2TermToFile(Stream, X, Y):-
		write(Stream, X),write(Stream, '.'),
		nl(Stream),
		write(Stream, Y),write(Stream, '.'),
		nl(Stream),!.


		
loadFile(Filename) :-
		statusGame(X),
		X == 0,
		open(Filename, read, Stream),
		read(Stream,PosX),
		read(Stream,PosY),
		retract( posisi(_,_) ),
		asserta( posisi(PosX,PosY) ),
		read(Stream,H),
		read(Stream,T),
		read(Stream,Ht),
		retract(hunger(_)),
		asserta(hunger(H)),
		retract(thirst(_)),
		asserta(thirst(T)),
		retract(health(_)),
		asserta(health(Ht)),
		readMusuh(Stream,1),
		readBarang(Stream,1),
		retract(statusGame(_)),asserta(statusGame(1)),
		close(Stream),
		write('Load file berhasil!'),nl,!,
		help,
		repeat,
		write('>'),
		read(MasukanCommand),
		catch(MasukanCommand, error(existence_error(procedure, _), _), format('Tidak ada command ~w.~n', [MasukanCommand])),nl,
		MasukanCommand == quit.


loadFile(_) :-
		write('Kamu sudah memulai game! Quit telebih dahulu untuk melakukan load.'),nl,!.

readMusuh(_, Count):-
	Count == 11,!.

readMusuh(Stream, Count):-

	read(Stream,MusuhKe),
	read(Stream,PosMusuhX),
	read(Stream,PosMusuhY),
	retract(musuh(MusuhKe,_,_)), asserta(musuh(MusuhKe,PosMusuhX,PosMusuhY)),
	Count2 is Count+1,
	readMusuh(Stream, Count2).

readBarang(_,Count):-
	Count == 30,!.

readBarang(Stream,Count):-

	read(Stream,Barang),
	read(Stream,PosBarangX),
	read(Stream,PosBarangY),
	retract(at(Barang,_,_)), asserta(at(Barang,PosBarangX,PosBarangY)),
	Count2 is Count+1,
	readBarang(Stream,Count2).

teleport(X,Y):-
	at(teleportscroll,0,0),!,
	retract(posisi(_,_)),
	asserta(posisi(X,Y)),
	write('Anda telah pindah ke lokasi '),write(X),write(' '),write(Y),write('.'),
	retract(at(teleportscrolltscoll,_,_)),
	asserta(at(teleportscrolltscoll,-2,-2)).

teleport(_,_):-
	write('Anda memerlukan teleportation scroll untuk menggunakan command ini.'),nl.

cekLokasi:-
	posisi(X,Y),
	write('Lokasi anda:'),write(X),write(' '),write(Y).




