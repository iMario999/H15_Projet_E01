USE [master]
GO
/****** Object:  Database [H15_PROJET_E01]    Script Date: 2015-05-20 19:09:29 ******/
CREATE DATABASE [H15_PROJET_E01]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'H15_PROJET_E01', FILENAME = N'C:\Dept_Info_SQL_Transfert\H15_PROJET_E01.mdf' , SIZE = 10240KB , MAXSIZE = 20480KB , FILEGROWTH = 10%)
 LOG ON 
( NAME = N'H15_PROJET_E01_log', FILENAME = N'C:\Dept_Info_SQL_Transfert\H15_PROJET_E01_log.ldf' , SIZE = 10240KB , MAXSIZE = 204800KB , FILEGROWTH = 20%)
GO
ALTER DATABASE [H15_PROJET_E01] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [H15_PROJET_E01].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [H15_PROJET_E01] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [H15_PROJET_E01] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [H15_PROJET_E01] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [H15_PROJET_E01] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [H15_PROJET_E01] SET ARITHABORT OFF 
GO
ALTER DATABASE [H15_PROJET_E01] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [H15_PROJET_E01] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [H15_PROJET_E01] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [H15_PROJET_E01] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [H15_PROJET_E01] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [H15_PROJET_E01] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [H15_PROJET_E01] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [H15_PROJET_E01] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [H15_PROJET_E01] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [H15_PROJET_E01] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [H15_PROJET_E01] SET  DISABLE_BROKER 
GO
ALTER DATABASE [H15_PROJET_E01] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [H15_PROJET_E01] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [H15_PROJET_E01] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [H15_PROJET_E01] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [H15_PROJET_E01] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [H15_PROJET_E01] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [H15_PROJET_E01] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [H15_PROJET_E01] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [H15_PROJET_E01] SET  MULTI_USER 
GO
ALTER DATABASE [H15_PROJET_E01] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [H15_PROJET_E01] SET DB_CHAINING OFF 
GO
ALTER DATABASE [H15_PROJET_E01] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [H15_PROJET_E01] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [H15_PROJET_E01]
GO
/****** Object:  User [LABORATOIRE\1256913]    Script Date: 2015-05-20 19:09:29 ******/
CREATE USER [LABORATOIRE\1256913] FOR LOGIN [LABORATOIRE\1256913] WITH DEFAULT_SCHEMA=[LABORATOIRE\1256913]
GO
/****** Object:  User [LABORATOIRE\1145173]    Script Date: 2015-05-20 19:09:29 ******/
CREATE USER [LABORATOIRE\1145173] FOR LOGIN [LABORATOIRE\1145173] WITH DEFAULT_SCHEMA=[LABORATOIRE\1145173]
GO
/****** Object:  User [LABORATOIRE\1030672]    Script Date: 2015-05-20 19:09:29 ******/
CREATE USER [LABORATOIRE\1030672] FOR LOGIN [LABORATOIRE\1030672] WITH DEFAULT_SCHEMA=[LABORATOIRE\1030672]
GO
ALTER ROLE [db_owner] ADD MEMBER [LABORATOIRE\1256913]
GO
ALTER ROLE [db_owner] ADD MEMBER [LABORATOIRE\1145173]
GO
ALTER ROLE [db_owner] ADD MEMBER [LABORATOIRE\1030672]
GO
/****** Object:  Schema [LABORATOIRE\1030672]    Script Date: 2015-05-20 19:09:29 ******/
CREATE SCHEMA [LABORATOIRE\1030672]
GO
/****** Object:  Schema [LABORATOIRE\1145173]    Script Date: 2015-05-20 19:09:29 ******/
CREATE SCHEMA [LABORATOIRE\1145173]
GO
/****** Object:  Schema [LABORATOIRE\1256913]    Script Date: 2015-05-20 19:09:29 ******/
CREATE SCHEMA [LABORATOIRE\1256913]
GO
/****** Object:  StoredProcedure [dbo].[proc_rapportMensuel]    Script Date: 2015-05-20 19:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_rapportMensuel]
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
/****** Object:  UserDefinedFunction [dbo].[ufnCalculTotal]    Script Date: 2015-05-20 19:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ufnCalculTotal]
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
/****** Object:  UserDefinedFunction [dbo].[ufnNomPhotoGraphe]    Script Date: 2015-05-20 19:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ufnNomPhotoGraphe]
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
/****** Object:  Table [dbo].[Agent]    Script Date: 2015-05-20 19:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Agent](
	[AgentID] [int] IDENTITY(1,1) NOT NULL,
	[Nom] [nvarchar](50) NOT NULL,
	[Telephone] [varchar](15) NULL,
	[Prenom] [varchar](50) NULL,
	[Email] [varchar](100) NULL,
	[Agence] [varchar](50) NULL,
	[Commentaire] [varchar](300) NULL,
PRIMARY KEY CLUSTERED 
(
	[AgentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Facture]    Script Date: 2015-05-20 19:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Facture](
	[SeanceID] [int] IDENTITY(1,1) NOT NULL,
	[ForfaitID] [int] NOT NULL,
	[Total]  AS ([dbo].[ufnCalculTotal]([SeanceID])),
PRIMARY KEY CLUSTERED 
(
	[SeanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Forfait]    Script Date: 2015-05-20 19:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Forfait](
	[ForfaitID] [int] IDENTITY(1,1) NOT NULL,
	[Nom] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](200) NOT NULL,
	[Prix] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ForfaitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Notification]    Script Date: 2015-05-20 19:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notification](
	[NotificationID] [int] IDENTITY(1,1) NOT NULL,
	[SeanceID] [int] NULL,
	[StatutID] [int] NOT NULL,
	[DateNotification] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[NotificationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Photo]    Script Date: 2015-05-20 19:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Photo](
	[PhotoID] [int] IDENTITY(1,1) NOT NULL,
	[SeanceID] [int] NOT NULL,
	[fileType] [nvarchar](5) NULL,
	[Path] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[PhotoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Photographe]    Script Date: 2015-05-20 19:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Photographe](
	[PhotographeID] [int] IDENTITY(1,1) NOT NULL,
	[Nom] [varchar](50) NULL,
	[Prenom] [nvarchar](50) NULL,
	[Telephone] [nvarchar](16) NULL,
	[email] [nvarchar](100) NULL,
	[NomComplet]  AS ([dbo].[ufnNomPhotoGraphe]([PhotographeID])),
PRIMARY KEY CLUSTERED 
(
	[PhotographeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Seance]    Script Date: 2015-05-20 19:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Seance](
	[SeanceID] [int] IDENTITY(1,1) NOT NULL,
	[DateSeance] [datetime] NULL,
	[Adresse] [nvarchar](150) NOT NULL,
	[Ville] [nvarchar](50) NOT NULL,
	[Telephone] [nvarchar](50) NOT NULL,
	[Commentaire] [nvarchar](350) NOT NULL,
	[AgentID] [int] NOT NULL,
	[HeureSeance] [datetime] NULL,
	[PhotographeID] [int] NULL,
	[StatutID] [int] NOT NULL CONSTRAINT [df_statutID]  DEFAULT ((1)),
	[ForfaitID] [int] NOT NULL,
	[NbPhotosPrise] [int] NULL,
	[DateFacturation] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[SeanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Statut]    Script Date: 2015-05-20 19:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Statut](
	[StatutID] [int] IDENTITY(1,1) NOT NULL,
	[Nom] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[StatutID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[view_AgentSeance]    Script Date: 2015-05-20 19:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_AgentSeance]
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
SET IDENTITY_INSERT [dbo].[Agent] ON 

INSERT [dbo].[Agent] ([AgentID], [Nom], [Telephone], [Prenom], [Email], [Agence], [Commentaire]) VALUES (1, N'Tebaa', N'(514)098-1234', N'Mario', N'mario@tebaa.com', N'3 Monkeys', NULL)
INSERT [dbo].[Agent] ([AgentID], [Nom], [Telephone], [Prenom], [Email], [Agence], [Commentaire]) VALUES (2, N'Pelletier', N'(000)000-0000', N'Keven', N'kev@pelletier.com', N'3 Monkeys', NULL)
INSERT [dbo].[Agent] ([AgentID], [Nom], [Telephone], [Prenom], [Email], [Agence], [Commentaire]) VALUES (3, N'Kaizuka', N'(514)212-9090', N'Kyo', N'kyo@kaizuka.com', N'3 Monkeys', N'Num. domicile : (450)444-5555')
INSERT [dbo].[Agent] ([AgentID], [Nom], [Telephone], [Prenom], [Email], [Agence], [Commentaire]) VALUES (4, N'Turgeon', N'(450)999-9999', N'Valérie', N'val@turgeon.com', N'college-em.info', NULL)
INSERT [dbo].[Agent] ([AgentID], [Nom], [Telephone], [Prenom], [Email], [Agence], [Commentaire]) VALUES (5, N'Vallière', N'(450)111-1234', N'Chantal', N'chantal@vall.ca', N'college-em.info', NULL)
INSERT [dbo].[Agent] ([AgentID], [Nom], [Telephone], [Prenom], [Email], [Agence], [Commentaire]) VALUES (9, N'Perron', N'(000)000-0000', N'Alex', N'perron@eee.ee', N'B-max', NULL)
SET IDENTITY_INSERT [dbo].[Agent] OFF
SET IDENTITY_INSERT [dbo].[Facture] ON 

INSERT [dbo].[Facture] ([SeanceID], [ForfaitID]) VALUES (31, 2)
INSERT [dbo].[Facture] ([SeanceID], [ForfaitID]) VALUES (32, 1)
SET IDENTITY_INSERT [dbo].[Facture] OFF
SET IDENTITY_INSERT [dbo].[Forfait] ON 

INSERT [dbo].[Forfait] ([ForfaitID], [Nom], [Description], [Prix]) VALUES (1, N'Bronze', N'20 photos et 35 minutes', CAST(90.00 AS Decimal(10, 2)))
INSERT [dbo].[Forfait] ([ForfaitID], [Nom], [Description], [Prix]) VALUES (2, N'Argent', N'26 photos et 50 minutes', CAST(105.00 AS Decimal(10, 2)))
INSERT [dbo].[Forfait] ([ForfaitID], [Nom], [Description], [Prix]) VALUES (3, N'Or', N'32 photos et 70 minutes', CAST(120.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[Forfait] OFF
SET IDENTITY_INSERT [dbo].[Notification] ON 

INSERT [dbo].[Notification] ([NotificationID], [SeanceID], [StatutID], [DateNotification]) VALUES (140, 31, 3, CAST(N'2015-05-14 13:54:22.307' AS DateTime))
INSERT [dbo].[Notification] ([NotificationID], [SeanceID], [StatutID], [DateNotification]) VALUES (142, 32, 2, CAST(N'2015-05-14 13:54:36.643' AS DateTime))
INSERT [dbo].[Notification] ([NotificationID], [SeanceID], [StatutID], [DateNotification]) VALUES (143, 32, 3, CAST(N'2015-05-14 13:57:30.367' AS DateTime))
INSERT [dbo].[Notification] ([NotificationID], [SeanceID], [StatutID], [DateNotification]) VALUES (144, 32, 3, CAST(N'2015-05-14 13:57:36.300' AS DateTime))
INSERT [dbo].[Notification] ([NotificationID], [SeanceID], [StatutID], [DateNotification]) VALUES (145, 32, 3, CAST(N'2015-05-14 13:59:00.143' AS DateTime))
INSERT [dbo].[Notification] ([NotificationID], [SeanceID], [StatutID], [DateNotification]) VALUES (146, 32, 3, CAST(N'2015-05-14 14:10:16.403' AS DateTime))
INSERT [dbo].[Notification] ([NotificationID], [SeanceID], [StatutID], [DateNotification]) VALUES (147, 31, 3, CAST(N'2015-05-14 15:30:49.430' AS DateTime))
INSERT [dbo].[Notification] ([NotificationID], [SeanceID], [StatutID], [DateNotification]) VALUES (148, 31, 3, CAST(N'2015-05-14 15:30:53.387' AS DateTime))
INSERT [dbo].[Notification] ([NotificationID], [SeanceID], [StatutID], [DateNotification]) VALUES (149, 31, 3, CAST(N'2015-05-14 15:30:57.663' AS DateTime))
INSERT [dbo].[Notification] ([NotificationID], [SeanceID], [StatutID], [DateNotification]) VALUES (150, 31, 3, CAST(N'2015-05-14 15:31:04.370' AS DateTime))
INSERT [dbo].[Notification] ([NotificationID], [SeanceID], [StatutID], [DateNotification]) VALUES (1003, 32, 3, CAST(N'2015-05-15 13:42:48.090' AS DateTime))
INSERT [dbo].[Notification] ([NotificationID], [SeanceID], [StatutID], [DateNotification]) VALUES (1006, 32, 6, CAST(N'2015-05-20 13:00:37.153' AS DateTime))
INSERT [dbo].[Notification] ([NotificationID], [SeanceID], [StatutID], [DateNotification]) VALUES (1007, 33, 2, CAST(N'2015-05-20 13:01:35.077' AS DateTime))
INSERT [dbo].[Notification] ([NotificationID], [SeanceID], [StatutID], [DateNotification]) VALUES (1008, 37, 2, CAST(N'2015-05-20 13:02:21.590' AS DateTime))
INSERT [dbo].[Notification] ([NotificationID], [SeanceID], [StatutID], [DateNotification]) VALUES (1009, 38, 2, CAST(N'2015-05-20 13:12:34.020' AS DateTime))
INSERT [dbo].[Notification] ([NotificationID], [SeanceID], [StatutID], [DateNotification]) VALUES (1010, 39, 2, CAST(N'2015-05-20 15:30:23.507' AS DateTime))
INSERT [dbo].[Notification] ([NotificationID], [SeanceID], [StatutID], [DateNotification]) VALUES (1011, 31, 5, CAST(N'2015-05-20 16:59:52.090' AS DateTime))
INSERT [dbo].[Notification] ([NotificationID], [SeanceID], [StatutID], [DateNotification]) VALUES (1012, 31, 6, CAST(N'2015-05-20 17:13:54.927' AS DateTime))
INSERT [dbo].[Notification] ([NotificationID], [SeanceID], [StatutID], [DateNotification]) VALUES (1013, 40, 4, CAST(N'2015-05-20 17:20:47.747' AS DateTime))
INSERT [dbo].[Notification] ([NotificationID], [SeanceID], [StatutID], [DateNotification]) VALUES (1014, 40, 2, CAST(N'2015-05-20 17:20:47.750' AS DateTime))
INSERT [dbo].[Notification] ([NotificationID], [SeanceID], [StatutID], [DateNotification]) VALUES (1015, 40, 4, CAST(N'2015-05-20 17:21:46.900' AS DateTime))
INSERT [dbo].[Notification] ([NotificationID], [SeanceID], [StatutID], [DateNotification]) VALUES (1016, 38, 5, CAST(N'2015-05-20 18:33:36.097' AS DateTime))
INSERT [dbo].[Notification] ([NotificationID], [SeanceID], [StatutID], [DateNotification]) VALUES (1017, 40, 5, CAST(N'2015-05-20 18:45:27.700' AS DateTime))
SET IDENTITY_INSERT [dbo].[Notification] OFF
SET IDENTITY_INSERT [dbo].[Photo] ON 

INSERT [dbo].[Photo] ([PhotoID], [SeanceID], [fileType], [Path]) VALUES (1025, 31, N'jpg', N'Photos/Images/31/Chrysanthemum.jpg')
INSERT [dbo].[Photo] ([PhotoID], [SeanceID], [fileType], [Path]) VALUES (1026, 38, N'jpg', N'Photos/Images/38/Penguins.jpg')
INSERT [dbo].[Photo] ([PhotoID], [SeanceID], [fileType], [Path]) VALUES (1027, 38, N'jpg', N'Photos/Images/38/Tulips.jpg')
INSERT [dbo].[Photo] ([PhotoID], [SeanceID], [fileType], [Path]) VALUES (1028, 31, N'jpg', N'Photos/Images/31/Jellyfish.jpg')
INSERT [dbo].[Photo] ([PhotoID], [SeanceID], [fileType], [Path]) VALUES (1029, 40, N'jpg', N'Photos/Images/40/Lighthouse.jpg')
SET IDENTITY_INSERT [dbo].[Photo] OFF
SET IDENTITY_INSERT [dbo].[Photographe] ON 

INSERT [dbo].[Photographe] ([PhotographeID], [Nom], [Prenom], [Telephone], [email]) VALUES (1, N'Duval', N'Vincent', N'(450)443-8787', N'Vincent.duval@gmail.com')
INSERT [dbo].[Photographe] ([PhotographeID], [Nom], [Prenom], [Telephone], [email]) VALUES (2, N'Marois', N'Pauline', N'(569)345-8787', N'PaulineM@gmail.com')
INSERT [dbo].[Photographe] ([PhotographeID], [Nom], [Prenom], [Telephone], [email]) VALUES (4, N'Duval', N'Guy', N'(514)123-4567', N'guy@duvalphoto.com')
SET IDENTITY_INSERT [dbo].[Photographe] OFF
SET IDENTITY_INSERT [dbo].[Seance] ON 

INSERT [dbo].[Seance] ([SeanceID], [DateSeance], [Adresse], [Ville], [Telephone], [Commentaire], [AgentID], [HeureSeance], [PhotographeID], [StatutID], [ForfaitID], [NbPhotosPrise], [DateFacturation]) VALUES (31, CAST(N'2015-05-30 00:00:00.000' AS DateTime), N'3536 ch.Chambly', N'Longueil', N'(450)556-2556', N'Séance de photo pour le Cegep Édouard-Montpetit', 1, CAST(N'2015-05-20 18:30:00.000' AS DateTime), 4, 6, 2, NULL, CAST(N'2015-05-21 00:00:00.000' AS DateTime))
INSERT [dbo].[Seance] ([SeanceID], [DateSeance], [Adresse], [Ville], [Telephone], [Commentaire], [AgentID], [HeureSeance], [PhotographeID], [StatutID], [ForfaitID], [NbPhotosPrise], [DateFacturation]) VALUES (32, CAST(N'2015-05-15 00:00:00.000' AS DateTime), N'71 Maurice-A-Louis ', N'Saint-Moise', N'(418)666-5634', N'Séance de photo pour mr.Maurice
Cell : 514-556-0909 ', 1, CAST(N'2015-05-20 01:22:00.000' AS DateTime), 1, 6, 1, 15, CAST(N'2015-05-20 00:00:00.000' AS DateTime))
INSERT [dbo].[Seance] ([SeanceID], [DateSeance], [Adresse], [Ville], [Telephone], [Commentaire], [AgentID], [HeureSeance], [PhotographeID], [StatutID], [ForfaitID], [NbPhotosPrise], [DateFacturation]) VALUES (33, CAST(N'2015-06-01 00:00:00.000' AS DateTime), N'46 montpellier', N'st-basile', N'(450)000-0000', N'Chez Kyo!!', 2, CAST(N'2015-05-20 10:00:00.000' AS DateTime), 2, 2, 3, NULL, NULL)
INSERT [dbo].[Seance] ([SeanceID], [DateSeance], [Adresse], [Ville], [Telephone], [Commentaire], [AgentID], [HeureSeance], [PhotographeID], [StatutID], [ForfaitID], [NbPhotosPrise], [DateFacturation]) VALUES (37, CAST(N'2015-06-01 00:00:00.000' AS DateTime), N'8005 Rue de Normanville', N'Montréal', N'(514)-376-9681', N'appartement à louer 2 et 1/2', 3, CAST(N'2015-05-20 10:00:00.000' AS DateTime), 1, 2, 2, NULL, NULL)
INSERT [dbo].[Seance] ([SeanceID], [DateSeance], [Adresse], [Ville], [Telephone], [Commentaire], [AgentID], [HeureSeance], [PhotographeID], [StatutID], [ForfaitID], [NbPhotosPrise], [DateFacturation]) VALUES (38, CAST(N'2015-06-01 00:00:00.000' AS DateTime), N'7125 Sherbrooke Est', N'Montréal', N'(514)987-9877', N'condo métro radisson', 3, CAST(N'2015-05-20 14:00:00.000' AS DateTime), 1, 5, 2, NULL, NULL)
INSERT [dbo].[Seance] ([SeanceID], [DateSeance], [Adresse], [Ville], [Telephone], [Commentaire], [AgentID], [HeureSeance], [PhotographeID], [StatutID], [ForfaitID], [NbPhotosPrise], [DateFacturation]) VALUES (39, CAST(N'2015-05-23 00:00:00.000' AS DateTime), N'369 rue ducharme', N'sorel', N'(569)445-3929', N'Maison de mr monique ', 3, CAST(N'2015-05-20 20:30:00.000' AS DateTime), 2, 2, 3, NULL, NULL)
INSERT [dbo].[Seance] ([SeanceID], [DateSeance], [Adresse], [Ville], [Telephone], [Commentaire], [AgentID], [HeureSeance], [PhotographeID], [StatutID], [ForfaitID], [NbPhotosPrise], [DateFacturation]) VALUES (40, CAST(N'2015-05-21 00:00:00.000' AS DateTime), N'7901 Samuel Hatt', N'Chambly', N'(450)447-4600', N'Cargill Foods Limited', 1, CAST(N'2015-05-20 22:58:00.000' AS DateTime), 1, 5, 3, 15, NULL)
SET IDENTITY_INSERT [dbo].[Seance] OFF
SET IDENTITY_INSERT [dbo].[Statut] ON 

INSERT [dbo].[Statut] ([StatutID], [Nom]) VALUES (1, N'Demandée')
INSERT [dbo].[Statut] ([StatutID], [Nom]) VALUES (2, N'Confirmée')
INSERT [dbo].[Statut] ([StatutID], [Nom]) VALUES (3, N'Reportée')
INSERT [dbo].[Statut] ([StatutID], [Nom]) VALUES (4, N'Réalisée')
INSERT [dbo].[Statut] ([StatutID], [Nom]) VALUES (5, N'Livrée')
INSERT [dbo].[Statut] ([StatutID], [Nom]) VALUES (6, N'Facturée')
SET IDENTITY_INSERT [dbo].[Statut] OFF
ALTER TABLE [dbo].[Facture]  WITH CHECK ADD  CONSTRAINT [FK_SeanceFactureID] FOREIGN KEY([SeanceID])
REFERENCES [dbo].[Seance] ([SeanceID])
GO
ALTER TABLE [dbo].[Facture] CHECK CONSTRAINT [FK_SeanceFactureID]
GO
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_SeanceID] FOREIGN KEY([SeanceID])
REFERENCES [dbo].[Seance] ([SeanceID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_SeanceID]
GO
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_StatutID] FOREIGN KEY([StatutID])
REFERENCES [dbo].[Statut] ([StatutID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_StatutID]
GO
ALTER TABLE [dbo].[Photo]  WITH CHECK ADD  CONSTRAINT [FK_PhotoID_Seance] FOREIGN KEY([SeanceID])
REFERENCES [dbo].[Seance] ([SeanceID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Photo] CHECK CONSTRAINT [FK_PhotoID_Seance]
GO
ALTER TABLE [dbo].[Seance]  WITH CHECK ADD  CONSTRAINT [FK_AgentID_SeanceID] FOREIGN KEY([AgentID])
REFERENCES [dbo].[Agent] ([AgentID])
GO
ALTER TABLE [dbo].[Seance] CHECK CONSTRAINT [FK_AgentID_SeanceID]
GO
ALTER TABLE [dbo].[Seance]  WITH CHECK ADD  CONSTRAINT [FK_ForfaitID_SeanceID] FOREIGN KEY([ForfaitID])
REFERENCES [dbo].[Forfait] ([ForfaitID])
GO
ALTER TABLE [dbo].[Seance] CHECK CONSTRAINT [FK_ForfaitID_SeanceID]
GO
ALTER TABLE [dbo].[Seance]  WITH CHECK ADD  CONSTRAINT [FK_Seance_PhotographeID] FOREIGN KEY([PhotographeID])
REFERENCES [dbo].[Photographe] ([PhotographeID])
GO
ALTER TABLE [dbo].[Seance] CHECK CONSTRAINT [FK_Seance_PhotographeID]
GO
ALTER TABLE [dbo].[Seance]  WITH CHECK ADD  CONSTRAINT [FK_StatutID_Seance] FOREIGN KEY([StatutID])
REFERENCES [dbo].[Statut] ([StatutID])
GO
ALTER TABLE [dbo].[Seance] CHECK CONSTRAINT [FK_StatutID_Seance]
GO
USE [master]
GO
ALTER DATABASE [H15_PROJET_E01] SET  READ_WRITE 
GO
