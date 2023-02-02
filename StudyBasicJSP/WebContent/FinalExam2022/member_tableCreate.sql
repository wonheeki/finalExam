drop table pj_member;

create table pj_member
(
  userId varchar(50) not null primary key,
  userPw varchar(60) not null,
  userName varchar(10) not null,
  userEmail varchar(30) not null,
  userTel varchar(20) not null,
  reg_date datetime not null
)

select * from pj_member

desc pj_member 