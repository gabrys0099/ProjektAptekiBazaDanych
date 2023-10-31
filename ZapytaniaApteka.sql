---Wypisanie najnowszej recepty danej osoby 
create or replace view Najnowsza_Recepta as
select distinct (ap.imie || ' ' || ap.nazwisko) as "Imie i Nazwisko", ar.id_Recepty, ar.data_recepty from Apteka_Recepta ar
join Apteka_Pacjent ap
on ap.id_pacjenta=ar.id_pacjenta
join apteka_pozycja_recepty apr
on apr.id_recepty=ar.id_recepty
join Apteka_Lek ale
on ale.id_leku=apr.id_Leku
where --Upper(ap.Nazwisko)=Upper('kowalska') 
    (sysdate-ar.data_recepty)<=(select min(sysdate-ar2.data_recepty) from Apteka_pozycja_Recepty apr2
                                    join apteka_recepta ar2
                                    on ar2.id_recepty=apr2.id_recepty
                                    join apteka_pacjent ap2
                                    on ap2.id_pacjenta=ar2.id_pacjenta
                                    where ap2.pesel=ap.pesel
                                   )
order by ar.id_recepty
;
select * from najnowsza_Recepta;

--Wypisanie liczby pozycji i sumy jaka trzeba zaplacic na ka¿dej recepcie od najwiekszej
create or replace view Cena_recepty as
select ar.id_Recepty, count(apr.nr_pozycji) as "Liczba Pozycji", sum(al.cena_Leku*apr.ilosc_leku) as "Suma Recepty" from Apteka_Recepta ar
join apteka_pozycja_recepty apr
on ar.id_recepty=apr.id_recepty
join Apteka_Lek al
on al.id_leku=apr.id_Leku
group by ar.id_Recepty
order by 3 desc
;
select * from cena_recepty;

--wypisanie leków najpopularniej wypisywanych przez danego lekarza (wliczajac ilosc na jednej recepcie)
create or replace view najpopularniejsze_Leki_Lekarza as
select al.id_Lekarza, ale.nazwa_leku, sum(apr.ilosc_leku) as "ilosc wystawionych" from apteka_Lekarz al
join apteka_recepta ar
on al.id_lekarza=ar.id_lekarza
join Apteka_Pozycja_Recepty apr
on apr.id_recepty=ar.id_recepty
join Apteka_Lek ale
on ale.id_Leku=apr.id_Leku
group by al.id_lekarza, ale.nazwa_leku
order by 1, 3 desc, 2
;

select * from najpopularniejsze_Leki_Lekarza;

--Wypisanie na recepcie zamienników
create or replace view Zamienniki_recepty as
select ar.id_recepty, apr.nr_pozycji, al.nazwa_leku|| ' prod. ' || ap2.nazwa_firmy as "Lek Na recepcie", al2.nazwa_leku || ' prod. ' || ap.nazwa_firmy as "Zamiennik" from Apteka_recepta ar
join apteka_pozycja_recepty apr
on apr.id_recepty=ar.id_recepty
join apteka_lek al
on al.id_leku=apr.id_leku
left join apteka_zamiennik az
on az.id_leku=al.id_leku
left join apteka_lek al2
on al2.id_leku=az.id_zamiennika
join apteka_producent ap
on ap.id_producenta=al2.id_producenta
join apteka_producent ap2
on al.id_producenta=ap2.id_producenta
order by 1, 2
;

select * from Zamienniki_recepty;

