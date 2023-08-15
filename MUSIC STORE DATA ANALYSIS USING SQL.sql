--Q1 Who is the senior most employee based on the job title?
SELECT *
FROM employee
ORDER BY levels DESC
LIMIT 1;

--Q2 Which countries have the most invoices?
SELECT billing_country ,COUNT(total) AS  t
FROM invoice
GROUP BY billing_country
ORDER BY t  DESC

-- Q3 What are top three values of total invoice?
SELECT total
FROM invoice
ORDER BY total DESC
LIMIT 3

-- Q4 WHICH CITY HAS THE BEST CUSTOMERS? WE WOULD LIKE TO THROW A PROMOTIONAL MUSIC FESTIVAL IN THE 
-- CITY WE MADE THE MOST MONEY. WRITE A QUERY THAT RETURNS ONE CITY THAT HAS THE HIGHEST SUM OF INVOICE TOTALS.
-- RETURN BOTH THE CITY NAME AND SUM OF ALL INVOICE TOTALS.

SELECT SUM(total) AS invoice_total , billing_city
FROM invoice
GROUP BY billing_city
ORDER BY invoice_total DESC

-- Q5 Who is the best customer? The customer who has spent the most money will be declared as the best
-- customer.Write a query that returns the person who has spent the most money

SELECT customer.customer_id , customer.first_name,customer.last_name, SUM(invoice.total) AS Total
FROM invoice
INNER JOIN customer
ON customer.customer_id=invoice.customer_id
GROUP BY customer.customer_id
ORDER BY Total DESC
LIMIT 1

-- Q6 Write a query to return the email,first name , last name, & Genre of all rock music listeners. 
-- Return your list ordered alphabetically by email starting with A.

SELECT DISTINCT customer.email, customer.first_name ,customer.last_name,genre.name
FROM customer
INNER JOIN invoice
ON customer.customer_id=invoice.customer_id
INNER JOIN invoice_line
ON invoice.invoice_id=invoice_line.invoice_id
INNER JOIN track
ON invoice_line.track_id=track.track_id
INNER JOIN genre
ON track.genre_id=genre.genre_id
WHERE genre.name LIKE 'Rock'   
ORDER BY customer.email 

-- Q7 Let's invite the artists who have written the most rock music in our dataset. 
-- Write a query that returns the artist name and total track count of the top 10 rock bands.

SELECT artist.artist_id,artist.name,COUNT(artist.artist_id) AS total_number_of_track
FROM track
JOIN album
ON album.album_id=track.album_id
JOIN artist
ON artist.artist_id=album.artist_id
JOIN genre
ON genre.genre_id=track.genre_id
WHERE genre.name LIKE 'ROCK'
GROUP BY artist.artist_id
ORDER BY total_number_of_track DESC
LIMIT 10;

-- Q8 Return all the track names that have a song length longer than the average song length.
-- Return the names and milliseconds for each track .Order by the song length with the longest song
-- listed first.

SELECT name ,milliseconds
FROM track 
WHERE milliseconds>(
                    SELECT AVG(milliseconds) AS avg_song_length
                    FROM track
                   )
ORDER BY milliseconds DESC











