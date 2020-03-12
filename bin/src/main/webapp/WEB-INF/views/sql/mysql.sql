CREATE TABLE BASKET(
	PID INT NOT NULL, 
	IDX INT NOT NULL,
	primary key(pid)
);

create table stud_score (

student_id int,

math_score int,

eng_score int,

phil_score int,

music_score int);



insert into stud_score values 

(123511,89,78,45,90),

(255475,88,90,null,87),

(9921100,87,null, null, 98),

(9732453,69,98,78,78),

(578981,59,90,89,null),

(768789,94,80,87,99),

(565789,58,64,72,null);


select * from stud_score;
