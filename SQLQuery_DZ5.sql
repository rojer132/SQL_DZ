create database [HomeWork_5]
go

use [HomeWork_5]
go

create table [Faculties]
(
[Id] int primary key identity(1,1) not null,
[Name] nvarchar(100) unique not null check ([Name] != '')
)

create table [Subjects]
(
[Id] int primary key identity(1,1) not null,
[Name] nvarchar(100) unique not null check([Name] != '')
)

create table[Teachers]
(
[Id] int primary key identity(1,1) not null,
[Name] nvarchar(max) not null check([Name] != ''),
[Surname] nvarchar(max) not null check([Surname] != ''),
[Salary] money not null check([Salary] > 0)
)

create table [Departments]
(
[Id] int primary key identity(1,1) not null,
[Name] nvarchar(100) unique not null check([Name] != ''),
[Financing] money default(0) not null check([Financing] >= 0),
[FacultyId] int references[Faculties]([Id]) not null
)

create table [Groups]
(
[Id] int primary key identity(1,1) not null,
[Name] nvarchar(10) unique not null check([Name] != ''),
[Year] int not null check([Year] > 0 and [Year] < 6),
[DepartmentId] int references[Departments]([Id]) not null
)

create table[Lectures]
(
[Id] int primary key identity(1,1) not null,
[DayOfWeek] int not null check([DayOfWeek] > 0 and [DayOfWeek] < 8),
[LectureRoom] nvarchar(max) not null check([LectureRoom] != ''),
[SubjectId] int references[Subjects]([Id]) not null,
[TeacherId] int references[Teachers]([Id]) not null
)

create table[GroupsLectures]
(
[Id] int primary key identity(1,1) not null,
[GroupId] int references[Groups]([Id]) not null,
[LectureId] int references[Lectures]([Id]) not null
)

insert into [Faculties]
values
('Computer Science'),
('Name2'),
('Name3')

insert into [Subjects]
values
('Subject1'),
('Subject2'),
('Subject3'),
('Subject4')

insert into [Teachers]
values
('Jack','Underhill',2000),
('Dave','McQueen',1850),
('Name3', 'SName3', 1600),
('Name4', 'SName4', 2100),
('Name5', 'SName5', 2100)

insert into [Departments]
values
('Software Development',2000,1),
('Name2', 1000, 2),
('Name3', 1500, 3)

insert into [Groups]
values
('Name1', 1, 1),
('Name2', 2, 1),
('Name3', 3, 2),
('Name4', 4, 2),
('Name5', 5, 3),
('Name6', 4, 3)

insert into [Lectures]
values
(1, 'D201', 1,1),
(2, 'D201', 1,1),
(3, 'D201', 1,1),
(4, 'D202', 2,2),
(5, 'D202', 2,2),
(6, 'D202', 2,2),
(7, 'D203', 3,3),
(1, 'D203', 3,3),
(2, 'D203', 3,3),
(3, 'D204', 4,4),
(4, 'D204', 4,4),
(5, 'D204', 4,4),
(6, 'D204', 4,4)

insert into [GroupsLectures]
values
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(1,7),
(2,8),
(3,9),
(4,10),
(5,11),
(6,12),
(1,13)

select [Departments].[Name] as 'Departments', count([Teachers].[Name]) from [Departments], [Teachers], [Lectures], [GroupsLectures], [Groups]
where [Departments].[Id] = [Groups].[DepartmentId] and [Groups].[Id] = [GroupsLectures].[GroupId] 
and [Teachers].[Id] = [Lectures].[TeacherId] and [Lectures].[Id] = [GroupsLectures].[LectureId] and [Departments].[Name] = 'Software Development'
group by [Departments].[Name]

select [Teachers].[Name] + ' ' + [Teachers].[Surname] as 'Teacher', count([Lectures].[TeacherId]) from [Teachers], [Lectures]
where [Teachers].[Id] = [Lectures].[TeacherId] and [Teachers].[Name] + ' ' + [Teachers].[Surname] = 'Dave McQueen'
group by [Teachers].[Name] + ' ' + [Teachers].[Surname]

select [Lectures].[LectureRoom] as 'LectureRoom', count([Lectures].[LectureRoom]) from [Lectures]
group by [Lectures].[LectureRoom]

select [Teachers].[Name] + ' ' + [Teachers].[Surname] as 'Teacher', count([GroupsLectures].[GroupId]) from [Teachers], [Lectures], [GroupsLectures], [Groups]
where [Teachers].[Name] + ' ' + [Teachers].[Surname] = 'Jack Underhill' and [Groups].[Id] = [GroupsLectures].[GroupId] 
and [Teachers].[Id] = [Lectures].[TeacherId] and [Lectures].[Id] = [GroupsLectures].[LectureId]
group by [Teachers].[Name] + ' ' + [Teachers].[Surname]

select [Faculties].[Name] as 'Faculties', avg([Teachers].[Salary]) from [Faculties], [Departments], [Teachers], [Lectures], [GroupsLectures], [Groups]
where [Faculties].[Id] = [Departments].[FacultyId] and [Departments].[Id] = [Groups].[DepartmentId] and [Groups].[Id] = [GroupsLectures].[GroupId] 
and [Teachers].[Id] = [Lectures].[TeacherId] and [Lectures].[Id] = [GroupsLectures].[LectureId] and [Faculties].[Name] = 'Computer Science'
group by [Faculties].[Name]

--7 завдання не виконав, бо в створенні не було кількості учнів у группі, а перероблювати лінь

select avg([Departments].[Financing]) from [Departments]

select [Teachers].[Name] + ' ' + [Teachers].[Surname] as 'Teacher', count([Lectures].[SubjectId]) from [Teachers], [Lectures], [Subjects]
where [Teachers].[Id] = [Lectures].[TeacherId] and [Lectures].[SubjectId] = [Subjects].[Id]
group by [Teachers].[Name] + ' ' + [Teachers].[Surname] --не працює, як потрібно (Не зміг зрозуміти, чому)

select [Lectures].[DayOfWeek] as 'Day of week', count([Lectures].[DayOfWeek]) from [Lectures]
group by [Lectures].[DayOfWeek]

select	[Lectures].[LectureRoom] as 'LectureRoom' , count([Departments].[Name]) from [Departments], [Lectures], [GroupsLectures], [Groups]
where [Departments].[Id] = [Groups].[DepartmentId] and [Groups].[Id] = [GroupsLectures].[GroupId] and [Lectures].[Id] = [GroupsLectures].[LectureId]
group by [Lectures].[LectureRoom]

select [Faculties].[Name], count([Lectures].[SubjectId]) from [Faculties], [Departments], [Subjects], [Lectures], [GroupsLectures], [Groups]
where [Faculties].[Id] = [Departments].[FacultyId] and [Departments].[Id] = [Groups].[DepartmentId] and [Groups].[Id] = [GroupsLectures].[GroupId] 
and [Subjects].[Id] = [Lectures].[SubjectId] and [Lectures].[Id] = [GroupsLectures].[LectureId]
group by [Faculties].[Name]