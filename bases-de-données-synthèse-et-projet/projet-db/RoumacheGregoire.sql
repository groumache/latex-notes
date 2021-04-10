/*Création BD*/
CREATE DATABASE ENTREPRISE_PETROLIERE;
GO

/*Utilisation de la BD*/
USE ENTREPRISE_PETROLIERE




/*Création tables*/
CREATE TABLE RAFFINERIE
(
	IdRaffinerie int PRIMARY KEY,

	ProductionMax float NOT NULL,
	ProductionJournalière float NOT NULL DEFAULT 0 CHECK (ProductionJournalière >= 0),
	NbEmployés int NOT NULL DEFAULT 0 CHECK (NbEmployés >= 0),

	CONSTRAINT CK_Production_Max_Journalière CHECK (ProductionMax >= ProductionJournalière),
);
CREATE TABLE PUIT
(
	IdPuit int PRIMARY KEY,

	Réserve float NOT NULL,
	ProductionJournalière float NOT NULL DEFAULT 0 CHECK (ProductionJournalière >= 0),
	Profondeur float NOT NULL DEFAULT 0 CHECK (Profondeur >= 0),

	Pipeline int NOT NULL FOREIGN KEY REFERENCES RAFFINERIE(IdRaffinerie),

	CONSTRAINT CK_Réserve_Production CHECK (Réserve >= ProductionJournalière),
);
CREATE TABLE CAMION_CITERNE
(
	Immatriculation varchar(20) PRIMARY KEY,

	NiveauRéservoir float NOT NULL DEFAULT 0 CHECK (NiveauRéservoir >= 0),
	NiveauCarburant float NOT NULL DEFAULT 0 CHECK (NiveauCarburant >= 0),

	Remplissage int NOT NULL FOREIGN KEY REFERENCES RAFFINERIE(IdRaffinerie),
);
CREATE TABLE STATION_SERVICE
(
	IdStationService int PRIMARY KEY,

	Capacité float NOT NULL,
	Réserve float NOT NULL DEFAULT 0 CHECK (Réserve >= 0),
	NbEmployés int NOT NULL DEFAULT 0 CHECK (NbEmployés >= 0),

	CONSTRAINT CK_Capacité_Réserve CHECK (Capacité >= Réserve),
);
CREATE TABLE RAVITAILLEMENT
(
	Camion varchar(20) NOT NULL FOREIGN KEY REFERENCES CAMION_CITERNE(Immatriculation),
	StationService int NOT NULL FOREIGN KEY REFERENCES STATION_SERVICE(IdStationService),

	CONSTRAINT PK_RAVITAILLEMENT PRIMARY KEY (Camion, StationService),
);
GO




/*Insertion*/
INSERT INTO RAFFINERIE VALUES
	(1, 500000, 250000, 4000),
	(2, 100000, 100000, 2500),
	(3,  25000,  24000,  100);

INSERT INTO PUIT(IdPuit, Réserve, ProductionJournalière, Profondeur, Pipeline) VALUES
	(1,   5000000, 10000, 1000, 1),
	(2, 200000000,     0, 1800, 1),
	(3,    200000, 20000,  450, 3);

INSERT INTO CAMION_CITERNE(Immatriculation, NiveauRéservoir, NiveauCarburant, Remplissage) VALUES
	('123AAA', 30054, 247.75, 3),
	('440AGF', 12000, 125.00, 1),
	('859BCD', 23540, 250.80, 2),
	('555FGH',	   0,   0.00, 1);

INSERT INTO STATION_SERVICE(IdStationService, Capacité, Réserve, NbEmployés) VALUES
	(1, 22000, 18000, 8),
	(2, 50000, 40000, 5),
	(3, 42800, 24356, 8);

INSERT INTO RAVITAILLEMENT(Camion, StationService) VALUES
	('440AGF', 1),
	('440AGF', 2),
	('859BCD', 1),
	('859BCD', 3),
	('555FGH', 2),
	('123AAA', 3);

GO




/*Sélections*/


-- cherche quelles raffineries fournissent quelles stations-service
SELECT IdStationService, IdRaffinerie
FROM RAFFINERIE
JOIN STATION_SERVICE
ON IdRaffinerie IN (			-- on choisit la raffinerie en fonction des camions qui s'y remplissent
	SELECT Remplissage
	FROM CAMION_CITERNE
	WHERE Immatriculation IN (	-- on choisit les camions en fonction des stations-services qu'ils ravitaillent
		SELECT Camion
		FROM RAVITAILLEMENT
		WHERE StationService = IdStationService
	)
) ORDER BY IdStationService;

-- SELECT IdStationService, IdRaffinerie
-- FROM RAFFINERIE
-- JOIN STATION_SERVICE ON IdRaffinerie = Remplissage
-- JOIN CAMION_CITERNE ON Immatriculation = Camion
-- JOIN RAVITAILLEMENT ON StationService = IdStationService;


-- caractéristiques des puits en fonction des raffineries
-- (moyenne des profondeurs, leur nombre, total des réserves, production journalière des puits)
SELECT
	IdRaffinerie,
	AVG(Profondeur) AS 'Profondeur moyenne',
	COUNT(*) AS 'Nb. de puits',
	SUM(Réserve) AS 'Total réserves',
	SUM(P.ProductionJournalière) AS 'Production journalière des puits'
FROM RAFFINERIE
JOIN PUIT P
ON Pipeline = IdRaffinerie
GROUP BY IdRaffinerie;


-- cherche le nombre total d'employés de l'entreprise
SELECT
	(SELECT SUM(NbEmployés) FROM RAFFINERIE)
	+ (SELECT SUM(NbEmployés) FROM STATION_SERVICE)
	AS 'Total employés';


GO