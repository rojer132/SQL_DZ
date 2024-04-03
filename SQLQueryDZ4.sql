create database [HomeWork_4]
go

use [HomeWork_4]
go

create table[Curators]
(
[Id] int primary key identity(1,1) not null,
[Name] nvarchar(max) not null check([Name] != ''),
[Surname] nvarchar(max) not null check([Surname] != '')
)
create table [Faculties]
(
[Id] int primary key identity(1,1) not null,
[Finansing] money default(0) not null check ([Finansing] >= 0),
[Name] nvarchar(100) unique not null check([Name] != '')
)
create table [Departments]
(
[Id] int primary key identity(1,1) not null,
[Finansing] money default(0) not null check ([Finansing] >= 0),
[Name] nvarchar(100) unique not null check([Name] != ''),
[FacultyId] int references[Faculties]([Id]) not null
)
create table [Groups]
(
[Id] int primary key identity(1,1) not null,
[Name] nvarchar(10) unique not null check([Name] != ''),
[Years] int not null check([Years] > 0 and [Years] < 6),
[DepartmentId] int references[Departments]([Id]) not null
)
create table [GroupsCurators]
(
[Id] int primary key identity(1,1) not null,
[CuratorId] int references[Curators]([Id]) not null,
[GroupId] int references[Groups]([Id]) not null
)
create table[Subjects]
(
[Id] int primary key identity(1,1) not null,
[Name] nvarchar(100) unique not null check([Name] != '')
)
create table[Teachers]
(
[Id] int primary key identity(1,1) not null,
[Name] nvarchar(max) not null check([Name] != ''),
[Salary] money not null check([Salary] > 0),
[Surname] nvarchar(max) not null check([Surname] != '')
)
create table [Lectures]
(
[Id] int primary key identity(1,1) not null,
[LectureRoom] nvarchar(max) not null check([LectureRoom] != ''),
[SubjectId] int references[Subjects]([Id]) not null,
[TeacherId] int references[Teachers]([Id]) not null
)
create table [GroupsLectures]
(
[Id] int primary key identity(1,1) not null,
[GroupId] int references[Groups]([Id]) not null,
[LectureId] int references[Lectures]([Id]) not null
)
insert into [Curators]
values
('Name1', 'Surname1'),
('Name2', 'Surname2'),
('Name3', 'Surname3')

insert into [Faculties]
values
(10000 , 'Name1'),
(15000 , 'Name2'),
(13000 , 'Name3'),
(20000 , 'Computer Science'),
(17000 , 'Name5'),
(23000 , 'Name6')

insert into [Departments]
values
(20000, 'Name1', 6),
(19000, 'Name2', 5),
(18000, 'Name3', 4),
(17000, 'Name4', 3),
(16000, 'Name5', 2),
(15000, 'Name6', 1)

insert into [Groups]
values
('Name1', 5, 1),
('Name2', 5, 1),
('Name3', 2, 3),
('Name4', 3, 6),
('Name5', 4, 5),
('Name6', 1, 2),
('P107', 5, 4)

insert into [GroupsCurators]
values
(1,7),
(1,5),
(1,3),
(2,2),
(2,4),
(3,1),
(3,6)

insert into [Subjects]
values
('Database Theory'),
('Name 2'),
('Name 3')

insert into [Teachers]
values
('Samantha', 1500, 'Adams'),
('Name2', 2000, 'S_Name2'),
('Name3', 2500, 'S_Name3')

insert into [Lectures]
values
('B103', 1, 3),
('Name2', 2, 1),
('Name3', 3, 2)

insert into [GroupsLectures]
values
(1,1),
(3,1),
(5,1),
(2,2),
(4,2),
(1,3),
(6,3),
(7,2)

select [Teachers].[Name] as 'Teachers', [Groups].[Name] as 'Groups' from [Teachers], [Groups], [Lectures], [GroupsLectures]
where [Teachers].[Id] = [Lectures].[TeacherId] and [GroupsLectures].[GroupId] = [Groups].[Id] and [Lectures].[Id] = [GroupsLectures].[LectureId]

select [Faculties].[Name] as 'Faculties' from [Faculties], [Departments]
where [Faculties].[Finansing] > [Departments].[Finansing] and [Faculties].[Id] = [Departments].[FacultyId]

select [Curators].[Name] as 'Curators', [Groups].[Name] as 'Groups' from [Groups], [Curators], [GroupsCurators]
where [Curators].[Id] = [GroupsCurators].[CuratorId] and [Groups].[Id] = [GroupsCurators].[GroupId]

select [Teachers].[Name] as 'Teachers', [Groups].[Name] as 'Groups' from [Teachers], [Groups], [Lectures], [GroupsLectures]
where [Teachers].[Id] = [Lectures].[TeacherId] and [GroupsLectures].[GroupId] = [Groups].[Id] and [Lectures].[Id] = [GroupsLectures].[LectureId] and
[Groups].[Name] = 'P107'

select [Teachers].[Name] as 'Teachers', [Faculties].[Name] as 'Faculties' from [GroupsLectures], [Teachers], [Faculties], [Departments], [Groups], [Lectures]
where [Teachers].[Id] = [Lectures].[TeacherId] and [Faculties].[Id] = [Departments].[FacultyId] and [Departments].[Id] = [Groups].[DepartmentId] and
[GroupsLectures].[GroupId] = [Groups].[Id] and [Lectures].[Id] = [GroupsLectures].[LectureId]

select [Departments].[Name] as 'Departmetns', [Groups].[Name] as 'Groups' from [Departments], [Groups]
where [Groups].[DepartmentId] = [Departments].[Id]

select [Teachers].[Name] as 'Teachers', [Subjects].[Name] as 'Subjects' from [Subjects], [Teachers], [Lectures]
where [Teachers].[Id] = [Lectures].[TeacherId] and [Subjects].[Id] = [Lectures].[SubjectId] and [Teachers].[Name] = 'Samantha'

select[Subjects].[Name] as 'Subjects', [Departments].[Name] as 'Departmetns' from [Departments], [Subjects], [GroupsLectures], [Lectures], [Groups]
where [Departments].[Id] = [Groups].[DepartmentId] and [GroupsLectures].[GroupId] = [Groups].[Id] and [Subjects].[Id] = [Lectures].[SubjectId] and
[Lectures].[Id] = [GroupsLectures].[LectureId] and [Subjects].[Name] = 'Database Theory'

select [Faculties].[Name] as 'Faculties', [Groups].[Name] as 'Groups' from [Faculties], [Groups], [Departments]
where [Faculties].[Id] = [Departments].[FacultyId] and [Departments].[Id] = [Groups].[DepartmentId] and [Faculties].[Name] = 'Computer Science'

select [Groups].[Name] as 'Groups', [Faculties].[Name] as 'Faculties' from [Faculties], [Groups], [Departments]
where [Groups].[Years] = 5 and [Faculties].[Id] = [Departments].[FacultyId] and [Departments].[Id] = [Groups].[DepartmentId]

select [Teachers].[Name] + ' ' + [Teachers].[Surname] as 'Teachers', [Groups].[Name] as 'Groups', [Subjects].[Name] as 'Subjects' 
from [Subjects], [GroupsLectures], [Lectures], [Groups], [Teachers]
where [Teachers].[Id] = [Lectures].[TeacherId] and [Subjects].[Id] = [Lectures].[SubjectId] and [Lectures].[Id] = [GroupsLectures].[LectureId] 
and [GroupsLectures].[GroupId] = [Groups].[Id] and [Lectures].[LectureRoom] = 'B103'