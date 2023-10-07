select count(*) from ardd_fatalities;
select distinct age_group from ardd_fatalities;

-- Updating age group
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
select * from ardd_fatalities;
select distinct gender from ardd_fatalities;
update ardd_fatalities set gender = 'unknown' where gender = '-9';

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


-- 

