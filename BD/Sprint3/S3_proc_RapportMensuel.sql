IF OBJECT_ID('dbo.view_AgentSeance') IS NOT NULL DROP VIEW dbo.view_AgentSeance
GO
CREATE VIEW dbo.view_AgentSeance
AS
	SELECT 
		A.AgentID
		, A.Nom
		, A.Prenom
		, A.Telephone
		, A.Email
		, A.Agence
		, A.Commentaire AS 'Commentaire d''agent'
		, S.SeanceID
		, S.DateSeance
		, S.HeureSeance
		, S.Commentaire AS 'Commentaire de la séance'
		, S.Adresse
		, S.Ville
		, S.ForfaitID
		, S.DateFacturation
		, S.StatutID
		, S.NbPhotosPrise
	FROM Agent A
	INNER JOIN Seance S ON A.AgentID = S.AgentID
GO

IF OBJECT_ID('dbo.proc_rapportMensuel') IS NOT NULL DROP PROCEDURE dbo.proc_rapportMensuel
GO
CREATE PROCEDURE dbo.proc_rapportMensuel
(
	@mois int,
	@annee int
)
AS
BEGIN

	SELECT ISNULL(Prenom, ' ') + ' ' + ISNULL(Nom, ' ') AS Agent,  COUNT(SeanceID) AS 'NOMBRE DE SEANCE'
	FROM dbo.view_AgentSeance
	WHERE MONTH(DateSeance) = @mois
	AND YEAR(DateSeance) = @annee
	GROUP BY AgentID, Prenom, Nom
END
GO

--test pour voir le rapport de juin 2015
--EXEC dbo.proc_rapportMensuel 6, 2015