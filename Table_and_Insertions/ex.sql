/*    For Fest       */
INSERT INTO fest VALUES ('11111','PARSEC','IIT Dharwad','2011-09-23','3 days');
INSERT INTO fest VALUES ('12131','Fest2','IIT Bombay','2012-01-02','7 days');
INSERT INTO fest VALUES ('21451','Fest3','IIT Madras','2010-03-10','2 days');

/*      For Event       */
INSERT INTO evento VALUES ('11223','Event1','2011-09-23 09:00:00','2011-09-23 12:00:00','2011-09-23 09:00:00','2011-09-23 12:00:00','palce','This is Description for event-1');
INSERT INTO evento VALUES ('31413','Event2','2011-09-23 14:00:00','2011-09-24 09:00:00','2011-09-23 09:00:00','2011-09-23 12:00:00','--','This is Description for event-2');
INSERT INTO evento VALUES ('21111','Event3','2012-01-02 10:30:00','2012-01-04 14:00:00','2011-09-23 09:00:00','2011-09-23 12:00:00','--','This is Description for event-3');
INSERT INTO evento VALUES ('12222','Event4','2010-03-10 15:00:00','2010-03-10 18:00:00','2011-09-23 09:00:00','2011-09-23 12:00:00','--','This is Description for event-4');
INSERT INTO evento VALUES ('12345','Event5','2010-03-12 19:00:00','2010-03-12 09:30:00','2011-09-23 09:00:00','2011-09-23 12:00:00','--','This is Description for event-5');

/*      For Has         */
INSERT INTO has VALUES ('11223','11111');
INSERT INTO has VALUES ('31413','11111');
INSERT INTO has VALUES ('21111','12131');
INSERT INTO has VALUES ('12222','21451');
INSERT INTO has VALUES ('12345','21451');

/*      For participant */
INSERT INTO participant VALUES ('55555','Josh',9992341234,'josh@gmail.com');
INSERT INTO participant VALUES ('54325','Kane',8892384727,'kane@gmail.com');
INSERT INTO participant VALUES ('45632','Avic',8765678186,'avic@gmail.com');
INSERT INTO participant VALUES ('66554','Zinda',7689841234,'zinda@gmail.com');
INSERT INTO participant VALUES ('61231','Frank',6799874321,'frank@gmail.com');

/*      For individual_participant */
INSERT INTO individual_participant VALUES ('55555','11223',0,'Score review');
INSERT INTO individual_participant VALUES ('54325','31413',0,'Score review');
INSERT INTO individual_participant VALUES ('45632','31413',0,'Score review');
INSERT INTO individual_participant VALUES ('66554','21111',0,'Score review');
INSERT INTO individual_participant VALUES ('61231','12222',0,'Score review');

/*      For group_participant   */
INSERT INTO group_participant VALUES ('55555','12345',0,'1','The Gang','Score review');
INSERT INTO group_participant VALUES ('54325','12345',0,'1','The Gang','Score review');
INSERT INTO group_participant VALUES ('61231','12345',0,'1','The Gang','Score review');

/*      Admin   */
INSERT INTO admino VALUES ('12127','Sriram',8889991234,'sri@gmail.com','123');
INSERT INTO admino VALUES ('29833','Manjeet',9837593752,'jeet@gmail.com','123');

/*      For Sponsor */
INSERT INTO sponsor VALUES ('85732','Github',2873425342,'www.gith**.com');
INSERT INTO sponsor VALUES ('27462','Laboget',7632342311,'www.labdh**.com');

/*      For gives */
INSERT INTO gives VALUES ('85732','11223',32000);
INSERT INTO gives VALUES ('85732','21111',52000);
INSERT INTO gives VALUES ('27462','11223',50000);
INSERT INTO gives VALUES ('27462','31413',70000);

/*      For guests */
INSERT INTO guest VALUES ('73452','Dankrel','breif abt dankrel',9583452734,'dank@gmail.com');
INSERT INTO guest VALUES ('16353','Wrick','breif abt wrick',9128882635,'wrik@gmail.com');

/*      For invite  */
INSERT INTO invite VALUES ('73452','11223');
INSERT INTO invite VALUES ('73452','31413');
INSERT INTO invite VALUES ('16353','11223');