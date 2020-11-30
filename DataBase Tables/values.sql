/*    For Fest       */
INSERT INTO fest VALUES ('202023','PARSEC','IIT Dharwad','2020-01-23','3 days');
INSERT INTO fest VALUES ('202001','Mood Indigo','IIT Bombay','2020-01-02','7 days');
INSERT INTO fest VALUES ('202003','Madras Fest','IIT Madras','2020-03-10','2 days');

/*      For Event       */
INSERT INTO evento VALUES ('20202301','DevHack 2.0 - Software','2020-01-23 09:00:00','2020-01-24 21:00:00','2020-01-01 00:00:00','2020-01-23 09:00:00','Academic Building - Room no. 23','Hackathon : Do you have what it takes to code sleeplessly for 36 hrs to develop a groundbreaking piece of software? Well then, this event is rightly engineered for you.','₹ 2,50,000');

INSERT INTO evento VALUES ('20202302','DevHack 2.0 - Hardware','2020-01-23 09:00:00','2020-01-24 21:00:00','2020-01-01 00:00:00','2020-01-23 09:00:00','Academic Building - Room no. 23','Hackathon : Do you have what it takes to code sleeplessly for 36 hrs to develop a groundbreaking piece of software? Well then, this event is rightly engineered for you.','₹ 2,50,000');

INSERT INTO evento VALUES ('20202303','AlgoStrike','2020-01-25 09:00:00','2020-01-25 18:00:00','2020-01-01 00:00:00','2020-01-25 09:00:00','Academic Building - Room no. 23','Competitive Coding : For normal people, maestro is a distinguished performer of a musical instrument. Although, for us, Code Maestro is someone who can interweave data structures and algos to solve a problem efficiently.','₹ 1,00,000');

INSERT INTO evento VALUES ('20202304','VeniVidiVici','2020-01-24 21:00:00','2020-01-25 09:00:00','2020-01-01 00:00:00','2020-01-24 21:00:00','Academic Building','Capture the Flag : Participate in this jeopardy-style CTF to conquer the flags hidden throughout some machines. Be assured that only knowledge will not suffice. You shall need a righteous blend of knowledge and temperament to crack this one','₹ 50,000');

INSERT INTO evento VALUES ('20202305','Synergia','2020-01-23 09:00:00','2020-01-25 09:00:00','2020-01-01 00:00:00','2020-01-23 09:00:00','Academic Building','Robotics Challenge : This is an event which will test your skills as a robotics enthusiast. A pair of robots traverse the designed terrain of a mountain and a valley in sync by displaying their co-ordination.','₹ 15,000');



/*      For Has         */
INSERT INTO has VALUES ('20202301','202023');
INSERT INTO has VALUES ('20202302','202023');
INSERT INTO has VALUES ('20202303','202023');
INSERT INTO has VALUES ('20202304','202023');
INSERT INTO has VALUES ('20202305','202023');

/*      For participant */
INSERT INTO participant VALUES ('2020230001','Josh',9992341234,'josh@gmail.com');
INSERT INTO participant VALUES ('2020230002','Kane',8892384727,'kane@gmail.com');
INSERT INTO participant VALUES ('2020230003','Avic',8765678186,'avic@gmail.com');
INSERT INTO participant VALUES ('2020230004','Zinda',7689841234,'zinda@gmail.com');
INSERT INTO participant VALUES ('2020230005','Frank',6799874321,'frank@gmail.com');
INSERT INTO participant VALUES ('2020230006','Josho',9992341235,'josho@gmail.com');
INSERT INTO participant VALUES ('2020230007','Kaneo',8892384728,'kaneo@gmail.com');
INSERT INTO participant VALUES ('2020230008','Avico',8765678187,'avico@gmail.com');
INSERT INTO participant VALUES ('2020230009','Zindao',7689841235,'zindao@gmail.com');
INSERT INTO participant VALUES ('2020230010','Franko',6799874322,'franko@gmail.com');

/*      For individual_participant */
INSERT INTO individual_participant VALUES ('2020230001','20202303',0,'NA');
INSERT INTO individual_participant VALUES ('2020230002','20202303',0,'NA');
INSERT INTO individual_participant VALUES ('2020230003','20202303',0,'NA');
INSERT INTO individual_participant VALUES ('2020230006','20202303',0,'NA');


/*      For group_participant   */
INSERT INTO group_participant VALUES ('2020230001','20202301',0,'2020230101','The Gang','NA');
INSERT INTO group_participant VALUES ('2020230002','20202301',0,'2020230101','The Gang','NA');
INSERT INTO group_participant VALUES ('2020230003','20202301',0,'2020230101','The Gang','NA');
INSERT INTO group_participant VALUES ('2020230004','20202301',0,'2020230101','The Gang','NA');

INSERT INTO group_participant VALUES ('2020230005','20202302',0,'2020230201','The Mechky','NA');
INSERT INTO group_participant VALUES ('2020230006','20202302',0,'2020230201','The Mechky','NA');
INSERT INTO group_participant VALUES ('2020230007','20202302',0,'2020230201','The Mechky','NA');
INSERT INTO group_participant VALUES ('2020230008','20202302',0,'2020230201','The Mechky','NA');

INSERT INTO group_participant VALUES ('2020230004','20202304',0,'2020230401','Black Torch','NA');
INSERT INTO group_participant VALUES ('2020230002','20202304',0,'2020230401','Black Torch','NA');
INSERT INTO group_participant VALUES ('2020230008','20202304',0,'2020230401','Black Torch','NA');

INSERT INTO group_participant VALUES ('2020230009','20202305',0,'2020230501','Metal Warriors','NA');
INSERT INTO group_participant VALUES ('2020230010','20202305',0,'2020230501','Metal Warriors','NA');

/*      Admin   */
INSERT INTO admino VALUES ('20202301','Shriram',8889991234,'shriram.ghadge1999@gmail.com');
INSERT INTO admino VALUES ('20202302','Manjeet',9837593752,'manjeet@gmail.com');
INSERT INTO admino VALUES ('20202303','Yashwant',9837593752,'yashwant@gmail.com');


/*      For Sponsor */
INSERT INTO sponsor VALUES ('20202301','Github',2873425342,'PLATINUM','www.github.com','https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png');
INSERT INTO sponsor VALUES ('20202302','SBI',7632342311,'PLATINUM','www.sbi.com','https://www.logolynx.com/topic/sbi#&gid=1&pid=6');
INSERT INTO sponsor VALUES ('20202303','Canara Bank',7632342399,'PLATINUM','www.canarabank.com','https://s3.ap-southeast-1.amazonaws.com/images.deccanchronicle.com/dc-Cover-279rad849ff1eu06cm9o9fira7-20161214130035.Medi.jpeg');
INSERT INTO sponsor VALUES ('20202304','Devfolio',7632367311,'PLATINUM','www.devfolio.com','data:image/png;base64,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');
INSERT INTO sponsor VALUES ('20202305','Wolfarm Language',7634442311,'GOLD','www.wolfarmlanguage.com','https://www.wolfram.com/common/framework/img/wolfram.en.png');
INSERT INTO sponsor VALUES ('20202306','Gatsby',7632348811,'GOLD','www.gatsby.com','data:image/png;base64,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');
INSERT INTO sponsor VALUES ('20202307','Hashnode',7332342311,'SILVER','www.hashnode.com','data:image/png;base64,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');
INSERT INTO sponsor VALUES ('20202308','HackerEarth',7678342311,'PLATFORM PARTNER','www.hackerearth.com','data:image/png;base64,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');


/*      For gives */
INSERT INTO gives VALUES ('20202301','20202301',100000);
INSERT INTO gives VALUES ('20202302','20202302',200000);
INSERT INTO gives VALUES ('20202303','20202301',100000);
INSERT INTO gives VALUES ('20202304','20202305',150000);

INSERT INTO gives VALUES ('20202305','20202303',75000);
INSERT INTO gives VALUES ('20202306','20202304',75000);

INSERT INTO gives VALUES ('20202307','20202305',50000);


/*      For guests */
INSERT INTO guest VALUES ('20202301','Dankrel','Director of the Indian Institute of Information Technology, Dharwad',9583452734,'dank@gmail.com');
INSERT INTO guest VALUES ('20202302','Wrick','Consumer Chief Technologist, McAfee Sr. Principal Engineer, Sr. Director of Technology Pathfinding and Research',9128889935,'wrik@gmail.com');
INSERT INTO guest VALUES ('20202303','Danky','Director of the Indian Institute of Science',9583999734,'danky@gmail.com');
INSERT INTO guest VALUES ('20202304','Siri','Consumer Chief Technologist, Micromax Sr. Principal Engineer, Sr. Director of Technology Pathfinding and Research',9120009935,'siri@gmail.com');
INSERT INTO guest VALUES ('20202305','Anonymous','Anonymous is a decentralized international activist/hacktivist collective/movement that is widely known for its various cyber attacks against several governments, government institutions and government agencies, corporations, and the Church of Scientology.',9876543210,'anonymous@gmail.com');

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

INSERT INTO invigilator VALUES ('20202311','Sidhu','IIT Dharwad professor',9177882635,'sidhu@gmail.com');
INSERT INTO invigilator VALUES ('20202312','Glenn','IIT Madras professor',9124562635,'glenn@gmail.com');
INSERT INTO invigilator VALUES ('20202313','Gauti','IIT Bombey professor',9124599635,'gauti@gmail.com');

INSERT INTO invigilator VALUES ('20202314','K.S.P.','IIT Hyadrabad professor',9177882600,'skp@gmail.com');
INSERT INTO invigilator VALUES ('20202315','Gill','IIT Roorkee professor',9124562600,'gill@gmail.com');
INSERT INTO invigilator VALUES ('20202316','Raavi','IIT Kharagpur professor',9124599600,'raavi@gmail.com');


/*      For appoint  */

INSERT INTO appoint VALUES ('20202311','20202301');
INSERT INTO appoint VALUES ('20202313','20202301');
INSERT INTO appoint VALUES ('20202315','20202301');

INSERT INTO appoint VALUES ('20202312','20202302');
INSERT INTO appoint VALUES ('20202314','20202302');
INSERT INTO appoint VALUES ('20202316','20202302');

INSERT INTO appoint VALUES ('20202311','20202303');
INSERT INTO appoint VALUES ('20202313','20202303');

INSERT INTO appoint VALUES ('20202315','20202304');
INSERT INTO appoint VALUES ('20202316','20202304');

INSERT INTO appoint VALUES ('20202314','20202305');
INSERT INTO appoint VALUES ('20202312','20202305');
