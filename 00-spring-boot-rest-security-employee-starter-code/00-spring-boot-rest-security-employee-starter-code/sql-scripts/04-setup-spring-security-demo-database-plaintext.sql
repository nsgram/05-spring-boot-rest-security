create table users(
	username varchar(50) not null primary key,
	password varchar(50) not null,
	enabled boolean not null
);

create table authorities (
	username varchar(50) not null,
	authority varchar(50) not null,
	constraint fk_authorities_users foreign key(username) references users(username)
);

create unique index ix_auth_username on authorities (username,authority);

insert into users VALUES('john','{noop}test123',TRUE);
insert into users VALUES('marry','{noop}test123',TRUE);
insert into users VALUES('susan','{noop}test123',TRUE);

insert into authorities VALUES('john','ROLE_EMPLOYEE');
insert into authorities VALUES('marry','ROLE_EMPLOYEE');
insert into authorities VALUES('marry','ROLE_MANAGER');
insert into authorities VALUES('susan','ROLE_EMPLOYEE');
insert into authorities VALUES('susan','ROLE_MANAGER');
insert into authorities VALUES('susan','ROLE_ADMIN');


SELECT *FROM authorities

