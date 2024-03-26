create database [HomeWork_3]
go

use [HomeWork_3]
go

create table [Departments]
(
[Id] int primary key identity (1,1) not null,
[Financing] money default (0) not null check ([Financing] >= 0),
[Name] nvarchar(100) unique not null check ([Name] != '')
)
create table [Faculties]
(
[Id] int primary key identity(1,1) not null,
[Dean] nvarchar(max) not null check ([Dean] != ''),
[Name] nvarchar(100) unique not null check ([Name] != '')
)
create table [Group]
(
[Id] int primary key identity(1,1) not null,
[Name] nvarchar(10) unique not null check ([Name] != ''),
[Rating] int not null check ([Rating] >=0 and [Rating] <=5),
[Year] int not null check ([Year] > 0 and [Year] <=5)
)
create table [Teachers]
(
[Id] int primary key identity(1,1) not null,
[EmploymendData] date not null check ([EmploymendData] > '1990.01.01'),
[IsAssistant] bit default(0) not null,
[IsProfessor] bit default(0) not null,
[Name] nvarchar(max) not null check([Name] != ''),
[Position] nvarchar(max) not null check([Position] != ''),
[Premium] money default(0) not null check([Premium] >= 0),
[Salary] money not null check([Salary] > 0),
[Surname] nvarchar(max) not null check ([Surname] != '')
)

insert into [Departments]
values
(10000, 'Departments1'),
(15000, 'Departments2'),
(12500, 'Departments3'),
(20000, 'Departments4'),
(30000, 'Departments5'),
(27000, 'Software Development'),
(15000, 'T_Departments')

insert into [Faculties]
values
('Dean1','Name1'),
('Dean2','Name2'),
('Dean3','Name3'),
('Dean4','Name4'),
('Dean5','Name5'),
('Dean6', 'Computer Science')

insert into [Group]
values
('Name1',3,1),
('Name2',4,3),
('Name3',4,1),
('Name4',5,4),
('Name5',2,2),
('Name6',3,5)

insert into [Teachers]
values
('2000.05.11', 1, 0, 'Name1','Position1', 150, 1000, 'Surname1'),
('1995.09.21', 0, 1, 'Name2','Position2', 500, 1500, 'Surname2'),
('2002.03.04', 1, 0, 'Name3','Position3', 0, 1000, 'Surname3'),
('2005.05.15', 0, 1, 'Name4','Position4', 350, 1500, 'Surname4'),
('1999.10.01', 0, 1, 'Name5','Position5', 0, 2000, 'Surname5'),
('1996.07.24', 1, 0, 'Name5','Position5', 300, 1000, 'Surname6'),
('1996.07.24', 1, 0, 'Name5','Position5', 0, 1500, 'Surname7')


select * from [Departments]
order by [Id] desc

select [Group].[Name] as 'Group Name', [Group].[Rating] as 'Group Rating' from [Group]

select [Teachers].[Surname] as 'Teacher' from [Teachers]
where [Teachers].[Salary] >= 1050 and [Teachers].[IsProfessor] = 1

select[Departments].[Name] as 'Departments Name' from [Departments]
where [Departments].[Financing] < 11000 or [Departments].[Financing] > 25000

select[Faculties].[Name] as 'Facultet Name' from [Faculties]
where [Faculties].[Name] != 'Computer Science'

select [Teachers].[Surname] as 'Teacher', [Teachers].[Position] as 'Position' from [Teachers]
where [Teachers].[IsAssistant] = 1

select [Teachers].[Surname] as 'Teacher', [Teachers].[Position] as 'Position', [Teachers].[Salary] as 'Salary', [Teachers].[Premium] as 'Premium' from [Teachers]
where [Teachers].[IsAssistant] = 1 and [Teachers].[Premium] > 160 and [Teachers].[Premium] < 550

select [Teachers].[Surname] as 'Teacher', [Teachers].[Position] as 'Position', [Teachers].[Salary] as 'Salary' from [Teachers]
where [Teachers].[IsAssistant] = 1

select [Teachers].[Surname] as 'Teacher', [Teachers].[Position] as 'Position' from [Teachers]
where [Teachers].[EmploymendData] > '2000.01.01'

select [Departments].[Name] as 'Name of Departments' from [Departments]
where [Departments].[Name] <= 'Software Development'
order by [Name]

select [Teachers].[Surname] as 'Teacher' from [Teachers]
where [Teachers].[IsAssistant] = 1 and [Teachers].[Salary] < 1200

select [Group].[Name] as 'Name' from [Group]
where [Group].[Year] = 5 and [Group].[Rating] >= 2 and [Group].[Rating] <= 4

select [Teachers].[Surname] as 'Teacher' from [Teachers]
where [Teachers].[IsAssistant] = 1 and [Teachers].[Salary] < 550 or [Teachers].[Premium] < 200