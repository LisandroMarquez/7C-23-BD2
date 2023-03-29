-- Create database
drop database if exists class03;
create database class03;
use class03;

-- TABLES
create table country(
	id int primary key auto_increment,
	country varchar(40),
	last_update datetime);
describe country;

create table city(
	id int primary key auto_increment,
	city varchar(40),
	country_id int,
	last_update datetime,
	constraint country_id foreign key (country_id) references country(id));
describe city;

create table address(
	id int primary key auto_increment,
	address varchar(60),
	address2 varchar(60),
	district varchar(60),
	city_id int,
	postal_code varchar(6),
	phone varchar(20),
	location varchar(50),
	last_update datetime,
	constraint city_id foreign key (city_id) references city(id));
describe address;

create table store(
	id int primary key auto_increment,
	manager_staff_id int,
	address_id int,
	last_update datetime,
	constraint address_id foreign key (address_id) references address(id));
describe store;

create table staff(
	id int primary key auto_increment,
	first_name varchar(40),
	last_name varchar(40),
	address_id int,
	picture varchar(50),
	email varchar(60),
	store_id int,
	active bool,
	username varchar(30),
	password varchar(30),
	last_update datetime,
	constraint address_id2 foreign key (address_id) references address(id),
	constraint store_id foreign key (store_id) references store(id));
describe staff;

create table customer(
	id int primary key auto_increment,
	store_id int,
	first_name varchar(40),
	last_name varchar(40),
	email varchar(60),
	address_id int,
	active bool,
	create_date datetime,
	last_update datetime,
	constraint address_id3 foreign key (address_id) references address(id),
	constraint store_id2 foreign key (store_id) references store(id));
describe customer;

create table language(
	id int primary key auto_increment,
	name varchar(30),
	last_update datetime);
describe language;

create table film(
	id int primary key auto_increment,
	title varchar(50),
	description varchar(150),
	release_year date,
	language_id int,
	original_language_id int,
	rental_duration int,
	rental_rate tinyint,
	length int,
	replacement_cost float,
	rating varchar(20),
	special_features varchar(50),
	last_update datetime,
	constraint language_id foreign key (language_id) references language(id),
	constraint original_language_id foreign key (original_language_id) references language(id));
describe film;

create table inventory(
	id int primary key auto_increment,
	film_id int,
	store_id int,
	last_update datetime,
	constraint film_id foreign key (film_id) references film(id),
	constraint store_id3 foreign key (store_id) references store(id));
describe inventory;

create table rental(
	id int primary key auto_increment,
	rental_date date,
	inventory_id int,
	customer_id int,
	return_date date,
	staff_id int,
	last_update datetime,
	constraint inventory_id foreign key (inventory_id) references inventory(id),
	constraint customer_id foreign key (customer_id) references customer(id),
	constraint staff_id foreign key (staff_id) references staff(id));
describe rental;

create table payment(
	id int primary key auto_increment,
	customer_id int,
	staff_id int,
	rental_id int,
	amount float,
	payment_date datetime,
	last_update datetime,
	constraint rental_id foreign key (rental_id) references rental(id),
	constraint customer_id2 foreign key (customer_id) references customer(id),
	constraint staff_id2 foreign key (staff_id) references staff(id));
describe rental;

create table category(
	id int primary key auto_increment,
	name varchar(30),
	last_update datetime);
describe category;

create table film_category(
	id int primary key auto_increment,
	film_id int,
	category_id int,
	last_update datetime,
	constraint film_id2 foreign key (film_id) references film(id),
	constraint category_id foreign key (category_id) references category(id));
describe film_category;

create table actor(
	id int primary key auto_increment,
	first_name varchar(40),
	last_name varchar(40),
	last_update datetime);
describe actor;

create table film_actor(
	id int primary key auto_increment,
	film_id int,
	actor_id int,
	last_update datetime,
	constraint film_id3 foreign key (film_id) references film(id),
	constraint actor_id foreign key (actor_id) references actor(id));
describe film_actor;

-- INSERTS
insert into country (country, last_update) values
('Estados Unidos', now()),
('Canadá', now()),
('México', now());

insert into city (city, country_id, last_update) values
('Nueva York', 1, now()),
('Toronto', 2, now()),
('Ciudad de México', 3, now());

insert into address (address, district, city_id, postal_code, phone, location, last_update) values
('123 Main St', 'Centro', 1, '1001', '555-1234', '123.456, -789.012', now()),
('456 Yonge St', 'Centro', 2, 'M4Y1', '555-5678', '456.789, -123.456', now()),
('789 Reforma', 'Centro', 3, '6000', '555-9012', '789.012, -345.678', now());

insert into store (manager_staff_id, address_id, last_update) values
(1, 1, now()),
(2, 2, now());

insert into staff (first_name, last_name, address_id, picture, email, store_id, active, username, password, last_update) values
('John', 'Doe', 1, 'john.jpg', 'john.doe@example.com', 1, true, 'johndoe', 'password', now()),
('Jane', 'Smith', 2, 'jane.jpg', 'jane.smith@example.com', 2, true, 'janesmith', 'password', now());

insert into customer (store_id2, first_name, last_name, email, address_id, active, create_date, last_update) values
(1, 'Bob', 'Johnson', 'bob.johnson@example.com', 3, true, now(), now()),
(2, 'Alice', 'Williams', 'alice.williams@example.com', 1, true, now(), now());

insert into language (name, last_update) values
('Inglés', now()),
('Francés', now()),
('Español', now());

insert into film (title, description, release_year, language_id, original_language_id, rental_duration, rental_rate, length, replacement_cost, rating, special_features, last_update) values
('Titanic', 'Una historia de amor en el Titanic', '1997-12-19', 1, null, 3, 4, 194, 19.99, 'PG-13', 'Comentarios', now()),
('La Bella y la Bestia', 'Un cuento de hadas de amor verdadero', '1991-11-22', 2, null, 5, 3, 90, 14.99, 'G', 'Comentarios', now()),
('El Mariachi', 'Un músico solitario busca venganza en una ciudad fronteriza', '1992-09-04', 3, null, 7, 2, 81, 9.99, 'R', 'Comentarios', now());

INSERT INTO inventory (film_id, store_id, last_update) VALUES
(1, 1, NOW()),
(2, 2, NOW()),
(3, 1, NOW());

INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id, last_update) VALUES
('2022-01-01', 1, 1, 1, NOW()),
('2022-02-01', 2, 2, 2, NOW());

INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date, last_update) VALUES
(1, 1, 1, 4.99, '2022-01-02', NOW()),
(2, 2, 2, 3.99, '2022-02-02', NOW());

INSERT INTO category (name, last_update) VALUES
('Comedy', NOW()),
('Drama', NOW()),
('Action', NOW()),
('Sci-Fi', NOW());

INSERT INTO film_category (film_id, category_id, last_update) VALUES
(1, 1, NOW()),
(2, 2, NOW()),
(3, 3, NOW());

INSERT INTO actor (first_name, last_name, last_update) VALUES
('Johnny', 'Depp', NOW()),
('Tom', 'Hanks', NOW()),
('Meryl', 'Streep', NOW()),
('Johnny', 'Null', NOW());

INSERT INTO film_actor (film_id, actor_id, last_update) VALUES
(1, 1, NOW()),
(2, 2, NOW()),
(3, 3, NOW());