select * from ardd_fatalities;
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
select count(*) from ardd_fatalities;
