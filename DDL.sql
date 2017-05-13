--------------------------------------------------------
--  File created - Sunday-October-30-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table ALERTS
--------------------------------------------------------

  CREATE TABLE "ALERTS" 
   (	"AID" NUMBER(*,0), 
	"PID" NUMBER(*,0), 
	"ALERT_TYPE" VARCHAR2(20), 
	"READ_FLAG" VARCHAR2(1), 
	"HID" NUMBER(*,0), 
	"MESSAGE" VARCHAR2(200)
   )
--------------------------------------------------------
--  DDL for Table DISEASE
--------------------------------------------------------

  CREATE TABLE "DISEASE" 
   (	"DID" NUMBER(*,0), 
	"DNAME" VARCHAR2(20)
   )
--------------------------------------------------------
--  DDL for Table DISEASE_HI
--------------------------------------------------------

  CREATE TABLE "DISEASE_HI" 
   (	"DID" NUMBER(*,0), 
	"HID" NUMBER(*,0), 
	"FREQUENCY" NUMBER(*,0)
   )
--------------------------------------------------------
--  DDL for Table HEALTHINDICATORS
--------------------------------------------------------

  CREATE TABLE "HEALTHINDICATORS" 
   (	"HID" NUMBER(*,0), 
	"HNAME" VARCHAR2(20), 
	"FREQUENCY" NUMBER(*,0), 
	"HI_TYPE" VARCHAR2(10)
   )
--------------------------------------------------------
--  DDL for Table HEALTHSUPPORTERS
--------------------------------------------------------

  CREATE TABLE "HEALTHSUPPORTERS" 
   (	"PID" NUMBER(*,0), 
	"HS_PID" NUMBER(*,0), 
	"HS_TYPE" VARCHAR2(10), 
	"AUTH_DATE" DATE
   )
--------------------------------------------------------
--  DDL for Table HI_ENUMVALUES
--------------------------------------------------------

  CREATE TABLE "HI_ENUMVALUES" 
   (	"HID" NUMBER(*,0), 
	"PARAM_NAME" VARCHAR2(20), 
	"ENUM" VARCHAR2(20)
   )
--------------------------------------------------------
--  DDL for Table HI_RANGEVALUES
--------------------------------------------------------

  CREATE TABLE "HI_RANGEVALUES" 
   (	"HID" NUMBER(*,0), 
	"PARAM_NAME" VARCHAR2(20), 
	"MIN_VALUE" NUMBER(*,0), 
	"MAX_VALUE" NUMBER(*,0)
   )
--------------------------------------------------------
--  DDL for Table OBSERVATIONS
--------------------------------------------------------

  CREATE TABLE "OBSERVATIONS" 
   (	"OBSERVATION_ID" NUMBER(*,0), 
	"PID" NUMBER(*,0), 
	"HID" NUMBER(*,0), 
	"PARAM_NAME" VARCHAR2(20), 
	"OBSERVATION_VALUE" VARCHAR2(20), 
	"OBSERVATION_TIME" DATE, 
	"RECORDED_DATE" DATE DEFAULT sysdate, 
	"ALERT_TIME" DATE
   )
--------------------------------------------------------
--  DDL for Table PATIENT
--------------------------------------------------------

  CREATE TABLE "PATIENT" 
   (	"PID" NUMBER(*,0), 
	"DID" NUMBER(*,0)
   )
--------------------------------------------------------
--  DDL for Table PATIENT_HIENUMVALUES_OVERRIDE
--------------------------------------------------------

  CREATE TABLE "PATIENT_HIENUMVALUES_OVERRIDE" 
   (	"PID" NUMBER(*,0), 
	"HID" NUMBER(*,0), 
	"PARAM_NAME" VARCHAR2(20), 
	"ENUM" VARCHAR2(20)
   )
--------------------------------------------------------
--  DDL for Table PATIENT_HIRANGEVALUES_OVERRIDE
--------------------------------------------------------

  CREATE TABLE "PATIENT_HIRANGEVALUES_OVERRIDE" 
   (	"PID" NUMBER(*,0), 
	"HID" NUMBER(*,0), 
	"PARAM_NAME" VARCHAR2(20), 
	"MIN_VALUE" NUMBER(*,0), 
	"MAX_VALUE" NUMBER(*,0)
   )
--------------------------------------------------------
--  DDL for Table PERSON
--------------------------------------------------------

  CREATE TABLE "PERSON" 
   (	"PID" NUMBER(*,0), 
	"P_PASSWORD" VARCHAR2(30), 
	"P_NAME" VARCHAR2(50), 
	"DOB" DATE, 
	"GENDER" VARCHAR2(1), 
	"ADDRESS" VARCHAR2(100), 
	"EMAIL" VARCHAR2(30), 
	"PHONE" NUMBER(10,0)
   )
REM INSERTING into ALERTS
SET DEFINE OFF;
Insert into ALERTS (AID,PID,ALERT_TYPE,READ_FLAG,HID,MESSAGE) values (2,1,'OUTSIDE_LIMIT','F',1,'10 is not in the recommended range for Weight');
Insert into ALERTS (AID,PID,ALERT_TYPE,READ_FLAG,HID,MESSAGE) values (3,1,'LOW_ACTIVITY','F',1,'An Observation has not been recorded for Weight, for a while now.');
Insert into ALERTS (AID,PID,ALERT_TYPE,READ_FLAG,HID,MESSAGE) values (1,1,'OUTSIDE_LIMIT','F',1,'90 is not in the recommended range for Weight');
REM INSERTING into DISEASE
SET DEFINE OFF;
Insert into DISEASE (DID,DNAME) values (3,'COPD');
Insert into DISEASE (DID,DNAME) values (1,'Heart Disease');
Insert into DISEASE (DID,DNAME) values (2,'HIV');
REM INSERTING into DISEASE_HI
SET DEFINE OFF;
Insert into DISEASE_HI (DID,HID,FREQUENCY) values (1,1,1);
Insert into DISEASE_HI (DID,HID,FREQUENCY) values (1,2,null);
Insert into DISEASE_HI (DID,HID,FREQUENCY) values (2,1,null);
Insert into DISEASE_HI (DID,HID,FREQUENCY) values (2,4,null);
Insert into DISEASE_HI (DID,HID,FREQUENCY) values (3,3,null);
Insert into DISEASE_HI (DID,HID,FREQUENCY) values (3,6,null);
REM INSERTING into HEALTHINDICATORS
SET DEFINE OFF;
Insert into HEALTHINDICATORS (HID,HNAME,FREQUENCY,HI_TYPE) values (1,'Weight',7,'RANGE');
Insert into HEALTHINDICATORS (HID,HNAME,FREQUENCY,HI_TYPE) values (2,'BP',1,'RANGE');
Insert into HEALTHINDICATORS (HID,HNAME,FREQUENCY,HI_TYPE) values (3,'Oxygen Saturation',1,'RANGE');
Insert into HEALTHINDICATORS (HID,HNAME,FREQUENCY,HI_TYPE) values (4,'Pain',1,'ENUM');
Insert into HEALTHINDICATORS (HID,HNAME,FREQUENCY,HI_TYPE) values (6,'Temperature',1,'RANGE');
Insert into HEALTHINDICATORS (HID,HNAME,FREQUENCY,HI_TYPE) values (5,'Mood',1,'ENUM');
REM INSERTING into HEALTHSUPPORTERS
SET DEFINE OFF;
Insert into HEALTHSUPPORTERS (PID,HS_PID,HS_TYPE,AUTH_DATE) values (2,3,'PRIMARY',to_date('10-OCT-16','DD-MON-RR'));
Insert into HEALTHSUPPORTERS (PID,HS_PID,HS_TYPE,AUTH_DATE) values (1,4,'PRIMARY',to_date('21-OCT-16','DD-MON-RR'));
Insert into HEALTHSUPPORTERS (PID,HS_PID,HS_TYPE,AUTH_DATE) values (3,4,'PRIMARY',to_date('21-OCT-16','DD-MON-RR'));
REM INSERTING into HI_ENUMVALUES
SET DEFINE OFF;
Insert into HI_ENUMVALUES (HID,PARAM_NAME,ENUM) values (5,'Mood','Happy');
Insert into HI_ENUMVALUES (HID,PARAM_NAME,ENUM) values (4,'Pain','5');
REM INSERTING into HI_RANGEVALUES
SET DEFINE OFF;
Insert into HI_RANGEVALUES (HID,PARAM_NAME,MIN_VALUE,MAX_VALUE) values (1,'Weight',120,200);
Insert into HI_RANGEVALUES (HID,PARAM_NAME,MIN_VALUE,MAX_VALUE) values (2,'Systolic',140,159);
Insert into HI_RANGEVALUES (HID,PARAM_NAME,MIN_VALUE,MAX_VALUE) values (2,'Diastolic',90,99);
Insert into HI_RANGEVALUES (HID,PARAM_NAME,MIN_VALUE,MAX_VALUE) values (3,'Oxygen Saturation',90,99);
Insert into HI_RANGEVALUES (HID,PARAM_NAME,MIN_VALUE,MAX_VALUE) values (6,'Temperature',95,100);
REM INSERTING into OBSERVATIONS
SET DEFINE OFF;
Insert into OBSERVATIONS (OBSERVATION_ID,PID,HID,PARAM_NAME,OBSERVATION_VALUE,OBSERVATION_TIME,RECORDED_DATE,ALERT_TIME) values (100,1,1,'Weight','10',to_date('01-OCT-16','DD-MON-RR'),to_date('30-OCT-16','DD-MON-RR'),to_date('30-OCT-16','DD-MON-RR'));
Insert into OBSERVATIONS (OBSERVATION_ID,PID,HID,PARAM_NAME,OBSERVATION_VALUE,OBSERVATION_TIME,RECORDED_DATE,ALERT_TIME) values (1,1,1,'Weight','90',to_date('10-OCT-16','DD-MON-RR'),to_date('30-OCT-16','DD-MON-RR'),to_date('30-OCT-16','DD-MON-RR'));
REM INSERTING into PATIENT
SET DEFINE OFF;
REM INSERTING into PATIENT_HIENUMVALUES_OVERRIDE
SET DEFINE OFF;
REM INSERTING into PATIENT_HIRANGEVALUES_OVERRIDE
SET DEFINE OFF;
REM INSERTING into PERSON
SET DEFINE OFF;
Insert into PERSON (PID,P_PASSWORD,P_NAME,DOB,GENDER,ADDRESS,EMAIL,PHONE) values (1,'password','Sheldon Cooper',to_date('26-MAY-84','DD-MON-RR'),'M','2500 Sacramento, Apt 903, Santa Cruz, CA - 90021','gmail@gmail.com',192847);
Insert into PERSON (PID,P_PASSWORD,P_NAME,DOB,GENDER,ADDRESS,EMAIL,PHONE) values (2,'password','Leonard Hofstader',to_date('19-APR-89','DD-MON-RR'),'M','2500 Sacramento, Apt 904, Santa Cruz, CA - 90021','gmail@gmail.com',192847);
Insert into PERSON (PID,P_PASSWORD,P_NAME,DOB,GENDER,ADDRESS,EMAIL,PHONE) values (3,'password','Penny Hofstader',to_date('25-DEC-90','DD-MON-RR'),'F','2500 Sacramento, Apt 904, Santa Cruz, CA - 90021','gmail@gmail.com',192847);
Insert into PERSON (PID,P_PASSWORD,P_NAME,DOB,GENDER,ADDRESS,EMAIL,PHONE) values (4,'password','Amy Farrahfowler',to_date('15-JUN-92','DD-MON-RR'),'F','2500 Sacramento, Apt 905, Santa Cruz, CA - 90021','gmail@gmail.com',192847);
--------------------------------------------------------
--  DDL for Trigger CHECK_HID_NAME
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "CHECK_HID_NAME" 
BEFORE INSERT ON OBSERVATIONS 
REFERENCING OLD AS O NEW AS N 
FOR EACH ROW 
DECLARE
flag NUMBER;
BEGIN
  flag := 0;
  FOR temp IN (Select hid, param_name from HI_ENUMVALUES UNION Select hid, param_name from HI_RANGEVALUES) LOOP
    IF temp.hid = :N.hid AND temp.param_name = :N.param_name THEN
      flag := 1;
      EXIT;
    END IF;
  END LOOP;
  IF flag = 0 THEN
    RAISE NO_DATA_FOUND;
  END IF;
END;
ALTER TRIGGER "CHECK_HID_NAME" ENABLE
--------------------------------------------------------
--  DDL for Procedure ADD_DISEASE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "ADD_DISEASE" 
(
  PERSON_ID IN NUMBER
, DISEASE_ID IN NUMBER
, output OUT NUMBER
) AS 
hitype VARCHAR2(20);
check_healthSupporters NUMBER;
BEGIN
  output := 0;
  SELECT count(*) INTO check_healthSupporters FROM HEALTHSUPPORTERS WHERE pid = PERSON_ID;
  
  IF check_healthSupporters > 0 THEN
    INSERT INTO Patient VALUES (PERSON_ID, DISEASE_ID);
    
    FOR hid_record IN (SELECT hid FROM  Disease_HI where did = DISEASE_ID minus (select hid FROM  Disease_HI where did in (select DISTINCT(did) FROM Patient where pid = PERSON_ID and did != DISEASE_ID))) LOOP
      select hi_type into hitype from HealthIndicators WHERE hid = hid_record.hid;
      IF hitype = 'RANGE' THEN 
        FOR t1 IN (SELECT min_value, max_value,param_name FROM HI_RANGEVALUES WHERE hid = hid_record.hid) LOOP
            INSERT INTO Patient_HIRangevalues_Override VALUES(PERSON_ID,hid_record.hid,t1.param_name,t1.min_value,t1.max_value);
        END LOOP;
      ELSE
        FOR t2 IN (SELECT enum,param_name FROM HI_ENUMVALUES WHERE HID = hid_record.hid) LOOP
           INSERT INTO Patient_HIEnumValues_Override VALUES (PERSON_ID, hid_record.hid, t2.param_name, t2.enum);
        END LOOP;
      END IF;
    END LOOP;
    output := 1;
  END IF;
END ADD_DISEASE;
--------------------------------------------------------
--  DDL for Procedure ADD_HEALTH_SUPPORTER
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "ADD_HEALTH_SUPPORTER" 
(
  PERSON_ID IN NUMBER 
, SUPPORTER_ID IN NUMBER
, AUTH_DATE IN DATE
, output OUT NUMBER
) AS 
counter NUMBER; 
BEGIN
  output:=0;
  SELECT COUNT(*) INTO counter FROM HEALTHSUPPORTERS WHERE pid = PERSON_ID;
  IF counter = 0 THEN
    INSERT INTO HEALTHSUPPORTERS VALUES(PERSON_ID,SUPPORTER_ID,'PRIMARY',AUTH_DATE);
    dbms_output.put_line('Inside Primary');
    output:=1;
  ELSIF counter = 1 THEN
    INSERT INTO HEALTHSUPPORTERS VALUES(PERSON_ID,SUPPORTER_ID,'SECONDARY',AUTH_DATE);
    dbms_output.put_line('Inside Secondary');
    output:=1;
  ELSE 
    output:=0;
  END IF;
  
END ADD_HEALTH_SUPPORTER;
--------------------------------------------------------
--  DDL for Procedure ADD_HEALTH_SUPPORTERS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "ADD_HEALTH_SUPPORTERS" 
(
  PERSON_ID IN NUMBER 
, SUPPORTER_ID IN NUMBER
, AUTH_DATE IN DATE
, output OUT NUMBER
) AS 
counter NUMBER; 
BEGIN
  output:=0;
  SELECT COUNT(*) INTO counter FROM HEALTHSUPPORTERS WHERE pid = PERSON_ID;
  IF counter = 0 THEN
    INSERT INTO HEALTHSUPPORTERS VALUES(PERSON_ID,SUPPORTER_ID,'PRIMARY',AUTH_DATE);
    dbms_output.put_line('Inside Primary');
    output:=1;
  ELSIF counter = 1 THEN
    INSERT INTO HEALTHSUPPORTERS VALUES(PERSON_ID,SUPPORTER_ID,'SECONDARY',AUTH_DATE);
    dbms_output.put_line('Inside Secondary');
    output:=1;
  END IF;
  
END ADD_HEALTH_SUPPORTERS;
--------------------------------------------------------
--  DDL for Procedure ADD_OBSERVATION
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "ADD_OBSERVATION" 
(
  OBSERVATION_ID IN NUMBER 
, PERSON_ID IN NUMBER 
, HID IN NUMBER 
, PARAM_NAME IN VARCHAR2 
, OBSERVATION_VALUE IN VARCHAR2 
, OBSERVATION_TIME IN DATE 
, output OUT NUMBER
) AS 
BEGIN
  output := 0;
  INSERT INTO OBSERVATIONS(observation_id,pid,hid,param_name,observation_value,observation_time) 
  VALUES(OBSERVATION_ID,PERSON_ID,HID,PARAM_NAME,OBSERVATION_VALUE,OBSERVATION_TIME);
  output := 1;
  DELETE FROM ALERTS WHERE PID = PERSON_ID AND ALERT_TYPE = 'LOW_ACTIVITY';
   EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Wrong combination of hid and name are entered!');
    WHEN others THEN
      DBMS_OUTPUT.PUT_LINE('Something went wrong!');
END ADD_OBSERVATION;
--------------------------------------------------------
--  DDL for Procedure CREATE_USER
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "CREATE_USER" 
(
  USER_ID IN NUMBER 
, USERNAME IN VARCHAR2 
, UPASSWORD IN VARCHAR2 
, ADDRESS IN VARCHAR2 
, PHONE IN VARCHAR2 
, GENDER IN VARCHAR2 
, DOB IN DATE 
, EMAIL IN VARCHAR2 
, output OUT NUMBER
) AS 
BEGIN
  INSERT INTO Person VALUES(user_id,upassword,username,dob,gender,address,email,phone);
  output := 1;
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      output := 0;
    WHEN others THEN
      output := 0;
END CREATE_USER;
--------------------------------------------------------
--  DDL for Procedure DELETE_DISEASE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "DELETE_DISEASE" 
(
  PERSON_ID IN NUMBER
,  DISEASE_ID IN NUMBER
,  output OUT NUMBER
) AS 
hitype VARCHAR2(20); 
BEGIN
  output := 0;
  FOR hid_record IN (SELECT hid FROM  Disease_HI where did = DISEASE_ID minus (select hid FROM  Disease_HI where did in (select DISTINCT(did) FROM Patient where pid = PERSON_ID and did != DISEASE_ID))) LOOP
    select hi_type into hitype from HealthIndicators WHERE hid = hid_record.hid;
    IF hitype = 'RANGE' THEN 
      DELETE FROM Patient_HIRangevalues_Override WHERE pid = PERSON_ID AND hid = hid_record.hid;
    ELSE
       DELETE FROM Patient_HIEnumValues_Override WHERE pid = PERSON_ID AND hid = hid_record.hid;
    END IF;
  END LOOP;
  
  DELETE FROM Patient WHERE pid = PERSON_ID AND did = DISEASE_ID;
  output := 1;
END DELETE_DISEASE;
--------------------------------------------------------
--  DDL for Procedure DELETE_HEALTH_SUPPORTERS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "DELETE_HEALTH_SUPPORTERS" 
(
  PERSON_ID IN NUMBER 
, HS_ID IN NUMBER
, output OUT NUMBER
) AS 
  counter NUMERIC := 0;
  check_healthSupporters NUMBER;
  hstype VARCHAR2(20);
BEGIN
  output := 0;
  check_healthSupporters := CHECK_HEALTH_SUPPORTERS_SICK(PERSON_ID);
  SELECT count(*) INTO counter FROM HEALTHSUPPORTERS WHERE PID = PERSON_ID AND HS_PID = HS_ID;
  IF counter = 1 AND check_healthSupporters = 3 THEN
      DELETE FROM HEALTHSUPPORTERS WHERE PID = PERSON_ID AND HS_PID = HS_ID;
      output := 1;
  END IF;
  IF check_healthSupporters > 1 and check_healthSupporters != 3 THEN
    SELECT hs_type INTO hstype FROM HEALTHSUPPORTERS WHERE PID = PERSON_ID AND HS_PID = HS_ID;
    DELETE FROM HEALTHSUPPORTERS WHERE PID = PERSON_ID AND HS_PID = HS_ID;
    IF hstype = 'PRIMARY' THEN
      DBMS_OUTPUT.PUT_LINE(hstype);
      UPDATE HEALTHSUPPORTERS SET hs_type = 'PRIMARY' WHERE PID = PERSON_ID;
    END IF;
    
    output := 1;
  END IF;
END DELETE_HEALTH_SUPPORTERS;
--------------------------------------------------------
--  DDL for Procedure DELETE_OBSERVATION
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "DELETE_OBSERVATION" 
(
  OBS_ID IN NUMBER
, output OUT NUMBER  
) AS 
BEGIN
  output := 0;
  DELETE FROM OBSERVATIONS WHERE OBSERVATION_ID = OBS_ID;
  output := 1;
END DELETE_OBSERVATION;
--------------------------------------------------------
--  DDL for Procedure GENERATE_ALERTS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "GENERATE_ALERTS" 
(
  PERSON_ID IN NUMBER
) AS 
alert_counter NUMBER;
range_counter NUMBER;
enum_counter NUMBER;
general_range_counter NUMBER;
is_Patient NUMBER;
frequency NUMBER;
alert_count NUMBER;
general_range HI_RangeValues%ROWTYPE;
general_enum HI_EnumValues%ROWTYPE;
patient_range Patient_HIRangeValues_Override%ROWTYPE;
patient_enum Patient_HIEnumValues_Override%ROWTYPE;
alert_message VARCHAR2(200);
flag NUMBER :=0;
CURSOR c1 IS SELECT * FROM HEALTHINDICATORS;
CURSOR indicator_ids(h_id NUMBER) IS 
  Select * from (SELECT * FROM Observations where pid = PERSON_ID AND hid = h_id order by RECORDED_DATE desc) Where ROWNUM = 1 ; 
/*select * from Observations where pid = PERSON_ID AND hid in (select hid from Observations o group by o.hid, o.RECORDED_DATE) order by RECORDED_DATE desc;*/
BEGIN
  IS_WELL_OR_SICK(PERSON_ID,is_Patient);

FOR h_rec in c1 LOOP
  /* LOW_ACTIVITY_ALERTS */
  FOR rec in indicator_ids(h_rec.hid) LOOP
    SELECT COUNT(*) INTO alert_counter FROM Alerts;
    alert_counter := alert_counter + 1;
    
    /* OUTSIDE LIMIT ALERTS */
    SYS.DBMS_OUTPUT.PUT_LINE(rec.param_name||rec.pid);
    SELECT count(*) INTO range_counter FROM Patient_HIRangeValues_Override WHERE pid = PERSON_ID AND hid = rec.hid;
    SELECT count(*) INTO enum_counter FROM Patient_HIEnumValues_Override WHERE pid = PERSON_ID AND hid = rec.hid;
    SELECT count(*) INTO general_range_counter FROM HI_RangeValues WHERE hid = rec.hid AND PARAM_NAME = rec.param_name;
    IF range_counter >0 THEN
      alert_message := rec.Observation_value ||' is not in the recommended range for '|| h_rec.hname;
      flag := 1;
      SYS.DBMS_OUTPUT.PUT_LINE('In Range couter ');
      SELECT * INTO patient_range FROM Patient_HIRangeValues_Override WHERE pid = PERSON_ID AND hid = rec.hid AND PARAM_NAME = rec.param_name;
      IF (TO_NUMBER(rec.observation_value) < patient_range.MIN_VALUE OR TO_NUMBER(rec.observation_value) > patient_range.MAX_VALUE) AND (rec.Alert_Time IS NULL OR CURRENT_DATE - rec.Alert_Time > 1) THEN
          INSERT INTO ALERTS VALUES(alert_counter, PERSON_ID,'OUTSIDE_LIMIT','F',rec.hid,alert_message);
          UPDATE Observations SET Alert_Time = CURRENT_DATE WHERE Observation_id = rec.Observation_id;
      END IF;
      
    ELSE
      IF general_range_counter > 0 THEN 
        SYS.DBMS_OUTPUT.PUT_LINE('In else part of Range counter ');
        flag := 1;
        SELECT * INTO general_range FROM HI_RangeValues WHERE hid = rec.hid AND PARAM_NAME = rec.param_name;
        IF TO_NUMBER(rec.observation_value) < general_range.MIN_VALUE OR TO_NUMBER(rec.observation_value) > general_range.MAX_VALUE AND (rec.Alert_Time IS NULL OR CURRENT_DATE - rec.Alert_Time > 1) THEN
            INSERT INTO ALERTS VALUES(alert_counter, PERSON_ID,'OUTSIDE_LIMIT','F',rec.hid,alert_message);
            UPDATE Observations SET Alert_Time = CURRENT_DATE WHERE Observation_id = rec.Observation_id;
        END IF;
      END IF;
    END IF;
    
    IF enum_counter >0 AND flag = 0 THEN
      alert_message := rec.Observation_value ||' is not the recommended value for '|| h_rec.hname;
      SYS.DBMS_OUTPUT.PUT_LINE('In Enum couter ');
      SELECT * INTO patient_enum FROM Patient_HIEnumValues_Override WHERE pid = PERSON_ID AND hid = rec.hid AND PARAM_NAME = rec.param_name; 
      IF LOWER(rec.observation_value) = 'sad' AND (rec.Alert_Time IS NULL OR CURRENT_DATE - rec.Alert_Time > 1) THEN
          INSERT INTO ALERTS VALUES(alert_counter, PERSON_ID,'OUTSIDE_LIMIT','F',rec.hid,alert_message);
          UPDATE Observations SET Alert_Time = CURRENT_DATE WHERE Observation_id = rec.Observation_id;
      END IF;
      
      IF TO_NUMBER(rec.observation_value) > TO_NUMBER(patient_enum.ENUM) AND (rec.Alert_Time IS NULL OR CURRENT_DATE - rec.Alert_Time > 1) THEN
          INSERT INTO ALERTS VALUES(alert_counter, PERSON_ID,'OUTSIDE_LIMIT','F',rec.hid,alert_message);
          UPDATE Observations SET Alert_Time = CURRENT_DATE WHERE Observation_id = rec.Observation_id;
      END IF;
      
    ELSIF flag = 0 THEN
      SYS.DBMS_OUTPUT.PUT_LINE('In else part of ENUM couter ');
      SELECT * INTO general_enum FROM HI_EnumValues WHERE hid = rec.hid AND PARAM_NAME = rec.param_name;
      IF (LOWER(rec.observation_value) = 'sad') AND (rec.Alert_Time IS NULL OR CURRENT_DATE - rec.Alert_Time > 1) THEN
          SYS.DBMS_OUTPUT.PUT_LINE('Before inserting enum alert');
          INSERT INTO ALERTS VALUES(alert_counter, PERSON_ID,'OUTSIDE_LIMIT','F',rec.hid,alert_message);
          UPDATE Observations SET Alert_Time = CURRENT_DATE WHERE Observation_id = rec.Observation_id;
      END IF;
      
      IF (TO_NUMBER(rec.observation_value) > TO_NUMBER(general_enum.ENUM)) AND (rec.Alert_Time IS NULL OR CURRENT_DATE - rec.Alert_Time > 1) THEN
          SYS.DBMS_OUTPUT.PUT_LINE('Before inserting enum alert');
          INSERT INTO ALERTS VALUES(alert_counter, PERSON_ID,'OUTSIDE_LIMIT','F',rec.hid,alert_message);
          UPDATE Observations SET Alert_Time = CURRENT_DATE WHERE Observation_id = rec.Observation_id;
      END IF;
    END IF;
    
     /* LOW ACTIVITY ALERTS */
    
    frequency := 0;
    FOR temp IN (SELECT hi.hid, d_hi.FREQUENCY as df, hi.FREQUENCY as hf
    FROM DISEASE_HI d_hi INNER JOIN HealthIndicators hi ON hi.HID = d_hi.HID
    WHERE DID IN (SELECT DID FROM PATIENT WHERE PID = PERSON_ID)) LOOP
      IF temp.df != NULL AND temp.df < temp.hf THEN
        frequency := temp.df;
      ELSE 
        frequency := temp.hf;
      END IF;
      DBMS_OUTPUT.put_line(frequency);
      Select count(*) into alert_count FROM ALERTS WHERE ALERT_TYPE = 'LOW_ACTIVITY' AND PID = PERSON_ID AND HID = rec.hid;
      IF CURRENT_DATE - rec.OBSERVATION_TIME > frequency AND alert_count = 0 THEN
      DBMS_OUTPUT.PUT_LINE(frequency || 'inside if loop');
        alert_message := 'An Observation has not been recorded for '|| h_rec.hname||', for a while now.';
        
    SELECT MAX(aid) INTO alert_counter FROM Alerts;
    alert_counter := alert_counter + 1;
        INSERT INTO ALERTS VALUES(alert_counter, PERSON_ID,'LOW_ACTIVITY','F',rec.hid,alert_message);
      END IF;
    END LOOP;
    
  END LOOP;
END LOOP;
END GENERATE_ALERTS;
--------------------------------------------------------
--  DDL for Procedure GET_DISEASE_FOR_PATIENT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "GET_DISEASE_FOR_PATIENT" 
(
  PERSON_ID IN NUMBER
, d_record OUT sys_refcursor
) AS 
BEGIN
  OPEN d_record FOR
  SELECT d.DID,d.DNAME
  FROM PATIENT p INNER JOIN DISEASE d ON p.did = d.did
  WHERE p.PID = PERSON_ID;
END GET_DISEASE_FOR_PATIENT;
--------------------------------------------------------
--  DDL for Procedure GET_HEALTH_SUPPORTERS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "GET_HEALTH_SUPPORTERS" 
(
  PERSON_ID IN NUMBER
, hs_records OUT sys_refcursor  
) AS 
BEGIN
  OPEN hs_records FOR SELECT * from HealthSupporters WHERE PID = PERSON_ID;  
END GET_HEALTH_SUPPORTERS;
--------------------------------------------------------
--  DDL for Procedure GET_HI_NAME
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "GET_HI_NAME" 
(
  d_id IN NUMBER
, D_NAME OUT VARCHAR2
) AS 
BEGIN
  Select DNAME into D_NAME FROM DISEASE WHERE did = d_id;
END GET_HI_NAME;
--------------------------------------------------------
--  DDL for Procedure GET_HS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "GET_HS" 
(
  UID IN NUMBER,
  user_record OUT sys_refcursor
) AS
BEGIN
  OPEN user_record FOR 
  SELECT * from HealthSupporters hs WHERE hs.PID = UID;
END GET_HS;
--------------------------------------------------------
--  DDL for Procedure GET_OBSERVATIONS_FOR_PATIENT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "GET_OBSERVATIONS_FOR_PATIENT" 
(
  PERSON_ID IN NUMBER
, obs_record OUT sys_refcursor  
) AS 
BEGIN
  OPEN obs_record FOR SELECT o.* FROM observations o WHERE o.Observation_id = PERSON_ID;
END GET_OBSERVATIONS_FOR_PATIENT;
--------------------------------------------------------
--  DDL for Procedure GET_PATIENTS_OF_HS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "GET_PATIENTS_OF_HS" 
(
  UID IN NUMBER,
  user_record OUT sys_refcursor
) AS
  counter NUMBER := 0;
BEGIN
  OPEN user_record FOR 
  SELECT p.pid,p.P_NAME from Person p inner join HealthSupporters hs on p.pid = hs.pid WHERE hs.hs_PID = UID;
END GET_PATIENTS_OF_HS;
--------------------------------------------------------
--  DDL for Procedure GET_PERSON_INFO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "GET_PERSON_INFO" 
(
  UNAME IN NUMBER 
, user_record OUT sys_refcursor
) AS
BEGIN
  OPEN user_record FOR
     SELECT p.* FROM Person p WHERE p.PID = uname;
END GET_PERSON_INFO;
--------------------------------------------------------
--  DDL for Procedure INSERT_HS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "INSERT_HS" 
(
  UID IN NUMBER,
  HS_ID IN NUMBER,
  HS_TYPE IN VARCHAR2,
  HS_DATE IN DATE,
  output OUT NUMBER
) AS
BEGIN
  INSERT INTO HealthSupporters VALUES (UID, HS_ID, HS_TYPE, HS_DATE);
  output := 1;
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      output := 0;
    WHEN others THEN
      output := 0;
END INSERT_HS;
--------------------------------------------------------
--  DDL for Procedure IS_WELL_OR_SICK
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "IS_WELL_OR_SICK" 
(
  PERSON_ID IN NUMBER
, isPatient OUT NUMBER
) AS 
counter NUMBER;
BEGIN
  SELECT COUNT(*) INTO counter FROM PATIENT WHERE pid = PERSON_ID;
  IF counter > 0 THEN
    isPatient := 1;
  ELSE
    isPatient := 0;
  END IF;
END IS_WELL_OR_SICK;
--------------------------------------------------------
--  DDL for Procedure UPDATE_HEALTH_SUPPORTERS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "UPDATE_HEALTH_SUPPORTERS" 
(
  PERSON_ID IN NUMBER 
, SUPPORTER_ID IN NUMBER 
, AUTHORIZATION_DATE IN DATE 
, SUPPORTER_TYPE IN VARCHAR2 
, output OUT NUMBER
) AS 
BEGIN
  output := 0;
  IF PERSON_ID != SUPPORTER_ID THEN 
    IF SUPPORTER_TYPE = 'PRIMARY' THEN
      UPDATE HEALTHSUPPORTERS H SET  H.HS_PID = SUPPORTER_ID, H.AUTH_DATE = AUTHORIZATION_DATE
      WHERE H.PID = PERSON_ID AND H.HS_TYPE = 'PRIMARY';
      output := 1;
    ELSE 
      UPDATE HEALTHSUPPORTERS T SET  T.HS_PID = SUPPORTER_ID, T.AUTH_DATE = AUTHORIZATION_DATE
      WHERE T.PID = PERSON_ID AND T.HS_TYPE = 'SECONDARY';
      output := 1;
    END IF;  
  END IF;
END UPDATE_HEALTH_SUPPORTERS;
--------------------------------------------------------
--  DDL for Procedure UPDATE_HS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "UPDATE_HS" 
(
  UID IN NUMBER,
  HS_ID IN NUMBER,
  HS_DATE IN DATE,
  output OUT NUMBER
) AS
BEGIN
  UPDATE HealthSupporters SET auth_date = HS_DATE WHERE pid = UID AND hs_pid = HS_ID;
  output := 1;
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      output := 0;
    WHEN others THEN
      output := 0;
END UPDATE_HS;
--------------------------------------------------------
--  DDL for Procedure UPDATE_OBSERVATION
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "UPDATE_OBSERVATION" 
(
  OBS_ID IN NUMBER  
, OBS_VALUE IN VARCHAR2 
, OBS_TIME IN DATE 
, output OUT NUMBER
)
AS 
BEGIN
  output := 0;
    UPDATE OBSERVATIONS SET  OBSERVATION_VALUE = OBS_VALUE, OBSERVATION_TIME = OBS_TIME
    WHERE OBSERVATION_ID = OBS_ID;
  output := 1;
END UPDATE_OBSERVATION;
--------------------------------------------------------
--  DDL for Procedure UPDATE_RECOMMENDATIONS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "UPDATE_RECOMMENDATIONS" 
(
  PERSON_ID IN NUMBER 
, UP_HID IN NUMBER 
, PARAMETER_NAME IN VARCHAR2 
, MINIMUM_VALUE IN NUMBER 
, MAXIMUM_VALUE IN NUMBER 
, ENUM_VALUE IN VARCHAR2 
, output OUT NUMBER
) AS 
BEGIN
  output := 0;
  IF (ENUM_VALUE = NULL OR ENUM_VALUE ='') AND (MINIMUM_VALUE != NULL AND  MAXIMUM_VALUE != NULL) THEN
    UPDATE PATIENT_HIRANGEVALUES_OVERRIDE SET MIN_VALUE = MINIMUM_VALUE, MAX_VALUE = MAXIMUM_VALUE 
    WHERE PID = PERSON_ID AND PARAM_NAME = PARAMETER_NAME AND HID = UP_HID;
    output := 1;
  ELSE 
    DBMS_OUTPUT.PUT_LINE('In Else block');
    UPDATE PATIENT_HIENUMVALUES_OVERRIDE SET ENUM = ENUM_VALUE 
    WHERE PID = PERSON_ID AND PARAM_NAME = PARAMETER_NAME AND HID = UP_HID;
    output := 1;
  END IF;
END UPDATE_RECOMMENDATIONS;
--------------------------------------------------------
--  DDL for Procedure UPDATE_USER
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "UPDATE_USER" 
(
  USER_ID IN NUMBER 
, USERNAME IN VARCHAR2 
, UPASSWORD IN VARCHAR2 
, U_ADDRESS IN VARCHAR2 
, U_PHONE IN VARCHAR2 
, U_GENDER IN VARCHAR2 
, U_DOB IN DATE 
, U_EMAIL IN VARCHAR2 
, output OUT NUMBER
) AS 
BEGIN
  UPDATE Person SET p_password = upassword, p_name = username, dob = U_DOB, gender = U_GENDER, address = U_ADDRESS, email = U_EMAIL, phone = U_PHONE
  WHERE PID = USER_ID;
  output := 1;
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      output := 0;
    WHEN others THEN
      output := 0;
END UPDATE_USER;
--------------------------------------------------------
--  DDL for Procedure VALIDATE_LOGIN
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "VALIDATE_LOGIN" 
(
  UNAME IN NUMBER 
, UPASSWORD IN VARCHAR2 
, IS_HS IN NUMBER 
, user_record OUT sys_refcursor
) AS
  counter NUMBER := 0;
BEGIN
  IF IS_HS = 0 THEN OPEN user_record FOR
     SELECT p.* FROM Person p WHERE p.PID = uname AND p.P_PASSWORD =  upassword;
  ELSE
    SELECT COUNT(*) INTO counter FROM HealthSupporters hs WHERE hs.HS_PID = uname;
    IF counter > 0 THEN
      OPEN user_record FOR 
      SELECT p.* from Person p WHERE p.PID = uname AND p.P_PASSWORD =  upassword;
    END IF;
  END IF;
END VALIDATE_LOGIN;
--------------------------------------------------------
--  DDL for Procedure VIEW_ALERTS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "VIEW_ALERTS" 
(
  UID IN NUMBER,
  alert_record OUT sys_refcursor
) AS
BEGIN
  GENERATE_ALERTS(UID);
  OPEN alert_record FOR 
  SELECT a.* FROM Alerts a WHERE a.PID = uid;
END VIEW_ALERTS;
--------------------------------------------------------
--  DDL for Procedure VIEW_HEALTH_SUPPORTERS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "VIEW_HEALTH_SUPPORTERS" 
(
  PERSON_ID IN NUMBER
, hs_records OUT sys_refcursor  
) AS 
BEGIN
  OPEN hs_records FOR SELECT * from HealthSupporters p WHERE p.PID = PERSON_ID;  
END VIEW_HEALTH_SUPPORTERS;
--------------------------------------------------------
--  DDL for Procedure VIEW_RECOMMENDATIONS_HS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "VIEW_RECOMMENDATIONS_HS" 
(
   PERSON_ID IN NUMBER
,  rec1 OUT sys_refcursor
,  rec2 OUT sys_refcursor
) AS 
BEGIN
  OPEN rec1 FOR 
  SELECT p1.* FROM PATIENT_HIRANGEVALUES_OVERRIDE p1 WHERE p1.PID = PERSON_ID;
  
  OPEN rec2 FOR
  SELECT p2.* FROM PATIENT_HIENUMVALUES_OVERRIDE p2 WHERE p2.PID = PERSON_ID;
END VIEW_RECOMMENDATIONS_HS;
--------------------------------------------------------
--  DDL for Function CHECK_HEALTH_SUPPORTERS_SICK
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "CHECK_HEALTH_SUPPORTERS_SICK" 
(
  p_PID IN NUMBER
) RETURN NUMBER AS 
  counter1 NUMBER; 
  counter2 NUMBER := 0;
  
BEGIN
  SELECT COUNT(*) INTO counter1 FROM Patient sp WHERE sp.pid = p_PID;
  dbms_output.put_line('counter1: ' || counter1);
  IF  counter1 = 0 THEN
    dbms_output.put_line('counter1: ' || counter1);
    RETURN 3;
  END IF;
  
  SELECT COUNT(*) INTO counter2 FROM HealthSupporters hs WHERE hs.pid = p_PID;
  dbms_output.put_line('counter2: ' || counter2);
  RETURN counter2;
END CHECK_HEALTH_SUPPORTERS_SICK;
--------------------------------------------------------
--  Constraints for Table ALERTS
--------------------------------------------------------

  ALTER TABLE "ALERTS" MODIFY ("ALERT_TYPE" NOT NULL ENABLE)
 
  ALTER TABLE "ALERTS" MODIFY ("READ_FLAG" NOT NULL ENABLE)
 
  ALTER TABLE "ALERTS" ADD CHECK (alert_type IN ('OUTSIDE_LIMIT', 'LOW_ACTIVITY')) ENABLE
 
  ALTER TABLE "ALERTS" ADD PRIMARY KEY ("AID") ENABLE
--------------------------------------------------------
--  Constraints for Table DISEASE
--------------------------------------------------------

  ALTER TABLE "DISEASE" MODIFY ("DNAME" NOT NULL ENABLE)
 
  ALTER TABLE "DISEASE" ADD PRIMARY KEY ("DID") ENABLE
--------------------------------------------------------
--  Constraints for Table DISEASE_HI
--------------------------------------------------------

  ALTER TABLE "DISEASE_HI" ADD PRIMARY KEY ("DID", "HID") ENABLE
--------------------------------------------------------
--  Constraints for Table HEALTHINDICATORS
--------------------------------------------------------

  ALTER TABLE "HEALTHINDICATORS" ADD CONSTRAINT "HI_TYPE" CHECK (hi_type IN ('RANGE', 'ENUM')) ENABLE
 
  ALTER TABLE "HEALTHINDICATORS" MODIFY ("HNAME" NOT NULL ENABLE)
 
  ALTER TABLE "HEALTHINDICATORS" ADD PRIMARY KEY ("HID") ENABLE
 
  ALTER TABLE "HEALTHINDICATORS" MODIFY ("HI_TYPE" NOT NULL ENABLE)
--------------------------------------------------------
--  Constraints for Table HEALTHSUPPORTERS
--------------------------------------------------------

  ALTER TABLE "HEALTHSUPPORTERS" MODIFY ("AUTH_DATE" NOT NULL ENABLE)
 
  ALTER TABLE "HEALTHSUPPORTERS" ADD CHECK (hs_type IN ('PRIMARY', 'SECONDARY')) ENABLE
 
  ALTER TABLE "HEALTHSUPPORTERS" ADD PRIMARY KEY ("PID", "HS_TYPE") ENABLE
--------------------------------------------------------
--  Constraints for Table HI_ENUMVALUES
--------------------------------------------------------

  ALTER TABLE "HI_ENUMVALUES" MODIFY ("PARAM_NAME" NOT NULL ENABLE)
 
  ALTER TABLE "HI_ENUMVALUES" ADD PRIMARY KEY ("HID", "PARAM_NAME") ENABLE
 
  ALTER TABLE "HI_ENUMVALUES" ADD CONSTRAINT "VALUES_CHECK" CHECK (ENUM IN ('Happy','Sad','1','2','3','4','5','6','7','8','9','10')) ENABLE
--------------------------------------------------------
--  Constraints for Table HI_RANGEVALUES
--------------------------------------------------------

  ALTER TABLE "HI_RANGEVALUES" MODIFY ("PARAM_NAME" NOT NULL ENABLE)
 
  ALTER TABLE "HI_RANGEVALUES" ADD PRIMARY KEY ("HID", "PARAM_NAME") ENABLE
--------------------------------------------------------
--  Constraints for Table OBSERVATIONS
--------------------------------------------------------

  ALTER TABLE "OBSERVATIONS" MODIFY ("OBSERVATION_VALUE" NOT NULL ENABLE)
 
  ALTER TABLE "OBSERVATIONS" MODIFY ("OBSERVATION_TIME" NOT NULL ENABLE)
 
  ALTER TABLE "OBSERVATIONS" MODIFY ("RECORDED_DATE" NOT NULL ENABLE)
 
  ALTER TABLE "OBSERVATIONS" ADD PRIMARY KEY ("OBSERVATION_ID") ENABLE
--------------------------------------------------------
--  Constraints for Table PATIENT
--------------------------------------------------------

  ALTER TABLE "PATIENT" ADD PRIMARY KEY ("PID", "DID") ENABLE
--------------------------------------------------------
--  Constraints for Table PATIENT_HIENUMVALUES_OVERRIDE
--------------------------------------------------------

  ALTER TABLE "PATIENT_HIENUMVALUES_OVERRIDE" ADD PRIMARY KEY ("PID", "HID") ENABLE
 
  ALTER TABLE "PATIENT_HIENUMVALUES_OVERRIDE" ADD CONSTRAINT "VALUES_CHECK_PATIENT" CHECK (ENUM IN ('Happy','Sad','1','2','3','4','5','6','7','8','9','10')) ENABLE
--------------------------------------------------------
--  Constraints for Table PATIENT_HIRANGEVALUES_OVERRIDE
--------------------------------------------------------

  ALTER TABLE "PATIENT_HIRANGEVALUES_OVERRIDE" ADD PRIMARY KEY ("PID", "HID", "PARAM_NAME") ENABLE
--------------------------------------------------------
--  Constraints for Table PERSON
--------------------------------------------------------

  ALTER TABLE "PERSON" MODIFY ("P_PASSWORD" NOT NULL ENABLE)
 
  ALTER TABLE "PERSON" MODIFY ("P_NAME" NOT NULL ENABLE)
 
  ALTER TABLE "PERSON" MODIFY ("DOB" NOT NULL ENABLE)
 
  ALTER TABLE "PERSON" MODIFY ("GENDER" NOT NULL ENABLE)
 
  ALTER TABLE "PERSON" MODIFY ("EMAIL" NOT NULL ENABLE)
 
  ALTER TABLE "PERSON" MODIFY ("PHONE" NOT NULL ENABLE)
 
  ALTER TABLE "PERSON" ADD CHECK (gender IN ('M', 'F')) ENABLE
 
  ALTER TABLE "PERSON" ADD PRIMARY KEY ("PID") ENABLE
--------------------------------------------------------
--  Ref Constraints for Table ALERTS
--------------------------------------------------------

  ALTER TABLE "ALERTS" ADD FOREIGN KEY ("PID")
	  REFERENCES "PERSON" ("PID") ON DELETE CASCADE ENABLE
--------------------------------------------------------
--  Ref Constraints for Table DISEASE_HI
--------------------------------------------------------

  ALTER TABLE "DISEASE_HI" ADD FOREIGN KEY ("DID")
	  REFERENCES "DISEASE" ("DID") ON DELETE CASCADE ENABLE
 
  ALTER TABLE "DISEASE_HI" ADD FOREIGN KEY ("HID")
	  REFERENCES "HEALTHINDICATORS" ("HID") ENABLE
--------------------------------------------------------
--  Ref Constraints for Table HEALTHSUPPORTERS
--------------------------------------------------------

  ALTER TABLE "HEALTHSUPPORTERS" ADD FOREIGN KEY ("PID")
	  REFERENCES "PERSON" ("PID") ON DELETE CASCADE ENABLE
 
  ALTER TABLE "HEALTHSUPPORTERS" ADD FOREIGN KEY ("HS_PID")
	  REFERENCES "PERSON" ("PID") ON DELETE CASCADE ENABLE
--------------------------------------------------------
--  Ref Constraints for Table HI_ENUMVALUES
--------------------------------------------------------

  ALTER TABLE "HI_ENUMVALUES" ADD FOREIGN KEY ("HID")
	  REFERENCES "HEALTHINDICATORS" ("HID") ENABLE
--------------------------------------------------------
--  Ref Constraints for Table HI_RANGEVALUES
--------------------------------------------------------

  ALTER TABLE "HI_RANGEVALUES" ADD FOREIGN KEY ("HID")
	  REFERENCES "HEALTHINDICATORS" ("HID") ENABLE
--------------------------------------------------------
--  Ref Constraints for Table OBSERVATIONS
--------------------------------------------------------

  ALTER TABLE "OBSERVATIONS" ADD FOREIGN KEY ("PID")
	  REFERENCES "PERSON" ("PID") ON DELETE CASCADE ENABLE
--------------------------------------------------------
--  Ref Constraints for Table PATIENT
--------------------------------------------------------

  ALTER TABLE "PATIENT" ADD FOREIGN KEY ("DID")
	  REFERENCES "DISEASE" ("DID") ON DELETE CASCADE ENABLE
 
  ALTER TABLE "PATIENT" ADD FOREIGN KEY ("PID")
	  REFERENCES "PERSON" ("PID") ON DELETE CASCADE ENABLE
--------------------------------------------------------
--  Ref Constraints for Table PATIENT_HIENUMVALUES_OVERRIDE
--------------------------------------------------------

  ALTER TABLE "PATIENT_HIENUMVALUES_OVERRIDE" ADD FOREIGN KEY ("HID", "PARAM_NAME")
	  REFERENCES "HI_ENUMVALUES" ("HID", "PARAM_NAME") ENABLE
 
  ALTER TABLE "PATIENT_HIENUMVALUES_OVERRIDE" ADD FOREIGN KEY ("PID")
	  REFERENCES "PERSON" ("PID") ON DELETE CASCADE ENABLE
--------------------------------------------------------
--  Ref Constraints for Table PATIENT_HIRANGEVALUES_OVERRIDE
--------------------------------------------------------

  ALTER TABLE "PATIENT_HIRANGEVALUES_OVERRIDE" ADD FOREIGN KEY ("HID", "PARAM_NAME")
	  REFERENCES "HI_RANGEVALUES" ("HID", "PARAM_NAME") ENABLE
 
  ALTER TABLE "PATIENT_HIRANGEVALUES_OVERRIDE" ADD FOREIGN KEY ("PID")
	  REFERENCES "PERSON" ("PID") ON DELETE CASCADE ENABLE
