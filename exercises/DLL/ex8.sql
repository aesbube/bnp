create table Vraboten
(
    ID          integer primary key,
    ime         text,
    prezime     text,
    datum_r     date,
    datum_v     date,
    obrazovanie text,
    plata       integer,
    check (datum_r < datum_v),
    check (obrazovanie in ('PhD', 'MSc', 'High School', 'BSc'))
);

create table Shalterski_rabotnik
(
    ID integer primary key,
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
    MBR_k  integer,
    broj   integer,
    valuta text,
    saldo  integer,
    primary key (MBR_k, broj),
    foreign key (MBR_k) references Klient (MBR_k) on delete cascade on update cascade
);

create table Transakcija_shalter
(
    ID      integer primary key,
    ID_v    integer,
    MBR_k   integer,
    MBR_k_s integer,
    broj    integer,
    datum   date,
    suma    integer,
    tip     text,
    foreign key (ID_v) references Shalterski_rabotnik (ID) on delete set null on update cascade,
    foreign key (MBR_k) references Klient (MBR_k) on delete cascade on update cascade,
    foreign key (MBR_k_s, broj) references Smetka (MBR_k, broj) on delete cascade on update cascade,
    check (datum not between '2020-12-30' and '2021-01-14'),
    check (tip in ('uplata', 'isplata'))
);

create table Bankomat
(
    ID       integer primary key,
    lokacija text unique,
    datum    date,
    zaliha   integer,
    check (zaliha >= 0)
);

create table Transakcija_bankomat
(
    ID      integer primary key,
    MBR_k_s integer,
    broj    integer,
    ID_b    integer default -1,
    datum   date,
    suma    integer,
    foreign key (MBR_k_s, broj) references Smetka (MBR_k, broj) on delete cascade on update cascade,
    foreign key (ID_b) references Bankomat (ID) on delete set default on update cascade,
    check (datum not between '2020-12-30' and '2021-01-14')
);
