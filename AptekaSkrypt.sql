drop VIEW najnowsza_Recepta;
drop view cena_recepty;
drop view najpopularniejsze_Leki_Lekarza;
drop view Zamienniki_recepty;
DROP TABLE Apteka_Pacjent CASCADE CONSTRAINTS;
drop table Apteka_Lekarz cascade constraints;
drop table Apteka_Recepta cascade constraints;
drop table Apteka_Pozycja_Recepty cascade constraints;
drop table Apteka_Lek cascade constraints;
drop table Apteka_Producent cascade constraints;
drop table Apteka_Zamiennik cascade constraints;
drop SEQUENCE seq_Lekarz_id;
drop sequence seq_pacjent_id;
drop sequence seq_producent_id;
drop sequence seq_lek_id;
drop sequence seq_recepta_id;



create table Apteka_Pacjent
(
    ID_Pacjenta number(7) primary key, 
    Imie nvarchar2(20) not null, 
    Nazwisko nvarchar2(30) not null, 
    Pesel number(11) unique not null
);

create table Apteka_Lekarz
(
    ID_Lekarza number(7) primary key, 
    Imie nvarchar2(20) not null, 
    Nazwisko nvarchar2(30) not null,
    Pesel number(11) unique not null
);

create table Apteka_Recepta
(
    ID_recepty number(7) primary key, 
    ID_Pacjenta number(7) not null, 
    ID_Lekarza number(7) not null,
    Data_Recepty date not null
);

alter table Apteka_Recepta
add constraint Recepta_Pacjent_FK foreign key (ID_Pacjenta) references Apteka_Pacjent(ID_Pacjenta);
alter table Apteka_Recepta
add constraint Recepta_Lekarz_FK foreign key (ID_Lekarza) references Apteka_Lekarz(ID_Lekarza);

create table Apteka_Pozycja_Recepty
(
    ID_Recepty number(7) not null, 
    Nr_Pozycji number(7) not null, 
    ID_Leku number(7) not null, 
    Ilosc_Leku number(7) not null
);
alter table Apteka_Pozycja_Recepty
add constraint Pozycja_Recepty_recepta_FK foreign key (ID_Recepty) references Apteka_Recepta(ID_recepty);

create table Apteka_Producent
(
    ID_Producenta number(7) primary key, 
    Nazwa_Firmy nvarchar2(50) not null, 
    NIP number(15) unique not null
);
create table Apteka_Zamiennik
(
    ID_Leku number(7) not null, 
    ID_zamiennika number(7) not null
);
create table Apteka_Lek
(
    ID_Leku number(7) primary key,
    ID_Producenta number(7) not null, 
    Nazwa_Leku nvarchar2(50) not null,
    Cena_leku number(7, 2) not null
);

alter table Apteka_Pozycja_Recepty
add constraint Pozycja_Recepty_Lek_FK foreign key (ID_Leku) references Apteka_Lek(ID_Leku);
alter table Apteka_Lek
add constraint Lek_Producent_FK foreign key (ID_Producenta) references Apteka_Producent(ID_Producenta);
alter table Apteka_Zamiennik
add constraint Zamiennik_Lek_FK foreign key (ID_Leku) references Apteka_Lek(ID_Leku);
alter table Apteka_Zamiennik
add constraint Zamiennik_Zamiennik_FK foreign key (ID_zamiennika) references Apteka_Lek(ID_Leku);

create sequence seq_pacjent_id
    start with 1 
    increment by 1
    nocache
    nocycle
;
insert into Apteka_Pacjent values
(seq_Pacjent_ID.nextval, 'Maria', 'Gregorczyk', 32154138267);
insert into Apteka_Pacjent values
(seq_Pacjent_ID.nextval, 'Marek', 'Maruszak', 83217984125);
insert into Apteka_Pacjent values
(seq_Pacjent_ID.nextval, 'Jakub', 'Michalak', 04519123120);
insert into Apteka_Pacjent values
(seq_Pacjent_ID.nextval, 'Marta', 'Kowalska', 06132820425);

create Sequence seq_Lekarz_id
    start with 1
    increment by 1
    nocache
    nocycle
    ;
insert into Apteka_Lekarz values
(seq_Lekarz_id.nextval, 'Pawel', 'Malinowski', 75620981876);
insert into Apteka_Lekarz values
(seq_Lekarz_id.nextval, 'Piotr', 'Kostrzewski', 68140632189);

create sequence seq_recepta_id
    start with 1
    increment by 1
    nocache
    nocycle
    ;
insert into Apteka_Recepta values
(seq_recepta_id.nextval, 1, 1, '19/07/19');
insert into Apteka_Recepta values
(seq_recepta_id.nextval, 1, 1, '22/12/21');
insert into Apteka_Recepta values
(seq_recepta_id.nextval, 1, 2, '18/11/10');
insert into Apteka_Recepta values
(seq_recepta_id.nextval, 1, 1, '23/01/02');
insert into Apteka_Recepta values
(seq_recepta_id.nextval, 2, 2, '16/05/04');
insert into Apteka_Recepta values
(seq_recepta_id.nextval, 2, 2, '21/09/14');
insert into Apteka_Recepta values
(seq_recepta_id.nextval, 3, 1, '21/11/20');
insert into Apteka_Recepta values
(seq_recepta_id.nextval, 4, 1, '21/02/11');
insert into Apteka_Recepta values
(seq_recepta_id.nextval, 4, 1, '20/03/18');
insert into Apteka_Recepta values
(seq_recepta_id.nextval, 4, 1, '20/12/29');

create sequence seq_producent_id
    start with 1
    increment by 1
    nocache
    nocycle
    ;
insert into Apteka_producent values
(seq_producent_id.nextval, 'Pfizer', 3423781237);
insert into Apteka_producent values
(seq_producent_id.nextval, 'Moderna', 421747800);
insert into Apteka_producent values
(seq_producent_id.nextval, 'Bayer', 513278957);

create sequence seq_lek_id
    start with 1
    increment by 1
    nocache
    nocycle
    ;
insert into Apteka_Lek values
(seq_lek_id.nextval, 1, 'Apap', 15.99);
insert into Apteka_Lek values
(seq_lek_id.nextval, 1, 'Ibuprom', 9.99);
insert into Apteka_Lek values
(seq_lek_id.nextval, 1, 'alertec', 51.49);
insert into Apteka_Lek values
(seq_lek_id.nextval, 1, 'aspirin', 25.99);
insert into Apteka_Lek values
(seq_lek_id.nextval, 1, 'poltram', 100);

insert into Apteka_Lek values
(seq_lek_id.nextval, 2, 'Monural', 14.50);
insert into Apteka_Lek values
(seq_lek_id.nextval, 2, 'Nolicin', 129.99);
insert into Apteka_Lek values
(seq_lek_id.nextval, 2, 'Pyralgina', 7.89);

insert into Apteka_Lek values
(seq_lek_id.nextval, 3, 'Etopiryna', 89.49);
insert into Apteka_Lek values
(seq_lek_id.nextval, 3, 'Polocard', 249.99);
insert into Apteka_Lek values
(seq_lek_id.nextval, 3, 'Altacet', 15.29);
insert into Apteka_Lek values
(seq_lek_id.nextval, 3, 'Acidolac', 69.99);
insert into Apteka_Lek values
(seq_lek_id.nextval, 3, 'Biofenac', 44.99);
insert into Apteka_Lek values
(seq_lek_id.nextval, 3, 'Scorbolamid', 18.99);

insert into Apteka_pozycja_recepty values
(1, 1, 2, 3);
insert into Apteka_pozycja_recepty values
(1, 2, 7, 1);
insert into Apteka_pozycja_recepty values
(1, 3, 12, 2);

insert into Apteka_pozycja_recepty values
(2, 1, 6, 1);

insert into Apteka_pozycja_recepty values
(3, 1, 1, 4);
insert into Apteka_pozycja_recepty values
(3, 2, 11, 1);

insert into Apteka_pozycja_recepty values
(4, 1, 10, 5);

insert into Apteka_pozycja_recepty values
(5, 1, 5, 6);
insert into Apteka_pozycja_recepty values
(5, 2, 2, 1);
insert into Apteka_pozycja_recepty values
(5, 3, 13, 2);

insert into Apteka_pozycja_recepty values
(6, 1, 7, 4);
insert into Apteka_pozycja_recepty values
(6, 2, 9, 1);

insert into Apteka_pozycja_recepty values
(7, 1, 14, 3);

insert into Apteka_pozycja_recepty values
(8, 1, 2, 1);
insert into Apteka_pozycja_recepty values
(8, 2, 4, 10);
insert into Apteka_pozycja_recepty values
(8, 3, 11, 1);
insert into Apteka_pozycja_recepty values
(8, 4, 14, 5);

insert into Apteka_pozycja_recepty values
(9, 1, 8, 3);

insert into Apteka_pozycja_recepty values
(10, 1, 4, 1);
insert into Apteka_pozycja_recepty values
(10, 2, 6, 4);
insert into Apteka_pozycja_recepty values
(10, 3, 7, 5);
insert into Apteka_pozycja_recepty values
(10, 4, 12, 2);
insert into Apteka_pozycja_recepty values
(10, 5, 10, 1);

insert into apteka_zamiennik values
(1, 2);
insert into apteka_zamiennik values
(1, 8);
insert into apteka_zamiennik values
(2, 1);
insert into apteka_zamiennik values
(2, 8);
insert into apteka_zamiennik values
(6, 3);
insert into apteka_zamiennik values
(14, 1);
insert into apteka_zamiennik values
(14, 2);
insert into apteka_zamiennik values
(7, 4);
insert into apteka_zamiennik values
(7, 13);

