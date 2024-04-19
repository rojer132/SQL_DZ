create database [HomeWork_FinalChapter]
go

use [HomeWork_FinalChapter]
go

create table [Subjects]
(
[Id] int primary key identity(1,1) not null,
[Name] nvarchar(100) unique not null check([Name] != '')
)

create table[Teachers]
(
[Id] int primary key identity(1,1) not null,
[IsProfessors] bit default(0) not null,
[Name] nvarchar(max) not null check([Name] != ''),
[Surname] nvarchar(max) not null check([Surname] != ''),
[Salary] money not null check([Salary] > 0)
)

create table [Students]
(
[Id] int primary key identity(1,1) not null,
[Name] nvarchar(max) not null check([Name] != ''),
[Surname] nvarchar(max) not null check([Surname] != ''),
[Rating] int not null check([Rating] > 0 and [Rating] < 6)
)

create table [Lectures]
(
[Id] int primary key identity(1,1) not null,
[Date] date not null check([Date] < getdate()),
[SubjectId] int references[Subjects]([Id]) not null,
[TeacherId] int references[Teachers]([Id]) not null
)

create table[Faculties]
(
[Id] int primary key identity(1,1) not null,
[Name] nvarchar(100) unique not null check([Name] != '')
)

create table[Departments]
(
[Id] int primary key identity(1,1) not null,
[Name] nvarchar(100) unique not null check([Name] != ''),
[Building] int not null check([Building] > 0 and [Building] < 6),
[Finansing] money default(0) not null check([Finansing] >=0),
[FacultyId] int references[Faculties]([Id]) not null
)

create table [Curators]
(
[Id] int primary key identity(1,1) not null,
[Name] nvarchar(max) not null check([Name] != '')
)

create table[Groups]
(
[Id] int primary key identity(1,1) not null,
[Name] nvarchar(10) unique not null check([Name] != ''),
[Years] int not null check([Years] > 0 and [Years] < 6),
[DepartmentId] int references[Departments]([Id]) not null
)

create table[GroupsCurators]
(
[Id] int primary key identity(1,1) not null,
[CuratorId] int references[Curators]([Id]) not null,
[GroupId] int references[Groups]([Id]) not null
)

create table[GroupsLectures]
(
[Id] int primary key identity(1,1) not null,
[GroupId] int references[Groups]([Id]) not null,
[LectureId] int references[Lectures]([Id]) not null
)

create table[GroupsStudents]
(
[Id] int primary key identity(1,1) not null,
[GroupId] int references[Groups]([Id]) not null,
[StudentId] int references[Students]([Id]) not null
)

insert into [Subjects]
values
('Sub'),
('Subj'),
('Subje'),
('Subjects')

insert into [Teachers]
values
(0, 'Name1','SurN1', 1500),
(1, 'Name2','SurN2', 1250),
(0, 'Name3','SurN3', 2000),
(1, 'Name4','SurN4', 1750)

insert into [Students]
values
('Name1','SurN1', 1),
('Name2','SurN2', 3),
('Name3','SurN3', 5),
('Name4','SurN4', 4),
('Name5','SurN5', 1),
('Name6','SurN6', 3),
('Name7','SurN7', 5),
('Name8','SurN8', 4)

insert into [Lectures]
values
('2024-04-15', 1, 1),
('2024-04-14', 2, 2),
('2024-04-13', 3, 3),
('2024-04-12', 4, 4)

insert into [Faculties]
values
('Name1'),
('Computer Science'),
('Name3'),
('Name4'),
('Name5')

insert into [Departments]
values
('Name1', 5, 150000, 1),
('Software Development', 5, 75000, 2),
('Name3', 3, 100000, 3),
('Name4', 2, 90000, 4),
('Name5', 2, 50000, 5)

insert into [Curators]
values
('Name1'),
('Name2'),
('Name3')

insert into [Groups]
values
('Name1', 5, 1),
('D221', 5, 2),
('Name3', 3, 3)

insert into [GroupsCurators]
values
(1,1),
(2,2),
(3,2),
(3,3)

insert into [GroupsLectures]
values
(1,1),
(2,2),
(2,3),
(3,4)

insert into [GroupsStudents]
values
(1,1),
(1,2),
(2,3),
(2,4),
(2,5),
(2,6),
(3,7),
(3,8)

--трохи переробив завдання, бо було лінь заповнювати велику кількість (В приклад 2-ге завдання, де потрібно 10 лекцій в тиждень, я зробив всього 2)

select D.[Building] from Departments as D
group by D.[Building]
having sum([Finansing]) > 100000

select G.[Name] from [Groups] as G
join [GroupsLectures] as GL on GL.[GroupId] = G.[Id]
join [Lectures] as L on L.[Id] = GL.[LectureId]
where l.[Date] >= getdate() - 7
group by G.[Name]
having count(GL.[LectureId]) > 1

select G.[Name] from [Groups] as G
join [GroupsStudents] as GS on GS.[GroupId] = G.[Id]
join [Students] as S on S.[Id] = GS.[StudentId]
group by G.[Name]
having avg(S.[Rating]) > (select avg (S.[Rating]) from [Students] as S
join [GroupsStudents] as GS on S.[Id] = GS.[StudentId]
join [Groups] as G on GS.[GroupId] = G.[Id]
where G.[Name] = 'D221')

select T.[Surname] + ' ' + T.[Name] from [Teachers] as T
group by T.[Surname] + ' ' + T.[Name]
having sum(T.[Salary]) > (select avg(T.Salary) from [Teachers] as T
where T.[IsProfessors] = 1)

select G.[Name] from [Groups] as G
join [GroupsCurators] as GC on G.[Id] = GC.[GroupId]
group by G.[Name]
having count(GC.[CuratorId]) > 1

select G.[Name] from [Groups] as G
join [GroupsStudents] as GS on GS.[GroupId] = G.[Id]
join [Students] as S on S.[Id] = GS.[StudentId]
group by G.[Name]
having avg(S.[Rating]) > (select avg (S.[Rating]) from [Students] as S
join [GroupsStudents] as GS on S.[Id] = GS.[StudentId]
join [Groups] as G on GS.[GroupId] = G.[Id]
where G.[Years] = 5)

select F.[Name] from [Faculties] as F
join [Departments] as D on F.[Id] = D.[FacultyId]
group by F.[Name]
having sum(D.[Finansing]) > (select sum(D.[Finansing]) from [Departments] as D
join [Faculties] as F on F.[Id] = D.[FacultyId]
where F.[Name] = 'Computer Science')

select S.[Name], T.[Surname] + ' ' + T.[Name]  from [Subjects] as S
join [Lectures] as L on L.[SubjectId] = S.[Id]
join [Teachers] as T on L.[TeacherId] = T.[Id]