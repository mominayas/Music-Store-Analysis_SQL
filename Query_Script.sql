--#####SET1######
--#Q1 Who is the senior most employee?
Select * from employee
order by levels desc
limit 1
--##Ans: Mohan Madan 

--#Q2 Which counries have the most invoices?
select count (*) as c, billing_country
from invoice
group by billing_country
order by c desc
--##Ans; USA

--#Q3 Top 3 values of total invoices?
select total from invoice
order by total desc
limit 3
--##Ans: 23.759--19.8--19.8

--#Q4 City with highest invoices total
select sum(total) as s, billing_city from invoice
group by billing_city
order by s desc
limit 1
--##Ans: Prague with 273.24 invoices in total

--#Q5 Best customer; person who spent the most money
select customer.customer_id, customer.first_name, customer.last_name, sum(invoice.total) as spent from customer
join invoice on customer.customer_id = invoice.customer_id
group by customer.customer_id
order by spent desc
limit 1
--##Ans: Best customer is R Madhav spent who 144.54

--#######SET2#######
--Q1 return first name, last name, genre of rock music listeners, ordered alphabetically by email
select distinct email, first_name, last_name from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
where track_id in(
	select track_id from track
	join genre on track.genre_id = genre.genre_id
	where genre.name='Rock')
order by email;

--Q2 Artist who have written the most rock music, top 10 rock bands
select artist.artist_id, artist.name, count(artist.artist_id) as songs from track
join album on album.album_id = track.album_id
join artist on artist.artist_id =album.artist_id
join genre on genre.genre_id = track.genre_id
where genre.name='Rock'
group by artist.artist_id
order by songs desc
limit 10

--Q3 track names with length bigger than average, with miliseconds, list longest first
select name, milliseconds from track
where milliseconds > (select avg(milliseconds) as avg_len from track)
order by milliseconds desc;

--#####SET3######
--Q1 Amount spent by each customer on artists, customer name, artisit name and total spent making a temp table using cte

with best_artist as (
	select artist.artist_id as artist_id, artist.name as artist_name,
	sum(invoice_line.unit_price * invoice_line.quantity) as sales
	from invoice_line
	join track on track.track_id = invoice_line.track_id
	join album on album.album_id = track.album_id
	join artist on artist.artist_id = album.artist_id
	group by 1
	order by 3 desc
	limit 1)
select c.customer_id, c.first_name, c.last_name, ba.artist_name, sum(il.unit_price*il.quantity) as amount_spent
from invoice i
join customer c on c.customer_id = i.customer_id
join invoice_line il on il.invoice_id = i.invoice_id
join track t on t.track_id = il.track_id
join album alb on alb.album_id = t.album_id
join best_artist ba on ba.artist_id = alb.artist_id
group by 1,2,3,4
order by 5 desc;

--Q2 each countrys most popular Genre. For countries where the maximum number of purchases is shared return all Genres

with pop_genre as (
    select count(invoice_line.quantity) as purchases, customer.country, genre.name, genre.genre_id, 
	row_number() over(partition by customer.country order by count(invoice_line.quantity) desc) as row 
    from invoice_line 
	join invoice on invoice.invoice_id = invoice_line.invoice_id
	join customer on customer.customer_id = invoice.customer_id
	join track on track.track_id = invoice_line.track_id
	join genre on genre.genre_id = track.genre_id
	group by 2,3,4
	order by 2 asc, 1 desc)
select * from pop_genre where row = 1

--Q3 country along with the top customer and how much they spent for countries where the top amount spent is shared, provide all customers who spent this amount
with top_cust_country as (
		select customer.customer_id,first_name,last_name,billing_country,sum(total) as total_spending,
	    row_number() over(partition by billing_country order by sum(total) desc) as row 
		from invoice
		join customer on customer.customer_id = invoice.customer_id
		group by 1,2,3,4
		order by 4 asc,5 desc)
select * from top_cust_country where row = 1