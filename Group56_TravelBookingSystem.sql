create database TBS;
use tbs;


-- -----------------------------------Create Tables--------------------------------------
-- --------------------------------------------------------------------------------------

create table USER_DETAIL(
UserID varchar(15) not null,
FirstName varchar(50),
LastName varchar(50),
DOB date not null,
Age int default (timestampdiff(year,DOB,curdate())),
primary key(UserID)
);

show create table USER_DETAIL;

create table USER_PASSWORD(
Email varchar(50) not null,
UserPassword varchar(15) not null,
UserID varchar(15) not null,
primary key(Email),
constraint fk_upass foreign key(UserID) references USER_DETAIL(UserID) on update cascade
);

show create table USER_PASSWORD;

create table USER_CONTACT(
UserID varchar(15) not null,
ContactNumber varchar(20) not null,
primary key(UserID,ContactNumber),
constraint fk_ucon foreign key(UserID) references USER_DETAIL(UserID) on update cascade
);

show create table USER_CONTACT;

create table DESTINATION(
DestinationName varchar(35) not null,
Location varchar(50) not null,
primary key(DestinationName,Location)
);

show create table DESTINATION;

create table HOTEL(
HotelID varchar(15) not null,
HotelName varchar(50) not null,
Country varchar(35) not null,
City varchar(35) not null,
Street varchar(35),
AddressNumber varchar(10),
Rating varchar(10),
primary key(HotelID)
);

show create table HOTEL;

create table HOTEL_DESTINATION(
HotelID varchar(15),
DestinationName varchar(35) not null,
Location varchar(50) not null,
primary key(HotelID,DestinationName,Location),
constraint fk_des foreign key(HotelID) references HOTEL(HotelID) on update cascade,
constraint fk_hotel foreign key(DestinationName,Location) references DESTINATION(DestinationName,Location) on update cascade
);

show create table HOTEL_DESTINATION;

create table HOTEL_CONTACT(
HotelID varchar(15) not null,
ContactNumber varchar(20) not null,
primary key(HotelID,ContactNumber),
constraint fk_hcon foreign key(HotelID) references HOTEL(HotelID) on update cascade
);

show create table HOTEL_CONTACT;

create table ROOM(
HotelID varchar(15) not null,
RoomNumber varchar(15) not null,
Floor varchar(10) not null,
RoomType varchar(30) not null,
PricePerNight decimal(10,2) not null,
Occupancy int,
primary key(HotelID,RoomNumber),
constraint fk_room foreign key(HotelID) references HOTEL(HotelID) on update cascade
);

show create table ROOM;

create table FACILITY(
HotelID varchar(15) not null,
FacilityName varchar(35) not null,
Capacity int,
OpeningHours varchar(30),
primary key(HotelID,FacilityName),
constraint fk_fac foreign key(HotelID) references HOTEL(HotelID) on update cascade
);

show create table FACILITY;

create table REVIEW(
ReviewID varchar(15) not null,
HotelID varchar(15) not null,
UserID varchar(15) not null,
Rating int,
Review varchar(250) not null,
primary key(ReviewID),
constraint fk_rev1 foreign key(HotelID) references HOTEL(HotelID) on update cascade,
constraint fk_rev2 foreign key(UserID) references USER_DETAIL(UserID) on update cascade
);

show create table REVIEW;

CREATE TABLE CARRENTAL (
CarRentalID varchar(15) NOT NULL,
CompanyName varchar(30) not null,
Country varchar(35) not null,
City varchar(35) not null,
Street varchar(35),
AddressNumber varchar(10),
primary key(CarRentalID)
);

show create table CARRENTAL;

create table CARRENTAL_CONTACT(
CarRentalID varchar(15) not null,
ContactNumber varchar(20) not null,
primary key(CarRentalID,ContactNumber),
constraint fk_carcon foreign key(CarRentalID) references CARRENTAL(CarRentalID) on update cascade
);

show create table CARRENTAL_CONTACT;

create table CAR(
CarNo varchar(15) not null,
CarModel varchar(25) not null,
CarType varchar(30) not null,
Capacity varchar(25) not null,
DailyRental varchar(15) not null,
CarRentalID varchar(15),
primary key(CarNo),
constraint fk_car foreign key(CarRentalID) references CARRENTAL(CarRentalID) on update cascade
);

show create table CAR;

create table AIRPORT(
AirportID varchar(15) not null,
AirportName varchar(50) not null,
Country varchar(35) not null,
City varchar(35) not null,
primary key(AirportID)
);

show create table AIRPORT;

create table FLIGHT(
FlightID varchar(15) not null,
Airline varchar(50),
TicketPrice decimal(10,2) not null,
DepartureAirport varchar(50) not null,
DepartureDate date not null,
DepartureTime time not null,
ArrivalAirport varchar(50) not null,
ArrivalDate date,
ArrivalTime time,
primary key(FlightID),
constraint fk_fd foreign key(DepartureAirport) 
references AIRPORT(AirportID) on update cascade,
constraint fk_fa foreign key(ArrivalAirport) 
references AIRPORT(AirportID) on update cascade
);

show create table FLIGHT;

create table BOOKING(
BookingID varchar(15) not null,
BookingDate date not null,
TotalCost decimal(10,2) not null,
UserID varchar(15) not null,
primary key(BookingID),
constraint fk_book foreign key(UserID) references USER_DETAIL(UserID) on update cascade
);

show create table BOOKING;

create table HOTEL_BOOKING(
BookingID varchar(15) not null,
HotelID varchar(15) not null,
primary key(BookingID,HotelID),
constraint fk_hbook foreign key(HotelID) references HOTEL(HotelID) on update cascade,
constraint fk_bid foreign key(BookingID) references BOOKING(BookingID) on update cascade
);

show create table HOTEL_BOOKING;

create table CARRENTAL_BOOKING(
BookingID varchar(15) not null,
CarRentalID varchar(15) not null,
primary key(BookingID,CarRentalID),
constraint fk_cbook foreign key(CarRentalID) references CARRENTAL(CarRentalID) on update cascade,
constraint fk_bidcar foreign key(BookingID) references BOOKING(BookingID) on update cascade
);

show create table CARRENTAL_BOOKING;

create table FLIGHT_BOOKING(
BookingID varchar(15) not null,
FlightID varchar(15) not null,
primary key(BookingID,FlightID),
constraint fk_fbook foreign key(FlightID) references FLIGHT(FlightID) on update cascade,
constraint fk_bidf foreign key(BookingID) references BOOKING(BookingID) on update cascade
);

show create table FLIGHT_BOOKING;

create table PAYMENT(
PaymentID varchar(15) not null,
PaymentDate date not null,
PaymentMethod varchar(30),
AmountPaid decimal(10,2) not null,
primary key(PaymentID)
);

show create table PAYMENT;

create table BOOKING_PAYMENT(
PaymentID varchar(15) not null,
BookingID varchar(15) not null,
primary key(PaymentID,BookingID),
constraint fk_bpay foreign key(BookingID) references BOOKING(BookingID) on update cascade,
constraint fk_pay foreign key(PaymentID) references PAYMENT(PaymentID) on update cascade
);

show create table BOOKING_PAYMENT;


-- ---------------------------------Insert Data-------------------------------------
-- ---------------------------------------------------------------------------------

insert into user_detail(UserID,FirstName,LastName,DOB)
values('U001','Jhon','Smith','1990-05-15');
insert into user_detail(UserID,FirstName,LastName,DOB)
values('U002','Sarah','Brown','1985-09-20');
insert into user_detail(UserID,FirstName,LastName,DOB)
values('U003','Michael','Brown','1995-03-10');
insert into user_detail(UserID,FirstName,LastName,DOB)
values('U004','Emily','Davis','1995-11-30');
insert into user_detail(UserID,FirstName,LastName,DOB)
values('U005','Jhon','Wilson','1995-03-10');
insert into user_detail(UserID,FirstName,LastName,DOB)
values('U006','Lisa','Anderson','1985-09-20');

select * from user_detail;

 
insert into user_password(Email,UserPassword,UserID)
values('john.smith@gmail.com','p@ssw0rd1','U001');
insert into user_password(Email,UserPassword,UserID)
values('sarah.b@gmail.com','secureP@ss2','U002');
insert into user_password(Email,UserPassword,UserID)
values('michael.b@gmail.com','p@ssw0rd1','U003');
insert into user_password(Email,UserPassword,UserID)
values('emily@gmail.com','D@vis123','U004');
insert into user_password(Email,UserPassword,UserID)
values('jhonw@gmail.com','W1ls0nJhn','U005');
insert into user_password(Email,UserPassword,UserID)
values('lisa.anderson@gmail.com','Lis@1234','U006');

select * from user_password;


insert into user_contact(UserID,ContactNumber)
values('U001','123-456-7890');
insert into user_contact(UserID,ContactNumber)
values('U002','545-143-4927');
insert into user_contact(UserID,ContactNumber)
values('U002','575-789-0123');
insert into user_contact(UserID,ContactNumber)
values('U003','999-088-7673');
insert into user_contact(UserID,ContactNumber)
values('U004','111-272-3383');
insert into user_contact(UserID,ContactNumber)
values('U005','776-129-1408');

select * from user_contact;


insert into destination(DestinationName,Location)
values('Sharjah','United Arab Emirates');
insert into destination(DestinationName,Location)
values('London','United Kingdom'); 
insert into destination(DestinationName,Location)
values('Venice','Italy');
insert into destination(DestinationName,Location)
values('Edinburgh','United Kingdom');
insert into destination(DestinationName,Location)
values('New York City','United States');
insert into destination(DestinationName,Location)
values('Venice','United States');

select * from destination;


insert into hotel(HotelID,HotelName,Country,City,Street,AddressNumber,Rating)
values('H001','Grand Plaza Hotel','United States','Venice','Broadway',null,'4.5');
insert into hotel(HotelID,HotelName,Country,City,Street,AddressNumber,Rating)
values('H002','Grand Canal Hotel','Italy','Venice','2nd Lane','46B','4.0');
insert into hotel(HotelID,HotelName,Country,City,Street,AddressNumber,Rating)
values('H003','Alpine Chalet','United Kingdom','Edinburgh','Bakers Street','23','4.9');
insert into hotel(HotelID,HotelName,Country,City,Street,AddressNumber,Rating)
values('H004','Cityscape Hotel','United Kingdom','London','Westmin Lane','03','4.5');
insert into hotel(HotelID,HotelName,Country,City,Street,AddressNumber,Rating)
values('H005','Grand Plaza Hotel','United Arab Emirates','Dubai','Desert Road','71A','4.4');
insert into hotel(HotelID,HotelName,Country,City,Street,AddressNumber,Rating)
values('H006','Seaside Paradise Hotel','Sri Lanka','Colombo','Broadway','46B','3.9');

select * from hotel;


insert into hotel_contact(HotelID,ContactNumber)
values('H001','223-456-7490');
insert into hotel_contact(HotelID,ContactNumber)
values('H001','223-406-7891');
insert into hotel_contact(HotelID,ContactNumber)
values('H002','771-157-1368');
insert into hotel_contact(HotelID,ContactNumber)
values('H004','997-399-5991');
insert into hotel_contact(HotelID,ContactNumber)
values('H005','555-579-4367');
insert into hotel_contact(HotelID,ContactNumber)
values('H003','334-657-9990');

select * from hotel_contact;


insert into room(HotelID,RoomNumber,Floor,RoomType,PricePerNight,Occupancy)
values('H001','201','2','Standard Double',150.00,2);
insert into room(HotelID,RoomNumber,Floor,RoomType,PricePerNight,Occupancy)
values('H002','201','5','Standard Twin',350.00,2);
insert into room(HotelID,RoomNumber,Floor,RoomType,PricePerNight,Occupancy)
values('H003','110','1','Standard Single',100.00,1);
insert into room(HotelID,RoomNumber,Floor,RoomType,PricePerNight,Occupancy)
values('H005','403','4','Executive Suite',400.00,3);
insert into room(HotelID,RoomNumber,Floor,RoomType,PricePerNight,Occupancy)
values('H004','1004','10','Family Suite',350.00,6);
insert into room(HotelID,RoomNumber,Floor,RoomType,PricePerNight,Occupancy)
values('H004','101','1','Standard Double',100.00,2); 

select * from room;


insert into facility(HotelID,FacilityName,Capacity,OpeningHours)
values('H001','Swimming Pool',50,'8:00 AM - 8:00 PM');
insert into facility(HotelID,FacilityName,Capacity,OpeningHours)
values('H003','Rooftop Bar',30,'5:00 PM - 1:00 AM');
insert into facility(HotelID,FacilityName,Capacity,OpeningHours)
values('H001','Fitness Center',20,'6:00 AM - 10:00 PM');
insert into facility(HotelID,FacilityName,Capacity,OpeningHours)
values('H005','Swimming Pool',60,'7:00 AM - 11:00 PM');
insert into facility(HotelID,FacilityName,Capacity,OpeningHours)
values('H004','Conference Room',60,'9:00 AM - 5:00 PM');
insert into facility(HotelID,FacilityName,Capacity,OpeningHours)
values('H002','Restaurant',80,'7:00 AM - 11:00 PM');

select * from facility;


insert into review(ReviewID,HotelID,UserID,Rating,Review)
values('R001','H001','U002',4,'The swimming pool was fantastic, and the staff were very friendly.');
insert into review(ReviewID,HotelID,UserID,Rating,Review)
values('R002','H001','U002',3,'The fitness center was well-equipped, but it could use more treadmills.');
insert into review(ReviewID,HotelID,UserID,Rating,Review)
values('R003','H002','U003',4,'The restaurant had delicious food, and the service was impeccable.');
insert into review(ReviewID,HotelID,UserID,Rating,Review)
values('R004','H005','U001',4,'Swimming pool was clean and well-maintained setting, comfortable loungers, and excellent poolside service.');
insert into review(ReviewID,HotelID,UserID,Rating,Review)
values('R005','H003','U005',5,'The conference room was spacious and perfect for our meeting.');
insert into review(ReviewID,HotelID,UserID,Rating,Review)
values('R006','H003','U003',3,'I was truly amazed by the exceptional service and its captivating beauty.');

select * from review;


insert into hotel_destination(HotelID,DestinationName,Location)
values('H005','Sharjah','United Arab Emirates');
insert into hotel_destination(HotelID,DestinationName,Location)
values('H004','Edinburgh','United Kingdom');
insert into hotel_destination(HotelID,DestinationName,Location)
values('H002','Venice','Italy');
insert into hotel_destination(HotelID,DestinationName,Location)
values('H003','Edinburgh','United Kingdom');
insert into hotel_destination(HotelID,DestinationName,Location)
values('H001','New York City','United States'); 
insert into hotel_destination(HotelID,DestinationName,Location)
values('H001','Venice','United States');

select * from hotel_destination;


insert into carrental(CarRentalID,CompanyName,Country,City,Street,AddressNumber)
values('CR001','DriveWell Rentals','United Arab Emirates','Dubai','Main Street','20A');
insert into carrental(CarRentalID,CompanyName,Country,City,Street,AddressNumber)
values('CR002','QuickWheels Car Hire','United Kingdom','London','Mapel Avenue','41');
insert into carrental(CarRentalID,CompanyName,Country,City,Street,AddressNumber)
values('CR003','AutoFlex Rent-A-Car','United Arab Emirates','Dubai','Sheikh Zayed Road','41');
insert into carrental(CarRentalID,CompanyName,Country,City,Street,AddressNumber)
values('CR004','DriveWell Rentals','Italy','Venice','Via Veneto',null);
insert into carrental(CarRentalID,CompanyName,Country,City,Street,AddressNumber)
values('CR005','CruiseRide Car Rentals','United States','New York','Oak Street','10');
insert into carrental(CarRentalID,CompanyName,Country,City,Street,AddressNumber)
values('CR006','CityCarve Car Rentals','Sri Lanka',' Colombo','Main Street','325'); 

select * from carrental;


insert into carrental_contact(CarRentalID,ContactNumber)
values('CR002','123-986-6554');
insert into carrental_contact(CarRentalID,ContactNumber)
values('CR003','856-369-7761');
insert into carrental_contact(CarRentalID,ContactNumber)
values('CR004','656-321-1264');
insert into carrental_contact(CarRentalID,ContactNumber)
values('CR005','223-879-4188');
insert into carrental_contact(CarRentalID,ContactNumber)
values('CR005','983-216-1487');
insert into carrental_contact(CarRentalID,ContactNumber)
values('CR001','762-711-0878');

select * from carrental_contact;


insert into car(CarNo,CarModel,CarType,Capacity,DailyRental,CarRentalID)
values('GDF546','Toyota Camry','Sedan','3.5L',50.00,'CR001');
insert into car(CarNo,CarModel,CarType,Capacity,DailyRental,CarRentalID)
values('CBJ138','Honda Civic','Sedan','1.5L',45.00,'CR005');
insert into car(CarNo,CarModel,CarType,Capacity,DailyRental,CarRentalID)
values('LSK876','BMW X5','SUV','3.0L',100.00,'CR001');
insert into car(CarNo,CarModel,CarType,Capacity,DailyRental,CarRentalID)
values('GYW385','Nissan Altima','Sedan','2.5L',80.00,'CR002'); 
insert into car(CarNo,CarModel,CarType,Capacity,DailyRental,CarRentalID)
values('SWD243','Jeep Wrangler','SUV','2.0L',80.00,'CR004');
insert into car(CarNo,CarModel,CarType,Capacity,DailyRental,CarRentalID)
values('ERY147','Toyota Camry','Hybrid','2.5L',70.00,'CR003');

select * from car;


insert into airport(AirportID,AirportName,Country,City)
values('A101','JFK International Airport','United States','New York');
insert into airport(AirportID,AirportName,Country,City)
values('A105','JFK International Airport','Jordan','Amman');
insert into airport(AirportID,AirportName,Country,City)
values('A104','Heathrow Airport','United Kingdom','London');
insert into airport(AirportID,AirportName,Country,City)
values('A102','Dubai International Airport','United Arab Emirates','Dubai');
insert into airport(AirportID,AirportName,Country,City)
values('A107','Bandaranaike International Airport','Sri Lanka','Colombo'); 
insert into airport(AirportID,AirportName,Country,City)
values('A106','Marco Polo Airport','Italy','Venice');

select * from airport;


insert into flight(FlightID,Airline,TicketPrice,DepartureAirport,DepartureDate,DepartureTime,ArrivalAirport,ArrivalDate,ArrivalTime)
values('F205','Emirates',500.00,'A101','2023-01-25','10:00:00','A102',' 2023-01-25','16:00:00');
insert into flight(FlightID,Airline,TicketPrice,DepartureAirport,DepartureDate,DepartureTime,ArrivalAirport,ArrivalDate,ArrivalTime)
values('F206','American Airlines',400.00,'A104','2023-01-29','09:45:00','A101','2023-01-29','16:15:00');
insert into flight(FlightID,Airline,TicketPrice,DepartureAirport,DepartureDate,DepartureTime,ArrivalAirport,ArrivalDate,ArrivalTime)
values('F203','British Airways',600.00,'A104','2023-02-15','14:00:00','A106','2023-02-16','07:30:00');
insert into flight(FlightID,Airline,TicketPrice,DepartureAirport,DepartureDate,DepartureTime,ArrivalAirport,ArrivalDate,ArrivalTime)
values('F207','British Airways',450.00,'A104','2023-03-04','08:15:00','A106','2023-03-04','15:00:00');
insert into flight(FlightID,Airline,TicketPrice,DepartureAirport,DepartureDate,DepartureTime,ArrivalAirport,ArrivalDate,ArrivalTime)
values('F212','Royal Jordanian Airlines',620.00,'A105','2023-03-10','09:30:00','A104','2023-03-10','14:15:00');
insert into flight(FlightID,Airline,TicketPrice,DepartureAirport,DepartureDate,DepartureTime,ArrivalAirport,ArrivalDate,ArrivalTime)
values('F210','Emirates',400.00,'A102','2023-05-12','22:30:00','A106','2023-05-13','09:40:00'); 

select * from flight;


insert into booking(BookingID,BookingDate,TotalCost,UserID)
values('B201','2023-01-15',6000.00,'U001');
insert into booking(BookingID,BookingDate,TotalCost,UserID)
values('B203','2023-01-17',6500.00,'U002');
insert into booking(BookingID,BookingDate,TotalCost,UserID)
values('B204','2023-02-05',9000.00,'U003');
insert into booking(BookingID,BookingDate,TotalCost,UserID)
values('B206','2023-02-07',7500.00,'U003');
insert into booking(BookingID,BookingDate,TotalCost,UserID)
values('B210','2023-02-25',6000.00,'U004');
insert into booking(BookingID,BookingDate,TotalCost,UserID)
values('B211','2023-03-02',10000.00,'U005'); 
insert into booking(BookingID,BookingDate,TotalCost,UserID)
values('B213','2023-04-15',5500.00,'U002'); 

select * from booking;


insert into hotel_booking(BookingID,HotelID)
values('B201','H005');
insert into hotel_booking(BookingID,HotelID)
values('B203','H001');
insert into hotel_booking(BookingID,HotelID)
values('B204','H003');
insert into hotel_booking(BookingID,HotelID)
values('B206','H002');
insert into hotel_booking(BookingID,HotelID)
values('B211','H003');
insert into hotel_booking(BookingID,HotelID)
values('B210','H005');

select * from hotel_booking;


insert into carrental_booking(BookingID,CarRentalID)
values('B201','CR001');
insert into carrental_booking(BookingID,CarRentalID)
values('B201','CR003');
insert into carrental_booking(BookingID,CarRentalID)
values('B203','CR005');
insert into carrental_booking(BookingID,CarRentalID)
values('B206','CR004');
insert into carrental_booking(BookingID,CarRentalID)
values('B210','CR001');
insert into carrental_booking(BookingID,CarRentalID)
values('B210','CR003');

select * from carrental_booking;


insert into flight_booking(BookingID,FlightID)
values('B201','F205');
insert into flight_booking(BookingID,FlightID)
values('B203','F206');
insert into flight_booking(BookingID,FlightID)
values('B206','F203');
insert into flight_booking(BookingID,FlightID)
values('B210','F207');
insert into flight_booking(BookingID,FlightID)
values('B211','F212');
insert into flight_booking(BookingID,FlightID)
values('B201','F206');

select * from flight_booking;


insert into payment(PaymentID,PaymentDate,PaymentMethod,AmountPaid)
values('P101','2023-01-17','Bank Transfer',6000.00);
insert into payment(PaymentID,PaymentDate,PaymentMethod,AmountPaid)
values('P102','2023-01-20','Credit Card',6500.00);
insert into payment(PaymentID,PaymentDate,PaymentMethod,AmountPaid)
values('P104','2023-02-11','Credit Card',16500.00);
insert into payment(PaymentID,PaymentDate,PaymentMethod,AmountPaid)
values('P107','2023-03-01','PayPal',6000.00);
insert into payment(PaymentID,PaymentDate,PaymentMethod,AmountPaid)
values('P110','2023-03-07','Bank Transfer',10000.00); 
insert into payment(PaymentID,PaymentDate,PaymentMethod,AmountPaid)
values('P115','2023-04-16','Debit Card',5500.00); 

select * from payment;


insert into booking_payment(PaymentID,BookingID)
values('P101','B201');
insert into booking_payment(PaymentID,BookingID)
values('P102','B203');
insert into booking_payment(PaymentID,BookingID)
values('P104','B204');
insert into booking_payment(PaymentID,BookingID)
values('P104','B206');
insert into booking_payment(PaymentID,BookingID)
values('P107','B210');
insert into booking_payment(PaymentID,BookingID)
values('P110','B211');

select * from booking_payment;


-- ---------------------------------Update and Delete Data-----------------------------------------
-- ------------------------------------------------------------------------------------------------

update user_password set UserPassword='secureP@ss3' where Email='sarah.b@gmail.com';
update user_password set Email='emily20@gmail.com' where Email='emily@gmail.com';

delete from user_password where Email='lisa.anderson@gmail.com';

select * from user_password;

-- ------------------------------------------------------------------------------------------------

update user_detail set LastName='Jackson' where UserID='U004';
update user_detail set DOB='1994-03-10' where UserID='U005';

delete from user_detail where UserID='U006';

select * from user_detail;

-- ------------------------------------------------------------------------------------------------

update user_contact set ContactNumber='545-143-4930' where UserID='U002' AND ContactNumber='545-143-4927';
update user_contact set UserID='U005' where UserID='U004';

delete from user_contact where UserID='U005' AND ContactNumber='776-129-1408';

select * from user_contact;

-- ------------------------------------------------------------------------------------------------

update destination set DestinationName='Abu Dhabi' where DestinationName='Sharjah'; 
update destination set DestinationName='Los Angeles' where DestinationName='New York City' AND Location='United States';

delete from destination where DestinationName='London' AND Location='United Kingdom';

select * from destination;

-- ------------------------------------------------------------------------------------------------

update hotel set HotelName='City Hotel',Street='Westminister Avenue' where HotelID='H004'; 
update hotel set Rating='4.2' where HotelID='H002';

delete from hotel where HotelID='H006';

select * from hotel;

-- ------------------------------------------------------------------------------------------------

update hotel_contact set HotelID='H002' where HotelID='H005'; 
update hotel_contact set ContactNumber='223-456-7590' where HotelID='H001' AND ContactNumber='223-456-7490';

delete from hotel_contact where HotelID='H001' AND ContactNumber='223-406-7891';

select * from hotel_contact;

-- ------------------------------------------------------------------------------------------------

update room set RoomType='Standard Single',PricePerNight='120.00' where HotelID='H001'AND RoomNumber='201'; 
update room set RoomNumber='108' where HotelID='H003';

delete from room where HotelID='H004' AND RoomNumber='101';

select * from room;

-- ------------------------------------------------------------------------------------------------

update facility set FacilityName='Outdoor Restaurant' where HotelID='H002'AND FacilityName='Restaurant'; 
update facility set Capacity=40,OpeningHours='5:00 AM - 10:00 PM' where HotelID='H001' AND FacilityName='Fitness Center';

delete from facility where HotelID='H004' AND FacilityName='Conference Room';

select * from facility;

-- ------------------------------------------------------------------------------------------------

update hotel_destination set DestinationName='Abu Dhabi' where HotelID='H005'AND DestinationName='Sharjah' AND Location='United Arab Emirates'; 
update hotel_destination set DestinationName='Los Angeles' where HotelID='H001'AND DestinationName='New York City' AND Location='United States'; 

delete from hotel_destination where HotelID='H001'AND DestinationName='New York City' AND Location='United States';

select * from hotel_destination;

-- ------------------------------------------------------------------------------------------------

update review set HotelID='H004' where ReviewID='R005'; 
update review set Rating='5',Review='I absolutely loved the swimming pool – it was a fantastic experience, and what made it even better was the incredibly friendly staff!' where ReviewID='R001';

delete from review where ReviewID='R004';

select * from review;

-- ------------------------------------------------------------------------------------------------

update carrental set CompanyName='AutoFlex Rentals',AddressNumber=null where CarRentalID='CR003';
update carrental set City='Sharjah' where CarRentalID='CR001';

delete from carrental where CarRentalID='CR006';

select * from carrental;

-- ------------------------------------------------------------------------------------------------

update carrental_contact set ContactNumber='656-321-1548',CarRentalID='CR003' where CarRentalID='CR004' AND ContactNumber='656-321-1264';
update carrental_contact set ContactNumber='983-216-1489' where CarRentalID='CR001' AND ContactNumber='762-711-0878';

delete from carrental_contact where CarRentalID='CR003' AND ContactNumber='856-369-7761';

select * from carrental_contact;

-- ------------------------------------------------------------------------------------------------

update car set CarModel='Ford Explorer',CarType='SUV',Capacity='2.3L',DailyRental=75.00 where CarNo='SWD243';
update car set CarNo='IEU174' where CarNo='ERY147';

delete from car where CarNo='GYW385';

select * from car;

-- ------------------------------------------------------------------------------------------------

update airport set AirportName='London City Airport' where AirportID='A104';
update airport set AirportName='Malpensa Airport',City='Milan' where AirportID='A106';

delete from airport where AirportID='A107';

select * from airport;

-- ------------------------------------------------------------------------------------------------

update flight set Airline='Air Italy' where FlightID='F203';
update flight set DepartureDate='2023-03-11',DepartureTime='07:50:00',ArrivalDate='2023-03-11',ArrivalTime='12:10:00' where FlightID='F212';

delete from flight where FlightID='F210';

select * from flight;

-- ------------------------------------------------------------------------------------------------

update booking set BookingDate='2023-02-24',TotalCost=5900.00 where BookingID='B210';
update booking set BookingDate='2023-01-17' where BookingID='B201';

delete from booking where BookingID='B213';

select * from booking;

-- ------------------------------------------------------------------------------------------------

update hotel_booking set BookingID='B206',HotelID='H004' where BookingID='B204' AND HotelID='H003';
update hotel_booking set HotelID='H002' where BookingID='B201' AND HotelID='H005';

delete from hotel_booking where BookingID='B206' AND HotelID='H002';

select * from hotel_booking;

-- ------------------------------------------------------------------------------------------------

update carrental_booking set BookingID='B204',CarRentalID='CR001' where BookingID='B203' AND CarRentalID='CR005';
update carrental_booking set CarRentalID='CR005' where BookingID='B201' AND CarRentalID='CR003';

delete from carrental_booking where BookingID='B210' AND CarRentalID='CR001';

select * from carrental_booking;

-- ------------------------------------------------------------------------------------------------

update flight_booking set BookingID='B204',FlightID='F205' where BookingID='B206' AND FlightID='F203';
update flight_booking set FlightID='F207' where BookingID='B211' AND FlightID='F212';

delete from flight_booking where BookingID='B201' AND FlightID='F205';

select * from flight_booking;

-- ------------------------------------------------------------------------------------------------

update payment set PaymentDate='2023-03-05' where PaymentID='P110';
update payment set PaymentDate='2023-02-09',PaymentMethod='Debit Card',AmountPaid=18000.00 where PaymentID='P104';

delete from payment where PaymentID='P115';

select * from payment;

-- ------------------------------------------------------------------------------------------------

update booking_payment set PaymentID='P101' where PaymentID='P102' AND BookingID='B203';
update booking_payment set PaymentID='P110',BookingID='B206' where PaymentID='P101' AND BookingID='B201';

delete from booking_payment where PaymentID='P104' AND BookingID='B206';

select * from booking_payment;


-- --------------------------------Simple Queries--------------------------------

-- -----------------------------------Select-------------------------------------

select * from CarRental;
select * from CarRental where Country='United Arab Emirates';

-- --------------------------------------Project---------------------------------------

select * from Flight;
select FlightID,Airline,TicketPrice from Flight;

-- -------------------------------Cartesian Product-----------------------------------

select * from Hotel;
select * from Facility;
select * from Hotel CROSS JOIN Facility;

-- ---------------------------------Create User View---------------------------------

create view UserView1 as select CarRentalID,CarNo from Car;
select * from UserView1;

-- --------------------------------------Rename--------------------------------------

rename table Review to Hotel_Review;
show tables;

-- -------------------------------Aggregation Function------------------------------

select * from User_Detail;
select * from User_Detail where Age=(select min(Age) from User_Detail);

-- -----------------------------------LIKE Keyword----------------------------------

select * from payment;
select * from payment where (PaymentDate Like '2023-03-__');


-- --------------------------------Complex Queries---------------------------------

-- ------------------------------------Union---------------------------------------

select * from Hotel_Review;
(select ReviewID,HotelID as Hotel from Hotel_Review where Rating='5') 
UNION 
(select ReviewID,HotelID as Hotel from Hotel_Review where Rating='3');

-- ---------------------------------Intersection-----------------------------------

select * from CarRental;
(select CarRentalID,City,Street,AddressNumber from CarRental where Country='United Arab Emirates') 
INTERSECT
(select CarRentalID,City,Street,AddressNumber from CarRental where CompanyName='DriveWell Rentals');

-- --------------------------------Set Difference----------------------------------

select * from Destination;
(select * from Destination) 
EXCEPT
(select * from Destination where Location='United States');

-- ------------------------------------Division--------------------------------------

select * from Car;
select distinct CarRentalID,CarModel from Car;
select distinct CarRentalID from Car where CarRentalID='CR001' OR CarRentalID='CR003';
select distinct CarModel from Car AS C1 
where not exists ((select distinct CarRentalID from Car where CarRentalID='CR001' OR CarRentalID='CR003')
EXCEPT
(select C2.CarRentalID from (select distinct CarRentalID,CarModel from Car) as C2 where C1.CarModel=C2.CarModel));

-- ----------------------------------Inner Join-------------------------------------

create view UV1 as (select BookingID,BookingDate,UserID from Booking);
select * from UV1;
create view UV2 as (select * from Hotel_Booking);
select * from UV2;
select * from UV1 as view1 inner join UV2 as view2 
on view1.BookingID=view2.BookingID where (view1.BookingDate like '2023-02-__'); 

-- ----------------------------------Natural Join-------------------------------------

create view UV3 as (select * from Flight_Booking);
select * from UV1;
select * from UV3;
select * from UV1 as view1 natural join UV3 as view3 where (view1.BookingDate='2023-01-17'); 

-- ----------------------------------Right Outer Join-------------------------------------

create view UV4 as (select CarRentalID,CompanyName,Country from CarRental);
select * from UV4;
create view UV5 as (select * from Car);
select * from UV5;
select * from UV4 as view4 right outer join UV5 as view5  
on view4.CarRentalID=view5.CarRentalID where (view4.Country='United Arab Emirates');

-- ----------------------------------Left Outer Join-------------------------------------

select * from UV4;
select * from UV5;
select * from UV4 as view4 left outer join UV5 as view5  
on view4.CarRentalID=view5.CarRentalID where (view4.Country='United Arab Emirates');


-- -----------------------------------Full Outer Join------------------------------------

select * from UV4 as view4 right outer join UV5 as view5 
on view4.CarRentalID=view5.CarRentalID where (view4.Country='United Arab Emirates');
select * from UV4 as view4 left outer join UV5 as view5 
on view4.CarRentalID=view5.CarRentalID where (view4.Country='United Arab Emirates');
(select * from UV4 as view4 right outer join UV5 as view5 on view4.CarRentalID=view5.CarRentalID where (view4.Country='United Arab Emirates')) 
UNION 
(select * from UV4 as view4 left outer join UV5 as view5 on view4.CarRentalID=view5.CarRentalID where (view4.Country='United Arab Emirates'));

-- -------------------------------------Outer Union--------------------------------------

select * from Booking;
select * from CarRental_Booking;
create view UV6 as ((select * from Booking as B natural join CarRental_Booking as CB) UNION (select B.BookingID,B.BookingDate,B.TotalCost,B.UserID,null from Booking as B));
select * from UV6;
(select * from UV6) EXCEPT (select * from UV6 where ((BookingID IN (select BookingID from CarRental_Booking)) AND (CarRentalID is null))); 

-- -------------------------------------Nested Function 1--------------------------------------

select * from User_Detail;
select * from Booking;
-- select * from Hotel_Review;
select U.UserID,U.FirstName,U.LastName from User_Detail as U where U.UserID IN(select B.UserID from Booking as B where B.TotalCost>7500.00); 

-- -------------------------------------Nested Function 2--------------------------------------

select AirportID,AirportName from Airport;
select FlightID,Airline,TicketPrice,DepartureAirport,ArrivalAirport from Flight;
select F.FlightID,F.Airline,F.TicketPrice,F.DepartureAirport,F.ArrivalAirport from Flight as F where DepartureAirport IN(select A.AirportID from Airport as A where A.AirportName='London City Airport'); 

-- -------------------------------------Nested Function 3--------------------------------------

select * from Hotel;
select * from Hotel_Review;
select R.ReviewID,R.Rating from Hotel_Review as R where R.HotelID IN(select H.HotelID from Hotel as H where H.HotelName='Grand Plaza Hotel'); 


-- -----------------------------------Tunning--------------------------------------

-- ------------------------------------Union---------------------------------------

show index from Hotel_Review;
EXPLAIN((select ReviewID,HotelID as Hotel from Hotel_Review where Rating='5') 
UNION 
(select ReviewID,HotelID as Hotel from Hotel_Review where Rating='3'));
create index Rating_Index on Hotel_Review(Rating);
show index from Hotel_Review;
EXPLAIN((select ReviewID,HotelID as Hotel from Hotel_Review where Rating='5') 
UNION 
(select ReviewID,HotelID as Hotel from Hotel_Review where Rating='3'));

-- ---------------------------------Intersection-----------------------------------

show index from CarRental;
EXPLAIN((select CarRentalID,City,Street,AddressNumber from CarRental where Country='United Arab Emirates') 
INTERSECT
(select CarRentalID,City,Street,AddressNumber from CarRental where CompanyName='DriveWell Rentals'));
create index Country_Index on CarRental(Country);
show index from CarRental;
EXPLAIN((select CarRentalID,City,Street,AddressNumber from CarRental where Country='United Arab Emirates') 
INTERSECT
(select CarRentalID,City,Street,AddressNumber from CarRental where CompanyName='DriveWell Rentals'));

-- --------------------------------Set Difference----------------------------------

show index from Destination;
EXPLAIN((select * from Destination) 
EXCEPT
(select * from Destination where Location='United States'));
create index Location_Index on Destination(Location);
show index from Destination;
EXPLAIN((select * from Destination) 
EXCEPT
(select * from Destination where Location='United States'));

-- ----------------------------------Natural Join-------------------------------------

show index from Booking;
show index from Flight_Booking;
EXPLAIN(select * from UV1 as view1 natural join UV3 as view3 where (view1.BookingDate='2023-01-17'));
create index BookingDate_Index on Booking(BookingDate);
show index from Booking;
EXPLAIN(select * from UV1 as view1 natural join UV3 as view3 where (view1.BookingDate='2023-01-17')); 

-- ----------------------------------Right Outer Join-------------------------------------

drop index Country_Index on CarRental;
show index from CarRental;
show index from Car;
EXPLAIN(select * from UV4 as view4 right outer join UV5 as view5 
on view4.CarRentalID=view5.CarRentalID where (view4.Country='United Arab Emirates')); 
create index Country_Index on CarRental(Country);
show index from CarRental;
EXPLAIN(select * from UV4 as view4 right outer join UV5 as view5
on view4.CarRentalID=view5.CarRentalID where (view4.Country='United Arab Emirates')); 

-- ----------------------------------Left Outer Join-------------------------------------

drop index Country_Index on CarRental;
show index from CarRental;
show index from Car;
EXPLAIN(select * from UV4 as view4 left outer join UV5 as view5
on view4.CarRentalID=view5.CarRentalID where (view4.Country='United Arab Emirates')); 
create index Country_Index on CarRental(Country);
show index from CarRental;
EXPLAIN(select * from UV4 as view4 left outer join UV5 as view5
on view4.CarRentalID=view5.CarRentalID where (view4.Country='United Arab Emirates')); 

-- -----------------------------------Full Outer Join------------------------------------

drop index Country_Index on CarRental;
show index from CarRental;
show index from Car;
EXPLAIN((select * from UV4 as view4 right outer join UV5 as view5
on view4.CarRentalID=view5.CarRentalID where (view4.Country='United Arab Emirates')) UNION (select * from UV4 as view4 left outer join UV5 as view5
on view4.CarRentalID=view5.CarRentalID where (view4.Country='United Arab Emirates')));
create index Country_Index on CarRental(Country);
show index from CarRental;
EXPLAIN((select * from UV4 as view4 right outer join UV5 as view5
on view4.CarRentalID=view5.CarRentalID where (view4.Country='United Arab Emirates')) UNION (select * from UV4 as view4 left outer join UV5 as view5
on view4.CarRentalID=view5.CarRentalID where (view4.Country='United Arab Emirates')));

-- -------------------------------------Nested Function 1--------------------------------------

show index from User_Detail;
show index from Booking;
EXPLAIN(select U.UserID,U.FirstName,U.LastName from User_Detail as U where U.UserID IN(select B.UserID from Booking as B where B.TotalCost>7500.00));
create index TotalCost_Index on Booking(TotalCost);
show index from Booking;
EXPLAIN(select U.UserID,U.FirstName,U.LastName from User_Detail as U where U.UserID IN(select B.UserID from Booking as B where B.TotalCost>7500.00)); 

-- -------------------------------------Nested Function 2--------------------------------------

show index from Airport;
show index from Flight;
EXPLAIN(select F.FlightID,F.Airline,F.TicketPrice,F.DepartureAirport,F.ArrivalAirport from Flight as F where DepartureAirport IN(select A.AirportID from Airport as A where A.AirportName='London City Airport'));
create index AirportName_Index on Airport(AirportName);
show index from Airport;
EXPLAIN(select F.FlightID,F.Airline,F.TicketPrice,F.DepartureAirport,F.ArrivalAirport from Flight as F where DepartureAirport IN(select A.AirportID from Airport as A where A.AirportName='London City Airport')); 

-- -------------------------------------Nested Function 3--------------------------------------

show index from Hotel;
show index from Hotel_Review;
EXPLAIN(select R.ReviewID,R.Rating from Hotel_Review as R where R.HotelID IN(select H.HotelID from Hotel as H where H.HotelName='Grand Plaza Hotel'));
create index HotelName_Index on Hotel(HotelName);
show index from Hotel;
EXPLAIN(select R.ReviewID,R.Rating from Hotel_Review as R where R.HotelID IN(select H.HotelID from Hotel as H where H.HotelName='Grand Plaza Hotel'));












