--1+
SELECT *
FROM "OAS_Manager".mechanic;

--2+
SELECT gnz, ser$Reg_certif, num$Reg_certif, date$Reg_certif
FROM "OAS_Manager".vehicle;

--3+
SELECT gnz,
CONCAT (ser$Reg_certif, num$Reg_certif, date$Reg_certif) AS "Свидетельство"
FROM "OAS_Manager".vehicle;

--4+
SELECT gnz 
FROM "OAS_Manager".maintenance 
GROUP BY gnz;

--5+
SELECT DISTINCT factory_name, legal_addr, phone
FROM "OAS_Manager".factory
WHERE factory_name != 'NULL'
ORDER BY factory_name;

--6+
SELECT 
CONCAT (id_tg,' : ', name,' - ', note) AS "Группы транспортных средств"
FROM "OAS_Manager".transpgroup;

--7+
SELECT 
CONCAT (sname_initials,' , дата рождения ', TO_CHAR(born, 'dd.mm.yyyy')) AS "Лучшие механики предприятия"
FROM "OAS_Manager".mechanic
LIMIT 10;

--8+
SELECT gnz, cost, cost*0.18 "Налог" 
FROM "OAS_Manager".vehicle;

--9+
select sum(cast (cost as decimal(12,2)))
FROM "OAS_Manager".vehicle;

--10+
SELECT sname_initials, TO_CHAR(born, 'dd.mm.yyyy'), DATE_PART('year', AGE(born)) 
FROM "OAS_Manager".mechanic;

--11+
SELECT
concat (gnz, ' - ', trunc(cost/run,2),' руб/км') as "Отношение стоимости к пробегу (руб\км)"
FROM "OAS_Manager".vehicle;

--12+
select gnz, to_char(date_work, 'dd.mm.yyyy') as "date",to_char(date_work, 'hh:ii:ss') as "time"
from "OAS_Manager".maintenance;

select gnz,to_char(date_work,'dd.mm.yyyy'),to_char(date_work,'hh.mi.ss')
from "OAS_Manager".maintenance;

--13+
SELECT gnz, date_use, cost - date_part('year', age(date_use))*(cost*0.05) as "Остаточная стоимость"
FROM "OAS_Manager".vehicle;

--14+
SELECT
concat(gnz, ' : ', to_char(date_made, 'DAY'), ' : ', extract(DOY FROM date_made)) 
as "День недели и день года выпуска"
FROM "OAS_Manager".vehicle;

--15+
SELECT factory_name, post_addr, phone
FROM "OAS_Manager".factory
WHERE (post_addr = legal_addr) and (post_addr like '%Россия%');

--16+
SELECT sname_initials,certif_date,work_in_date,DATE_PART('year', AGE(certif_date))
FROM "OAS_Manager".mechanic
WHERE DATE_PART('year', AGE(certif_date))>10
ORDER BY age(certif_date) asc;

--17+
SELECT gnz, num$reg_certif, ser$reg_certif, date$reg_certif
FROM "OAS_Manager".vehicle
WHERE  gnz  not like '%57 '
ORDER BY right(gnz,2) DESC;


--18+
SELECT gnz,cast((cost/100 * 18) as decimal(12,2))as "NDS", date_use
FROM "OAS_Manager".vehicle
WHERE (cost/100 * 18)>500000
ORDER BY cost DESC;

--19+
SELECT gnz, date_work, to_char(date_work, 'day') as "День недели", tech_cond_resume
FROM "OAS_Manager".maintenance
WHERE to_char(date_work, 'day') like 's%';

--20+
SELECT gnz, date_work, to_char(date_work, 'day') as "День недели", tech_cond_resume
FROM "OAS_Manager".maintenance
WHERE (tech_cond_resume is null) and (to_char(date_work, 'day') like 's%');

--21+
SELECT model_name 
FROM "OAS_Manager".model
WHERE model_name like '___-____';

--22+
SELECT sname_initials
FROM "OAS_Manager".mechanic
WHERE sname_initials like any (array['С%','К%','Л%'])
ORDER BY sname_initials;

--23+
SELECT factory_name, post_addr, legal_addr, phone
FROM "OAS_Manager".factory
WHERE legal_addr like '%\_%' escape '\';


--24+
SELECT gnz, to_char(max(date_work), 'dd.mm.yyyy')
FROM "OAS_Manager".maintenance
WHERE gnz = 'c910ca57';

--25+
SELECT DISTINCT gnz
FROM "OAS_Manager".maintenance
WHERE date_work between '01-01-2017' and '31-12-2017';

--26
SELECT s$diag_chart, n$diag_chart, date_work
FROM "OAS_Manager".maintenance
WHERE s$diag_chart ~ '^[0-9]{4}';

--27
SELECT concat( s$diag_chart,'  ', n$diag_chart,' ')
FROM "OAS_Manager".maintenance
WHERE (tech_cond_resume like '%ТО%') AND (date_work BETWEEN '01-01-2019' AND '31-12-2019');

--28
SELECT s$diag_chart, n$diag_chart, to_char(date_work,'dd.mm.yyyy'), tech_cond_resume 
FROM "OAS_Manager".maintenance
WHERE to_char(date_work,'dd.mm.yyyy') = to_char((date_trunc('month', date_work) + interval '1 month -1 day')::timestamp(0),'dd.mm.yyyy');

--29
SELECT gnz, date_made, date_use, ser$reg_certif, num$reg_certif, date$reg_certif 
FROM "OAS_Manager".vehicle
WHERE gnz not like '%57 '
ORDER BY date_use;

--30
SELECT ROW_NUMBER() OVER(ORDER BY gnz ASC) as "numrow", gnz 
FROM "OAS_Manager".vehicle;

--31
SELECT factory_name as "Завод", name as "Бренд" 
FROM "OAS_Manager".factory, "OAS_Manager".brand
WHERE factory.IDB = brand.IDB
ORDER BY factory_name asc;

--32
SELECT vehicle.gnz as "Государственный номерной знак", concat(brand.name,', ', marka.name,', ', model_name) 
FROM "OAS_Manager".vehicle, "OAS_Manager".brand, "OAS_Manager".marka, "OAS_Manager".model
WHERE vehicle.idb = brand.idb and vehicle.idm = marka.idm and vehicle.idmo = model.idmo;

--33
SELECT vehicle.gnz, brand.name, factory.phone
FROM "OAS_Manager".factory, "OAS_Manager".vehicle, "OAS_Manager".brand
WHERE vehicle.idb = brand.idb AND vehicle.idf = factory.idf;

--34
SELECT to_char(maintenance.date_work, 'dd.mm.yyyy'), mechanic.sname_initials 
FROM "OAS_Manager".vehicle, "OAS_Manager".mechanic, "OAS_Manager".maintenance 
WHERE maintenance.gnz = 'o999yy57 ' AND maintenance.gnz = vehicle.gnz AND maintenance.id_mech = mechanic.id_mech 
ORDER BY maintenance.date_work ASC;

--35
SELECT COALESCE(CONCAT(brand.name, ' ', marka.name, ' ', model.model_name)), vehicle.gnz
FROM "OAS_Manager".vehicle, "OAS_Manager".factory, "OAS_Manager".brand, "OAS_Manager".model, "OAS_Manager".marka
WHERE (factory.legal_addr like '%Japan%') AND (vehicle.idf = factory.idf) AND (vehicle.idm = marka.idm) 
AND (vehicle.idmo = model.idmo) AND (vehicle.idb = brand.idb);

--36
SELECT  a.date_made, a.gnz as "old gnz", CONCAT(a.ser$reg_certif,' ', a.num$reg_certif,' ', to_char(a.date$reg_certif, 'dd.mm.yyyy')) as "old", 
b.gnz as "new gnz", CONCAT(b.ser$reg_certif,' ', b.num$reg_certif,' ', to_char(b.date$reg_certif, 'dd.mm.yyyy')) as "new"
FROM "OAS_Manager".vehicle a, "OAS_Manager".vehicle b
WHERE (a.date_made = b.date_made) AND (a.idb = b.idb) AND (a.idm = b.idm) AND (a.idmo = b.idmo) AND (a.gnz != b.gnz) 
AND (a.date$reg_certif < b.date$reg_certif);

--37
SELECT mechanic.sname_initials, maintenance.gnz, maintenance.date_work
FROM "OAS_Manager".maintenance 
LEFT JOIN "OAS_Manager".mechanic
ON maintenance.id_mech = mechanic.id_mech;

--38
SELECT brand.name, factory.factory_name, to_char(maintenance.date_work, 'dd.mm.yyyy'), maintenance.tech_cond_resume 
FROM "OAS_Manager".maintenance, "OAS_Manager".vehicle, "OAS_Manager".brand, "OAS_Manager".factory 
WHERE (maintenance.idb = brand.idb) AND (brand.name = 'BMW') AND (maintenance.idf = factory.idf) AND (maintenance.gnz = vehicle.gnz) 
ORDER BY maintenance.date_work;

--39
SELECT DISTINCT a.factory_name, a.post_addr, a.legal_addr, a.phone
FROM "OAS_Manager".factory a 
JOIN "OAS_Manager".factory b
ON a.post_addr = b.post_addr
WHERE a.factory_name like '%ОАО АВТОВАЗ';

--40
SELECT ma2.gnz, to_char(ma2.date_work, 'dd.mm.yyyy') as "data", to_char(ma2.date_work, 'hh24.mi') as "time"
FROM "OAS_Manager".mechanic m, "OAS_Manager".maintenance ma, "OAS_Manager".maintenance ma2
WHERE ma.gnz = 'o929ao57 ' AND ma.id_mech = m.id_mech AND ma2.id_mech = ma.id_mech;

--41
SELECT v2.gnz, b.name, v2.date_use, v2.ser$reg_certif 
FROM "OAS_Manager".vehicle v1, "OAS_Manager".vehicle v2, "OAS_Manager".brand b 
WHERE (v1.gnz = 'c172ac57 ') AND (v1.ser$reg_certif = v2.ser$reg_certif) AND (v1.gnz != v2.gnz) AND (v1.idb = b.idb) AND (v2.idb = b.idb);

--42
SELECT gnz 
FROM "OAS_Manager".vehicle
WHERE gnz Not in 
	(SELECT gnz FROM "OAS_Manager".maintenance);

--43
SELECT gnz, cost 
FROM "OAS_Manager".vehicle
WHERE cost < (SELECT avg(cost) FROM "OAS_Manager".vehicle);

--44
SELECT gnz 
FROM "OAS_Manager".vehicle
WHERE gnz in 
	(SELECT gnz 
	 FROM "OAS_Manager".vehicle 
	 WHERE to_char(date_use,'mm.yyyy') != to_char(date$reg_certif,'mm.yyyy'));

--45
SELECT v.gnz, f.factory_name, f.post_addr, f.phone 
FROM "OAS_Manager".vehicle v , "OAS_Manager".factory f
WHERE v.idf in 
	(SELECT idf 
	 FROM "OAS_Manager".vehicle 
	 WHERE gnz = 'x027kp57') 
	 and f.idf in 
	 	(SELECT idf 
		 FROM "OAS_Manager".vehicle 
		 WHERE gnz = 'x027kp57') 
	and v.gnz!= 'x027kp57';

--46
SELECT b.name, s.name  
FROM "OAS_Manager".brand b, "OAS_Manager".state s
WHERE b.idb in 
	(SELECT idb 
	 FROM "OAS_Manager".factory
	 WHERE legal_addr not like '%Россия%') 
and b.st_id = s.st_id;

--47
SELECT b.name, f.factory_name, f.legal_addr, s2.name
FROM "OAS_Manager".brand b, "OAS_Manager".factory f, "OAS_Manager".state s2
WHERE b.idb in (SELECT f2.idb
                FROM "OAS_Manager".factory f2, "OAS_Manager".state s
                WHERE s.name != 'Российская Федерация' AND s.st_id = f2.st_id)
AND b.idb = f.idb AND f.st_id = s2.st_id AND b.name in (SELECT b2.name
                                                        FROM "OAS_Manager".brand b2, "OAS_Manager".factory f2
                                                        WHERE f2.legal_addr like '%Россия%' AND b2.idb = f2.idb);

--48
SELECT v.gnz, CONCAT(b.name, ', ', m.name, ', ', mo.model_name), v.date_made, f.factory_name, f.post_addr, ma.date_work, 
CONCAT(ma.s$diag_chart, ' ', ma.n$diag_chart), ma.tech_cond_resume
FROM "OAS_Manager".vehicle v, "OAS_Manager".factory f, "OAS_Manager".maintenance ma, "OAS_Manager".model mo, 
"OAS_Manager".marka m, "OAS_Manager".brand b
WHERE v.idf in 
				(SELECT f2.idf
                FROM "OAS_Manager".factory f2, "OAS_Manager".vehicle v2
                WHERE (v2.gnz = 'a723ak57 ') AND (f2.idf = v2.idf))
AND (f.idf = v.idf) AND (v.gnz = 'a723ak57 ') AND (v.gnz = ma.gnz) 
AND (to_char(ma.date_work, 'dd.mm.yyyy') = '06.11.2018') AND (v.idb = b.idb) AND (v.idmo = mo.idmo) AND (v.idm = m.idm);

--49
SELECT sum(case when (m.mt_id in 
				(select mt.mt_id 
                from "OAS_Manager".maintenancetype mt
                where mt.name like '%ТО%')) then 1 else 0 end) as "ТО",
sum(case when (m.mt_id in 
			   (select mt.mt_id 
                from "OAS_Manager".maintenancetype mt
                where mt.name like '%Ремонт%')) then 1 else 0 end) as "Ремонт",
sum(case when (m.mt_id in 
			   (select mt.mt_id 
                from "OAS_Manager".maintenancetype mt
                where mt.name like '%Предпродажная подготовка%')) then 1 else 0 end) as "Предпродажная подготовка"
FROM "OAS_Manager".maintenance m;

--50
SELECT distinct me1.sname_initials
FROM "OAS_Manager".maintenance m1, "OAS_Manager".mechanic me1
WHERE me1.sname_initials in 
	(SELECT me2.sname_initials 
     FROM "OAS_Manager".maintenance m2, "OAS_Manager".mechanic me2
     WHERE (to_char(m1.date_work,'dd.mm.yyyy') = to_char(m2.date_work,'dd.mm.yyyy')) AND (m1.id_mech = m2.id_mech) 
	 	AND (m1.date_work != m2.date_work)) AND (me1.id_mech = m1.id_mech) ;

--51
SELECT v.gnz, v.date_made, v.run
FROM "OAS_Manager".vehicle v
WHERE v.st_id in 
				(SELECT st_id
                 FROM "OAS_Manager".state s
                 WHERE s.name = 'Российская Федерация') AND date_part('year', age(v.date_made)) >= 30
UNION
SELECT v2.gnz, v2.date_made, v2.run
FROM "OAS_Manager".vehicle v2
WHERE v2.st_id in 
				(SELECT st_id
                 FROM "OAS_Manager".state s
                 WHERE s.name != 'Российская Федерация') AND date_part('year', age(v2.date_made)) >= 25
UNION
SELECT v3.gnz, v3.date_made, v3.run
FROM "OAS_Manager".vehicle v3
WHERE v3.run >= 500000;

--52
SELECT m.gnz 
FROM "OAS_Manager".maintenance m
WHERE to_char(m.date_work, 'DAY') LIKE 'M%' 
AND NOT EXISTS (SELECT m2.gnz
				FROM "OAS_Manager".maintenance m2
				WHERE (to_char(m2.date_work, 'DAY') NOT LIKE 'M%') AND (m.gnz = m2.gnz));

--53
SELECT m.gnz 
FROM "OAS_Manager".maintenance m
WHERE m.mt_id IN (SELECT mt_id
                 FROM "OAS_Manager".maintenancetype 
                 WHERE name LIKE '%ТО%') AND m.id_mech IN (SELECT id_mech
                                                           FROM "OAS_Manager".mechanic 
                                                           WHERE sname_initials = 'Баженов М.К.')
AND EXISTS (SELECT m2.gnz
FROM "OAS_Manager".maintenance m2
WHERE m2.mt_id IN (SELECT mt_id
                 FROM "OAS_Manager".maintenancetype 
                 WHERE name LIKE '%Ремонт%') AND m2.id_mech IN (SELECT id_mech
                                                           FROM "OAS_Manager".mechanic 
                                                           WHERE sname_initials = 'Савостьянов А.В.') AND m.gnz = m2.gnz);

--54
SELECT m1.sname_initials
FROM "OAS_Manager".mechanic m1, "OAS_Manager".maintenance ma1
WHERE to_char(ma1.date_work, 'yyyy') = '2018' AND m1.id_mech = ma1.id_mech  
GROUP BY m1.sname_initials
HAVING COUNT(DISTINCT to_char(ma1.date_work, 'mm.yyyy')) >= 12;

--55
SELECT ma.gnz, to_char(ma.date_work, 'dd.mm.yyyy'), ma.tech_cond_resume
FROM "OAS_Manager".maintenance ma
WHERE NOT EXISTS(SELECT ma1.gnz 
				 FROM "OAS_Manager".maintenance ma1 
				 WHERE to_char(ma1.date_work, 'yyyy') != '2018' AND ma1.gnz = ma.gnz)
AND to_char(ma.date_work, 'yyyy') = '2018';

--56
SELECT to_char(dates, 'dd.mm.yyyy')
FROM generate_series('2018-02-01', '2018-02-28', interval '1 day') AS dates
WHERE to_char(dates, 'dd.mm.yyyy') NOT IN 
									(SELECT to_char(date_work, 'dd.mm.yyyy') 
									 FROM "OAS_Manager".maintenance);

--57
SELECT COUNT(date_work) 
FROM "OAS_Manager".maintenance  
WHERE to_char(date_work, 'yyyy') = '2017';

--58
SELECT CONCAT(trunc(SUM(cost*0.18)), ' руб. ', trunc(mod(SUM(cost*0.18), 1)*100), ' коп.') 
FROM "OAS_Manager".vehicle
WHERE to_char(date_made, 'yyyy') = '2016';

--59
SELECT Count(*) 
FROM "OAS_Manager".vehicle
WHERE gnz LIKE '%57%';

--60
SELECT TRUNC(AVG(date_part('year', age(born)))::numeric,2) 
FROM "OAS_Manager".mechanic;

--61
SELECT TRUNC(SUM(cost)::numeric,2)::money AS "Общая стоимость", TRUNC(AVG(cost)::numeric,2)::money AS "Средняя стоимость", 
TRUNC(SUM(run),2) AS "Общий пробег", TRUNC(AVG(run),2) AS "Средний пробег" 
FROM "OAS_Manager".vehicle;

--62
SELECT b.name, trunc(AVG(run), 2)
FROM "OAS_Manager".vehicle v, "OAS_Manager".brand b
WHERE v.idb = b.idb AND b.name LIKE '%BMW%'
GROUP BY b.name

UNION
SELECT b.name, trunc(AVG(run), 2)
FROM "OAS_Manager".vehicle v, "OAS_Manager".brand b
WHERE v.idb = b.idb AND b.name LIKE '%Mercedes-Benz%'
GROUP BY b.name

UNION
SELECT b.name, trunc(AVG(run), 2)
FROM "OAS_Manager".vehicle v, "OAS_Manager".brand b
WHERE v.idb = b.idb AND b.name LIKE '%Audi%'
GROUP BY b.name

UNION
SELECT b.name, trunc(AVG(run), 2)
FROM "OAS_Manager".vehicle v, "OAS_Manager".brand b
WHERE v.idb = b.idb AND b.name LIKE '%Peugeot%'
GROUP BY b.name

UNION
SELECT b.name, trunc(AVG(run), 2)
FROM "OAS_Manager".vehicle v, "OAS_Manager".brand b
WHERE v.idb = b.idb AND b.name LIKE '%Renault%'
GROUP BY b.name

UNION
SELECT b.name, trunc(AVG(run), 2)
FROM "OAS_Manager".vehicle v, "OAS_Manager".brand b
WHERE v.idb = b.idb AND b.name LIKE '%ГАЗ%'
GROUP BY b.name

UNION
SELECT b.name, trunc(AVG(run), 2)
FROM "OAS_Manager".vehicle v, "OAS_Manager".brand b
WHERE v.idb = b.idb AND b.name LIKE '%ВАЗ%'
GROUP BY b.name

UNION
SELECT b.name, trunc(AVG(run), 2)
FROM "OAS_Manager".vehicle v, "OAS_Manager".brand b
WHERE v.idb = b.idb AND b.name LIKE '%ПАЗ%'
GROUP BY b.name

UNION
SELECT b.name, trunc(AVG(run), 2)
FROM "OAS_Manager".vehicle v, "OAS_Manager".brand b
WHERE v.idb = b.idb AND b.name LIKE '%Toyota%'
GROUP BY b.name

UNION
SELECT b.name, trunc(AVG(run), 2)
FROM "OAS_Manager".vehicle v, "OAS_Manager".brand b
WHERE v.idb = b.idb AND b.name LIKE '%Nissan%'
GROUP BY b.name

UNION
SELECT b.name, trunc(AVG(run), 2)
FROM "OAS_Manager".vehicle v, "OAS_Manager".brand b
WHERE v.idb = b.idb AND b.name LIKE '%VolgaBus%'
GROUP BY b.name;


--63
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE (m.name IS NOT NULL )AND (m.name LIKE '%Serie 1%') AND (v.idb = b.idb) AND (v.idm = m.idm)
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE (m.name IS NOT NULL) AND (m.name LIKE '%Serie 2%') AND (v.idb = b.idb) AND (v.idm = m.idm)
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE (m.name IS NOT NULL) AND (m.name LIKE '%Serie 3%') AND (v.idb = b.idb) AND (v.idm = m.idm)
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE (m.name IS NOT NULL) AND (m.name LIKE '%Serie 5%') AND (v.idb = b.idb) AND (v.idm = m.idm)
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE (m.name IS NOT NULL) AND (m.name LIKE '%Serie 7%') AND (v.idb = b.idb) AND (v.idm = m.idm)
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE (m.name IS NOT NULL) AND (m.name LIKE '%CLA%') AND (v.idb = b.idb) AND (v.idm = m.idm)
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE (m.name IS NOT NULL) AND (m.name LIKE '%CLC%') AND (v.idb = b.idb) AND (v.idm = m.idm)
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE (m.name IS NOT NULL) AND (m.name LIKE '%CLS%') AND (v.idb = b.idb) AND (v.idm = m.idm)
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE (m.name IS NOT NULL) AND (m.name LIKE '%SLS%') AND (v.idb = b.idb) AND (v.idm = m.idm)
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE (m.name IS NOT NULL) AND (m.name LIKE '%SLC%') AND (v.idb = b.idb) AND (v.idm = m.idm)
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE (m.name IS NOT NULL) AND (m.name LIKE '%CLE%') AND (v.idb = b.idb) AND (v.idm = m.idm)
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE (m.name IS NOT NULL) AND (m.name LIKE '%GL%') AND (v.idb = b.idb) AND (v.idm = m.idm)
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE (m.name IS NOT NULL) AND (m.name LIKE '%GLC%') AND (v.idb = b.idb) AND (v.idm = m.idm)
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE (m.name IS NOT NULL) AND (m.name LIKE '%Viano%') AND (v.idb = b.idb) AND (v.idm = m.idm)
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE (m.name IS NOT NULL) AND (m.name LIKE '%Actros%') AND (v.idb = b.idb) AND (v.idm = m.idm)
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE (m.name IS NOT NULL) AND (m.name LIKE '%Boxer%') AND (v.idb = b.idb) AND (v.idm = m.idm)
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE (m.name IS NOT NULL) AND (m.name LIKE '%Partner%') AND (v.idb = b.idb) AND (v.idm = m.idm)
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE (m.name IS NOT NULL) AND (m.name LIKE '%Expert%') AND (v.idb = b.idb) AND (v.idm = m.idm)
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE (m.name IS NOT NULL) AND (m.name LIKE '%Clio%') AND (v.idb = b.idb) AND (v.idm = m.idm)
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE (m.name IS NOT NULL) AND (m.name LIKE '%Dokker%') AND (v.idb = b.idb) AND (v.idm = m.idm)
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE (m.name IS NOT NULL) AND (m.name LIKE '%Master%') AND (v.idb = b.idb) AND (v.idm = m.idm)
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Logan%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Kaptur%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Duster%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Track%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Kangoo%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Twizy%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Arkana%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Волга%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Siber%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Газель%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%ГАЗон%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Ларгус%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Нива%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Самара%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Веста%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Приора%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Гранта%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Жигули%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Лада%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Турист%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Пассажир%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Voyager%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Traveller%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Corolla%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Camry%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Lexus%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Runner%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%X-Trail%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Navarra%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Qashqai%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE v.idb = b.idb AND v.idm = m.idm AND m.idm = 110
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE v.idb = b.idb AND v.idm = m.idm AND m.idm = 310
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE v.idb = b.idb AND v.idm = m.idm AND m.idm = 20
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE v.idb = b.idb AND v.idm = m.idm AND m.idm = 80
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE v.idb = b.idb AND v.idm = m.idm AND m.idm = 92
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(v.cost), 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE v.idb = b.idb AND v.idm = m.idm AND m.idm = 426
GROUP BY b.name, m.name;

--64
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Serie 1%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Serie 2%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Serie 3%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Serie 5%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Serie 7%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%CLA%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%CLC%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%CLS%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%SLS%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%SLC%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%CLE%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%GL%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%GLC%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Viano%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Actros%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Boxer%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Partner%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Expert%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Clio%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Dokker%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Master%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Logan%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Kaptur%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Duster%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Track%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Kangoo%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Twizy%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Arkana%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Волга%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Siber%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Газель%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%ГАЗон%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Ларгус%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Нива%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Самара%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Веста%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Приора%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Гранта%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Жигули%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Лада%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Турист%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Пассажир%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Voyager%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Traveller%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Corolla%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Camry%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Lexus%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Runner%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%X-Trail%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Navarra%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, m.name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v
WHERE m.name IS NOT NULL AND m.name LIKE '%Qashqai%' AND v.idb = b.idb AND v.idm = m.idm
GROUP BY b.name, m.name

UNION
SELECT b.name, mo.model_name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v, "OAS_Manager".model mo
WHERE v.idb = b.idb AND v.idm = m.idm AND m.idm = 110 AND v.idmo = mo.idmo
GROUP BY b.name, mo.model_name

UNION
SELECT b.name, mo.model_name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v, "OAS_Manager".model mo
WHERE v.idb = b.idb AND v.idm = m.idm AND m.idm = 310 AND v.idmo = mo.idmo
GROUP BY b.name, mo.model_name

UNION
SELECT b.name, mo.model_name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v, "OAS_Manager".model mo
WHERE v.idb = b.idb AND v.idm = m.idm AND m.idm = 20 AND v.idmo = mo.idmo
GROUP BY b.name, mo.model_name

UNION
SELECT b.name, mo.model_name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v, "OAS_Manager".model mo
WHERE v.idb = b.idb AND v.idm = m.idm AND m.idm = 80 AND v.idmo = mo.idmo
GROUP BY b.name, mo.model_name

UNION
SELECT b.name, mo.model_name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v, "OAS_Manager".model mo
WHERE v.idb = b.idb AND v.idm = m.idm AND m.idm = 92 AND v.idmo = mo.idmo
GROUP BY b.name, mo.model_name

UNION
SELECT b.name, mo.model_name, trunc(AVG(date_part('year', age(v.date_made)))::numeric, 2)
FROM "OAS_Manager".marka m, "OAS_Manager".brand b, "OAS_Manager".vehicle v,"OAS_Manager".model mo
WHERE v.idb = b.idb AND v.idm = m.idm AND m.idm = 426 AND v.idmo = mo.idmo
GROUP BY b.name, mo.model_name;

--65
SELECT TEMP.to_char 
FROM (SELECT DISTINCT to_char(date_work, 'yyyy'), COUNT(date_work) 
	  FROM "OAS_Manager".maintenance
      GROUP BY to_char(date_work, 'yyyy')
      ORDER BY COUNT(date_work) DESC 
LIMIT 1) TEMP;

--66
SELECT DISTINCT CONCAT(b.name,' ',m.name), COUNT(v.gnz)
FROM "OAS_Manager".marka m, "OAS_Manager".vehicle v, "OAS_Manager".brand b
WHERE m.idm = v.idm AND m.idb = b.idb
GROUP BY m.name, b.name
HAVING COUNT(v.gnz) >= 8
ORDER BY count DESC;

--67
SELECT TEMP.gnz
FROM (SELECT DISTINCT gnz, count(*)
FROM "OAS_Manager".maintenance
GROUP BY gnz
HAVING count(*) = 1) TEMP;

--68
SELECT DISTINCT v.gnz, f.factory_name 
FROM "OAS_Manager".vehicle v, "OAS_Manager".state s, "OAS_Manager".factory f
WHERE (s.euro_union = '1') and (v.st_id = s.st_id)  and (f.st_id = v.st_id) and (f.idf = v.idf);

--69
SELECT m.gnz, m.date_work, mech.sname_initials
FROM "OAS_Manager".maintenance m, "OAS_Manager".maintenancetype mt, "OAS_Manager".mechanic mech
WHERE (m.mt_id = mt.mt_id) AND (m.id_mech = mech.id_mech) AND (mt.mt_id = '19');

--70
SELECT TEMP.name
FROM(SELECT DISTINCT b.name, SUM(v.cost) 
FROM "OAS_Manager".vehicle v, "OAS_Manager".brand b
WHERE b.idb = v.idb
GROUP BY b.name
ORDER BY SUM(v.cost) DESC LIMIT 1) TEMP;

--71
SELECT m.gnz, b.name
FROM "OAS_Manager".maintenance m, "OAS_Manager".mechanic me, "OAS_Manager".brand b, "OAS_Manager".marka ma
WHERE (me.Sname_initials = 'Кротов К.О.') AND (me.id_mech = m.id_mech) AND (m.idb = b.idb) 
AND (ma.idm = m.idm) AND (ma.name LIKE 'Газель' or b.name LIKE 'VolgaBus');

--72
SELECT CONCAT(v.gnz,' ', f.factory_name,' ', b.name,' ', m.name,', Свидетельство о Регистрации: ', 
			  v.ser$reg_certif,' №', v.num$reg_certif,' Выдано: ', v.date$reg_certif), v.date_use
FROM "OAS_Manager".vehicle v, "OAS_Manager".factory f, "OAS_Manager".brand b, "OAS_Manager".marka m
WHERE (v.idf = f.idf) AND (v.idb = b.idb) AND (v.idm = m.idm) AND (v.date_use - v.date$reg_certif) > 14;

--73
SELECT f.factory_name, b.name, 	
	case when s.euro_union = '1' then f.post_addr
		 when s.euro_union is null then f.legal_addr END, f.phone
FROM "OAS_Manager".factory f, "OAS_Manager".brand b, "OAS_Manager".state s
WHERE (f.st_id = s.st_id) AND (b.st_id = s.st_id) AND (f.idb = b.idb) AND (f.legal_addr like '%Россия%');

--74
SELECT CONCAT('"',b.name,'" - ', COUNT(m.gnz), ' ремонта')
FROM "OAS_Manager".maintenance m, "OAS_Manager".brand b, "OAS_Manager".maintenancetype mt
WHERE (b.idb = m.idb) AND (to_char(m.date_work,'yyyy') = '2018') AND (mt.mt_id = m.mt_id) AND (mt.name LIKE 'Ремонт')
GROUP BY b.name
ORDER BY COUNT(m.gnz) LIMIT 1;

--75
SELECT mc.sname_initials
FROM "OAS_Manager".mechanic mc, "OAS_Manager".maintenance m,
	(SELECT COUNT(m1.tech_cond_resume)
	   FROM "OAS_Manager".maintenance m1, "OAS_Manager".mechanic mc1
	   WHERE mc1.id_mech = m1.id_mech AND mc1.sname_initials LIKE 'Голубев Д.Н.') TEMP
WHERE (mc.sname_initials NOT LIKE 'Голубев Д.Н.') AND (mc.id_mech = m.id_mech)
GROUP BY mc.sname_initials, TEMP.count
HAVING COUNT(m.tech_cond_resume) > TEMP.count;

--76
SELECT v.gnz,CONCAT(b.name,' ', ma.name,' ',m.model_name) ,to_char(v.date$reg_certif, 'dd.mm.yyyy')
FROM "OAS_Manager".vehicle v, "OAS_Manager".marka ma, "OAS_Manager".model m, "OAS_Manager".brand b, 
	(SELECT gnz, to_char(date$reg_certif, 'dd.mm.yyyy')
	 FROM "OAS_Manager".vehicle ) TEMP
WHERE (v.idm = ma.idm) AND (v.idmo = m.idmo) AND (v.idb = b.idb) 
AND (v.gnz != TEMP.gnz AND to_char(v.date$reg_certif, 'dd.mm.yyyy') = TEMP.to_char);

--77
SELECT v.gnz, v.ser$reg_certif, v.num$reg_certif, v.date$reg_certif, COUNT(m.gnz)
FROM "OAS_Manager".vehicle v, "OAS_Manager".maintenance m 
WHERE v.gnz = m.gnz
GROUP BY v.gnz, v.ser$reg_certif, v.num$reg_certif, v.date$reg_certif

UNION 
SELECT v.gnz, v.ser$reg_certif, v.num$reg_certif, v.date$reg_certif, 0
FROM "OAS_Manager".vehicle v
WHERE v.gnz NOT IN 
	(SELECT gnz FROM "OAS_Manager".maintenance );

--78
SELECT m.gnz, COUNT(to_char(m.date_work, 'yyyy')) 
FROM "OAS_Manager".maintenance m,
	(SELECT m.gnz, COUNT(to_char(m.date_work, 'yyyy')) 
FROM "OAS_Manager".maintenance m 
WHERE to_char(date_work, 'yyyy') = '2016' OR to_char(date_work, 'yyyy') = '2017' OR to_char(date_work, 'yyyy') = '2018' GROUP BY m.gnz) 
TEMP WHERE m.gnz = TEMP.gnz GROUP BY m.gnz, TEMP.count 
HAVING COUNT(to_char(m.date_work, 'yyyy'))*0.8 <= TEMP.count 
ORDER BY m.gnz;

--79
SELECT sname_initials ,date_part('year', age(born)) 
FROM "OAS_Manager".mechanic 
WHERE (date_part('year', age(born)) >= 60) AND (sname_initials NOT LIKE '%а _._.')

UNION
SELECT sname_initials , date_part('year', age(born))
FROM "OAS_Manager".mechanic 
WHERE (date_part('year', age(born)) >= 55) AND (sname_initials LIKE '%а _._.');

--80
SELECT m.gnz, CONCAT(b.name, ', ', ma.name, ', ', mo.model_name), 
CONCAT(v.ser$reg_certif, ', ', v.num$reg_certif, ', ', to_char(v.date$reg_certif, 'dd.mm.yyyy')), 
mech.sname_initials, to_char(m.date_work, 'dd.mm.yyyy'), m.tech_cond_resume
FROM "OAS_Manager".maintenance m, "OAS_Manager".marka ma, "OAS_Manager".model mo, 
"OAS_Manager".brand b, "OAS_Manager".vehicle v, "OAS_Manager".mechanic mech
WHERE (m.idm = ma.idm) AND (m.idmo = mo.idmo) AND (m.idb = b.idb) AND (m.gnz = v.gnz) AND (m.id_mech = mech.id_mech);

--81
SELECT CONCAT(TRUNC(((TEMP_ONE.count / TEMP_ALL.count) * 100)::numeric, 2),' %')
FROM (SELECT COUNT(m.tech_cond_resume)::float 
	 FROM "OAS_Manager".maintenance m, "OAS_Manager".mechanic mech
	 WHERE m.id_mech = mech.id_mech AND mech.sname_initials = 'Савостьянов А.В.') TEMP_ONE,
	 	(SELECT COUNT(m.tech_cond_resume)::float
	  	FROM "OAS_Manager".maintenance m, "OAS_Manager".mechanic mech
      	WHERE m.id_mech = mech.id_mech) TEMP_ALL;

--82
SELECT DISTINCT v.gnz, date_part('year', age(v.date_use)), v.run, LAST_DATE_WORK.max
FROM "OAS_Manager".vehicle v, "OAS_Manager".transpgroup tg, 
								(SELECT DISTINCT m.gnz, MAX(m.date_work)::date 
								 FROM "OAS_Manager".maintenance m
								 GROUP BY m.gnz) LAST_DATE_WORK
WHERE v.id_tg = tg.id_tg AND v.gnz = LAST_DATE_WORK.gnz 
	AND (v.run > 100000 OR date_part('year', age(v.date_use)) >= 3 
	OR tg.name = 'Специальные автомобили' OR tg.name = 'Специализированные автомобили' 
	OR tg.name = 'Спортивные автомобили' OR tg.name = 'Спортивные мотоциклы');

--83
SELECT m.gnz, br.name, ma.name, mo.model_name, mtp.name, m.date_work, m.tech_cond_resume, mech.sname_initials
FROM "OAS_Manager".maintenance m, "OAS_Manager".maintenancetype mtp, "OAS_Manager".mechanic mech,
"OAS_Manager".state st, "OAS_Manager".marka ma, "OAS_Manager".model mo, "OAS_Manager".brand br
WHERE (m.mt_id = mtp.mt_id) AND (m.id_mech = mech.id_mech) AND (st.st_id = m.st_id) AND (m.idm = ma.idm) 
AND (m.idmo = mo.idmo) AND (m.idb = br.idb) AND  (m.mt_id = mtp.mt_id)
AND (st.name = 'Япония') AND (mtp.name NOT LIKE '%японских%') AND (mtp.name NOT LIKE '%Ремонт%') 
AND (mtp.name NOT LIKE '%Предпродажная подготовка%') AND (mtp.name NOT LIKE '%Сезонное ТО%') AND (mtp.name NOT LIKE '%Ежедневное ТО%');

--84
SELECT m1.gnz, extract(epoch from m2.date_work - m1.date_work) 
FROM "OAS_Manager".maintenance m1
INNER JOIN "OAS_Manager".maintenance m2 ON (m1.gnz = m2.gnz) AND (m1.date_work != m2.date_work)
GROUP BY m1.gnz, m1.date_work, m2.date_work
HAVING extract(epoch from m2.date_work - m1.date_work) > 0
ORDER BY m1.date_work
LIMIT 1;

--85
SELECT TEMP.name, TEMP.count FROM(SELECT mt.name, COUNT(tech_cond_resume)
FROM "OAS_Manager".maintenance m, "OAS_Manager".maintenancetype mt
WHERE m.mt_id = mt.mt_id AND mt.name NOT LIKE 'Ежедневное ТО' AND mt.name NOT LIKE 'Сезонное ТО' 
								  AND mt.name NOT LIKE 'Предпродажная подготовка' AND mt.name NOT LIKE 'Ремонт' 
								  AND mt.name NOT LIKE '%япон%'
GROUP BY mt.name
ORDER BY mt.name ASC) TEMP

UNION ALL
SELECT TEMP1.name, TEMP1.count FROM(SELECT mt.name, COUNT(tech_cond_resume)
FROM "OAS_Manager".maintenance m, "OAS_Manager".maintenancetype mt
WHERE m.mt_id = mt.mt_id AND mt.name NOT LIKE 'Ежедневное ТО' AND mt.name NOT LIKE 'Сезонное ТО' 
									AND mt.name NOT LIKE 'Предпродажная подготовка' AND mt.name NOT LIKE 'Ремонт' 
									AND mt.name LIKE '%япон%'
GROUP BY mt.name
ORDER BY mt.name ASC) TEMP1;

--86

--87
SELECT b.name, TEMP2.concat AS "0-3", TEMP3.concat AS "4-7", TEMP4.concat AS "8-10", TEMP5.concat AS "11-15", TEMP6.concat AS ">15"
FROM "OAS_Manager".brand b
FULL JOIN
	(SELECT DISTINCT b.name, CONCAT(ROUND((count(b.name)::numeric/TEMP.count::numeric)*100,2),' %')
	FROM "OAS_Manager".vehicle v, "OAS_Manager".brand b, 
	 						(SELECT COUNT(gnz)
							  FROM "OAS_Manager".vehicle
							  WHERE date_part('year', age(date_use)) < 3) TEMP
	WHERE date_part('year', age(date_use)) < 3 AND v.idb = b.idb
	GROUP BY b.name,TEMP.count) TEMP2
ON b.name = TEMP2.name
FULL JOIN
	(SELECT DISTINCT b.name, CONCAT(ROUND((count(b.name)::numeric/TEMP.count::numeric)*100,2),' %')
	FROM "OAS_Manager".vehicle v, "OAS_Manager".brand b,(SELECT COUNT(gnz)
							 FROM "OAS_Manager".vehicle
							 WHERE date_part('year', age(date_use)) > 3 AND date_part('year', age(date_use)) <=7) TEMP
	WHERE date_part('year', age(date_use)) > 3 AND date_part('year', age(date_use)) <=7 AND v.idb = b.idb
	GROUP BY b.name, TEMP.count) TEMP3
ON b.name = TEMP3.name
FULL JOIN
	(SELECT DISTINCT b.name, CONCAT(ROUND((count(b.name)::numeric/TEMP.count::numeric)*100,2),' %')
	FROM "OAS_Manager".vehicle v, "OAS_Manager".brand b,(SELECT COUNT(gnz)
							 FROM "OAS_Manager".vehicle
							 WHERE date_part('year', age(date_use)) > 7 AND date_part('year', age(date_use)) <=10) TEMP
	WHERE date_part('year', age(date_use)) > 7 AND date_part('year', age(date_use)) <=10 AND v.idb = b.idb
	GROUP BY b.name, TEMP.count) TEMP4
ON b.name = TEMP4.name
FULL JOIN
	(SELECT DISTINCT b.name, CONCAT(ROUND((count(b.name)::numeric/TEMP.count::numeric)*100,2),' %')
	FROM "OAS_Manager".vehicle v, "OAS_Manager".brand b,(SELECT COUNT(gnz)
							 FROM "OAS_Manager".vehicle
							 WHERE date_part('year', age(date_use)) > 10 AND date_part('year', age(date_use)) <=15) TEMP
	WHERE date_part('year', age(date_use)) > 10 AND date_part('year', age(date_use)) <=15 AND v.idb = b.idb
	GROUP BY b.name, TEMP.count) TEMP5
ON b.name = TEMP5.name
FULL JOIN
	(SELECT DISTINCT b.name, CONCAT(ROUND((count(b.name)::numeric/TEMP.count::numeric)*100,2),' %')
	FROM "OAS_Manager".vehicle v, "OAS_Manager".brand b,(SELECT COUNT(gnz)
							 FROM "OAS_Manager".vehicle
							 WHERE date_part('year', age(date_use)) > 15) TEMP
	WHERE date_part('year', age(date_use)) > 15 AND v.idb = b.idb
	GROUP BY b.name, TEMP.count) TEMP6
ON b.name = TEMP6.name;

--88
SELECT TEMP1.factory_name, TEMP1.round 
FROM 
	(SELECT TEMP_REP.factory_name, ROUND((TEMP_VEH.count::float/TEMP_REP.count::float)::numeric,6) 
	 FROM 
	 	(SELECT f.factory_name , COUNT(v.gnz) 
		 FROM "OAS_Manager".factory f, "OAS_Manager".vehicle v 
		 WHERE f.idf = v.idf GROUP BY f.factory_name 
		 ORDER BY f.factory_name) TEMP_VEH, 
	 		(SELECT f.factory_name, COUNT(m.gnz) 
			 FROM "OAS_Manager".maintenance m, "OAS_Manager".factory f 
			 WHERE f.idf = m.idf 
			 GROUP BY f.factory_name 
			 ORDER BY f.factory_name) TEMP_REP 
	 WHERE TEMP_VEH.factory_name = TEMP_REP.factory_name 
	 ORDER BY ROUND((TEMP_VEH.count::float/TEMP_REP.count::float)::numeric,6) DESC LIMIT 1) TEMP1 
	 
	 UNION 
	 SELECT TEMP2.factory_name, TEMP2.count 
	 FROM 
	 	(SELECT f.factory_name, COUNT(m.gnz) 
		 FROM "OAS_Manager".maintenance m, "OAS_Manager".factory f 
		 WHERE f.idf = m.idf
		GROUP BY f.factory_name 
		 ORDER BY COUNT(m.gnz) DESC 
		 LIMIT 1)TEMP2;

--89
SELECT DISTINCT ON (m.gnz) CONCAT(m.gnz,'; ', b.name,', ',ma.name,', ',mo.model_name), 
date_part('day', m.date_work - v.date_made), mt.name, mt.mt_id, 
(date_part('year', age(v.date_made))::float - date_part('year', age(m.date_work))::float)::float
FROM "OAS_Manager".maintenance m, "OAS_Manager".vehicle v, "OAS_Manager".brand b, "OAS_Manager".marka ma,
"OAS_Manager".model mo, "OAS_Manager".maintenancetype mt
WHERE m.gnz = v.gnz AND v.idb = b.idb AND m.idm = ma.idm AND m.idmo = mo.idmo AND m.mt_id = mt.mt_id
AND (date_part('year', age(v.date_made))::float - date_part('year', age(m.date_work))::float)::float <1;

--90
SELECT m.gnz, mch.sname_initials, m.date_work, TEMP.date_part
FROM "OAS_Manager".maintenance m, "OAS_Manager".mechanic mch,
	(SELECT m.gnz, mch.id_mech, date_part('year',m.date_work)
	 FROM "OAS_Manager".maintenance m, "OAS_Manager".mechanic mch
	 WHERE m.id_mech = mch.id_mech
  	) TEMP
WHERE (m.id_mech = mch.id_mech) AND (m.gnz = TEMP.gnz)
AND (date_part('year',m.date_work) = TEMP.date_part) AND (m.id_mech != TEMP.id_mech) 
GROUP BY m.gnz, mch.sname_initials, m.date_work, TEMP.date_part
ORDER BY m.gnz, TEMP.date_part DESC;

--91
SELECT SUM(TRUNC((((TEMP.cost * TEMP.count)/161)::numeric),0))::money AS "Медиана", 
TRUNC(CEILING((|/(SUM(TRUNC((((TEMP.cost^2 * TEMP.count)/161)::numeric),0)) - SUM(TRUNC((((TEMP.cost * TEMP.count)/161)::numeric),0))^2)))::numeric,0)::money AS "Разброс"
FROM
	(SELECT v.cost, count(v.cost)
	FROM "OAS_Manager".vehicle v
	GROUP BY v.cost
	ORDER BY COUNT(v.cost) DESC) TEMP;






















