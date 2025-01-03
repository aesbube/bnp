-- Ova se bara
create table Korisnik
(
    k_ime     text primary key,
    ime       text,
    prezime   text,
    tip       text,
    pretplata text,
    datum_reg date,
    tel_broj  text,
    email     text,
    check ( not (datum_reg < '2015-01-01' and pretplata = 'pretplata 3') )
);

-- Ova se bara
create table Premium_korisnik
(
    k_ime          text primary key,
    datum          date,
    procent_popust integer default 10,
    foreign key (k_ime) references Korisnik (k_ime) on delete cascade on update cascade
);

create table Profil
(
    k_ime text,
    ime   text,
    datum date,
    primary key (k_ime, ime),
    foreign key (k_ime) references Korisnik (ime) on delete cascade on update cascade
);

create table Video_zapis
(
    naslov       text primary key,
    jazik        text,
    vremetraenje text,
    datum_d      date,
    datum_p      date
);

create table Video_zapis_zanr
(
    naslov text,
    zanr   text,
    primary key (naslov, zanr),
    foreign key (naslov) references Video_zapis (naslov) on delete cascade on update cascade
);

-- Ova se bara
create table Lista_zelbi
(
    ID     text primary key,
    naslov text,
    k_ime  text,
    ime    text,
    foreign key (naslov) references Video_zapis (naslov) on delete set null on update cascade,
    foreign key (k_ime, ime) references Profil (k_ime, ime) on delete cascade on update cascade
);

create table Preporaka
(
    ID       text primary key,
    k_ime_od text,
    k_ime_na text,
    naslov   text,
    datum    date,
    komentar text,
    ocena    integer,
    foreign key (k_ime_od) references Korisnik (k_ime) on delete set null on update cascade,
    foreign key (k_ime_na) references Korisnik (k_ime) on delete cascade on update cascade,
    foreign key (naslov) references Video_zapis (naslov) on delete cascade on update cascade,
    check ( k_ime_od != k_ime_na and datum <= current_date)
);

