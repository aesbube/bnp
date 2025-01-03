create table Muzicar
(
    id             text primary key,
    ime            text,
    prezime        text,
    datum_ragjanje date
);

create table Muzicar_instrument
(
    id_muzicar text,
    instrument text,
    primary key (id_muzicar, instrument),
    foreign key (id_muzicar) references Muzicar (id)
);

-- Ova se bara
create table Bend
(
    id               text primary key,
    ime              text,
    godina_osnovanje integer,
    check ( godina_osnovanje >= 1970 )
);

-- Ova se bara
create table Bend_zanr
(
    id_bend text,
    zanr    text,
    primary key (id_bend, zanr),
    foreign key (id_bend) references Bend (id) on delete cascade on update cascade
);

create table Nastan
(
    id        text primary key,
    cena      integer,
    kapacitet integer
);

create table Koncert
(
    id    text primary key,
    datum date,
    vreme text,
    foreign key (id) references Nastan (id) on delete cascade on update cascade
);

create table Festival
(
    id primary key,
    name text,
    foreign key (id) references Nastan (id) on delete cascade on update cascade
);

create table Festival_odrzuvanje
(
    id       text,
    datum_od date,
    datum_do date,
    primary key (id, datum_od),
    foreign key (id) references Festival (id) on delete cascade on update cascade
);

create table Muzicar_bend
(
    id_muzicar       text,
    id_bend          text,
    datum_napustanje date,
    primary key (id_muzicar, id_bend),
    foreign key (id_muzicar) references Muzicar (id) on delete cascade on update cascade,
    foreign key (id_bend) references Bend (id) on delete cascade on update cascade
);

-- Ova se bara
create table Festival_bend
(
    id_festival text,
    datum_od    date,
    id_bend     text,
    primary key (id_festival, datum_od, id_bend),
    foreign key (id_festival, datum_od) references Festival_odrzuvanje (id, datum_od) on delete cascade on update cascade,
    foreign key (id_bend) references Bend (id) on delete set default on update cascade,
    check ( not (id_bend = '5' and id_festival = '2') )
);

create table Koncert_muzicar_bend
(
    id_koncert text,
    id_muzicar text,
    id_bend    text,
    primary key (id_koncert, id_muzicar, id_bend),
    foreign key (id_koncert) references Koncert (id) on delete cascade on update cascade,
    foreign key (id_muzicar) references Muzicar (id) on delete cascade on update cascade,
    foreign key (id_bend) references Bend (id) on delete cascade on update cascade
);
