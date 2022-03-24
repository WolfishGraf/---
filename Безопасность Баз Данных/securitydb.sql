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

--7? (преобразование даты сделать)

SELECT 
CONCAT (mechanic.sname_initials,' , дата рождения ', mechanic.born) AS "Лучшие механики предприятия"
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







































































