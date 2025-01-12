create table Muzej
(
    shifra        text primary key,
    ime_muzej     text,
    opis          text,
    grad          text,
    tip           text,
    rabotno_vreme text,
    check ( tip in ('otvoreno', 'zatvoreno') ),
    check ( (tip = 'otvoreno' and shifra like 'o%') or (tip = 'zatvoreno' and not shifra like 'o%'))
);

create table Umetnicko_delo
(
    shifra  text primary key,
    ime     text,
    godina  text,
    umetnik text
);

create table Izlozeni
(
    shifra_d      text,
    ime_i         text,
    datum_pocetok date,
    datum_kraj    date,
    primary key (shifra_d, ime_i),
    foreign key (shifra_d) references Umetnicko_delo (shifra) on update cascade on delete cascade,
    foreign key (ime_i) references Izlozba_UD (ime_i) on update cascade on delete cascade
)

