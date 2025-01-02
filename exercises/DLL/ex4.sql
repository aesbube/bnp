-- Ova se bara
create table Korisnik
(
    kor_ime  text primary key,
    ime      text,
    prezime  text,
    pol      text,
    data_rag date,
    data_reg date
);

-- Ova se bara
create table Korisnik_email
(
    kor_ime text,
    email   text,
    primary key (kor_ime, email),
    foreign key (kor_ime) references Korisnik (kor_ime) on delete cascade on update cascade,
    check ( length(email) >= 10 and email like '%.com' )
);

create table Mesto
(
    id  text primary key,
    ime text
);

-- Ova se bara
create table Poseta
(
    id       text primary key,
    kor_ime  text,
    id_mesto text,
    datum    date,
    foreign key (kor_ime) references Korisnik (kor_ime) on delete set null on update cascade,
    foreign key (id_mesto) references Mesto (id) on delete cascade on update cascade,
    check ( datum <= current_date )
);

create table Grad
(
    id_mesto text primary key,
    drzava   text,
    foreign key (id_mesto) references Mesto (id) on delete cascade on update cascade
);

create table Objekt
(
    id_mesto    text primary key,
    adresa      text,
    geo_shirina text,
    geo_dolzina text,
    id_grad     text,
    foreign key (id_mesto) references Mesto (id) on delete cascade on update cascade,
    foreign key (id_grad) references Grad (id_mesto) on delete cascade on update cascade
);

create table Sosedi
(
    grad1      text,
    grad2      text,
    rastojanie integer,
    primary key (grad1, grad2),
    foreign key (grad1, grad2) references Grad (id_mesto, id_mesto) on delete cascade on update cascade
);