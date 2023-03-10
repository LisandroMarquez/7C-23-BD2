/* Create database */
drop database if exists class03;
create database class03;
use class03;

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
	address_id2 int,
	picture varchar(50),
	email varchar(60),
	store_id int,
	active bool,
	username varchar(30),
	password varchar(30),
	last_update datetime,
	constraint address_id2 foreign key (address_id2) references address(id),
	constraint store_id foreign key (store_id) references store(id));
describe staff;

create table customer(
	id int primary key auto_increment,
	store_id2 int,
	first_name varchar(40),
	last_name varchar(40),
	email varchar(60),
	address_id3 int,
	active bool,
	create_date datetime,
	last_update datetime,
	constraint address_id3 foreign key (address_id3) references address(id),
	constraint store_id2 foreign key (store_id2) references store(id));
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
	store_id3 int,
	last_update datetime,
	constraint film_id foreign key (film_id) references film(id),
	constraint store_id3 foreign key (store_id3) references store(id));
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
	customer_id2 int,
	staff_id2 int,
	rental_id int,
	amount float,
	payment_date datetime,
	last_update datetime,
	constraint rental_id foreign key (rental_id) references rental(id),
	constraint customer_id2 foreign key (customer_id2) references customer(id),
	constraint staff_id2 foreign key (staff_id2) references staff(id));
describe rental;

create table category(
	id int primary key auto_increment,
	name varchar(30),
	last_update datetime);
describe category;

create table film_category(
	id int primary key auto_increment,
	film_id2 int,
	category_id int,
	last_update datetime,
	constraint film_id2 foreign key (film_id2) references film(id),
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
	film_id3 int,
	actor_id int,
	last_update datetime,
	constraint film_id3 foreign key (film_id3) references film(id),
	constraint actor_id foreign key (actor_id) references actor(id));
describe film_actor;