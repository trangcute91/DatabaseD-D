-- 1. Create database named VNTours.
-- 2. Create tables with constraints as design above.

create table Tour(
	TourID int primary key identity(1,1),
	TourName nvarchar(200) not null,
	Days tinyint,
	Nights tinyint,
	Image varchar(150),
	Description nvarchar(500),
	Price money
);

create table TourDetails(
	TourDetailsID int primary key identity(1,1),
	TourID int foreign key references Tour(TourID),
	Day tinyint,
	Place varchar(100) not null,
	Detail nvarchar(200),
	Vehicle nvarchar(100)
);

drop table Tour;
drop table TourDetails;

-- 3. Insert into each table at lease 3 records.
insert into Tour(TourName, Days, Nights, Image, Description, Price)
	values
	(N'Thái Lan', '3', '4', 'https://akdmc.com/media/12572/thailand-6.jpg', '5 START', '6,000,000'),
	(N'Hạ Long', '5', '4', 'https://akdmc.com/media/12572/thailand-6.jpg', '3 START', '5,000,000'),
	('GerMany', '7', '6', 'https://akdmc.com/media/12572/thailand-6.jpg', '4 START', '57,000,000')
select * from Tour;

insert  into TourDetails(TourID, Day, Place, Detail, Vehicle)
	values
	('1', '1', 'BangKok', N'Hướng dẫn khách hàng làm thủ tục máy bay và khách sạn', N'Máy Bay'),
	('2', '3', 'Ha Long Bay', N'Hướng Dẫn KH thăm quan Đảo Vịnh Hạ Long', N'Thuyền'),
	('3', '6', 'BerLin', N'Hướng dẫn khách hàng làm thủ tục trả phòng khách sạn và ra sân bay', 'Bus')
select * from TourDetails;

-- 4. Write a query to select from Tours table where TourName or Description contains ‘Ha Long’.
select * from Tour  where TourName like N'Hạ Long';

-- 5. Write a query to get tours that have days and nights less than 3 and Price less than10 million.
select * from  Tour where Days < 3 and Nights < 3 and Price < 10000000;

-- 6. Create index on column TourName of Tours table.
create index Tour_Name on Tour(TourName);

-- 7. Create a view named v_TourInfor about one tour that display TourName, Price,Day, Place, Detail and Vehicle from Tours and TourDetails tables.
create view v_TourInfor
as
select Tour.TourName, Tour.Price, Tour.Days, TourDetails.Day, TourDetails.Place, TourDetails.Detail, TourDetails.Vehicle 
from Tour, TourDetails
where Tour.TourID = TourDetails.TourID;

-- 8. Create a stored procedure named sp_FindTourByName that accepts keyword as given input and display all tours that have TourName contain the keyword.
create procedure sp_FindTourName @tourname nvarchar(200)
as
begin
select TourName, Days, Nights, Image, Description, Price from Tour where TourName = @tourname
order by TourName
end;


-- 9. Create a trigger named tg_RemoveTour that allows delete information relating to a
tour when this tour is deleted from the table Tours (delete information in table
TourDetails)

create trigger tg_RemoveTour on Tour
after delete
as
delete * from TourDetails where TourID = '1';
delete * from Tour where TourID = '1';
select * from Tour;