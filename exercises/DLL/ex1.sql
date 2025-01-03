-- Ova se bara
create table Vraboten
(
    ID          text primary key,
    ime         text,
    prezime     text,
    datum_r     date,
    datum_v     date,
    obrazovanie text,
    plata       integer,
    check (datum_r < datum_v)
);

-- Ova se bara
create table Shalterski_rabotnik
(
    ID text primary key,
    foreign key (ID) references Vraboten (ID) on delete cascade on update cascade
);

create table Klient
(
    MBR_k   integer primary key,
    ime     text,
    prezime text,
    adresa  text default 'Ne e navedena',
    datum   date
);

create table Smetka
(
    MBR_k_s integer,
    broj    integer,
    valuta  text,
    saldo   integer,
    primary key (MBR_k_s, broj)
);

-- Ova se bara
create table Transakcija_shalter
(
    ID      text primary key,
    ID_v    text,
    MBR_k   integer,
    MBR_k_s integer,
    broj    integer,
    datum   date,
    suma    integer,
    tip     text,
    foreign key (ID_v) references Shalterski_rabotnik (ID) on delete set null on update cascade,
    foreign key (MBR_k) references Klient(MBR_k) on delete cascade on update cascade,
    foreign key (MBR_k_s, broj) references Smetka(MBR_k_s, broj) on delete cascade on update cascade,
    check ( datum not between '2020-12-30' and '2021-01-14'),
    check ( tip in ('uplata', 'isplata') )
);

create table Bankomat
(
    ID       text primary key,
    lokacija text,
    datum_p  date,
    zaliha   integer
);

create table Transakcija_bankomat
(
    ID      text primary key,
    MBR_k_s integer,
    broj    integer,
    ID_b    integer,
    datum   date,
    suma    integer,
    foreign key (MBR_k_s, broj) references Smetka (MBR_k_s, broj) on delete no action on update cascade,
    foreign key (ID_b) references Bankomat (ID) on delete no action on update cascade
);
