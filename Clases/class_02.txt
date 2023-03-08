/* Create database */
drop database if exists imdb;
create database imdb;
use imdb;

/* Create tables */
drop table if exists Films;
create table Films(
	id int primary key auto_increment,
	title varchar(50),
	description varchar(100),
	release_year datetime
	);
describe Films;

drop table if exists Actors;
create table Actors(
	id int primary key auto_increment,
	first_name varchar(30),
	last_name varchar(30)
	);
describe Actors;

drop table if exists Film_Actor;
create table Film_Actor(
	id int primary key auto_increment,
	id_film int,
	id_actor int
	);
describe Film_Actor;

/* Add FKs */
alter table Film_actor add
	constraint id_film
	foreign key (id_film)
	references Films(id);
alter table Film_actor add
	constraint id_actor
	foreign key (id_actor)
	references Actors(id);
describe Film_Actor;

/* Add new column */
alter table Films add
	last_update datetime;
describe Films;

alter table Actors add
	last_update datetime;
describe Actors;

/* Inserts and Selects */
Insert into Films(title, description, release_year)
Values("Back to the Future", "A time machine transports a teenager to the 1950s, when his parents were still in high school", "1985-12-26");
Insert into Films(title, description, release_year)
Values("Back to the Future II", "A teen and an inventor travel to the past and future to alter a series of events", "1989-12-28");
Select *
From Films;

Insert into Actors(first_name, last_name)
Values("Michael Andrew", "Fox");
Insert into Actors(first_name, last_name)
Values("Christopher", "Lloyd");
Select *
From Actors;

Insert into Film_Actor(id_film, id_actor)
Values(1, 1);
Insert into Film_Actor(id_film, id_actor)
Values(1, 2);
Insert into Film_Actor(id_film, id_actor)
Values(2, 1);
Insert into Film_Actor(id_film, id_actor)
Values(2, 2);
Select *
From Film_Actor;
