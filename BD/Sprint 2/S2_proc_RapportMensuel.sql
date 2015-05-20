IF OBJECT_ID('dbo.proc_rapportMensuel') IS NOT NULL DROP PROCEDURE dbo.proc_rapportMensuel
GO
CREATE PROCEDURE dbo.proc_rapportMensuel
(
	@mois int,
	@annee int
)
AS
BEGIN

	SELECT A.AgentID, ISNULL(A.Prenom, ' ') + ' ' + ISNULL(A.Nom, ' ') AS Agent,  COUNT(SeanceID) AS 'NOMBRE DE SEANCE'
	FROM Seance S
	INNER JOIN Agent A ON A.AgentID = S.AgentID
	WHERE MONTH(S.DateSeance) = @mois
	AND YEAR(S.DateSeance) = @annee
	GROUP BY A.AgentID, A.Prenom, A.Nom
END
GO

--test pour voir le rapport de juin 2015
--EXEC dbo.proc_rapportMensuel 6, 2015