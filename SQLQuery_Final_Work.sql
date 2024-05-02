create database [Final_Work]
go

use [Final_Work]
go

create table [Countries]
(
[Id] int primary key identity(1,1) not null,
[Name] nvarchar(50) unique not null check([Name] != ' ')
)

create table [Authors]
(
[Id] int primary key identity(1,1) not null,
[Name] nvarchar(max) not null check([Name] != ' '),
[Surname] nvarchar(max) not null check([Surname] != ' '),
[CountryId] int references[Countries]([Id]) not null
)

create table [Themes]
(
[Id] int primary key identity(1,1) not null,
[Name] nvarchar(100) unique not null check([Name] != ' ')
)

create table [Books]
(
[Id] int primary key identity(1,1) not null,
[Name] nvarchar(max) not null check([Name] != ' '),
[Pages] int not null check([Pages] > 0),
[Price] money not null check([Price] > 0),
[Publish_Date] date not null check([Publish_Date] <= getdate()),
[AuthorId] int references[Authors]([Id]) not null,
[ThemeId] int references[Themes]([Id]) not null
)

create table [Shops]
(
[Id] int primary key identity(1,1) not null,
[Name] nvarchar(max) not null check([Name] != ' '),
[CountryId] int references[Countries]([Id]) not null
)

create table [Sales]
(
[Id] int primary key identity(1,1) not null,
[Price] money not null check([Price] > 0),
[Quantity] int not null check([Quantity] >= 0),
[SaleDate] date default(getdate()) not null check ([SaleDate] <= getdate()),
[BookId] int references[Books]([Id]) not null,
[ShopId] int references[Shops]([Id]) not null
)

insert into [Countries]
values
('Україна'),
('Чехія'),
('Греція'),
('Росія'),
('Японія'),
('Германія'),
('Америка')

insert into [Authors]
values
('Ріічіро','Інагакі',5),
('Хадзіме','Ісаяма',5),
('Сергій','Клочков',4),
('Майа','Іліш',6),
('Люка','Дашвар',1),
('Мілан','Кундера',2),
('Кікі','Дімула',3),
('Володимир','Гундяєв',4),
('Уильям','Фолкнер', 7)

insert into [Themes]
values
('Фентезі'),
('Бойовик'),
('Научна фантастика'),
('Сбірка віршів'),
('Програмування'),
('Роман')

insert into [Books]
values 
('Базове програмування на С++',250, 50, '2024.04.15', 8, 5),
('Доктор Стоун', 550 , 25, '2023.11.04', 1, 3),
('Комната кукол', 354, 20, '2012.03.17', 4, 6),
('Вальс на прощание', 361, 15, '2008.07.21', 6, 6),
('Звук разлуки', 177, 17, '2001.10.04', 7, 4),
('Атака Титанов', 650, 35 , '2022.09.16', 2, 2),
('Лунь', 334, 25, '2013.06.15', 3, 3),
('Ініціація',298 ,30, '2020.11.15', 5, 6),
('Звук и ярость',340, 35, '2016.05.18', 9, 6),
('Дар Монолита', 356, 30, '2011.04.17', 3, 3)

insert into [Shops]
values
('Світ книжок',1),
('Svět knihy',2),
('Мир книг',4)

insert into [Sales]
values 
(60, 4, '2024.01.19', 1, 3),
(30, 2, '2023.11.01', 3, 2),
(35, 6, '2023.12.25', 7, 1),
(27, 12, '2024.04.17', 5, 2),
(35, 21, '2024.02.11', 2, 1),
(35, 15, '2024.04.18', 7, 2)

select * from Books as B
where B.Pages > 500 and B.Pages < 650

select * from Books as B
where B.[Name] like 'А%' or B.[Name] like 'З%'

select B.[Name] from Books as B
join Sales as S on S.BookId = B.Id
join Themes as T on T.Id = B.ThemeId
where T.[Name] = 'Научна фантастика'
group by B.[Name]
having sum(S.Quantity) > 15

select B.[Name] from Books as B
where B.[Name] like '%Звук%' and B.[Name] not like '%Разлуки%'

select B.[Name], T.[Name], A.[Name] from Books as B, Themes as T, Authors as A
where B.[AuthorId] = A.[Id] and B.[ThemeId] = T.[Id]
group by B.[Name], B.[Pages], B.[Price], T.[Name], A.[Name]
having B.Price / B.Pages <= 0.07

select B.[Name] from Books as B
where (len(B.[Name])-len(replace(B.[Name],' ',''))+1)=4

select B.[Name], T.[Name], A.[Name] + ' ' + A.[Surname], B.[Price], Sa.[Quantity], Sh.[Name] from Books as B
join Themes as T on B.[ThemeId] = T.[Id]
join Sales as Sa on Sa.[BookId] = B.[Id]
Join Shops as Sh on Sh.[Id] = Sa.[ShopId]
join Authors as A on B.[AuthorId] = A.[Id]
join Countries as C on Sh.[CountryId] = C.[Id]
where B.[Name] not like '%і%' and T.[Name] != 'Програмування' and A.[Name] + ' ' + A.[Surname] != 'Майа Іліш' and B.[Price] Between 15 and 25
and Sa.[Quantity] > 7 and (C.[Name] != 'Україна' and C.[Name] != 'Росія')

select T.[Name], sum(B.[Pages]) from Themes as T
join Books as B on B.[ThemeId] = T.[Id]
group by T.[Name]

select A.[Name] + ' ' + A.[Surname], sum(B.[Pages]), count(B.[Id]) from Authors as A
join Books as B on B.[AuthorId] = A.[Id]
group by A.[Name] + ' ' + A.[Surname]

select B.[Name], max(B.[Pages]) from Books as B
join Themes as T on T.[Id] = B.[ThemeId]
where T.[Name] = 'Програмування'
group by B.[Name]

select T.[Name], avg(B.[Pages]) from Themes as T
join Books as B on B.[ThemeId] = T.[Id]
group by T.[Name]
having avg(B.[Pages]) < 400

select T.[Name], sum(B.[Pages]) from Themes as T
join Books as B on B.[ThemeId] = T.[Id]
where B.[Pages] >= 300 and (T.[Name] = 'Научна фантастика' or T.[Name] = 'Роман')
group by T.[Name]

select top 1 Sh.[Name], sum(Sa.[Price] * Sa.[Quantity]) from Sales as Sa 
join Shops as Sh on Sh.[Id] = Sa.[ShopId]
group by Sh.[Name]
order by sum(Sa.[Price] * Sa.[Quantity]) desc