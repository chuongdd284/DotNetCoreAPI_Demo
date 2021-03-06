USE [master]
GO
/****** Object:  Database [DemoWeek1DB]    Script Date: 11/5/2020 10:11:49 PM ******/
CREATE DATABASE [DemoWeek1DB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DemoWeek1DB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\DemoWeek1DB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DemoWeek1DB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\DemoWeek1DB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [DemoWeek1DB] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DemoWeek1DB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DemoWeek1DB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DemoWeek1DB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DemoWeek1DB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DemoWeek1DB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DemoWeek1DB] SET ARITHABORT OFF 
GO
ALTER DATABASE [DemoWeek1DB] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [DemoWeek1DB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DemoWeek1DB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DemoWeek1DB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DemoWeek1DB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DemoWeek1DB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DemoWeek1DB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DemoWeek1DB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DemoWeek1DB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DemoWeek1DB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DemoWeek1DB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DemoWeek1DB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DemoWeek1DB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DemoWeek1DB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DemoWeek1DB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DemoWeek1DB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DemoWeek1DB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DemoWeek1DB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DemoWeek1DB] SET  MULTI_USER 
GO
ALTER DATABASE [DemoWeek1DB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DemoWeek1DB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DemoWeek1DB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DemoWeek1DB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DemoWeek1DB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DemoWeek1DB] SET QUERY_STORE = OFF
GO
USE [DemoWeek1DB]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 11/5/2020 10:11:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[Customer_ID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [char](10) NULL,
	[CustomerName] [nvarchar](50) NULL,
	[CustomerAddress] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 11/5/2020 10:11:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](255) NULL,
	[Password] [nvarchar](255) NULL,
	[FullName] [nvarchar](255) NULL,
	[Role] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[AddUser]    Script Date: 11/5/2020 10:11:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[AddUser] 
	-- Add the parameters for the stored procedure here
	@UserName nvarchar(255),
	@Password nvarchar (255),
	@FullName nvarchar(255) null,
	@Role nvarchar(100) --Admin/Member
	
as
begin
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	insert into [Users] (UserName, Password, FullName, Role)
	values (@UserName, @Password, @FullName, @Role)
end

GO
/****** Object:  StoredProcedure [dbo].[DeleteUserById]    Script Date: 11/5/2020 10:11:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[DeleteUserById]
	-- Add the parameters for the stored procedure here
	@Id int
as
begin
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	delete [Users]
	where Id = @Id
end

GO
/****** Object:  StoredProcedure [dbo].[GetAllUsers]    Script Date: 11/5/2020 10:11:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetAllUsers]
as 
begin
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT Id, UserName, Password, FullName, Role
	FROM dbo.Users
	ORDER BY Id
end;
GO
/****** Object:  StoredProcedure [dbo].[GetUserById]    Script Date: 11/5/2020 10:11:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetUserById]
-- Add the parameters for the stored procedure here
	@Id int
as
begin
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Id, UserName, Password, FullName, Role
	from [Users]
	where Id = @Id
end

GO
/****** Object:  StoredProcedure [dbo].[GetUsersByRole]    Script Date: 11/5/2020 10:11:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetUsersByRole]
	-- Add the parameters for the stored procedure here
	@Role nvarchar(100) --Admin/Member
as
begin
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Select Id, UserName, Password, FullName, Role
	from Users
	where Role = @Role
	order by Id
end
GO
/****** Object:  StoredProcedure [dbo].[SearchByUserName]    Script Date: 11/5/2020 10:11:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SearchByUserName]
	-- Add the parameters for the stored procedure here
	@Name nvarchar(255) 
as
begin
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Select Id,UserName,Password,FullName,Role
	from [Users]
	where UserName like '%'+@Name+'%'
	order by Id
	--where UserName like '%Chuong%'
end
GO
/****** Object:  StoredProcedure [dbo].[UpdateUserById]    Script Date: 11/5/2020 10:11:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[UpdateUserById]
	-- Add the parameters for the stored procedure here
	@Id int,
	@UserName nvarchar(255) null,
	@Password nvarchar(255) null,
	@FullName nvarchar(255) null,
	@Role nvarchar(100) --Admin/Member
as
begin
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	update [Users]
	set UserName = @UserName, Password = @Password, FullName=@FullName, Role=@Role
	where Id = @Id
end
GO
USE [master]
GO
ALTER DATABASE [DemoWeek1DB] SET  READ_WRITE 
GO
