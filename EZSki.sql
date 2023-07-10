
create table skiuser (
	id    varchar(20) not null primary key,
	pwd   varchar(20) not null,
	name  varchar(20) not null,
	sex    varchar(3) ,         
	birth   varchar(20) not null,
	tel     varchar(20) not null,
	city    varchar(10) ,     
	email  varchar(20) not null,    
	utype  char(1) default '1' , 
	edate  date not null         
);



select * from SkiUser;
---------------------------------------------------------------------------------------------------------------------------------------

create sequence SkiReview_seq
	increment by 1
	start with 1
	minvalue 1
	maxvalue 1000
	nocycle
	nocache
	noorder;

create sequence numb_seq	
	increment by 1	
	start with 1
	minvalue 1
	maxvalue 1000
	nocycle
	nocache	
	noorder;


---------------------------------------------------------------------------------------------------------------------------------------

create table SkiReview (
	NUMB number primary key ,
	TITLE varchar2(200) not null,
	WRITER varchar2(20) not null,
	WDATE DATE not null,
	DETAILS varchar2(500) not null,
	REF number,
	REF_STEP number,
	REF_LEVEL number
);

select * from SkiReview;

---------------------------------------------------------------------------------------------------------------------------------------

create table skinotice (
    numb number not null primary key,
    cat varchar2(15) not null,
    title varchar2(30) not null,
    details varchar2(500) not null,
    wdate date not null,
    views number
);

select * from SkiNotice;

---------------------------------------------------------------------------------------------------------------------------------------

create table skibooking (
    id varchar2(30) not null,
    bdate varchar2(20) not null,
    bcheck varchar2(3) not null,
    rdate  varchar2(30) not null,
    
    primary key(id, bdate)
);


select * from SkiBooking;

---------------------------------------------------------------------------------------------------------------------------------------



drop table SkiUser;
drop table SkiReview;
drop table SkiBooking;
drop table SkiNotice;



commit;