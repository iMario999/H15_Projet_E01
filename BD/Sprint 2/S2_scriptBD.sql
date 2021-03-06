USE [master]
GO
/****** Object:  Database [H15_PROJET_E01]    Script Date: 2015-05-06 14:29:12 ******/
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
/****** Object:  User [LABORATOIRE\1256913]    Script Date: 2015-05-06 14:29:12 ******/
CREATE USER [LABORATOIRE\1256913] FOR LOGIN [LABORATOIRE\1256913] WITH DEFAULT_SCHEMA=[LABORATOIRE\1256913]
GO
/****** Object:  User [LABORATOIRE\1145173]    Script Date: 2015-05-06 14:29:12 ******/
CREATE USER [LABORATOIRE\1145173] FOR LOGIN [LABORATOIRE\1145173] WITH DEFAULT_SCHEMA=[LABORATOIRE\1145173]
GO
/****** Object:  User [LABORATOIRE\1030672]    Script Date: 2015-05-06 14:29:12 ******/
CREATE USER [LABORATOIRE\1030672] FOR LOGIN [LABORATOIRE\1030672] WITH DEFAULT_SCHEMA=[LABORATOIRE\1030672]
GO
ALTER ROLE [db_owner] ADD MEMBER [LABORATOIRE\1256913]
GO
ALTER ROLE [db_owner] ADD MEMBER [LABORATOIRE\1145173]
GO
ALTER ROLE [db_owner] ADD MEMBER [LABORATOIRE\1030672]
GO
/****** Object:  Schema [LABORATOIRE\1030672]    Script Date: 2015-05-06 14:29:12 ******/
CREATE SCHEMA [LABORATOIRE\1030672]
GO
/****** Object:  Schema [LABORATOIRE\1145173]    Script Date: 2015-05-06 14:29:12 ******/
CREATE SCHEMA [LABORATOIRE\1145173]
GO
/****** Object:  Schema [LABORATOIRE\1256913]    Script Date: 2015-05-06 14:29:12 ******/
CREATE SCHEMA [LABORATOIRE\1256913]
GO
/****** Object:  Table [dbo].[Agent]    Script Date: 2015-05-06 14:29:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Photographe]    Script Date: 2015-05-06 14:29:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Photographe](
	[PhotographeID] [int] IDENTITY(1,1) NOT NULL,
	[Nom] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[PhotographeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Seance]    Script Date: 2015-05-06 14:29:12 ******/
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
	[FactureID] [nchar](10) NULL,
	[HeureSeance] [datetime] NULL,
	[PhotographeID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SeanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Statut]    Script Date: 2015-05-06 14:29:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Statut](
	[StatutID] [int] IDENTITY(1,1) NOT NULL,
	[SeanceID] [int] NULL,
	[DateStatut] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[StatutID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Agent] ON 

INSERT [dbo].[Agent] ([AgentID], [Nom], [Telephone], [Prenom], [Email], [Agence], [Commentaire]) VALUES (1, N'Mario', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Agent] ([AgentID], [Nom], [Telephone], [Prenom], [Email], [Agence], [Commentaire]) VALUES (2, N'Keven Pelletier', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Agent] ([AgentID], [Nom], [Telephone], [Prenom], [Email], [Agence], [Commentaire]) VALUES (3, N'Kyo', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Agent] ([AgentID], [Nom], [Telephone], [Prenom], [Email], [Agence], [Commentaire]) VALUES (4, N'Valérie                                           ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Agent] ([AgentID], [Nom], [Telephone], [Prenom], [Email], [Agence], [Commentaire]) VALUES (5, N'Chantal', NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Agent] OFF
SET IDENTITY_INSERT [dbo].[Seance] ON 

INSERT [dbo].[Seance] ([SeanceID], [DateSeance], [Adresse], [Ville], [Telephone], [Commentaire], [AgentID], [FactureID], [HeureSeance], [PhotographeID]) VALUES (1, CAST(N'2015-05-31 00:00:00.000' AS DateTime), N'l''ananas a bob ', N'bikini bottom', N'(450)-444-4545', N'Attention à Gary l''escargot ', 1, NULL, CAST(N'2015-05-06 10:30:00.000' AS DateTime), NULL)
INSERT [dbo].[Seance] ([SeanceID], [DateSeance], [Adresse], [Ville], [Telephone], [Commentaire], [AgentID], [FactureID], [HeureSeance], [PhotographeID]) VALUES (2, CAST(N'2015-05-20 00:00:00.000' AS DateTime), N'71, Germaine guevremont', N'varennes', N'(450)411-9493', N'salut ça va ? ', 1, NULL, CAST(N'2015-05-06 01:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Seance] ([SeanceID], [DateSeance], [Adresse], [Ville], [Telephone], [Commentaire], [AgentID], [FactureID], [HeureSeance], [PhotographeID]) VALUES (3, CAST(N'2015-05-30 00:00:00.000' AS DateTime), N'123 rue des riches', N'ville de riches', N'450-450-4444', N'im rich come at me bro', 1, NULL, CAST(N'2015-05-06 10:30:00.000' AS DateTime), NULL)
INSERT [dbo].[Seance] ([SeanceID], [DateSeance], [Adresse], [Ville], [Telephone], [Commentaire], [AgentID], [FactureID], [HeureSeance], [PhotographeID]) VALUES (4, NULL, N'879846548498546 rue', N'Montreal on va dire', N'(000)-000-0000', N'test num telephone', 1, NULL, NULL, NULL)
INSERT [dbo].[Seance] ([SeanceID], [DateSeance], [Adresse], [Ville], [Telephone], [Commentaire], [AgentID], [FactureID], [HeureSeance], [PhotographeID]) VALUES (6, NULL, N'22 jump street', N'SomewhereUSA', N'(123)456-7890', N'something cool', 3, NULL, NULL, NULL)
INSERT [dbo].[Seance] ([SeanceID], [DateSeance], [Adresse], [Ville], [Telephone], [Commentaire], [AgentID], [FactureID], [HeureSeance], [PhotographeID]) VALUES (7, NULL, N'21 rue des rues', N'Villageo', N'(159)951-1591', N'...', 2, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Seance] OFF
ALTER TABLE [dbo].[Seance]  WITH CHECK ADD  CONSTRAINT [FK_AgentID_SeanceID] FOREIGN KEY([AgentID])
REFERENCES [dbo].[Agent] ([AgentID])
GO
ALTER TABLE [dbo].[Seance] CHECK CONSTRAINT [FK_AgentID_SeanceID]
GO
ALTER TABLE [dbo].[Seance]  WITH CHECK ADD  CONSTRAINT [FK_Seance_PhotographeID] FOREIGN KEY([PhotographeID])
REFERENCES [dbo].[Photographe] ([PhotographeID])
GO
ALTER TABLE [dbo].[Seance] CHECK CONSTRAINT [FK_Seance_PhotographeID]
GO
ALTER TABLE [dbo].[Statut]  WITH CHECK ADD  CONSTRAINT [FK_Statut_SeanceID] FOREIGN KEY([SeanceID])
REFERENCES [dbo].[Seance] ([SeanceID])
GO
ALTER TABLE [dbo].[Statut] CHECK CONSTRAINT [FK_Statut_SeanceID]
GO
USE [master]
GO
ALTER DATABASE [H15_PROJET_E01] SET  READ_WRITE 
GO
