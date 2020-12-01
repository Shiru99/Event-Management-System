/*    For Fest       */
INSERT INTO fest VALUES ('202023','PARSEC','IIT Dharwad','2020-01-23','3 days');
INSERT INTO fest VALUES ('202001','Mood Indigo','IIT Bombay','2020-01-02','7 days');
INSERT INTO fest VALUES ('202003','Madras Fest','IIT Madras','2020-03-10','2 days');

/*      For Event       */
INSERT INTO evento VALUES ('20202301','DevHack 2.0 - Software','2020-01-23 09:00:00','2020-01-24 21:00:00','2020-01-01 00:00:00','2020-01-23 09:00:00','Academic Building - Room no. 23','Hackathon','Do you have what it takes to code sleeplessly for 36 hrs to develop a groundbreaking piece of software? Well then, this event is rightly engineered for you.',4,'₹ 2,50,000');

INSERT INTO evento VALUES ('20202302','DevHack 2.0 - Hardware','2020-01-23 09:00:00','2020-01-24 21:00:00','2020-01-01 00:00:00','2020-01-23 09:00:00','Academic Building - Room no. 23','Hackathon','Do you have what it takes to code sleeplessly for 36 hrs to develop a groundbreaking piece of software? Well then, this event is rightly engineered for you.',4,'₹ 2,50,000');

INSERT INTO evento VALUES ('20202303','AlgoStrike','2020-01-25 09:00:00','2020-01-25 18:00:00','2020-01-01 00:00:00','2020-01-25 09:00:00','Academic Building - Room no. 23','Competitive Coding','For normal people, maestro is a distinguished performer of a musical instrument. Although, for us, Code Maestro is someone who can interweave data structures and algos to solve a problem efficiently.',1,'₹ 1,00,000');

INSERT INTO evento VALUES ('20202304','VeniVidiVici','2020-01-24 21:00:00','2020-01-25 09:00:00','2020-01-01 00:00:00','2020-01-24 21:00:00','Academic Building','Capture the Flag','Participate in this jeopardy-style CTF to conquer the flags hidden throughout some machines. Be assured that only knowledge will not suffice. You shall need a righteous blend of knowledge and temperament to crack this one',3,'₹ 50,000');

INSERT INTO evento VALUES ('20202305','Synergia','2020-01-23 09:00:00','2020-01-25 09:00:00','2020-01-01 00:00:00','2020-01-23 09:00:00','Academic Building','Robotics Challenge','This is an event which will test your skills as a robotics enthusiast. A pair of robots traverse the designed terrain of a mountain and a valley in sync by displaying their co-ordination.',4,'₹ 15,000');



/*      For Has         */
INSERT INTO has VALUES ('20202301','202023');
INSERT INTO has VALUES ('20202302','202023');
INSERT INTO has VALUES ('20202303','202023');
INSERT INTO has VALUES ('20202304','202023');
INSERT INTO has VALUES ('20202305','202023');

/*      For participant */
INSERT INTO participant VALUES ('2020230001','Josh','9992341234','josh@gmail.com');
INSERT INTO participant VALUES ('2020230002','Kane','8892384727','kane@gmail.com');
INSERT INTO participant VALUES ('2020230003','Avic','8765678186','avic@gmail.com');
INSERT INTO participant VALUES ('2020230004','Zinda','7689841234','zinda@gmail.com');
INSERT INTO participant VALUES ('2020230005','Frank','6799874321','frank@gmail.com');
INSERT INTO participant VALUES ('2020230006','Josho','9992341235','josho@gmail.com');
INSERT INTO participant VALUES ('2020230007','Kaneo','8892384728','kaneo@gmail.com');
INSERT INTO participant VALUES ('2020230008','Avico','8765678187','avico@gmail.com');
INSERT INTO participant VALUES ('2020230009','Zindao','7689841235','zindao@gmail.com');
INSERT INTO participant VALUES ('2020230010','Franko','6799874322','franko@gmail.com');

INSERT INTO participant VALUES ('2020230011','Joshq','9992441234','joshq@gmail.com');
INSERT INTO participant VALUES ('2020230012','Kaneq','8892484727','kaneq@gmail.com');
INSERT INTO participant VALUES ('2020230013','Avicq','8765478186','avicq@gmail.com');
INSERT INTO participant VALUES ('2020230014','Zindaq','7684841234','zindaq@gmail.com');

INSERT INTO participant VALUES ('2020230021','Jasson','9992341999','jasson@gmail.com');
INSERT INTO participant VALUES ('2020230022','KaneWill','8892384888','kanewill@gmail.com');
INSERT INTO participant VALUES ('2020230023','AvicDinda','8765678777','avicdinda@gmail.com');
INSERT INTO participant VALUES ('2020230024','ZindaKet','7689841666','zindaket@gmail.com');
INSERT INTO participant VALUES ('2020230025','FrankKon','6799874555','frankkon@gmail.com');
INSERT INTO participant VALUES ('2020230026','JoshoBrad','9992341444','joshobrad@gmail.com');
INSERT INTO participant VALUES ('2020230027','Kaneosin','8892384333','kaneosin@gmail.com');
INSERT INTO participant VALUES ('2020230028','Avicobit','8765678222','avicobit@gmail.com');
INSERT INTO participant VALUES ('2020230029','Zindaobyte','768984111','zindaobyte@gmail.com');
INSERT INTO participant VALUES ('2020230030','Franko','6799874000','franko@gmail.com');

INSERT INTO participant VALUES ('2020230041','Joshqson','9992441234','joshqson@gmail.com');
INSERT INTO participant VALUES ('2020230042','Kaneqpit','8892484727','kaneqpit@gmail.com');
INSERT INTO participant VALUES ('2020230043','Avicqlr','8765478186','avicqlr@gmail.com');
INSERT INTO participant VALUES ('2020230044','Zindaqkk','7684841234','zindaqkk@gmail.com');

INSERT INTO participant VALUES ('2020230091','Mahi','9992888234','mahis@gmail.com');
INSERT INTO participant VALUES ('2020230092','kapil','8897774727','kapil@gmail.com');
INSERT INTO participant VALUES ('2020230093','zac','8765666186','zac3@gmail.com');
INSERT INTO participant VALUES ('2020230094','fanny','7684831334','fanny@gmail.com');

/*      For individual_participant */
INSERT INTO individual_participant VALUES ('2020230001','20202303',0,'NA');
INSERT INTO individual_participant VALUES ('2020230002','20202303',0,'NA');
INSERT INTO individual_participant VALUES ('2020230003','20202303',0,'NA');
INSERT INTO individual_participant VALUES ('2020230006','20202303',0,'NA');

INSERT INTO individual_participant VALUES ('2020230021','20202303',10,'NA');
INSERT INTO individual_participant VALUES ('2020230022','20202303',20,'NA');
INSERT INTO individual_participant VALUES ('2020230023','20202303',30,'NA');
INSERT INTO individual_participant VALUES ('2020230026','20202303',10,'NA');


/*      For group_participant   */
INSERT INTO group_participant VALUES ('2020230001','20202301',0,'2020230101','The Gang','NA');
INSERT INTO group_participant VALUES ('2020230002','20202301',0,'2020230101','The Gang','NA');
INSERT INTO group_participant VALUES ('2020230003','20202301',0,'2020230101','The Gang','NA');
INSERT INTO group_participant VALUES ('2020230004','20202301',0,'2020230101','The Gang','NA');

INSERT INTO group_participant VALUES ('2020230021','20202301',30,'2020230102','The Set','NA');
INSERT INTO group_participant VALUES ('2020230022','20202301',30,'2020230102','The Set','NA');
INSERT INTO group_participant VALUES ('2020230023','20202301',30,'2020230102','The Set','NA');
INSERT INTO group_participant VALUES ('2020230024','20202301',30,'2020230102','The Set','NA');

INSERT INTO group_participant VALUES ('2020230011','20202301',0,'2020230103','The Red','NA');
INSERT INTO group_participant VALUES ('2020230012','20202301',0,'2020230103','The Red','NA');
INSERT INTO group_participant VALUES ('2020230013','20202301',0,'2020230103','The Red','NA');
INSERT INTO group_participant VALUES ('2020230014','20202301',0,'2020230103','The Red','NA');

INSERT INTO group_participant VALUES ('2020230041','20202302',10,'2020230107','The Violet','NA');
INSERT INTO group_participant VALUES ('2020230042','20202302',10,'2020230107','The violet','NA');
INSERT INTO group_participant VALUES ('2020230043','20202302',10,'2020230107','The violet','NA');
INSERT INTO group_participant VALUES ('2020230044','20202302',10,'2020230107','The violet','NA');

INSERT INTO group_participant VALUES ('2020230005','20202302',0,'2020230208','The Mechky','NA');
INSERT INTO group_participant VALUES ('2020230006','20202302',0,'2020230208','The Mechky','NA');
INSERT INTO group_participant VALUES ('2020230007','20202302',0,'2020230208','The Mechky','NA');
INSERT INTO group_participant VALUES ('2020230008','20202302',0,'2020230208','The Mechky','NA');

INSERT INTO group_participant VALUES ('2020230025','20202302',70,'2020230209','The Mechky','NA');
INSERT INTO group_participant VALUES ('2020230026','20202302',70,'2020230209','The Mechky','NA');
INSERT INTO group_participant VALUES ('2020230027','20202302',70,'2020230209','The Mechky','NA');
INSERT INTO group_participant VALUES ('2020230028','20202302',70,'2020230209','The Mechky','NA');


INSERT INTO group_participant VALUES ('2020230004','20202304',45,'2020230411','Black Torch','NA');
INSERT INTO group_participant VALUES ('2020230002','20202304',45,'2020230411','Black Torch','NA');
INSERT INTO group_participant VALUES ('2020230008','20202304',45,'2020230411','Black Torch','NA');

INSERT INTO group_participant VALUES ('2020230014','20202304',50,'2020230433','White Shadow','NA');
INSERT INTO group_participant VALUES ('2020230012','20202304',50,'2020230433','White Shadow','NA');
INSERT INTO group_participant VALUES ('2020230028','20202304',50,'2020230433','White Shadow','NA');

INSERT INTO group_participant VALUES ('2020230009','20202305',50,'2020230501','Metal Warriors','NA');
INSERT INTO group_participant VALUES ('2020230010','20202305',50,'2020230501','Metal Warriors','NA');
INSERT INTO group_participant VALUES ('2020230029','20202305',50,'2020230501','Metal Warriors','NA');
INSERT INTO group_participant VALUES ('2020230030','20202305',50,'2020230501','Metal Warriors','NA');

INSERT INTO group_participant VALUES ('2020230091','20202305',90,'2020230509','Short Circuit','NA');
INSERT INTO group_participant VALUES ('2020230092','20202305',90,'2020230509','Short Circuit','NA');
INSERT INTO group_participant VALUES ('2020230093','20202305',90,'2020230509','Short Circuit','NA');
INSERT INTO group_participant VALUES ('2020230094','20202305',90,'2020230509','Short Circuit','NA');


/*      Admin   */
INSERT INTO admino VALUES ('20202301','Shriram','8889991234','shriram.ghadge1999@gmail.com');
INSERT INTO admino VALUES ('20202302','Manjeet','9837593752','manjeet@gmail.com');
INSERT INTO admino VALUES ('20202303','Yashwant','9837593752','yashwant@gmail.com');


/*      For Sponsor */
INSERT INTO sponsor VALUES ('20202301','Github','2873425342','PLATINUM','www.github.com');
INSERT INTO sponsor VALUES ('20202302','SBI','7632342311','PLATINUM','www.sbi.com');
INSERT INTO sponsor VALUES ('20202303','Canara Bank','7632342399','PLATINUM','www.canarabank.com');
INSERT INTO sponsor VALUES ('20202304','Devfolio','7632367311','PLATINUM','www.devfolio.com');
INSERT INTO sponsor VALUES ('20202305','Wolfarm Language','7634442311','GOLD','www.wolfarmlanguage.com');
INSERT INTO sponsor VALUES ('20202306','Gatsby','7632348811','GOLD','www.gatsby.com');
INSERT INTO sponsor VALUES ('20202307','Hashnode','7332342311','SILVER','www.hashnode.com');
INSERT INTO sponsor VALUES ('20202308','HackerEarth','7678342311','PLATFORM PARTNER','www.hackerearth.com');


/*      For gives */
INSERT INTO gives VALUES ('20202301','20202301',100000);
INSERT INTO gives VALUES ('20202302','20202302',200000);
INSERT INTO gives VALUES ('20202303','20202301',100000);
INSERT INTO gives VALUES ('20202304','20202305',150000);

INSERT INTO gives VALUES ('20202305','20202303',75000);
INSERT INTO gives VALUES ('20202306','20202304',75000);

INSERT INTO gives VALUES ('20202307','20202305',50000);


/*      For guests */
INSERT INTO guest VALUES ('20202301','Kamalnath Swami Kamalnath Swami','Director of the Indian Institute of Information Technology, Dharwad','9583452734','dank@gmail.com');
INSERT INTO guest VALUES ('20202302','Wrick','Consumer Chief Technologist, McAfee Sr. Principal Engineer, Sr. Director of Technology Pathfinding and Research','9128889935','wrik@gmail.com');
INSERT INTO guest VALUES ('20202303','Danky','Director of the Indian Institute of Science','9583999734','danky@gmail.com');
INSERT INTO guest VALUES ('20202304','Mr. chakradhar','Consumer Chief Technologist, Micromax Sr. Principal Engineer, Sr. Director of Technology Pathfinding and Research','9120009935','siri@gmail.com');
INSERT INTO guest VALUES ('20202305','Anonymous','Anonymous is a decentralized international activist/hacktivist collective/movement that is widely known for its various cyber attacks against several governments, government institutions and government agencies, corporations, and the Church of Scientology.','9876543210','anonymous@gmail.com');

INSERT INTO invite VALUES ('20202301','20202301');
INSERT INTO invite VALUES ('20202302','20202301');
INSERT INTO invite VALUES ('20202303','20202302');
INSERT INTO invite VALUES ('20202304','20202302');
INSERT INTO invite VALUES ('20202301','20202303');
INSERT INTO invite VALUES ('20202302','20202303');
INSERT INTO invite VALUES ('20202305','20202304');
INSERT INTO invite VALUES ('20202303','20202305');
INSERT INTO invite VALUES ('20202304','20202305');

/*      For invigilator  */

INSERT INTO invigilator VALUES ('20202314','Mahi','IIT Hyadrabad professor','9177882600','shriram.ghadge27@gmail.com');

INSERT INTO invigilator VALUES ('20202311','Sidhu','IIT Dharwad professor','9177882635','sidhu@gmail.com');
INSERT INTO invigilator VALUES ('20202312','Glenn','IIT Madras professor','9124562635','glenn@gmail.com');
INSERT INTO invigilator VALUES ('20202313','Gauti','IIT Bombey professor','9124599635','gauti@gmail.com');


INSERT INTO invigilator VALUES ('20202315','Gill','IIT Roorkee professor','9124562600','gill@gmail.com');
INSERT INTO invigilator VALUES ('20202316','Raavi','IIT Kharagpur professor','9124599600','raavi@gmail.com');


/*      For appoint  */

INSERT INTO appoint VALUES ('20202311','20202301');
INSERT INTO appoint VALUES ('20202313','20202301');
INSERT INTO appoint VALUES ('20202314','20202301');

INSERT INTO appoint VALUES ('20202312','20202302');
INSERT INTO appoint VALUES ('20202315','20202302');
INSERT INTO appoint VALUES ('20202316','20202302');

INSERT INTO appoint VALUES ('20202311','20202303');
INSERT INTO appoint VALUES ('20202313','20202303');
INSERT INTO appoint VALUES ('20202314','20202303');


INSERT INTO appoint VALUES ('20202314','20202304');
INSERT INTO appoint VALUES ('20202316','20202304');

INSERT INTO appoint VALUES ('20202315','20202305');
INSERT INTO appoint VALUES ('20202312','20202305');
