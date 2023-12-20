#Challenge 1
#1. You need to use SQL built-in functions to gain insights relating to the duration of movies:

#1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
select 
min(length) as min_duration,
max(length) as max_duration 
 from film;
 
 select length from film;
#1.2. Express the average movie duration in hours and minutes. Don't use decimals.
SELECT floor(avg(length)/60) as avg_length,
floor(avg(length)%60) as avg_minute,
concat(floor(avg(length)/60), 'h',floor(avg(length)%60),'m') as avg_time
from film;

#2 You need to gain insights related to rental dates:
# 2.1 Calculate the number of days that the company has been operating.
SELECT DATEDIFF(Max(return_date), Min(rental_date)) AS `Days of operation`
FROM rental;

#2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT *,
DAYNAME(rental_date),
monthname(rental_date),
MONTH(rental_date),
WEEKDAY(rental_date),
date_format(rental_date,'%M'),
date_format(rental_date,'W'),
CASE
	WHEN WEEKDAY(rental_date) <= 5 THEN 'Workday'
	WHEN WEEKDAY(rental_date) >= 5 THEN 'Weekend'
ELSE
	'Not a weekday at all'
End as workdays
FROM rental ;
#2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
#Hint: use a conditional expression

#3. You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
select 
	title,
    ifnull(rental_duration, 'Not available'),
	rental_duration	
from film 
where rental_duration is null;

#Bonus:
select concat(first_name,' ',last_name) as `Full name`,
left(email,3) as `First 3 char of email`
from customer;

#Challenge 2
#1.1 The total number of films that have been released.
select count(*) from film;
#1.2 The number of films for each rating.
select rating,count(*)  from film group by rating ;
#1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
select rating,count(*)  from film group by rating order by count(*) desc ;
#2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
select rating,round(avg(length)) from film group by rating order by round(avg(length))  desc;
#2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
select 
	rating,
    round(avg(length))
from 
	film 
group by rating 
having floor(avg(length)/60) >=2
order by round(avg(length)) desc;

#Bonus: determine which last names are not repeated in the table actor.
select last_name
from actor
group by last_name
having count(*) = 1; 