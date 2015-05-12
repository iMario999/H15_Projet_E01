DROP TABLE Statut 
GO
CREATE TABLE dbo.Statut
(
	StatutID int IDENTITY(1,1) PRIMARY KEY, 
	Nom nvarchar(50),
)
GO



CREATE TABLE dbo.Notification
(
	NotificationID int IDENTITY(1,1) PRIMARY KEY,
	SeanceID int NULL,
	StatutID int NOT NULL ,
	DateNotification datetime  
)
GO

ALTER TABLE dbo.Notification
ADD CONSTRAINT FK_SeanceID FOREIGN KEY (SeanceID) REFERENCES dbo.Seance (SeanceID) ON DELETE CASCADE  ,
CONSTRAINT FK_StatutID FOREIGN KEY (StatutID) REFERENCES dbo.Statut (StatutID) ON DELETE CASCADE 

GO
ALTER TABLE dbo.Seance
ADD StatutID int 
GO
ALTER TABLE dbo.Seance 
ADD CONSTRAINT FK_StatutID_Seance FOREIGN KEY (StatutID) REFERENCES dbo.Statut (StatutID) 

GO
INSERT INTO dbo.Statut(Nom)
VALUES ('Demandée'),('Confirmée'),('Reportée'),('Réalisée'),('Livrée'),('Facturée')
GO
ALTER TABLE dbo.Seance
ADD CONSTRAINT df_statutID DEFAULT 1 FOR StatutID 

INSERT INTO dbo.Seance (Adresse, Ville, Telephone, Commentaire, AgentID)
VALUES ('TEST','TEST','(450)111-2345','yioo',1)

ALTER TABLE dbo.Seance
ALTER COLUMN StatutID int  NOT NULL 

UPDATE dbo.Seance
SET StatutID = 1 

GO
DROP TRIGGER dbo.trgSeanceDemande
GO 
CREATE TRIGGER dbo.trgSeanceDemande
ON dbo.Seance 
AFTER UPDATE 
AS 
BEGIN 

IF(UPDATE([DateSeance]))
	BEGIN 

		DECLARE @VielleDate datetime = (SELECT DateSeance FROM deleted)   
		DECLARE @SeanceID int = (SELECT SeanceID FROM inserted) 

		IF( @VielleDate IS NULL)
			BEGIN  
			
				UPDATE dbo.Seance
				SET StatutID = 2 
				WHERE SeanceID = @SeanceID

				INSERT INTO dbo.Notification(SeanceID, StatutID, DateNotification )
				VALUES (@SeanceID,2,GETDATE()) 

			END  
		ELSE
			BEGIN

				UPDATE dbo.Seance
				SET StatutID = 3 
				WHERE SeanceID = @SeanceID

				INSERT INTO dbo.Notification(SeanceID, StatutID, DateNotification )
				VALUES (@SeanceID,3,GETDATE()) 

			END
	END
END 
GO 

UPDATE dbo.Seance
SET DateSeance = '20150511'
WHERE SeanceID = 6  


GO

CREATE TRIGGER dbo.trgSeanceStatutUpdate 
ON dbo.Seance 
AFTER UPDATE 
AS 
BEGIN 

IF(UPDATE([StatutID]))
	BEGIN 
		DECLARE @NouveauStatutID int = (SELECT StatutID FROM inserted) 
		DECLARE @SeanceID int = (SELECT SeanceID FROM inserted) 

		IF( @NouveauStatutID = 4)
			BEGIN  
			
				/*SI LA SEANCE EST RÉALISÉE */
				INSERT INTO dbo.Notification(SeanceID, StatutID, DateNotification )
				VALUES (@SeanceID,4,GETDATE()) 

			END  
		ELSE IF ( @NouveauStatutID = 5 ) 
			BEGIN
				/*SI LA SEANCE EST LIVRÉE */
				INSERT INTO dbo.Notification(SeanceID, StatutID, DateNotification )
				VALUES (@SeanceID,5,GETDATE()) 

			END
		ELSE IF (@NouveauStatutID = 6)
			BEGIN
				/*SI LES PHOTOS DE LA SÉANCE SONT TÉLÉCHARGÉ PAR LE CLIENT  */
				/* A FAIRE CRÉATION DE LA FACTURE DU CLIENT  */

				INSERT INTO dbo.Notification(SeanceID, StatutID, DateNotification )
				VALUES (@SeanceID,6,GETDATE()) 
			END 
	END
END 
GO 

UPDATE dbo.Seance
SET StatutID = 4
WHERE SeanceID = 4  

UPDATE dbo.Seance
SET StatutID = 5
WHERE SeanceID = 4 

UPDATE dbo.Seance
SET StatutID = 6
WHERE SeanceID = 4

GO

CREATE TABLE dbo.Facture 
(
	FactureID int IDENTITY(1,1) PRIMARY KEY ,
	SeanceID int NOT NULL, 
	ForfaitID int NOT NULL
)

ALTER TABLE [dbo].[Seance]
ALTER COLUMN [FactureID] int NULL 

ALTER TABLE dbo.Facture
ADD CONSTRAINT FK_Facture_ForfaitID FOREIGN KEY (ForfaitID) REFERENCES dbo.Forfait (ForfaitID) 

ALTER TABLE dbo.Seance
ADD CONSTRAINT FK_SeanceFactureID FOREIGN KEY (FactureID) REFERENCES dbo.Facture (FactureID)

go
ALTER TABLE dbo.Facture
ALTER COLUMN Prix decimal(10,2) NOT NULL 



/*CREATE VIEW dbo.viewFactureClient 
AS 
SELECT */
