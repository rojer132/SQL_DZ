create database[H_W7]
go

use [H_W7]
go

create table [Subjects]
(
[Id] int primary key identity(1,1) not null,
[Name] nvarchar(100) unique not null check([Name] != ' ')
)

create table [Teachers]
(
[Id] int primary key identity(1,1) not null,
[Name] nvarchar(max) not null check([Name] != ' '),
[Surname] nvarchar(max) not null check([Surname] != ' ')
)

create table[Lectures]
(
[Id] int primary key identity(1,1) not null,
[SubjectId] int references[Subjects]([Id]) not null,
[TeacherId] int references[Teachers]([Id]) not null
)

create table[LectureRooms]
(
[Id] int primary key identity(1,1) not null,
[Building] int not null check([Building] > 0 and [Building] < 6),
[Name] nvarchar(10) unique not null check([Name] != ' ')
)

create table[Schedules]
(
[Id] int primary key identity(1,1) not null,
[Class] int not null check([Class] > 0 and [Class] < 9),
[DayOfWeek] int not null check([DayOfWeek] > 0 and [DayOfWeek] < 8),
[Week] int not null check ([Week] > 0 and [Week] < 53),
[LectureId] int references[Lectures]([Id]) not null,
[LectureRoomId] int references[LectureRooms]([Id]) not null
)

create table[Heads]
(
[Id] int primary key identity(1,1) not null,
[TeacherId] int references[Teachers]([Id]) not null
)

create table[Deans]
(
[Id] int primary key identity(1,1) not null,
[TeacherId] int references[Teachers]([Id]) not null
)

create table[Faculties]
(
[Id] int primary key identity(1,1) not null,
[Building] int not null check([Building] > 0 and [Building] < 6),
[Name] nvarchar(100) unique not null check([Name] != ' '),
[DeanId] int references[Deans]([Id]) not null
)

create table[Departments]
(
[Id] int primary key identity(1,1) not null,
[Building] int not null check([Building] > 0 and [Building] < 6),
[Name] nvarchar(100) unique not null check([Name] != ' '),
[FacultyId] int references[Faculties]([Id]) not null,
[HeadId] int references[Heads]([Id]) not null
)

create table[Curators]
(
[Id] int primary key identity(1,1) not null,
[TeacherId] int references[Teachers]([Id]) not null
)

create table[Assistants]
(
[Id] int primary key identity(1,1) not null,
[TeacherId] int references[Teachers]([Id]) not null
)

create table[Groups]
(
[Id] int primary key identity(1,1) not null,
[Name] nvarchar(10) unique not null check([Name] != ' '),
[Years] int not null check([Years] > 0 and [Years] < 6),
[DepartmentId] int references[Departments]([Id]) not null
)

create table[GroupCurators]
(
[Id] int primary key identity(1,1) not null,
[CuratorId] int references[Curators]([Id]) not null,
[GroupId] int references[Groups]([Id]) not null
)

create table[GroupLectures]
(
[Id] int primary key identity(1,1) not null,
[GroupId] int references[Groups]([Id]) not null,
[LectureId] int references[Lectures]([Id]) not null
)

insert into [Teachers]
values
('Edward','Hopper'),
('Alex','Carmack'),
('Name3','SName3'),
('Name4','SName4'),
('Name5','Sname5')

insert into [Subjects]
values
('Sub1'),
('Sub2'),
('Sub3'),
('Sub4')

insert into [Lectures]
values
(1,1),
(2,2),
(3,3),
(4,4),
(1,5),
(1,2)

insert into [LectureRooms]
values
(1,'A311'),
(2,'Name2'),
(4,'Name3')

insert into [Schedules]
values
(1, 1, 12, 1, 1),
(2, 1, 12, 2, 2),
(1, 3, 15, 3, 3)

insert into [Heads]
values
(1)

insert into [Deans]
values
(2)

insert into [Faculties]
values
(2, 'Name1', 1)

insert into [Departments]
values
(2, 'Name1', 1, 1)

insert into [Curators]
values
(3)

insert into [Assistants]
values
(5)

insert into [Groups]
values
('F505', 5, 1),
('Name2', 4, 1),
('Name3', 3, 1)

insert into [GroupCurators]
values
(1,1)

insert into [GroupLectures]
values 
(1,1),
(2,2),
(3,6),
(1,7)

select LR.[Name] from [LectureRooms] as LR
join [Schedules] as S on S.[LectureRoomId] = LR.[Id]
join Lectures as L on L.[Id] = S.[LectureId]
join Teachers as T on T.[Id] = L.[TeacherId]
where T.[Name] + ' ' + T.[Surname] = 'Edward Hopper'

select T.[Name] from Teachers as T
join [Lectures] as L on L.[TeacherId] = T.[Id]
join [GroupLectures] as GL on L.[Id] = GL.[LectureId]
join [Groups] as G on G.[Id] = GL.[GroupId]
join [Assistants] as A on A.[TeacherId] = T.[Id]

select S.[Name] from [Subjects] as S
join [Lectures] as L on L.SubjectId = S.Id
join [Teachers] as T on T.Id = L.TeacherId
join [GroupLectures] as GL on GL.LectureId = L.Id
join [Groups] as G on G.[Id] = GL.GroupId
where G.Years = 5 and T.[Name] + ' ' + T.[Surname] = 'Alex Carmack'

select T.[Name] from [Teachers] as T
join Lectures as L on L.TeacherId = T.Id
Join Schedules as S on S.LectureId = L.Id
where S.[DayOfWeek] != 1

select LR.[Name], LR.Building from LectureRooms as LR
join Schedules as S on S.LectureRoomId = LR.Id
join Lectures as L on L.Id = S.LectureId
where S.[DayOfWeek] != 3 and S.[Week] != 2 and S.Class != 3

select T.[Name] from Teachers as T
join Lectures as L on L.TeacherId = T.Id
join GroupLectures as GL on GL.LectureId = L.Id
join Groups as G on G.Id = GL.GroupId
join Departments as D on G.DepartmentId = D.Id
join Faculties as F on D.FacultyId = F.Id
where F.[Name] = 'Computer Science' and D.[Name] = 'Software Development'

select LR.Building from LectureRooms as LR
join Schedules as S on S.LectureRoomId = LR.Id
join Lectures as L on L.Id = S.LectureId
join GroupLectures as GL on GL.LectureId = L.Id
join Groups as G on G.Id = GL.GroupId
join Departments as D on G.DepartmentId = D.Id
join Faculties as F on D.FacultyId = F.Id

