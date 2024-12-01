CREATE TABLE Vraboten (
    ID INT PRIMARY KEY,
    ime VARCHAR(50),
    prezime VARCHAR(50),
    datum_r DATE,
    datum_v DATE,
    obrazovanie VARCHAR(10),
    plata INT,
    CONSTRAINT check_datum CHECK (datum_r < datum_v),
    CONSTRAINT check_obrazovanie CHECK (obrazovanie in ('PhD', 'MSc', 'High School', 'BSc'))
);

CREATE TABLE Shalterski_rabotnik (
    ID INT PRIMARY KEY,
    CONSTRAINT fk_shalterski_rabotnik FOREIGN KEY (ID) REFERENCES Vraboten(ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Klient (
    MBR_k INT PRIMARY KEY,
    ime VARCHAR(50),
    prezime VARCHAR(50),
    adresa VARCHAR(50) DEFAULT 'Ne e navedena',
    datum DATE
);

CREATE TABLE Smetka (
    MBR_k_s INT,
    broj INT,
    valuta VARCHAR(10),
    saldo INT,
    PRIMARY KEY (MBR_k_s, broj),
    CONSTRAINT fk_smetka_klient FOREIGN KEY (MBR_k_s) REFERENCES Klient(MBR_k) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Transakcija_shalter (
    ID INT PRIMARY KEY,
    ID_v INT,
    MBR_k INT,
    MBR_k_s INT,
    broj INT,
    datum DATE,
    suma INT,
    tip VARCHAR(10),
    FOREIGN KEY (ID_v) REFERENCES Vraboten(ID) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (MBR_k) REFERENCES Klient(MBR_k) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (MBR_k_s, broj) REFERENCES Smetka(MBR_k_s, broj) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT check_datum_transakcija CHECK (datum NOT BETWEEN '2020-12-30' AND '2021-01-14'),
    CONSTRAINT check_tip_transakcija CHECK (tip IN ('uplata', 'isplata'))
);

CREATE TABLE Bankomat (
    ID INT PRIMARY KEY,
    lokacija VARCHAR(50) UNIQUE,
    datum_p DATE,
    zaliha INT,
    CONSTRAINT check_zaliha CHECK (zaliha >= 0)
);

CREATE TABLE Transakcija_bankomat (
    ID INT PRIMARY KEY,
    MBR_k_s INT,
    broj INT,
    ID_b INT DEFAULT -1,
    datum DATE,
    suma INT,
    CONSTRAINT fk_trans_bankomat_smetka FOREIGN KEY (MBR_k_s, broj) REFERENCES Smetka(MBR_k_s, broj) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_trans_bankomat_bankomat FOREIGN KEY (ID_b) REFERENCES Bankomat(ID) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT chk_datum_transakcija_bankomat CHECK (datum NOT BETWEEN '2020-12-30' AND '2021-01-14')
);

