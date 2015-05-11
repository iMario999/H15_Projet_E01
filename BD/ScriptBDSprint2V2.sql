DROP TABLE Statut 

CREATE TABLE dbo.Statut
(
	StatutID int IDENTITY(1,1) PRIMARY KEY, 
	Nom nvarchar(50),
)

CREATE TABLE dbo.Notifications
(
	NotificationID int IDENTITY(1,1) PRIMARY KEY,
	SeanceID int,
	StatutID int,
	DateNotification datetime  
)

ALTER TABLE dbo.Notifications
ADD CONSTRAINT FK_SeanceID FOREIGN KEY (SeanceID) REFERENCES dbo.Seance (SeanceID),
CONSTRAINT FK_StatutID FOREIGN KEY (StatutID) REFERENCES dbo.Statut (StatutID) 


ALTER TABLE dbo.Seance
ADD StatutID int 

ALTER TABLE dbo.Seance 
ADD CONSTRAINT FK_StatutID_Seance FOREIGN KEY (StatutID) REFERENCES dbo.Statut (StatutID) 