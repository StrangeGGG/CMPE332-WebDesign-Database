drop database if exists restaurantDB;
create database restaurantDB;

create table restaurant(
	name varchar(50) not null,
	URL varchar(50) not null,
	street varchar(50),
	city varchar(50),
	pc char(6),
	primary key(name, URL));
	
create table orderfood(
	ID integer primary key not null,
	item varchar(50),
	price float,
	deliveryID integer,
	deliverytime varchar(50),
	OrderPlaseTime varchar(50),
	tip integer,
	orderdate date);

create table customer(
	email varchar(50) primary key not null,
	firstName varchar(50),
	lastName varchar(50),
	street varchar(50),
	city varchar(50),
	pc char(6),
	phone char(10));
	
create table management(
	ID integer primary key not null,
	name varchar(50),
	email varchar(50));
	
create table delivery(
	ID integer primary key not null,
	name varchar(50),
	email varchar(50));
	
create table chef(
	ID integer primary key not null,
	name varchar(50),
	email varchar(50));
	
create table servers(
	ID integer primary key not null,
	name varchar(50),
	email varchar(50));
	

create table ManagementSchedule(
	listofdays varchar(50),
	starttime varchar(50),
	endtime varchar(50),
	managementID integer not null,
	primary key(managementID, listofdays),
	foreign key(managementID) references management(ID) on delete cascade);
	
create table DeliverySchedule(
	listofdays varchar(50),
	starttime varchar(50),
	endtime varchar(50),
	deliveryID integer not null,
    itemsID integer,
	primary key(deliveryID, listofdays, itemsID),
	foreign key(deliveryID) references delivery(ID) on delete cascade,
	foreign key(itemsID) references orderfood(ID) on delete cascade);
	
create table ChefSchedule(
	listofdays varchar(50),
	starttime varchar(50),
	endtime varchar(50),
	chefID integer not null,
	primary key(chefID, listofdays),
	foreign key(chefID) references chef(ID) on delete cascade);
	
create table ServerSchedule(
	listofdays varchar(50),
	starttime varchar(50),
	endtime varchar(50),
	serverID integer not null,
	primary key(serverID, listofdays),
	foreign key(serverID) references servers(ID) on delete cascade);

create table employee(
	ID integer primary key not null,
	name varchar(50),
	email varchar(50));
	
create table schedule(
	listofdays varchar(50),
	starttime varchar(50),
	endtime varchar(50),
	sID integer not null,
	primary key(sID, listofdays),
	foreign key(sID) references employee(ID) on delete cascade);
	
create table account(
	paymentdate varchar(50),
	amountcredit float,
	CustomerEmail varchar(50) not null,
	primary key(CustomerEmail),
	foreign key(CustomerEmail) references customer(email) on delete cascade);
	
create table CustomerPlaseOrderFromRestaurant(
	orderID integer not null,
	CustomerEmail varchar(50) not null,
	RestaurantName varchar(50) not null,
	RestaurantURL varchar(50) not null,
	primary key(orderID, CustomerEmail, RestaurantName, RestaurantURL),
	foreign key(orderID) references orderfood(ID) on delete cascade,
	foreign key(CustomerEmail) references customer(email) on delete cascade,
	foreign key(RestaurantName, RestaurantURL) references restaurant(name, URL) on delete cascade);
	
create table CustomerEmployeeRelationship(
	CustomerEmail varchar(50) not null,
	managementID integer not null,
	deliveryID integer not null,
	chefID integer not null,
	serverID integer not null,
	primary key(CustomerEmail, managementID, deliveryID, chefID, serverID),
	foreign key(CustomerEmail) references customer(email) on delete cascade,
	foreign key(managementID) references management(ID) on delete cascade,
	foreign key(deliveryID) references delivery(ID) on delete cascade,
	foreign key(chefID) references chef(ID) on delete cascade,
	foreign key(serverID) references servers(ID) on delete cascade);
	
create table EmployeeWorkinRestaurant(
	RestaurantName varchar(50) not null,
	RestaurantURL varchar(50) not null,
	foreign key(RestaurantName, RestaurantURL) references restaurant(name, URL) on delete cascade);
    
create table company(
	RestaurantName varchar(50) not null,
	RestaurantURL varchar(50) not null,
	foreign key(RestaurantName, RestaurantURL) references restaurant(name, URL) on delete cascade);
	
create table onlinemenu(
	RestaurantName varchar(50) not null,
	RestaurantURL varchar(50) not null,
	foreign key(RestaurantName, RestaurantURL) references restaurant(name, URL) on delete cascade);
	
create table credentials(
	chefID integer not null,
	credentials varchar(50) not null,
	primary key(chefID, credentials),
	foreign key(chefID) references chef(ID) on delete cascade);

create table food(
	name varchar(50),
	food varchar(50) not null,
	primary key(food));

create table price(
	price varchar(50) not null,
	primary key(price));
	