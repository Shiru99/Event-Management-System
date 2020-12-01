DROP TABLE appoint;
DROP TABLE invigilator;
DROP TABLE invite;
DROP TABLE guest;
DROP TABLE gives;
DROP TABLE sponsor;
DROP TABLE admino;
DROP TABLE group_participant;
DROP TABLE individual_participant;
DROP TABLE participant;
DROP TABLE has;
DROP TABLE evento;
DROP TABLE fest;

create table fest
	(	fest_id			varchar(20),
		fest_name		varchar(60),
		college_name	varchar(60),
		start_date		DATE,
		duration		varchar(20),
		primary key (fest_id)
	);

create table evento
	(	event_id					varchar(20),
		event_name					varchar(60),
		start_date_time				TIMESTAMP,
		end_date_time				TIMESTAMP,
		register_start_date_time	TIMESTAMP,
		register_end_date_time		TIMESTAMP,
		place						varchar(60),
		short_description			varchar(60),
		description					varchar(900),
		participant_limit			int,
		price 						VARCHAR(60),
		primary key (event_id)
	);

create table has
	(	event_id		varchar(20),
		fest_id			varchar(20),
		primary key (fest_id,event_id),
		foreign key (event_id) references evento on delete cascade,
		foreign key (fest_id) references fest on delete cascade
	);

create table participant
	(	participant_id		varchar(20),
		participant_name	varchar(60),
		participant_cno		VARCHAR(10),
		participant_email	varchar(50),
		primary key (participant_id)
	);

create table individual_participant
	(	participant_id		varchar(20),
		event_id			varchar(20),
		score				int,
		review 				varchar(30),
		primary key (participant_id,event_id),
		foreign key (participant_id) references participant on delete cascade,
		foreign key (event_id) references evento on delete cascade
	);

create table group_participant
	(	participant_id		varchar(20),
		event_id			varchar(20),
		score				int,
		group_id			varchar(20),
		group_name			varchar(60),
		review				varchar(30),
		primary key (participant_id,event_id,group_id),
		foreign key (participant_id) references participant on delete cascade,
		foreign key (event_id) references evento on delete cascade
	);

create table admino
	(	admin_id		varchar(20),
		admin_name		varchar(60),
		admin_cno		VARCHAR(10),
		admin_email		varchar(50),
		primary key (admin_id)
	);

create table sponsor
	(	sponsor_id		varchar(20),
		sponsor_name	varchar(60),
		sponsor_cno		VARCHAR(10),
		sponsor_category varchar(60),
		sponsor_link	varchar(100),
		primary key (sponsor_id)
	);

create table gives
	(	sponsor_id		varchar(20),
		event_id		varchar(20),
		amount			VARCHAR(10),
		primary key (sponsor_id,event_id),
		foreign key (sponsor_id) references sponsor on delete cascade,
		foreign key (event_id) references evento on delete cascade
	);

create table guest
	(	guest_id		varchar(20),
		guest_name		varchar(60),
		descriptiono		varchar(600),
		guest_cno		VARCHAR(10),
		guest_email		varchar(50),
		primary key (guest_id)
	);

create table invite
	(	guest_id		varchar(20),
		event_id		varchar(20),
		primary key (guest_id,event_id),
		foreign key (guest_id) references guest on delete cascade,
		foreign key (event_id) references evento on delete cascade
	);

create table invigilator
	(	invigilator_id			varchar(20),
		invigilator_name		varchar(60),
		descriptiono			varchar(600),
		invigilator_cno			VARCHAR(10),
		invigilator_email		varchar(50),
		primary key (invigilator_id)
	);

create table appoint
	(	invigilator_id		varchar(20),
		event_id			varchar(20),
		primary key (invigilator_id,event_id),
		foreign key (invigilator_id) references invigilator on delete cascade,
		foreign key (event_id) references evento on delete cascade
	);
