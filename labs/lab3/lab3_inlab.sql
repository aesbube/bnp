create table Med_lice (
    id int primary key,
    staz int,
    constraint fk_med_lice_lice foreign key (id) references Lice(id) on delete SET NULL on update cascade,
    constraint check_staz check (staz >= 5)
);

create table Vakcina (
    shifra varchar(50) primary key,
    ime varchar(50),
    proizvoditel varchar(30) not null
);

create table Vakcinacija (
    id_lice int, 
    id_med_lice int default 1,
    shifra_vakcina int,
    primary key (id_lice, id_med_lice, shifra_vakcina),
    constraint fk_vakcinacija_lice foreign key (id_lice) references Lice(id) on delete cascade on update cascade,
    constraint fk_vakcinacija_med_lice foreign key (id_med_lice) references Med_lice(id) on delete SET NULL on update cascade,
    constraint fk_vakcinacija_vakcina foreign key (shifra_vakcina) references Vakcina(shifra) on delete SET NULL on update cascade 
);

create table Vakcinacija_datum (
    id_lice int, 
    id_med_lice int,
    shifra_vakcina int,
    datum date,
    primary key (id_lice, id_med_lice, shifra_vakcina, datum),
    constraint check_datum check (datum <= '2025-01-31'),
    constraint fk_vakcinacija foreign key (id_lice, id_med_lice, shifra_vakcina) references Vakcinacija(id_lice, id_med_lice, shifra_vakcina) on delete SET NULL on update cascade
);
