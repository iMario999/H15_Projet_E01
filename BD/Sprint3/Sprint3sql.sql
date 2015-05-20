
GO
CREATE FUNCTION dbo.ufnCalculTotal
(
	@SeanceID int 
)
RETURNS decimal(10,2)
AS
BEGIN 

DECLARE @ForfaitID int
DECLARE @Total decimal(10,2)

SELECT @ForfaitID = ForfaitID FROM Seance WHERE SeanceID = @SeanceID 

SELECT @Total = Prix FROM Forfait WHERE ForfaitID = @ForfaitID

SET @Total = (@Total * 1.15)

RETURN @Total
END

GO



ALTER TABLE dbo.Facture
ADD Total AS dbo.ufnCalculTotal(SeanceID)

GO
DROP FUNCTION dbo.ufnNomPhotoGraphe
GO
CREATE FUNCTION dbo.ufnNomPhotoGraphe
(
	@PhotographeID int
)
RETURNS nvarchar(60)
AS
BEGIN

DECLARE @NomComplet nvarchar(60)
SELECT @NomComplet = Nom + ' ' + Prenom FROM dbo.Photographe WHERE PhotographeID = @PhotographeID

RETURN @NomComplet
END

GO
ALTER TABLE dbo.Photographe
ADD NomComplet AS dbo.ufnNomPhotoGraphe(PhotographeID)


ALTER TABLE dbo.Photographe
DROP COLUMN NomComplet