--1
SELECT *
FROM "OAS_Manager".mechanic;

--2
SELECT vehicle.st_ID, vehicle.ser$Reg_certif, vehicle.num$Reg_certif, vehicle.date$Reg_certif
FROM "OAS_Manager".vehicle;

--3
SELECT vehicle.gnz,
CONCAT (vehicle.ser$Reg_certif, vehicle.num$Reg_certif, vehicle.date$Reg_certif) AS "Свидетельство"
FROM "OAS_Manager".vehicle;

--4?
SELECT maintenance.gnz
FROM "OAS_Manager".maintenance
WHERE maintenance.tech_cond_resume = 'Годен к эксплуатации';

SELECT *
FROM "OAS_Manager".maintenance;


--5
SELECT DISTINCT factory.factory_name, factory.post_addr, factory.phone
FROM "OAS_Manager".factory
WHERE factory.factory_name != 'NULL'
ORDER BY factory.factory_name;

--6
SELECT 
CONCAT (transpgroup.id_tg,' : ', transpgroup.name,' - ', transpgroup.note) AS "Группы транспортных средств"
FROM "OAS_Manager".transpgroup;

--7
SELECT 
CONCAT (mechanic.sname_initials,' , дата рождения ', TO_CHAR(mechanic.born, 'dd.mm.yyyy')) AS "Лучшие механики предприятия"
FROM "OAS_Manager".mechanic
LIMIT 10;

--8
ALTER TABLE "OAS_Manager".vehicle ADD COLUMN nalog INTEGER;

UPDATE "OAS_Manager".vehicle
SET nalog = (vehicle.cost/100) * 18
WHERE vehicle.cost >0;

SELECT vehicle.gnz, vehicle.cost, vehicle.nalog
FROM "OAS_Manager".vehicle;

select sum(vehicle.nalog)
FROM "OAS_Manager".vehicle;

--9

select sum(cast (vehicle.cost as decimal(12,2)))
FROM "OAS_Manager".vehicle;

--10
SELECT mechanic.sname_initials, TO_CHAR(mechanic.born, 'dd.mm.yyyy'), DATE_PART('year', AGE(mechanic.born)) 
from "OAS_Manager".mechanic;

--11
select
concat (vehicle.gnz, ' - ', cast ((vehicle.cost/ vehicle.run) as decimal(12,2)) ) as "Отношение стоимости к пробегу (руб\км)"
from "OAS_Manager".vehicle;

--12
select maintenance.gnz, to_char(maintenance.date_work, 'dd.mm.yyyy') as "date",to_char(maintenance.date_work, 'hh:ii:ss') as "time"
from "OAS_Manager".maintenance;

--13?

--14
select 
concat(vehicle.gnz, ' : ', to_char(vehicle.date_made, 'DAY'), ' : ', extract(DOY FROM vehicle.date_made)) 
as "День недели и день года выпуска"
from "OAS_Manager".vehicle;

--15
select factory.factory_name, factory.post_addr, factory.phone
from "OAS_Manager".factory
where (factory.post_addr = factory.legal_addr) and (factory.factory_name like '%а%');

--16
SELECT mechanic.sname_initials,mechanic.certif_date,mechanic.work_in_date,DATE_PART('year', AGE(mechanic.certif_date))
from "OAS_Manager".mechanic
where DATE_PART('year', AGE(mechanic.certif_date))>10; 

--17
select vehicle.gnz, vehicle.num$reg_certif,vehicle.ser$reg_certif,vehicle.date$reg_certif
from "OAS_Manager".vehicle
where  not vehicle.gnz  like '%57%';

--18
select vehicle.gnz,cast((vehicle.cost/100 * 18) as decimal(12,2))as "NDS", vehicle.date_use
from "OAS_Manager".vehicle
where (vehicle.cost/100 * 18)>500000;

--19
--20



















































