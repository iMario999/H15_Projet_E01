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
		DECLARE @DateAjouter datetime = (SELECT DateSeance FROM inserted)   
		DECLARE @SeanceID int = (SELECT SeanceID FROM inserted) 
		IF(@DateAjouter IS NOT NULL)
		BEGIN
		IF( @VielleDate IS NULL)
			BEGIN  
			
				UPDATE dbo.Seance
				SET StatutID = 2 
				WHERE SeanceID = @SeanceID

				INSERT INTO dbo.Notification(SeanceID, StatutID, DateNotification )
				VALUES (@SeanceID,2,GETDATE()) 

			END  
		ELSE IF(@VielleDate != @DateAjouter)
			BEGIN

				UPDATE dbo.Seance
				SET StatutID = 3 
				WHERE SeanceID = @SeanceID

				INSERT INTO dbo.Notification(SeanceID, StatutID, DateNotification )
				VALUES (@SeanceID,3,GETDATE()) 

			END
	END
END 
END
GO 

UPDATE dbo.Seance
SET DateSeance = '20150511'
WHERE SeanceID = 6  



GO




CREATE TABLE dbo.Facture 
(
	SeanceID int NOT NULL IDENTITY(1,1) PRIMARY KEY ,
	ForfaitID int NOT NULL
)


ALTER TABLE dbo.Facture
ADD CONSTRAINT FK_SeanceFactureID  FOREIGN KEY (SeanceID) REFERENCES dbo.Seance (SeanceID) 




CREATE TABLE dbo.Photo
(
	PhotoID int IDENTITY(1,1) PRIMARY KEY,
	SeanceID int NOT NULL
)

GO

 

CREATE TRIGGER dbo.Trg_PhotoAjouter 
ON dbo.Photo
AFTER INSERT  
AS 
BEGIN 
DECLARE  @SeanceID int
--Statut de la séance ou les photos sont ajoutées 
DECLARE  @StatutID int 

SELECT @SeanceID = SeanceID  FROM inserted
SELECT @StatutID = StatutID FROM dbo.Seance WHERE SeanceID = @SeanceID 

IF(@StatutID < 5)
	BEGIN
		
		UPDATE dbo.Seance
		SET StatutID = 5
		WHERE SeanceID = @SeanceID

		INSERT INTO dbo.Notification(SeanceID, StatutID, DateNotification )
				VALUES (@SeanceID,5,GETDATE()) 

	END 
--Fin du trigger 
END 

GO 



--TEST du trigger ajouter photo 

INSERT INTO dbo.Photo (SeanceID)
VALUES (1),(1),(1),(1) 


ALTER TABLE dbo.Seance
ADD NbPhotosPrise int NULL 


-- TRIGGER photo prises 
GO
CREATE TRIGGER dbo.Trg_photoPrise
ON dbo.Seance
AFTER UPDATE 
AS 
BEGIN 

DECLARE @SeanceID int 
DECLARE @StatutID int 
DECLARE @NbPhotos int 
SELECT @SeanceID = SeanceID, @StatutID = StatutID, @NbPhotos = NbPhotosPrise FROM inserted
IF(@NbPhotos != NULL )
BEGIN
IF(UPDATE(NbPhotosPrise))
	BEGIN
		IF(@StatutID < 4)
		BEGIN
			UPDATE dbo.Seance
			SET StatutID = 4
			WHERE SeanceID= @SeanceID
		
			INSERT INTO dbo.Notification(SeanceID, StatutID, DateNotification )
			VALUES (@SeanceID,4,GETDATE()) 
		END
	END 
END
END
GO

ALTER TABLE dbo.Seance
ADD DateFacturation DateTime NULL 

--Trigger Seance Facturé 
GO

CREATE TRIGGER dbo.Trg_DateFacturationUpdate 
ON dbo.Seance
AFTER UPDATE
AS
BEGIN 

DECLARE @SeanceID int 
DECLARE @StatutID int 
DECLARE	@DateFacturation datetime 



SELECT @SeanceID = SeanceID, @StatutID = StatutID, @DateFacturation =  DateFacturation FROM inserted

IF(@DateFacturation != NULL)
BEGIN

IF(UPDATE(DateFacturation))
	BEGIN
		IF(@StatutID < 6)
			BEGIN
				DECLARE @ForfaitID int = (SELECT ForfaitID FROM inserted) 

				UPDATE dbo.Seance
				SET StatutID = 6
				WHERE SeanceID = @SeanceID

				SET IDENTITY_INSERT dbo.Facture  ON 
				INSERT INTO dbo.Facture(SeanceID, ForfaitID) 
				VALUES(@SeanceID, @ForfaitID)
				SET IDENTITY_INSERT dbo.Facture  OFF


				INSERT INTO dbo.Notification(SeanceID, StatutID, DateNotification )
				VALUES (@SeanceID,6,GETDATE())
			END
	END

END 
END
GO		


UPDATE dbo.Seance
SET [NbPhotosPrise] = 4
WHERE SeanceID = 2

INSERT INTO dbo.Photo (SeanceID)
VALUES (2),(2),(2),(2) 

UPDATE dbo.Seance
SET [DateFacturation] = GETDATE()
WHERE SeanceID = 2

GO

CREATE TRIGGER dbo.SupprimeFacture
ON dbo.Seance
INSTEAD OF DELETE 
AS
BEGIN

DECLARE @SeanceID int 

SELECT @SeanceID = SeanceID From deleted

DELETE FROM dbo.Facture
WHERE SeanceID = @SeanceID


DELETE FROM dbo.Seance
WHERE SeanceID = @SeanceID

END 