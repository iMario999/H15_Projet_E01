USE H15_PROJET_E01

CREATE TABLE dbo.Forfait (
    ForfaitID INT IDENTITY(1, 1) NOT NULL,
    Nom NVARCHAR(50) NOT NULL,
	Description NVARCHAR(200) NOT NULL,
	Prix INT NOT NULL
    PRIMARY KEY CLUSTERED (ForfaitID ASC)
)

INSERT INTO dbo.Forfait
VALUES ('Bronze', '20 photos et 35 minutes', 90),
('Argent', '26 photos et 50 minutes', 105),
('Or', '32 photos et 70 minutes', 120)

ALTER TABLE dbo.Seance
ADD ForfaitID INT

UPDATE dbo.Seance
SET ForfaitID = 1

ALTER TABLE dbo.Seance
ADD CONSTRAINT FK_ForfaitID_SeanceID
FOREIGN KEY (ForfaitID) 
REFERENCES dbo.Forfait(ForfaitID)

--Car je ne pouvais pas les assigné NOT NULL avant, mais maintenant une fois que j'ai mis des valeurs dedans sa marche.
ALTER TABLE dbo.Seance
ALTER COLUMN ForfaitID INT NOT NULL

