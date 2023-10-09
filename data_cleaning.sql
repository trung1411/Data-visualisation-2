select count(*), gender from ardd_fatalities group by gender; -- 6457 fatalities
select distinct age_group from ardd_fatalities;
select count(*) from ardd_fatal_crashes; -- 5978 fatal crashes

create table crashes_fatalities 
as select count(crash_id) as number_of_crashes,  number_of_fatalities from ardd_fatal_crashes group by number_of_fatalities;

select * from ardd_fatal_crashes;
select * from crashes_fatalities;

alter table ardd_fatal_crashes add time_period DATE;

alter session set nls_date_format ='MM/DD/YYYY HH24:MI:SS';
update ardd_fatal_crashes set time_period = to_date(time, 'HH24:MI');

select * from ardd_fatalities;
update ardd_fatalities set time = '0'||time where length(time) < 5;
alter table ardd_fatalities add time_period DATE;
update ardd_fatalities set time_period = to_date(time, 'HH24:MI');

-- Changing the time by rounding them down to the nearest hours (21: 01 to 21:00, 21:45 to 21:00)
select * from ardd_fatalities;
update ardd_fatalities set time_period = case
when substr(time, 1, 2) = '00' then to_date('00:00', 'HH24:MI')
when substr(time, 1, 2) = '01' then to_date('01:00', 'HH24:MI')
when substr(time, 1, 2) = '02' then to_date('02:00', 'HH24:MI')
when substr(time, 1, 2) = '03' then to_date('03:00', 'HH24:MI')
when substr(time, 1, 2) = '04' then to_date('04:00', 'HH24:MI')
when substr(time, 1, 2) = '05' then to_date('05:00', 'HH24:MI')
when substr(time, 1, 2) = '06' then to_date('06:00', 'HH24:MI')
when substr(time, 1, 2) = '07' then to_date('07:00', 'HH24:MI')
when substr(time, 1, 2) = '08' then to_date('08:00', 'HH24:MI')
when substr(time, 1, 2) = '09' then to_date('09:00', 'HH24:MI')
when substr(time, 1, 2) = '10' then to_date('10:00', 'HH24:MI')
when substr(time, 1, 2) = '11' then to_date('11:00', 'HH24:MI')
when substr(time, 1, 2) = '12' then to_date('12:00', 'HH24:MI')
when substr(time, 1, 2) = '13' then to_date('13:00', 'HH24:MI')
when substr(time, 1, 2) = '14' then to_date('14:00', 'HH24:MI')
when substr(time, 1, 2) = '15' then to_date('15:00', 'HH24:MI')
when substr(time, 1, 2) = '16' then to_date('16:00', 'HH24:MI')
when substr(time, 1, 2) = '17' then to_date('17:00', 'HH24:MI')
when substr(time, 1, 2) = '18' then to_date('18:00', 'HH24:MI')
when substr(time, 1, 2) = '19' then to_date('19:00', 'HH24:MI')
when substr(time, 1, 2) = '20' then to_date('20:00', 'HH24:MI')
when substr(time, 1, 2) = '21' then to_date('21:00', 'HH24:MI')
when substr(time, 1, 2) = '22' then to_date('22:00', 'HH24:MI')
else to_date('23:00', 'HH24:MI') end;

-- Create csv file for lasagna heat map
create table fatalities_weekday_time as 
select count(crash_id) as number_of_fatalities, dayweek, time_period from ardd_fatalities group by dayweek, time_period order by dayweek, time_period;
select sum(number_of_fatalities) from fatalities_weekday_time;
 
select * from  fatalities_weekday_time where to_char(time_period, 'HH:MM') = '02:10';
select * from fatalities_weekday_time where dayweek = 'Monday';

-- Update state in ardd_fatal_crashes
alter table ardd_fatal_crashes modify state varchar(100);
update ardd_fatal_crashes set state =  
case
when state = 'ACT' then 'Australian Capital Territory'
when state = 'NSW' then 'New South Wales'
when state = 'NT' then 'Northern Territory'
when state = 'Qld' then 'Queensland'
when state = 'SA' then 'South Australia'
when state = 'Tas' then 'Tasmania' 
when state = 'Vic' then 'Victoria'
else 'Western Australia' end;


-- Updating age group in ardd_fatalities
update ardd_fatalities set age_group = 
case 
when age_group = '75_or_older' then '>75'
when age_group = '17_to_25' then '17-25'
when age_group = '26_to_39' then '26-39'
when age_group = '65_to_74' then '65-74'
when age_group = '0_to_16' then '0-16'
when age_group = '40_to_64' then '40-64'
else 'unknown' 
end where age_group in ('75_or_older', '17_to_25', '26_to_39','65_to_74','0_to_16','40_to_64');

-- Updating gender
update ardd_fatalities set gender = 'unknown' where gender = '-9';
select * from ardd_fatal_crashes;


-- Updating age
select * from ardd_fatalities;
delete from ardd_fatalities where age = -9;

-- Deleting speed_limit, gender, ROAD_USER
select count(*) from ardd_fatalities where speed_limit = -9;
delete from ardd_fatalities where speed_limit = -9;
delete from ardd_fatalities where gender = 'unknown';
delete from ardd_fatalities where road_user = 'Other/-9';

select * from ardd_fatalities;

select * from fit3179_fat_per_year;
drop table fit3179_fat_per_year;
create table FIT3179_fat_per_year as
select count(crash_id) as fatalities_per_year, state, year from ardd_fatalities group by state, year order by year asc, state asc;

update fit3179_fat_per_year set state =  
case
when state = 'ACT' then 'Australian Capital Territory'
when state = 'NSW' then 'New South Wales'
when state = 'NT' then 'Northern Territory'
when state = 'Qld' then 'Queensland'
when state = 'SA' then 'South Australia'
when state = 'Tas' then 'Tasmania' 
when state = 'Vic' then 'Victoria'
else 'Western Australia' end;

select * from fit3179_fat_per_year;


select * from ardd_fatalities8;

-- State
select distinct(state) from ardd_fatalities;
-- ==> No unknown value for state

-- Create table with number of fatalities aggregated by state and year
select * from fit3179_fat_per_year;

drop table fit3179_fat_per_year;
create table fit3179_fat_per_year as select count(crash_id) as fatalities, state, year from ardd_fatalities group by state, 
year order by year, state asc;



-- Gender
select distinct(gender) from ardd_fatalities;
-- ==> There are unknown/ na values assigned value -9
select count(gender) from ardd_fatalities where gender = '-9';
update ardd_fatalities set gender = 'Unknown' where gender = '-9';

-- Create table with number of fatalities aggregated by gender and year
drop table fit3179_fat_per_year_gender;
create table fit3179_fat_per_year_gender as select count(crash_id) as fatalities, gender, state, month, year, month||year as time_id from ardd_fatalities group by gender, state, month, year order by year, month, state asc;
select * from fit3179_fat_per_year_gender;

-- Updating time column for fit_3179_fat_per_year_gender
alter table fit3179_fat_per_year_gender add (time DATE);
update fit3179_fat_per_year_gender set time = to_date(time_id, 'MMYYYY') where month > 9;
update fit3179_fat_per_year_gender set time_id = '0'||time_id where month < 10;
update fit3179_fat_per_year_gender set time = to_date(time_id, 'MMYYYY') where month < 10;


alter table fit3179_fat_per_year_gender modify state varchar(100);
update fit3179_fat_per_year_gender set state =  
case
when state = 'ACT' then 'Australian Capital Territory'
when state = 'NSW' then 'New South Wales'
when state = 'NT' then 'Northern Territory'
when state = 'Qld' then 'Queensland'
when state = 'SA' then 'South Australia'
when state = 'Tas' then 'Tasmania' 
when state = 'Vic' then 'Victoria'
else 'Western Australia' end;

select * from fit3179_fat_per_year_gender;




