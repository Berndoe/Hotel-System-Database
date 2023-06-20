drop schema if exists HotelSystem;
set sql_safe_updates = 0;
create schema HotelSystem;
use HotelSystem;


create table Branch (
  branchId int primary key auto_increment,
    branchName varchar(20) ,
    city varchar(10),
    numRooms int,
    telephone varchar(20),
    postalCode varchar(40),
    email varchar(50)
);

create table Department (
  departmentCode varchar(30) primary key ,
    departmentName varchar(30),
    location varchar(30),
    email varchar(50)
); 



create table BranchDepartment(
branchId int,
    departmentCode varchar(30),
    primary key(branchId, departmentCode),
    
    foreign key (branchId)
    references Branch(branchId)
        on delete cascade
    on update cascade,
        
    foreign key (departmentCode)
    references Department(departmentCode)  
        on delete cascade
    on update cascade
);


    
create table RoomType (
  roomType varchar(20) primary key, 
    roomDescription varchar(200),
    price decimal
);

    
create table Room (
   roomNumber int primary key,
    roomType varchar(20),
    branchId int,
    smoking boolean default 0, -- 1 for smoking : 0 for not smoking
    availability boolean default 1, -- 1 for availabile:  0 for not
  
    foreign key (roomType) 
    references RoomType(roomType) 
        on delete cascade
        on update cascade,
        
    foreign key (branchId) 
    references Branch(branchId)
        on delete cascade
        on update cascade
);


    
create table Services (
   serviceId varchar(10) primary key,
    serviceName varchar(20),
    startDate date,
    endDate date,
    amountCharged decimal, 
    deliveryStatus boolean default 0,
    check (endDate >= startDate)
);


create table Meals (
  serviceId varchar(20) references Services(serviceId)
        on delete cascade
        on update cascade,
    food varchar(20),
    numnberOfServings int
);

create table Laundry (
   serviceId varchar(20) references Services(serviceId)
        on delete cascade
        on update cascade,
    loadType enum("Cotton", "Polyester", "Silk", "Mixed"), 
    quantity int default 1
);


create table BranchService (
  branchId int, 
    serviceId varchar(20) unique,
    primary key(branchId, serviceId),
    
    foreign key (branchId) 
    references Branch(branchId) 
    on delete cascade
        on update cascade,
        
    foreign key (serviceId) 
    references Services(serviceId)
        on delete cascade
        on update cascade
);


create table EmployeeRole (
  roleId varchar(10) primary key, 
    title varchar(100), 
    titleDescription varchar(500)
);


create table Employee (
  empId int primary key,
    empRole varchar(10),
    gender enum('M', 'F', 'NA') not null,
   firstName varchar(20),
    lastName varchar(20),
    telephone int,
    address varchar(50), 
    email varchar(50),
    dailyWorkingHours int,
    check (dailyWorkingHours > 0),
    
    foreign key (empRole) 
    references EmployeeRole(roleId) 
        on delete cascade
        on update cascade
);


create table Guest (
  guestId int primary key,
    firstName varchar(20),
    lastName varchar(20),
    gender enum('M', 'F', 'NA') not null,
    telephone int,
    address varchar(50),
    email varchar(50)

);

create table Booking (
  bookingId int primary key,
    branchId int, 
    guestId int,
    empId int,
    roomNumber int,
    bookingDate date,
    bookingTime time,
    arrivalDate date,
    departureDate date,
    specialRequests varchar(60) default "none", 
    checkInStatus boolean default 0,
    
    foreign key (branchId)
    references Branch(branchId)
        on delete cascade
        on update cascade,
        
    foreign key (empId) 
    references Employee(empId)
        on delete cascade
        on update cascade,
        
    foreign key (guestId) 
    references Guest(guestId)
        on delete cascade
        on update cascade,
        
    foreign key (roomNumber) 
    references Room(roomNumber)
        on delete cascade
        on update cascade
	
);



create table BranchServiceGuest (
  branchId int, 
    serviceId varchar(20),
    guestId int,
    primary key(branchId, serviceId, guestId),
    
    foreign key (guestId)
    references Guest(guestId)
        on delete cascade
        on update cascade,
        
  foreign key (branchId)
    references Branch(branchId)
        on delete cascade
        on update cascade,
        
    foreign key (serviceId) 
    references Services(serviceId)
        on delete cascade
        on update cascade
);

create table Payment (
  invoiceNo int primary key,
    bookingId int,
    serviceId varchar(20),
    paymentMethod enum('Cash', 'Mobile money','Bank', 'Card', 'Mixed'), 
    charge decimal,
    additionalCharge decimal default 0,
    paymentDate date,
    
    foreign key (bookingId) 
    references Booking(bookingId)
        on delete cascade
        on update cascade,
        
	foreign key (serviceId) 
    references BranchServiceGuest(serviceId)
        on delete cascade
        on update cascade
);



create table BranchServiceBooking (
  branchId int, 
    serviceId varchar(20),
    bookingId int,
    primary key(branchId, serviceId, bookingId),
    
    foreign key (bookingId)
    references Booking(bookingId)
        on delete cascade
        on update cascade,
        
  foreign key (branchId)
    references Branch(branchId)
        on delete cascade
        on update cascade,
        
    foreign key (serviceId) 
    references Services(serviceId)
        on delete cascade
        on update cascade
);

create table FullTime (
  empId int references Employee(empId)
        on delete cascade
        on update cascade,
  salary decimal,
    bonus decimal default 0
    
);


create table PartTime (
  empId int references Employee(empId)
        on delete cascade
        on update cascade,
  numberOfWorkingDays int,
    hourlyRate decimal,
    check (numberOfWorkingDays > 0)
);


create table Contract (
  empId int  references Employee(empId)
        on delete cascade
        on update cascade,
    startDate date,
    endDate date,
  contractFee decimal,
  check (endDate > startDate)
);


-- -- -------------------- INSERT VALUES -----------------------------------

insert into Branch  (branchName, city, numRooms, telephone, postalCode, email)
  values("Accra Branch", "Accra", 500, "02441819211", "P.O. BOX AC 16829", "beyondthehills-Accra@gmail.com"
    );
insert into Branch  (branchName, city, numRooms, telephone, postalCode, email)
  values("Cape Coast Branch", "Cape Coast", 450, "055192756", "P.O.BOX CS 82929", "beyondthehills-CapeCoast@gmail.com"
    );
    
insert into Branch  (branchName, city, numRooms, telephone, postalCode, email)
  values("Kumasi Branch", "Kumasi", 600, "026192715", "P.O.BOX KN 9172", "beyondthehills-Kumasi@gmail.com"
    );

insert into Branch  (branchName, city, numRooms, telephone, postalCode, email)
  values("Takoradi Branch", "Takoradi", 350, "0244619387", "P.O.BOX TK 0101", "beyondthehills-Takoradi@gmail.com"
    );
    
insert into Branch  (branchName, city, numRooms, telephone, postalCode, email)
  values("Berekuso Branch", "Berekuso", 600, "055783451", "P.O.BOX BK 1924", "beyondthehills-Berekuso@gmail.com"
    );
    

INSERT INTO Department 
  VALUES ("DP101", "House Keeping", "Basement", "beyondthehills.housekeeping@hotmail.com"
    );
INSERT INTO Department 
  VALUES ("DP301", "Guest Services", "First Floor", "beyondthehills.guestservices@hotmail.com"
  );
INSERT INTO Department
  VALUES ("DP110", "Account", "D1 Second Block", "beyondthehills.accounts@hotmail.com"
    );
INSERT INTO Department
  VALUES ("DP211", "Security", "D2 Second Block", "beyondthehills.securityserv@hotmail.com"
    );
INSERT INTO Department 
  VALUES ("DP210", "Information Technology", "E8 Third Block", "daddybernd.informationtech@hotmail.com"
    );

INSERT INTO BranchDepartment
  VALUES(1, "DP101"
    );
    
INSERT INTO BranchDepartment
  VALUES(2, "DP101"
    );
    
INSERT INTO BranchDepartment
  VALUES(3, "DP101"
    );
    
INSERT INTO BranchDepartment
  VALUES(4, "DP101"
    );
    
INSERT INTO BranchDepartment
  VALUES(5, "DP101"
    );

INSERT INTO BranchDepartment
  VALUES(5, "DP211"
    );

INSERT INTO BranchDepartment
  VALUES(2, "DP211"
    );

INSERT INTO BranchDepartment
  VALUES(3, "DP211"
    );
    

INSERT INTO BranchDepartment
  VALUES(4, "DP211"
    );
    
INSERT INTO BranchDepartment
  VALUES(1, "DP211"
    );
INSERT INTO BranchDepartment
  VALUES(1, "DP301"
    );
INSERT INTO BranchDepartment
  VALUES(2, "DP301"
    );
    
INSERT INTO BranchDepartment
  VALUES(3, "DP301"
    );
INSERT INTO BranchDepartment
  VALUES(4, "DP301"
    );
INSERT INTO BranchDepartment
  VALUES(5, "DP301"
    );
    
INSERT INTO BranchDepartment
  VALUES(1, "DP110"
    );
INSERT INTO BranchDepartment
  VALUES(2, "DP110"
    );
INSERT INTO BranchDepartment
  VALUES(3, "DP110"
    );
INSERT INTO BranchDepartment
  VALUES(4, "DP110"
    );
INSERT INTO BranchDepartment
  VALUES(5, "DP110"
    );
INSERT INTO BranchDepartment
  VALUES(3, "DP210"
    );
INSERT INTO BranchDepartment
  VALUES(1, "DP210"
    );
INSERT INTO BranchDepartment
  VALUES(2, "DP210"
    );
INSERT INTO BranchDepartment
  VALUES(4, "DP210"
    );
INSERT INTO BranchDepartment
  VALUES(5, "DP210"
    );

INSERT INTO RoomType
  VALUES("Single","A room assigned to one person. May have one or more beds.", 1000
    );
    

INSERT INTO RoomType
  VALUES("Double","A room assigned to two people. May have one or more beds.", 1850
    );
    
    
INSERT INTO RoomType
  VALUES("Triple","A room that can accommodate three persons and has been fitted with three twin beds, one double bed and one twin bed or two double beds.", 2600
    );
    
INSERT INTO RoomType
  VALUES("Queen","A room with a queen-sized bed. May be occupied by one or more people.", 3500
    );
    
INSERT INTO RoomType
  VALUES("King","A room with a king-sized bed. May be occupied by one or more.", 4000
    );
    
INSERT INTO RoomType
  VALUES("Studio","A room with a studio bed- a couch which can be converted into a bed. May also have an additional bed.", 3400
    );
    
    
    
INSERT INTO RoomType
  VALUES("Executive Suite","A parlour or living room connected with to one or more bedrooms.", 5000
    );
    
    
INSERT INTO RoomType
  VALUES("Cabana","A room having a private pool attached to the it.", 6000
    );
    
    
INSERT INTO RoomType
  VALUES("Junior Suite","A single room with a bed and sitting area.", 5500
    );
    
INSERT INTO RoomType
  VALUES("Connecting Room","Room with individual entrance doors from the outside and a connecting door between. Guests can move between rooms without going through the hallway.", 5500
    );

INSERT INTO Room (roomNumber, roomType, branchId)
  VALUES(111, "Single", 4
    );
    INSERT INTO Room (roomNumber, roomType, branchId)
  VALUES(216,"Single", 4
    );

INSERT INTO Room (roomNumber, roomType, branchId)
  VALUES(775, "Queen", 1
    );
    
INSERT INTO Room (roomNumber, roomType, branchId)
  VALUES(45, "Studio", 1
    );
    INSERT INTO Room (roomNumber, roomType, branchId)
  VALUES(99, "Studio", 1
    );
    INSERT INTO Room (roomNumber, roomType, branchId)
  VALUES(12, "Studio", 1
    );

INSERT INTO Room (roomNumber, roomType, branchId)
  VALUES(17, "Connecting Room", 2
    );
    
INSERT INTO Room (roomNumber, roomType, branchId)
  VALUES(8, "Junior Suite", 3
    );
    INSERT INTO Room (roomNumber, roomType, branchId)
  VALUES(16,"Junior Suite", 3
    );    
    
INSERT INTO Room (roomNumber, roomType, branchId)
  VALUES(5, "Double", 4
    );
    INSERT INTO Room (roomNumber, roomType, branchId)
  VALUES(7, "Double", 4
    );
    INSERT INTO Room (roomNumber, roomType, branchId)
  VALUES(28, "Double", 4
    );
    
INSERT INTO Room (roomNumber, roomType, branchId)
  VALUES(78, "Triple", 5
    );
    
INSERT INTO Room (roomNumber, roomType, branchId)
  VALUES(26, "Connecting Room", 2
    );
    
INSERT INTO Room (roomNumber, roomType, branchId)
  VALUES(80, "Junior Suite", 1
    );
    INSERT INTO Room (roomNumber, roomType, branchId)
  VALUES(95, "Junior Suite", 4
    );    
    
INSERT INTO Room (roomNumber, roomType, branchId)
  VALUES(76, "Double", 2
    );
    INSERT INTO Room (roomNumber, roomType, branchId)
  VALUES(33, "Double", 3
    );
    INSERT INTO Room (roomNumber, roomType, branchId)
  VALUES(125, "Double", 5
    );
    
INSERT INTO Room (roomNumber, roomType, branchId)
  VALUES(72, "Triple", 1
    );
    
    INSERT INTO Room (roomNumber, roomType, branchId)
  VALUES(29, "Double", 1
    );
    
    INSERT INTO Room (roomNumber, roomType, branchId)
  VALUES(50, "Junior Suite", 1
    );


INSERT INTO EmployeeRole 
  VALUES ("ER101", "General Manager" , "Oversees all aspects of hotel operations"
    );

INSERT INTO EmployeeRole 
  VALUES ("ER308", "Assistant General Manager", "Supports the general manager in all aspects of hotel operations"
    );

INSERT INTO EmployeeRole 
  VALUES ("ER110", "Security Personnel" , "Oversees the safety and security of the hotel and guests throughout operation hours"
    );

INSERT INTO EmployeeRole 
  VALUES ("ER211", "Concierge", "Attends to and answers guest inquiries regarding the city, events, and attractions"
    );

INSERT INTO EmployeeRole 
  VALUES ("ER217", "Front Office Manager", "Responsible for all duties of the front desk operation which includes: staff training, inter-department communications, and staff scheduling"
    );

INSERT INTO EmployeeRole
  VALUES ("ER30B", "Room Attendant", "Responsible for all cleanliness for all guests' rooms, hallways amd public areas at hotel" 
    );

INSERT INTO EmployeeRole 
  VALUES ("ER230C", "Bellman", "Responsible for transporting guests to and from the hotel to local area attractions as well as assisting guests with recommendations for restaurants and tourist activities"
    );
    
INSERT INTO EmployeeRole 
  VALUES ("ER100", "Executive House Keeper", "Responsible for all housekeeping operations and cleanliness levels of all areas on the property."
    );

INSERT INTO EmployeeRole 
  VALUES ("ER210", "House Person", "Responsible for maintaining the cleanliness and appearance of the hotel and providing customers with quality service in a timely and friendly manner"
    );

INSERT INTO EmployeeRole 
  VALUES ("ER300", "Continental Breakfast Attendant", "Responsible for setting up the daily complimentary continental breakfast"
  );

INSERT INTO EmployeeRole 
  VALUES ("ER1230", "Night Auditor", "Responsible for the front desk operation during the overnight shift"
    );
    


INSERT INTO Employee 
  VALUES (91725311, "ER101", 'M', 'Ryan', 'Dunn', 050198431, '1690 Florida A1A', 'ryan.dunn@ymail.com', 12
    );


INSERT INTO Employee 
  VALUES (510108291, "ER1230", 'F', 'Jesse', 'Bell', 0238101156, '700 Airport Hills Boulevard', 'jesse.bell@ymail.com', 5
    );
    
INSERT INTO Employee 
  VALUES (8290108, "ER210", 'M', 'Harrison', 'Brady', 050198431, '25 Strawberry Ln', 'brady.harrison03@hotmail.com', 10
    );
    
INSERT INTO Employee 
  VALUES (68022023, "ER30B", 'F', 'Kate', 'Bush', 054836219, '11 Hawkins Street', 'kate.bush@ymail.com', 12
    );
    
INSERT INTO Employee 
  VALUES (387901018, "ER300", 'M', 'Kofi', 'Owusu', 0244031455, '1860 Acewoord Drive', 'owusuk@gmail.com', 12
    );

INSERT INTO Employee 
  VALUES (3879122, "ER230C", 'M', 'Kwame', 'Thompson', 0266518991, '10 Pine Ave', 'thompsonk@gmail.com', 10
    );
    
INSERT INTO Employee 
  VALUES (11020201, "ER300", 'F', 'Ohemaa', 'Brown', 0244010123, '160 Bromley Street', 'brown.ohemaa@gmail.com', 12
    );
    
    
INSERT INTO Employee 
  VALUES (89929210, "ER308", 'F', 'Thelma', 'Quayson', 056700912, '22 Wood Street', 'thelma.quay@hotmail.com', 14
    );
    
    
INSERT INTO Employee 
  VALUES (79182012, "ER217", 'M', 'Bernd', 'Boadu', 059876543, '1 University Avenue', 'bernd.b@gmail.com', 10
    );
    
    
INSERT INTO Employee 
  VALUES (93021232, "ER101", 'M', 'John', 'Agyekum', 024718992, 'Bromley Junction', 'agyekum.j@icloud.com', 12
    );
    

INSERT INTO Services (serviceId, serviceName, startDate, endDate, amountCharged) 
  VALUES ("SS101", "Meal", "2022-01-02", "2022-01-02", 340.00
    );
    
INSERT INTO Meals (serviceId, food, numnberOfServings) 
  VALUES ("SS101", "Jollof", 3
    );
    
INSERT INTO BranchService
  VALUES(3, "SS101"
    );
    
INSERT INTO Guest (guestId,  firstName, lastName, gender, telephone, address, email) 
  VALUES (555692, "Vanessa", "Johnson", "F", 055123799, "50 Lawremce Road", "v.johnson@randatmail.com" 
    );




INSERT INTO Booking (bookingId, branchId, guestId, empId, roomNumber, bookingDate, bookingTime, arrivalDate, departureDate)
  VALUES (221106, 3, 555692, 91725311, 16, "2021-12-12", "19:30:20", "2022-01-01", "2022-02-27"
    );

INSERT INTO BranchServiceBooking
  VALUES(3, "SS101", 221106
    );
    
    
INSERT INTO Payment (invoiceNo, bookingId, paymentMethod, charge, additionalCharge, paymentDate) 
  VALUES (66482, 221106, "Bank", (select price
 from RoomType rt, Room r, Booking bk
 where rt.roomType = r.roomType and r.roomNumber = bk.roomNumber and bk.bookingId = bookingId
 ) *datediff((select departureDate from Booking bk where bk.bookingId = bookingId),
 (select arrivalDate from Booking bk where bk.bookingId = bookingId)), 
 15.00, "2022-02-27"
);




 
INSERT INTO Services (serviceId, serviceName, startDate, endDate, amountCharged) 
  VALUES ("SS103", "Laundry", "2022-05-15", "2022-05-15", 105.00
    );

INSERT INTO Laundry (serviceId, loadType, quantity) 
  VALUES ("SS103", "Mixed", 6
    );
    
INSERT INTO BranchService
  VALUES(4, "SS103"
    );

INSERT INTO Guest (guestId,  firstName, lastName, gender, telephone, address, email) 
  VALUES (712339,   "Henry", "Phillips", "M", 030631946, "19 Lakeshore Road", "h.phillips@randatmail.com" 
    );
    
INSERT INTO Booking (bookingId, branchId, guestId, empId, roomNumber, bookingDate, bookingTime, arrivalDate, departureDate)
  VALUES (930012, 4, 712339, 510108291, 5, "2022-04-12", "05:14:32", "2022-05-15", "2022-05-16"
    );
    

INSERT INTO BranchServiceBooking
  VALUES(4, "SS103", 930012
    );
    

INSERT INTO Payment (invoiceNo, bookingId, paymentMethod, charge, paymentDate) 
  VALUES (715679, 930012, "Mobile Money",(select price
 from RoomType rt, Room r, Booking bk
 where rt.roomType = r.roomType and r.roomNumber = bk.roomNumber and bk.bookingId = 930012)
 *(datediff((select departureDate from Booking bk where bk.bookingId = 930012),(select arrivalDate from Booking bk where bk.bookingId = 930012))), "2022-05-16"
    );
    
 
INSERT INTO Services (serviceId, serviceName, startDate, endDate, amountCharged) 
  VALUES ("SS104", "Meal", "2022-06-11", "2022-06-11", 204.00
    );
    
INSERT INTO Meals (serviceId, food, numnberOfServings) 
  VALUES ("SS104", "Fufu", 1
    );
    
INSERT INTO BranchService
  VALUES(3, "SS104"
    );
    
INSERT INTO Guest (guestId,  firstName, lastName, gender, telephone, address, email) 
  VALUES (18765,  "Clark", "Farrell", "M", 0244789002, "34 North Sheridan Road", "c.farrell@randatmail.com" 
    );
    
INSERT INTO Booking (bookingId, branchId, guestId, empId, roomNumber, bookingDate, bookingTime, arrivalDate, departureDate, checkInStatus)
  VALUES (72115, 3, 18765, 387901018, 8, "2022-04-21", "21:35:32", "2022-06-10", "2022-06-17", 1
    );

INSERT INTO BranchServiceBooking
  VALUES(3, "SS104", 72115
    );
    
INSERT INTO Payment (invoiceNo, bookingId, paymentMethod, charge, paymentDate) 
  VALUES (177990,72115, "Bank", (select price
 from RoomType rt, Room r, Booking bk
 where rt.roomType = r.roomType and r.roomNumber = bk.roomNumber and bk.bookingId = 72115)
 *(datediff((select departureDate from Booking bk where bk.bookingId = 72115),(select arrivalDate from Booking bk where bk.bookingId = 72115))), "2022-09-15"
    );

INSERT INTO Services (serviceId, serviceName, startDate, endDate, amountCharged) 
  VALUES ("SS105", "Laundry", "2022-12-25", "2022-12-27", 1320.00
    );
    
INSERT INTO Laundry (serviceId, loadType, quantity) 
  VALUES ("SS105", "Cotton", 2
    );

INSERT INTO BranchService
  VALUES(2, "SS105"
    );
    
INSERT INTO Guest (guestId,  firstName, lastName, gender, telephone, address, email) 
  VALUES (93021,  "Anna", "Nelson", "F", 0245791233, "73 Street", "a.nelson@randatmail.com"
    );
    
    
INSERT INTO Booking (bookingId, branchId, guestId, empId, roomNumber, bookingDate, bookingTime, arrivalDate, departureDate, specialRequests)
  VALUES (829133, 2, 93021, 387901018, 17, "2022-11-20", "19:25:32", "2022-12-20","2023-01-05", "Bubble bath"
    );
    
INSERT INTO BranchServiceBooking
  VALUES(2, "SS105", 829133
    );
    
INSERT INTO Payment (invoiceNo, bookingId, paymentMethod, charge, paymentDate) 
  VALUES (12891, 829133, "Mixed", (select price
 from RoomType rt, Room r, Booking bk
 where rt.roomType = r.roomType and r.roomNumber = bk.roomNumber and bk.bookingId = 829133)
 *(datediff((select departureDate from Booking bk where bk.bookingId = 829133),(select arrivalDate from Booking bk where bk.bookingId = 829133))), "2022-01-05"
    );



INSERT INTO Services (serviceId,serviceName, startDate, endDate, amountCharged) 
  VALUES ("SS067", "Meals and Laundry", "2022-03-15", "2022-03-20", 25.00
    );
    
INSERT INTO Meals (serviceId, food, numnberOfServings) 
  VALUES ("SS067", "Banku", 1
    );
    
INSERT INTO Laundry (serviceId, loadType, quantity) 
    VALUES ("SS067", "Silk", 3
        );
        
INSERT INTO BranchService
  VALUES(5, "SS067"
    );
    
INSERT INTO Guest (guestId,  firstName, lastName, gender, telephone, address, email) 
  VALUES (92001,   "Lily", "Howard", "F", 0558790233, "Sika Junction", "l.howard@randatmail.com" 
    );

    
INSERT INTO Booking (bookingId, branchId, guestId, empId, roomNumber, bookingDate, bookingTime, arrivalDate, departureDate, specialRequests, checkInStatus)
  VALUES (88192, 5, 92001, 8290108, 78, "2022-03-11", "20:55:32", "2022-03-12", "2022-04-01", "Flowers on the bed", 1
    );
    
INSERT INTO BranchServiceBooking
  VALUES(5, "SS067", 88192
    );

INSERT INTO Payment (invoiceNo, bookingId, paymentMethod, charge, paymentDate) 
  VALUES (78005, 88192, "Cash", (select price
 from RoomType rt, Room r, Booking bk
 where rt.roomType = r.roomType and r.roomNumber = bk.roomNumber and bk.bookingId = 88192)
 *(datediff((select departureDate from Booking bk where bk.bookingId = 88192),(select arrivalDate from Booking bk where bk.bookingId = 88192))), "2022-04-01"
    );
    


INSERT INTO Services (serviceId,serviceName, startDate, endDate, amountCharged) 
  VALUES ("SS019", "Meals and Laundry", "2022-01-02", "2022-01-05", 40.00
    );

INSERT INTO Meals (serviceId, food, numnberOfServings) 
  VALUES ("SS019", "Lasagna", 4
    );
    
INSERT INTO Laundry (serviceId, loadType, quantity) 
  VALUES ("SS019", "Polyester", 5
    );
    
INSERT INTO BranchService
  VALUES(1, "SS019"
    );
    
INSERT INTO Guest (guestId, firstName, lastName, gender, telephone, address, email) 
  VALUES (783929,   "Lydia", "Craig", "F", 050126790, "75 Buck Avenue", "l.craig@randatmail.com"
    );
    
INSERT INTO BranchServiceGuest
  VALUES(1, "SS019", 783929
    );
    

INSERT INTO Payment (invoiceNo, serviceId, paymentMethod, charge, paymentDate) 
  VALUES (949021, "SS019", "Bank", (select amountCharged from Services s
where s.serviceId = "SS019"), "2022-01-15"
    );

INSERT INTO Services (serviceId, serviceName, startDate, endDate, amountCharged) 
  VALUES ("SS023", "Meal", "2022-05-14", "2022-05-14", 30.00
    );
    
INSERT INTO Meals (serviceId, food, numnberOfServings) 
  VALUES ("SS023", "Fish and Chips", 4
    );
    
INSERT INTO BranchService
  VALUES(5, "SS023"
    );
    
INSERT INTO Guest (guestId, firstName, lastName, gender, telephone, address, email) 
  VALUES (81920,  "Penelope", "Ryan", "F", 0245123867, "20 University Avenue", "p.ryan@randatmail.com" 
    );
    
INSERT INTO Booking (bookingId, branchId, guestId, empId, roomNumber, bookingDate, bookingTime, arrivalDate, departureDate, specialRequests, checkInStatus)
  VALUES (775691, 5, 81920, 68022023, 125, "2022-04-22", "10:04:32", "2022-05-12", "2022-05-28", "Champagne", 1
    );
    
INSERT INTO BranchServiceBooking
  VALUES(5, "SS023", 775691
    );
    
INSERT INTO Payment (invoiceNo, bookingId, paymentMethod, charge, additionalCharge, paymentDate) 
  VALUES (87123, 775691, "Bank", (select price
 from RoomType rt, Room r, Booking bk
 where rt.roomType = r.roomType and r.roomNumber = bk.roomNumber and bk.bookingId = 775691)
 *(datediff((select departureDate from Booking bk where bk.bookingId = 775691),(select arrivalDate from Booking bk where bk.bookingId = 775691))), 15.00, "2022-05-28"
    );
    
    
    
INSERT INTO Services (serviceId, serviceName, startDate, endDate, amountCharged) 
  VALUES ("SS054", "Laundry", "2022-10-17", "2022-10-18", 25.00
    );
    
INSERT INTO Laundry (serviceId, loadType, quantity) 
  VALUES ("SS054", "Cotton", 2
    );
    
INSERT INTO BranchService
  VALUES(4, "SS054"
    );
    
INSERT INTO Guest (guestId, firstName, lastName, gender, telephone, address, email) 
  VALUES (1221092,  "Kellan", "Hall", "M", 024690875, "Kenilworth Lane", "k.hall@randatmail.com"
    );
    
    
INSERT INTO BranchServiceGuest
  VALUES(4, "SS054", 1221092
    );
    

    
INSERT INTO Payment (invoiceNo, serviceId, paymentMethod, charge, paymentDate) 
  VALUES (1925002, "SS054", "Mobile Money", (select amountCharged from Services s
where s.serviceId = "SS054"), "2022-12-24"
    );

INSERT INTO Services (serviceId, serviceName, startDate, endDate, amountCharged) 
  VALUES ("SS02", "Meals and Laundry", "2022-10-17", "2022-10-21", 25.00
    );
    
INSERT INTO Meals (serviceId, food, numnberOfServings) 
  VALUES ("SS02", "Fried Rice", 1
    );
    
INSERT INTO Laundry (serviceId, loadType, quantity) 
  VALUES ("SS02", "Cotton", 2
    );
    
INSERT INTO BranchService
  VALUES(2, "SS02"
    );
    
INSERT INTO Guest (guestId, firstName, lastName, gender, telephone, address, email) 
  VALUES (17753,   "Kelsey", "Clark", "F", 0267192345, "Kokrobite Avenue", "k.clark@randatmail.com"
    );
    
INSERT INTO BranchServiceGuest
  VALUES(2, "SS02", 17753
    );
    
    
INSERT INTO Payment (invoiceNo, serviceId, paymentMethod, charge, paymentDate) 
  VALUES (191912,"SS02", "Mixed", (select amountCharged from Services s
where s.serviceId = "SS02"), "2022-11-02"
    );
    
    

INSERT INTO Services (serviceId, serviceName, startDate, endDate, amountCharged) 
  VALUES ("SS078", "Meal", "2022-12-21", "2022-12-21", 25
    );
    
INSERT INTO Meals (serviceId, food, numnberOfServings) 
  VALUES ("SS078", "Waakye", 1
    );

INSERT INTO BranchService
  VALUES(1, "SS078"
    );
    
INSERT INTO Guest (guestId,  firstName, lastName, gender, telephone, address, email) 
  VALUES (881001,  "Daniel", "Barrett", "M", 054903217, "Boulder Ridge Junction", "d.barrett@randatmail.com" 
    );
    
INSERT INTO Booking (bookingId, branchId, guestId, empId, roomNumber, bookingDate, bookingTime, arrivalDate, departureDate, specialRequests, checkInStatus)
  VALUES (83921, 1, 881001, 68022023, 12, "2022-12-14", "09:25:32", "2022-12-18", "2023-02-02", "Champagne",1
    );
    
-- update all rooms that have been booked
update  Room r set  availability = 0 where roomNumber in (select roomNumber from Booking bk  where bk.roomNumber = r.roomNumber) ;

INSERT INTO BranchServiceBooking
  VALUES(1, "SS078", 83921
    );
    
INSERT INTO Payment (invoiceNo, bookingId, paymentMethod, charge, paymentDate) 
  VALUES (023302, 83921, "Cash", (select price
 from RoomType rt, Room r, Booking bk
 where rt.roomType = r.roomType and r.roomNumber = bk.roomNumber and bk.bookingId = 83921)
 *(datediff((select departureDate from Booking bk where bk.bookingId = 83921),(select arrivalDate from Booking bk where bk.bookingId = 83921))), "2022-02-02"
    );
    
    
INSERT INTO FullTime (empId, salary)
  VALUES(8290108,10000
    );
    
INSERT INTO FullTime (empId, salary)
  VALUES(68022023,8000
    );
    
    
INSERT INTO FullTime (empId, salary)
  VALUES(91725311,11500
    );
    
INSERT INTO FullTime (empId, salary)
  VALUES(93021232, 7500
    );


INSERT INTO PartTime 
  VALUES(3879122, 3, 50
    );
INSERT INTO PartTime 
  VALUES(11020201, 4, 50
    );
INSERT INTO PartTime
  VALUES(89929210, 2, 30
    );
    

INSERT INTO Contract
  VALUES(387901018,"2022-01-15","2023-02-01", 8500
    );
    
INSERT INTO Contract
  VALUES(510108291,"2021-08-17", "2022-12-16", 10000
    );
    
INSERT INTO Contract
  VALUES(79182012, "2022-05-31", "2022-08-01", 1000
    );
   
-- -------------------- QUERIES -----------------------------------
-- Track room availability

select roomType, count(roomType) as NumberOfAvailableRooms
	from Room
    where availability = 1
    group by roomType;

-- keep track of which employees made which bookings

SELECT bookingId, e.empId, firstName, lastName, bookingDate, bookingTime 
from Employee e
 inner join  Booking bk  on 
 e.empId = bk.empId ;
 

-- Get information on current reservations

SELECT monthname(BookingDate) as Months , count(RoomNumber) as Number_of_Rooms
from Booking 
group by month(BookingDate)
order by month(BookingDate);

-- Keep tracks of services 
select  serviceName, startDate, endDate, amountCharged 
From Guest g
inner join Booking bk on
	g.guestId = bk.guestId
join branchservicebooking bsb on 
    bsb.bookingId = bk.bookingId 
join services s on 
    s.serviceId = bsb.serviceId
    union
select serviceName, startDate, endDate,amountCharged 
From Guest g
 join branchserviceguest bsg on
	bsg.guestId = g.guestId
    join services s on 
    s.serviceId = bsg.serviceId
group by serviceName
order by serviceName;


-- generate overnight hotel guest bill (look at the employee role)
select   g.guestid,  firstName, lastName, bk.bookingId,bookingDate, arrivalDate, roomNumber,
		departureDate, empId, charge, additionalCharge, s.serviceName, amountCharged
from Guest g
	inner join Booking bk on
	g.guestId = bk.guestId
    join payment p on 
    p.bookingId = bk.bookingId
    join branchservicebooking bsb on 
    bsb.bookingId = bk.bookingId
    join services s on 
    s.serviceId = bsb.serviceId
order by firstName;


-- generate walk in guest bill

select  distinct g.guestid, firstName, lastName, s.serviceId, serviceName, startDate, endDate, amountCharged 
from Guest g
	join BranchServiceGuest bsg on
    g.guestId = bsg.guestId
    join Services s on 
    bsg.serviceId = s.ServiceId
   
order by firstName;

-- generate monthly report
--  Summary reports per month for walk in guests
select  monthname(paymentDate) as MonthOfYear, count(bg.guestId) as numberOfGuests, sum(Charge) as serviceCharge
from Payment p
join BranchServiceGuest bg on p.serviceId=bg.serviceId
join Services s on p.serviceId = s.serviceId
group by month(paymentDate)
order by month(paymentDate);

-- Summary reports for the month for stay in guests
select  monthname(paymentDate) as MonthOfYear, count(bk.guestId) as numberOfGuests, sum(charge) as roomCharge, sum(additionalCharge) as additionalCharges, sum(amountCharged) as serviceCharge
from Payment p
join Booking bk on p.bookingId = bk.bookingId
join branchservicebooking bsb on bsb.bookingId = bk.bookingId
join services s on s.serviceId = bsb.serviceId

group by month(paymentDate)
order by month(paymentDate);


