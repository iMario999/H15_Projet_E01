USE H15_PROJET_E01 

ALTER TABLE dbo.Agent
ADD Telephone varchar(15),
Prenom varchar(50), 
Email varchar(100),
Agence varchar(50),
Commentaire varchar(300)  


CREATE TABLE dbo.Statut
(
	StatutID int IDENTITY(1,1) PRIMARY KEY, 	
	SeanceID int,
	DateStatut Datetime 
)

CREATE TABLE dbo.Photographe
(
	PhotographeID int IDENTITY(1,1) PRIMARY KEY,
	Nom Varchar(50)  
)

ALTER TABLE dbo.Seance
ADD PhotographeID int 

ALTER TABLE dbo.Seance
ADD CONSTRAINT FK_Seance_PhotographeID FOREIGN KEY (PhotographeID) REFERENCES dbo.Photographe (PhotographeID) 


ALTER TABLE dbo.Statut
ADD CONSTRAINT FK_Statut_SeanceID FOREIGN KEY (SeanceID) REFERENCES dbo.Seance (SeanceID)

