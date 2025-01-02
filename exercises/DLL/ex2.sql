create table Lice
(
    id      text primary key,
    mbr     integer,
    ime     text,
    prezime text,
    data_r  date,
    vozrast integer,
    pol     text
);

create table Med_lice
(
    id primary key,
    staz integer,
    foreign key (id) references Lice (id) on delete cascade on update cascade
);

-- Ova se bara
create table Test
(
    id           text,
    shifra       integer,
    tip          text,
    datum        date,
    rezultat     text,
    laboratorija text,
    primary key (id, shifra),
    foreign key (id) references Lice (id) on delete cascade on update cascade,
    check ( not (laboratorija = 'lab-abc' and tip != 'seroloshki') )
);

create table Vakcina
(
    shifra       integer primary key,
    ime          text,
    proizvoditel text
);

-- Ova se bara
create table Vakcinacija
(
    id_lice        text,
    id_med_lice    text,
    shifra_vakcina text,
    primary key (id_lice, id_med_lice, shifra_vakcina),
    foreign key (id_lice) references Lice (id) on delete set default on update cascade,
    foreign key (id_med_lice) references Med_lice (id) on delete set default on update cascade,
    foreign key (shifra_vakcina) references Vakcina (shifra) on delete set default on update cascade,
    check ( id_lice != id_med_lice )
);

-- Ova se bara
create table Vakcinacija_datum
(
    id_lice        text,
    id_med_lice    text,
    shifra_vakcina text,
    datum          date,
    primary key (id_lice, id_med_lice, shifra_vakcina, datum),
    foreign key (id_lice, id_med_lice, shifra_vakcina) references Vakcinacija (id_lice, id_med_lice, shifra_vakcina) on delete set null on update cascade
)