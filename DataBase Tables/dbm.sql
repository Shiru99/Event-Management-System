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
	(	fest_id			varchar(8),
		fest_name		varchar(20),
		college_name	varchar(20),
		start_date		DATE,
		duration		varchar(8),
		primary key (fest_id)
	);

create table evento
	(	event_id					varchar(8),
		event_name					varchar(20),
		start_date_time				TIMESTAMP,
		end_date_time				TIMESTAMP,
		register_start_date_time	TIMESTAMP,
		register_end_start_time		TIMESTAMP,
		place						varchar(20),
		description					varchar(300),
		primary key (event_id)
	);

create table has
	(	event_id		varchar(8),
		fest_id			varchar(8),
		primary key (fest_id,event_id),
		foreign key (event_id) references evento on delete cascade,
		foreign key (fest_id) references fest on delete cascade
	);

create table participant
	(	participant_id		varchar(8),
		participant_name	varchar(20),
		participant_cno		numeric(10),
		participant_email	varchar(50),
		primary key (participant_id)
	);

create table individual_participant
	(	participant_id		varchar(8),
		event_id			varchar(8),
		score				numeric(10,3),
		review 				varchar(30),
		primary key (participant_id,event_id),
		foreign key (participant_id) references participant on delete cascade,
		foreign key (event_id) references evento on delete cascade
	);

create table group_participant
	(	participant_id		varchar(8),
		event_id			varchar(8),
		score				numeric(10,3),
		group_id			varchar(8),
		group_name			varchar(20),
		review				varchar(30),
		primary key (participant_id,event_id,group_id),
		foreign key (participant_id) references participant on delete cascade,
		foreign key (event_id) references evento on delete cascade
	);

create table admino
	(	admin_id		varchar(8),
		admin_name		varchar(20),
		admin_cno		numeric(10),
		admin_email		varchar(50),
		passwor		varchar(50),
		primary key (admin_id)
	);

create table sponsor
	(	sponsor_id		varchar(8),
		sponsor_name	varchar(20),
		sponsor_cno		numeric(10),
		sponsor_link	varchar(100),
		primary key (sponsor_id)
	);

create table gives
	(	sponsor_id		varchar(8),
		event_id		varchar(8),
		amount			numeric(10,2),
		primary key (sponsor_id,event_id),
		foreign key (sponsor_id) references sponsor on delete cascade,
		foreign key (event_id) references evento on delete cascade
	);

create table guest
	(	guest_id		varchar(8),
		guest_name		varchar(20),
		descriptiono		varchar(300),
		guest_cno		numeric(10),
		guest_email		varchar(50),
		primary key (guest_id)
	);

create table invite
	(	guest_id		varchar(8),
		event_id		varchar(8),
		primary key (guest_id,event_id),
		foreign key (guest_id) references guest on delete cascade,
		foreign key (event_id) references evento on delete cascade
	);