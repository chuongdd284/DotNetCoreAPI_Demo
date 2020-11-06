create database DemoWeek1DB
go
use DemoWeek1DB
go

create table Customers(
	--Customer_ID bigint primary key Identity,
	Customer_ID int identity(1,1),
	CustomerID char(10),
	CustomerName nvarchar(50),
	CustomerAddress nvarchar(100)
);
go
create table Users(
	Id int primary key identity(1,1) not null,
	UserName nvarchar(255),
	Password nvarchar (255),
	FullName nvarchar(255) null,
	Role nvarchar(100) --Admin/Member
)
go

SELECT * FROM Customers
GO
--drop proc GetAllUsers
--go
create procedure GetAllUsers
as 
begin
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT Id, UserName, Password, FullName, Role
	FROM dbo.Users
	ORDER BY Id
end;
go
execute GetAllUsers
go

create proc GetUserById
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
go
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
go

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
go
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
go
--drop procedure SearchByUserName 
go
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
go
select * from Users
go
exec SearchByUserName @Name='em';
go

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
go
exec GetUsersByRole @Role='Member';
