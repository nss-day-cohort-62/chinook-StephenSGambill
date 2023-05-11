-- 1
-- non_usa_customers.sql
-- Provide a query showing Customers who are not in the US. The resultant table should include:
-- Customer's full name
-- Customer Id,
-- Customer's country
SELECT FirstName, LastName, CustomerId, Country
FROM Customer
WHERE Country <> 'USA'

-- 2
-- brazil_customers.sql
-- Provide a query only showing the Customers from Brazil.
SELECT FirstName, LastName, CustomerId, Country
FROM Customer
WHERE Country = 'Brazil'

-- 3
-- brazil_customers_invoices.sql:
-- Provide a query showing the Invoices of Customers who are from Brazil. The resultant table should include:
-- Customer's full name
-- Invoice Id,
-- Date of the invoice
-- Billing country
SELECT FirstName, LastName, InvoiceId, InvoiceDate, BillingCountry
FROM Customer as c
Join Invoice as i ON c.CustomerId = i.CustomerId
WHERE Country = 'Brazil'

-- 4
-- sales_agents.sql
-- Provide a query showing only the Employees who are "Sales Agents"
SELECT FirstName, LastName, Title
From Employee
WHERE Title = 'Sales Support Agent'

-- 5
-- unique_invoice_countries.sql:
-- Provide a query showing a unique (distinct) list of billing countries from the Invoice table.
SELECT BillingCountry
FROM Invoice 
GROUP BY BillingCountry

-- 6 
-- sales_agent_invoices.sql:
-- Provide a query that shows the invoices associated with each sales agent. The resultant table should include:
-- Sales Agent's full name
-- Invoice ID

SELECT i.InvoiceId, e.FirstName || ' ' || e.LastName AS FullName
FROM Employee as e
Join Customer as c on e.EmployeeId = c.SupportRepId
Join Invoice as i on i.CustomerId = c.CustomerId
ORDER BY i.InvoiceId

-- 7
-- invoice_totals.sql:
-- Provide a query that shows the customers and employees associated with each invoice. The resultant table should include:
-- Invoice Total
-- Customer Name
-- Customer Country
-- Sale Agent full name

SELECT i.InvoiceId, i.Total, c.FirstName || ' ' || c.LastName AS Customer_Name, c.Country as Customer_Country, e.FirstName || ' ' || e.LastName AS SupportRep_Name
FROM Invoice as i
Join Customer as c on i.CustomerId = c.CustomerId
Join Employee as e on e.EmployeeId = c.SupportRepId

-- 8
-- total_invoices_{year}.sql:
-- How many Invoices were there in 2009 and 2011?
-- HINT: COUNT

SELECT COUNT(*) as TotalCount, strftime('%Y', InvoiceDate) AS Year
From Invoice 
WHERE  strftime('%Y', InvoiceDate) IN ('2009', '2011')
GROUP BY Year

-- 9
-- total_sales_{year}.sql:
-- What are the respective total sales for each of those years?
-- HINT: SUM
SELECT COUNT(*) as TotalCount, strftime('%Y', InvoiceDate) AS Year, SUM(Total) as TotalSales
From Invoice 
WHERE  strftime('%Y', InvoiceDate) IN ('2009', '2011')
GROUP BY Year

-- 10
-- invoice_37_line_item_count.sql:
-- Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37

SELECT COUNT(*) as TotalCount
From InvoiceLine
WHERE InvoiceId = '37'

-- 11
-- line_items_per_invoice.sql:
-- Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice.
-- HINT: GROUP BY
SELECT InvoiceId, COUNT(*)
From InvoiceLine
GROUP BY InvoiceId


-- 12
-- line_item_track.sql:
-- Provide a query that shows each Invoice line item, with the name of the track that was purchased.

SELECT il.InvoiceLineId, t.Name
FROM InvoiceLine as il
Join Track as t WHERE t.TrackId = il.TrackId
Group by il.InvoiceLineId

-- 13
-- line_item_track_artist.sql:
-- Provide a query that shows each Invoice line item, with the name of the track that was purchase, and the name of the artist.
SELECT il.InvoiceLineId, t.Name as Track_Name, ar.Name as Artist_Name
FROM InvoiceLine as il
Join Track as t ON t.TrackId = il.TrackId
Join Album as a ON a.AlbumId = t.AlbumId
Join Artist as ar ON ar.ArtistId = a.ArtistId
Group by il.InvoiceLineId

-- 14
-- country_invoices.sql:
-- Provide a query that shows the total number of invoices per country.
-- HINT: GROUP BY

SELECT COUNT(*), BillingCountry
FROM Invoice
Group by BillingCountry

-- 15
-- playlists_track_count.sql:
-- Provide a query that shows the total number of tracks in each playlist. The resultant table should include:
-- Playlist name
-- Total number of tracks on each playlist

Select COUNT(t.TrackId) as Total_Tracks , pl.Name
From Playlist as pl
Join PlayListTrack as plt ON plt.PlaylistId = pl.PlaylistId
Join Track as t ON plt.TrackId = t.TrackId
GROUP BY pl.Name 
ORDER BY Total_Tracks

-- 16
-- tracks_no_id.sql:
-- Provide a query that shows all the Tracks, but displays no IDs. The resultant table should include:
-- Album name
-- Media type
-- Genre

SELECT t.Name as Track, a.Title as Album_Title, mt.Name as Media_Type, g.Name as Genre
FROM Track as t
Join Album as a ON t.AlbumId = a.AlbumId
Join MediaType as mt ON mt.MediaTypeId = t.MediaTypeId
Join Genre as g ON g.GenreId = t.GenreId
ORDER BY t.Name

-- 17
-- invoices_line_item_count.sql:
-- Provide a query that shows all Invoices. The resultant table should include:
-- InvoiceId
-- The total number of line items on each invoice

SELECT i.InvoiceId, COUNT(il.InvoiceId) as Total_Line_Items
FROM Invoice as i
Join InvoiceLine as il on i.InvoiceId = il.InvoiceId
GROUP BY i.InvoiceId

-- 18
-- sales_agent_total_sales.sql:
-- Provide a query that shows total sales made by each sales agent. The resultant table should include:
-- Employee full name
-- Total sales for each employee (all time)

SELECT e.FirstName, e.LastName, SUM(i.Total)
From Employee as e
Join Customer as c on c.SupportRepId = e.EmployeeId
Join Invoice as i on i.CustomerId = c.CustomerId
GROUP BY e.EmployeeId

-- 19
-- top_2009_agent.sql: Which sales agent made the most in sales in 2009?
-- HINT: Use the MAX function on a subquery.

SELECT e.FirstName, e.LastName, SUM(i.Total) as TotalSales
From Employee as e
Join Customer as c on c.SupportRepId = e.EmployeeId
Join Invoice as i on i.CustomerId = c.CustomerId
WHERE strftime('%Y', InvoiceDate) = '2009'
GROUP BY e.EmployeeId
ORDER BY TotalSales DESC
LIMIT 1

-- 20
-- top_agent.sql:
-- Which sales agent made the most in sales over all?
SELECT e.FirstName, e.LastName, SUM(i.Total) as TotalSales
From Employee as e
Join Customer as c on c.SupportRepId = e.EmployeeId
Join Invoice as i on i.CustomerId = c.CustomerId
GROUP BY e.EmployeeId
ORDER BY TotalSales DESC
LIMIT 1

-- 21
-- sales_agent_customer_count.sql:
-- Provide a query that shows how many customers are assigned to each employee. The resultant table should include:
-- Employee full name
-- Total number of customers assigned to each employee (even if it's zero)

SELECT e.FirstName || ' ' || e.LastName AS Full_Name, Count(c.SupportRepId) as CustomerCount
FROM Employee AS e
LEFT JOIN Customer AS c ON c.SupportRepId = e.EmployeeId 
WHERE c.SupportRepId IS NULL
    OR c.SupportRepId = e.EmployeeId
GROUP BY e.LastName

-- 22
-- sales_per_country.sql:
-- Provide a query that shows the total sales per country.

SELECT i.BillingCountry AS Country, SUM(i.Total) AS Total_Sales
FROM Invoice as i
GROUP BY i.BillingCountry

-- 23
-- top_country.sql:
-- Which country's customers spent the most?
-- HINT: Use the MAX function on a subquery.

SELECT i.BillingCountry AS Country, SUM(i.Total) AS Total_Sales
FROM Invoice as i
GROUP BY i.BillingCountry
ORDER BY Total_Sales DESC
LIMIT 1

SELECT i.BillingCountry AS Country, SUM(i.Total) AS Total_Sales
FROM Invoice AS i
GROUP BY i.BillingCountry
HAVING SUM(i.Total) = (
  SELECT MAX(Total_Sales)
  FROM (
    SELECT SUM(i2.Total) AS Total_Sales
    FROM Invoice AS i2
    GROUP BY i2.BillingCountry
  ) AS subquery
)

-- 24
-- top_2013_track.sql:
-- Provide a query that shows the most purchased track(s) of 2013.

SELECT t.Name, COUNT(il.Quantity) as PurchaseCount
FROM Track as t
JOIN InvoiceLine as il ON il.TrackId = t.TrackId
JOIN Invoice as i ON i.InvoiceId = il.InvoiceId
WHERE strftime('%Y', InvoiceDate) = '2013'
GROUP BY t.Name
ORDER BY PurchaseCount DESC

-- 25
-- top_5_tracks.sql:
-- Provide a query that shows the top 5 most purchased tracks over all.

SELECT t.Name, COUNT(il.Quantity) as PurchaseCount
FROM Track as t
JOIN InvoiceLine as il ON il.TrackId = t.TrackId
JOIN Invoice as i ON i.InvoiceId = il.InvoiceId
GROUP BY t.Name
ORDER BY PurchaseCount DESC
LIMIT 5

-- 26
-- top_3_artists.sql:
-- Provide a query that shows the top 3 best selling artists.

SELECT a.Name, COUNT(il.Quantity) as PurchaseCount
FROM Artist as a
JOIN Album as al ON al.ArtistId = a.ArtistId
JOIN Track as t ON t.AlbumId = al.AlbumId
JOIN InvoiceLine as il ON il.TrackId = t.TrackId
GROUP BY a.Name
ORDER BY PurchaseCount DESC
LIMIT 3

-- 27
-- top_media_type.sql:
-- Provide a query that shows the most purchased Media Type.

SELECT m.Name as Media_Type, COUNT(il.Quantity) as Total_Count
FROM MediaType as m
JOIN Track as t ON t.MediaTypeId = m.MediaTypeId
JOIN InvoiceLine as il ON il.TrackId = t.TrackId
GROUP BY m.Name
ORDER BY Total_Count DESC