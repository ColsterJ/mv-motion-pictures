CREATE DATABASE [motionpicturesdb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'motionpicturesdb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\motionpicturesdb.mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'motionpicturesdb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\motionpicturesdb_log.ldf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [motionpicturesdb] SET COMPATIBILITY_LEVEL = 150
GO
ALTER DATABASE [motionpicturesdb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [motionpicturesdb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [motionpicturesdb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [motionpicturesdb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [motionpicturesdb] SET ARITHABORT OFF 
GO
ALTER DATABASE [motionpicturesdb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [motionpicturesdb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [motionpicturesdb] SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF)
GO
ALTER DATABASE [motionpicturesdb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [motionpicturesdb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [motionpicturesdb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [motionpicturesdb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [motionpicturesdb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [motionpicturesdb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [motionpicturesdb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [motionpicturesdb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [motionpicturesdb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [motionpicturesdb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [motionpicturesdb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [motionpicturesdb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [motionpicturesdb] SET  READ_WRITE 
GO
ALTER DATABASE [motionpicturesdb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [motionpicturesdb] SET  MULTI_USER 
GO
ALTER DATABASE [motionpicturesdb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [motionpicturesdb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [motionpicturesdb] SET DELAYED_DURABILITY = DISABLED 
GO
USE [motionpicturesdb]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = Off;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = Primary;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = On;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = Primary;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = Off;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = Primary;
GO
USE [motionpicturesdb]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [motionpicturesdb] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO

CREATE TABLE [dbo].[MotionPictures](
	[ID] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[Release Year] [int] NOT NULL,
) ON [PRIMARY]
GO

INSERT INTO [dbo].[MotionPictures]
           ([Name]
           ,[Description]
           ,[Release Year])
     VALUES
           ('The Matrix'
           ,'When a beautiful stranger leads computer hacker Neo to a forbidding underworld, he discovers the shocking truth--the life he knows is the elaborate deception of an evil cyber-intelligence.'
           ,1999)

INSERT INTO [dbo].[MotionPictures]
           ([Name]
           ,[Description]
           ,[Release Year])
     VALUES
           ('Snowpiercer'
           ,'In a future where a failed climate change experiment has killed all life except for the survivors who boarded the Snowpiercer (a train that travels around the globe), a new class system emerges.'
           ,2013)

INSERT INTO [dbo].[MotionPictures]
           ([Name]
           ,[Description]
           ,[Release Year])
     VALUES
           ('Spider-Man: No Way Home'
           ,'With Spider-Man''s identity now revealed, Peter asks Doctor Strange for help. When a spell goes wrong, dangerous foes from other worlds start to appear, forcing Peter to discover what it truly means to be Spider-Man.'
           ,2021)

INSERT INTO [dbo].[MotionPictures]
           ([Name]
           ,[Description]
           ,[Release Year])
     VALUES
           ('Big Fish'
           ,'A frustrated son tries to determine the fact from fiction in his dying father''s life.'
           ,2003)

INSERT INTO [dbo].[MotionPictures]
           ([Name]
           ,[Description]
           ,[Release Year])
     VALUES
           ('The Sandlot'
           ,'In the summer of 1962, a new kid in town is taken under the wing of a young baseball prodigy and his rowdy team, resulting in many adventures.'
           ,1993)

INSERT INTO [dbo].[MotionPictures]
           ([Name]
           ,[Description]
           ,[Release Year])
     VALUES
           ('Back to the Future'
           ,'Marty McFly, a 17-year-old high school student, is accidentally sent 30 years into the past in a time-traveling DeLorean invented by his close friend, the maverick scientist Doc Brown.'
           ,1985)