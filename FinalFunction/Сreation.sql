create table department (
id integer primary key,
name varchar
);

insert into department values
('1', 'Therapy'),
('2', 'Neurology'),
('3', 'Cardiology'),
('4', 'Gastroenterology'),
('5', 'Hematology'),
('6', 'Oncology'),
('7', 'Cleaning');

create table employee (
id integer primary key,
department_id integer,
chief_doc_id integer,
name varchar,
num_public integer
);

insert into employee values
('1', '1', '1', 'Kate', 4),
('2', '1', '1', 'Lidia', 2),
('3', '1', '1', 'Alexey', 1),
('4', '1', '2', 'Pier', 7),
('5', '1', '2', 'Aurel', 6),
('6', '1', '2', 'Klaudia', 1),
('7', '2', '3', 'Klaus', 12),
('8', '2', '3', 'Maria', 11),
('9', '2', '4', 'Kate', 10),
('10', '3', '5', 'Peter', 8),
('11', '3', '5', 'Sergey', 9),
('12', '3', '6', 'Olga', 12),
('13', '3', '6', 'Maria', 14),
('14', '4', '7', 'Irina', 2),
('15', '4', '7', 'Grit', 10),
('16', '4', '7', 'Vanessa', 16),
('17', '5', '8', 'Sascha', 21),
('18', '5', '8', 'Ben', 22),
('19', '6', '9', 'Jessy', 19),
('20', '6', '9', 'Ann', 18);

create table chief (
id integer primary key,
department_id integer,
name varchar,
experience integer);

insert into chief values
(1, 1, 'John "J.D." Dorian', 9),
(2, 1, 'Christopher Turk', 9),
(3, 2, 'Elliot Reid', 8),
(4, 2, 'Carla Espinosa-Turk', 8),
(5, 3, 'Percival "Perry" Cox', 9),
(6, 3, 'Robert "Bob" Kelso', 8),
(7, 4, 'Denise Mahoney', 1),
(8, 5, 'Lucy Bennett', 1),
(9, 6, 'Drew Suffin', 1),
(10, 7, '"Janitor"', 7);

create table mark (
university_id integer primary key,
employee_id integer,
average_mark numeric);

insert into mark values
(1, 6, 3.1),
(2, 18, 3.7),
(3, 3, 3.1),
(4, 16, 5),
(5, 13, 4.2),
(6, 17, 4),
(7, 8, 4),
(8, 20, 4),
(9, 14, 3.1),
(10, 2, 3.3),
(11, 19, 5),
(12, 1, 3.4),
(13, 15, 4.8),
(14, 5, 3.6),
(15, 11, 3.1),
(16, 12, 5),
(17, 4, 4.3),
(18, 10, 3.3),
(19, 7, 5),
(20, 9, 5);
