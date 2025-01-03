create table Korisnik
(
    k_ime     text primary key,
    ime       text,
    prezime   text,
    tip       text,
    pretplata text,
    datum_reg date,
    tel_broj  varchar(12),
    email     text,
    check ( datum_reg between '2023-01-01' and '2024-31-12')
);

create table Premium_korisnik
(
    k_ime          text primary key,
    datum          date,
    procent_popust integer default 20,
    foreign key (k_ime) references Korisnik (k_ime) on delete cascade on update cascade
);

create table Profil
(
    k_ime text,
    ime   text,
    datum date,
    primary key (k_ime, ime),
    foreign key (k_ime) references Korisnik (k_ime) on delete cascade on update cascade
);

create table Video_zapis
(
    naslov       text primary key,
    jazik        text default 'English',
    vremetraenje text,
    datum_d      date,
    datum_p      date,
    check ( datum_d >= datum_p )
);

create table Video_zapis_zanr
(
    naslov text,
    zanr   text,
    primary key (naslov, zanr),
    foreign key (naslov) references Video_zapis (naslov) on delete cascade on update cascade
);

create table Lista_zelbi
(
    naslov text,
    k_ime  text,
    ime    text,
    primary key (naslov, k_ime, ime),
    foreign key (naslov) references Video_zapis (naslov) on delete cascade on update cascade,
    foreign key (k_ime, ime) references Profil (k_ime, ime) on delete cascade on update cascade
);

create table Preporaka
(
    ID       text primary key,
    k_ime_od text,
    k_ime_na text,
    naslov   text default 'Deleted',
    datum    date,
    komentar varchar(250) not null,
    ocena    integer,
    foreign key (k_ime_od) references Korisnik (k_ime) on delete cascade on update cascade,
    foreign key (k_ime_na) references Korisnik (k_ime) on delete cascade on update cascade,
    foreign key (naslov) references Video_zapis (naslov) on delete set default on update cascade,
    check ( ocena between 1 and 5),
    check ( datum >= '2022-12-07' )
);

