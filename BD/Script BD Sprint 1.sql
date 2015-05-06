USE H15_PROJET_E01
GO

CREATE TABLE [dbo].[Agent] (
    [AgentID] INT        IDENTITY (1, 1) NOT NULL,
    [Nom]     NCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([AgentID] ASC)
);

CREATE TABLE [dbo].[Seance] (
    [SeanceID]    INT            IDENTITY (1, 1) NOT NULL,
    [DateSeance]  DATETIME       NULL,
    [Adresse]     NVARCHAR (150) NOT NULL,
    [Ville]       NVARCHAR (50)  NOT NULL,
    [Telephone]   NVARCHAR (50)  NOT NULL,
    [Commentaire] NVARCHAR (350) NOT NULL,
    [AgentID]     INT            NOT NULL,
    [FactureID]   NCHAR (10)     NULL,
    [HeureSeance] DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([SeanceID] ASC),
    CONSTRAINT [FK_AgentID_SeanceID] FOREIGN KEY ([AgentID]) REFERENCES [dbo].[Agent] ([AgentID])
);

SET IDENTITY_INSERT [dbo].[Agent] ON
INSERT INTO [dbo].[Agent] ([AgentID], [Nom]) VALUES (1, N'Mario')
INSERT INTO [dbo].[Agent] ([AgentID], [Nom]) VALUES (2, N'Keven')
INSERT INTO [dbo].[Agent] ([AgentID], [Nom]) VALUES (3, N'Kyo')
SET IDENTITY_INSERT [dbo].[Agent] OFF

SET IDENTITY_INSERT [dbo].[Seance] ON
INSERT INTO [dbo].[Seance] ([SeanceID], [DateSeance], [Adresse], [Ville], [Telephone], [Commentaire], [AgentID], [FactureID], [HeureSeance]) VALUES (1, NULL, N'l''ananas a bob ', N'bikini', N'450-444-4545', N'yioooo ', 1, NULL, NULL)
INSERT INTO [dbo].[Seance] ([SeanceID], [DateSeance], [Adresse], [Ville], [Telephone], [Commentaire], [AgentID], [FactureID], [HeureSeance]) VALUES (2, NULL, N'71, Germaine guevremont', N'varennes', N'(450) 411-9493', N'salut ça va ? ', 2, NULL, NULL)
INSERT INTO [dbo].[Seance] ([SeanceID], [DateSeance], [Adresse], [Ville], [Telephone], [Commentaire], [AgentID], [FactureID], [HeureSeance]) VALUES (3, NULL, N'123 rue des riches', N'ville de riches', N'450-450-4444', N'im rich come at me bro', 2, NULL, NULL)
INSERT INTO [dbo].[Seance] ([SeanceID], [DateSeance], [Adresse], [Ville], [Telephone], [Commentaire], [AgentID], [FactureID], [HeureSeance]) VALUES (4, NULL, N'879846548498546 rue', N'Montreal on va dire', N'000-000-00000', N'test num telephone', 3, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Seance] OFF

ALTER TABLE dbo.Agent
ALTER COLUMN Nom NVARCHAR(50) NOT NULL