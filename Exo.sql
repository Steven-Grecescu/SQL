
select * from personnage;
select * from arme;
select nom, levelmin from arme;
select nom, surnom, level from personnage;
select surnom as "Pseudo", level as "Niveau" from personnage;
select libelle as "Types d'armes du jeu" from typearme;
------
select count(*) from arme;
select count(*) as "Nombre de personnage" from personnage;
select avg(level) as "Moyenne de niveau" from personnage;
select sum(baseForce) as "Points de force", sum(baseAgi) as "Points d'agilité", sum(baseintel) as "Points d'intel" from classe;
select min(levelmin), max(levelmin) from arme;
select nom, baseforce + baseagi + baseintel as "NB points" from classe;
------
select concat(nom, surnom) from personnage;
select concat(nom, " - F : ", baseforce, " - A : ", baseagi, " - I : ", baseintel) from classe;
select substring(nom, 1, 6) from personnage;
select concat(substring(nom,1,5), substring(description,1,20)) from classe;
------
select * from arme where levelmin > 5;
select * from arme where degat < 25;
select nom, surnom from personnage where level = 10;
select * from typearme where estdistance = 1;
------
select * from arme where levelmin between 4 and 8;
select * from personnage where idpersonnage <= 3 and level = 10;
select * from arme where levelmin not between 4 and 8;
select * from arme where idtypearme = 1 or idtypearme = 2 or degat >=30;
select * from arme where idtypearme = 1 or idtypearme = 2 or degat between 25 and 40;
select * from personnage where level != 8 and level not between 6 and 7;
select count(*) from personnage where level != 10;
select avg(degat) from arme where levelmin between 3 and 7;
------
select * from personnage where nom like "l%";
select * from personnage where nom like "l%er";
select * from arme where nom like "%bois%";
select * from arme where nom like "a_b%";
select * from arme where idarme in (1, 2, 4, 5, 7);
select * from personnage where idpersonnage in (2, 3, 4, 6) and level = 10;
select * from personnage where surnom IS NOT NULL;
select * from personnage where surnom IS NULL;
select * from personnage limit 3;
select * from personnage limit 3,2;

-- 2)

select * from personnage inner join classe on personnage.idClasse = classe.idClasse;
select nom, levelmin, libelle, estdistance from arme inner join typearme on arme.idTypeArme = typearme.idTypeArme;
------
select personnage.nom, classe.nom from personnage inner join classe using (idclasse);
select personnage.nom, arme.nom, levelmin, degat from personnage inner join arme on personnage.idarmeutilise = arme.idarme;
select personnage.nom, arme.nom, levelmin, degat, libelle, estdistance from personnage inner join arme on personnage.idarmeutilise = arme.idarme inner join typearme using (idtypearme);
------
select personnage.nom, level, arme.nom, levelmin from dispose inner join personnage using (idpersonnage) inner join arme using (idarme);
select nom, levelmin, degat, libelle from arme inner join typearme on using (idtypearme) where estdistance = 0;
select personnage.nom, arme.nom, libelle from personnage inner join classe using (idclasse) inner join arme on personnage.idarmeutilise = arme.idarme inner join typearme using (idtypearme) where classe.nom = "Guerrier";
------
select personnage.idpersonnage, personnage.nom, arme.nom, libelle from dispose inner join personnage using (idpersonnage) inner join arme using (idarme) inner join typearme using (idtypearme) where level = 10;
select personnage.idpersonnage, personnage.nom, arme.nom, libelle from dispose inner join personnage using (idpersonnage) inner join arme using (idarme) inner join typearme using (idtypearme) where level = 10 order by personnage.idpersonnage;
select avg(degat) from arme inner join typearme using (idtypearme) where estdistance = 1;
select personnage.nom from dispose inner join personnage using (idpersonnage) inner join arme using (idarme) inner join typearme using (idtypearme) where libelle like "a%" group by personnage.nom;
------
select libelle, nom from typearme left join arme using (idtypearme);
select libelle, nom from arme right join typearme using (idtypearme);
select * from arme left join personnage on personnage.idarmeutilise = arme.idarme order by personnage.nom;
select arme.idarme, arme.nom, personnage.nom from personnage right join dispose using (idpersonnage) right join arme using (idarme) order by arme.idarme;

--3)

select libelle as "Type d'arme", count(idarme) as "Nombre d'arme" from typearme left join arme using (idtypearme) group by libelle;
select classe.nom as "Classe", description, count(*) as "Nombre Personnage" from personnage inner join classe using (idclasse) group by idclasse;
select personnage.nom, count(*) from dispose inner join personnage using (idpersonnage) group by idpersonnage;
select classe.nom, personnage.nom, count(*) from dispose inner join personnage using (idpersonnage) inner join classe using (idclasse) where classe.nom = "Guerrier" group by idpersonnage;
select nom, count(idpersonnage) from dispose right join arme using (idarme) group by nom;
select classe.nom, avg(level) from classe inner join personnage using (idclasse) group by classe.nom;
------
select classe.nom, avg(level) from classe inner join personnage using (idclasse) group by classe.nom having avg(level) >= 9;
select nom, count(idpersonnage) from dispose right join arme using (idarme) group by nom having count(idpersonnage) between 1 and 2;
select libelle as "Type d'arme", count(idarme) as "Nombre d'arme" from typearme left join arme using (idtypearme) where estdistance = 0 group by libelle having count(idarme) <= 1;