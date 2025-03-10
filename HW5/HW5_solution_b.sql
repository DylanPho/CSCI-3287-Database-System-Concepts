-- 1. Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.
-- Issue: None
SELECT CustomerId, FirstName, LastName, Country 
FROM Customer 
WHERE Country <> 'USA';

-- 2. Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.
-- Issue: None
SELECT C.FirstName, C.LastName, I.InvoiceId, I.InvoiceDate, I.BillingCountry 
FROM Invoice I
JOIN Customer C ON I.CustomerId = C.CustomerId
WHERE C.Country = 'Brazil';

-- 3. Provide a query showing only the Employees who are Sales Agents.
-- Issue: None
SELECT EmployeeId, FirstName, LastName, Title 
FROM Employee 
WHERE Title = 'Sales Support Agent';

-- 4. Provide a query showing a unique list of billing countries from the Invoice table.
-- Issue: None
SELECT DISTINCT BillingCountry FROM Invoice;

-- 5. Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.
-- Issue: None
SELECT E.FirstName AS SalesAgent, C.FirstName AS Customer, I.InvoiceId
FROM Invoice I
JOIN Customer C ON I.CustomerId = C.CustomerId
JOIN Employee E ON C.SupportRepId = E.EmployeeId
WHERE E.Title = 'Sales Support Agent';

-- 6. Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.
-- Issue: None
SELECT I.InvoiceId, I.Total, C.FirstName AS Customer, C.Country, E.FirstName AS SalesAgent
FROM Invoice I
JOIN Customer C ON I.CustomerId = C.CustomerId
JOIN Employee E ON C.SupportRepId = E.EmployeeId;

-- 7. How many Invoices were there in 2011? What are the respective total sales for each of those years?
-- Issue: I used the same database information in the sample solution, the queery code is correct but the result will be empty due to the earliest invoice was in 2021.
SELECT YEAR(InvoiceDate) AS Year, COUNT(*) AS InvoiceCount, SUM(Total) AS TotalSales
FROM Invoice
WHERE YEAR(InvoiceDate) = 2011
GROUP BY YEAR(InvoiceDate);

-- 8. Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice.
-- Issue: None
SELECT InvoiceId, COUNT(*) AS LineItemCount 
FROM InvoiceLine 
GROUP BY InvoiceId;

-- 9. Provide a query that includes the track name with each invoice line item.
-- Issue: None
SELECT IL.InvoiceId, T.Name AS TrackName
FROM InvoiceLine IL
JOIN Track T ON IL.TrackId = T.TrackId;

-- 10. Provide a query that includes the purchased track name AND artist name with each invoice line item.
-- Issue: None
SELECT IL.InvoiceId, T.Name AS TrackName, A.Name AS ArtistName
FROM InvoiceLine IL
JOIN Track T ON IL.TrackId = T.TrackId
JOIN Album AL ON T.AlbumId = AL.AlbumId
JOIN Artist A ON AL.ArtistId = A.ArtistId;

-- 11. Provide a query that shows the # of invoices per country.
-- Issue: None
SELECT BillingCountry, COUNT(*) AS InvoiceCount
FROM Invoice
GROUP BY BillingCountry;

-- 12. Provide a query that shows the total number of tracks in each playlist. The Playlist name should be included on the resultant table.
-- Issue: None
SELECT P.Name AS PlaylistName, COUNT(PT.TrackId) AS TrackCount
FROM Playlist P
JOIN PlaylistTrack PT ON P.PlaylistId = PT.PlaylistId
GROUP BY P.Name;

-- 13. Provide a query that shows all the Tracks but displays no IDs. The resultant table should include the Album name, Media type and Genre.
-- Issue: None
SELECT T.Name AS TrackName, A.Title AS Album, M.Name AS MediaType, G.Name AS Genre
FROM Track T
JOIN Album A ON T.AlbumId = A.AlbumId
JOIN MediaType M ON T.MediaTypeId = M.MediaTypeId
JOIN Genre G ON T.GenreId = G.GenreId;

-- 14. Provide a query that shows all Invoices but includes the # of invoice line items.
-- Issue: None
SELECT I.InvoiceId, COUNT(IL.InvoiceLineId) AS NumberOfItems
FROM Invoice I
JOIN InvoiceLine IL ON I.InvoiceId = IL.InvoiceId
GROUP BY I.InvoiceId;

-- 15. Provide a query that shows total sales made by each sales agent.
-- Issue: None
SELECT E.FirstName AS SalesAgent, SUM(I.Total) AS TotalSales
FROM Invoice I
JOIN Customer C ON I.CustomerId = C.CustomerId
JOIN Employee E ON C.SupportRepId = E.EmployeeId
GROUP BY E.FirstName;

-- 16. Which sales agent made the most in sales in 2009?
-- Issue: I used the same database information in the sample solution, the queery code is correct but the result will be empty due to the earliest invoice was in 2021.
SELECT E.FirstName AS SalesAgent, SUM(I.Total) AS TotalSales
FROM Invoice I
JOIN Customer C ON I.CustomerId = C.CustomerId
JOIN Employee E ON C.SupportRepId = E.EmployeeId
WHERE YEAR(I.InvoiceDate) = 2009
GROUP BY E.FirstName
ORDER BY TotalSales DESC
LIMIT 1;

-- 17. Provide a query that shows the # of customers assigned to each sales agent.
-- Issue: None
SELECT E.FirstName AS SalesAgent, COUNT(C.CustomerId) AS CustomerCount
FROM Customer C
JOIN Employee E ON C.SupportRepId = E.EmployeeId
GROUP BY E.FirstName;

-- 18. Provide a query that shows the total sales per country. Which country's customers spent the most?
-- Issue: None
SELECT BillingCountry, SUM(Total) AS TotalSales
FROM Invoice
GROUP BY BillingCountry
ORDER BY TotalSales DESC

-- 19. Provide a query that shows the most purchased track of 2013.
-- Issue: None
SELECT T.Name AS TrackName, COUNT(IL.TrackId) AS PurchaseCount
FROM InvoiceLine IL
JOIN Invoice I ON IL.InvoiceId = I.InvoiceId
JOIN Track T ON IL.TrackId = T.TrackId
WHERE YEAR(I.InvoiceDate) = 2013
GROUP BY T.Name
ORDER BY PurchaseCount DESC
LIMIT 1;

-- 20. Provide a query that shows the top 3 best-selling artists.
-- Issue: None
SELECT A.Name AS ArtistName, SUM(IL.Quantity) AS TotalSales
FROM InvoiceLine IL
JOIN Track T ON IL.TrackId = T.TrackId
JOIN Album AL ON T.AlbumId = AL.AlbumId
JOIN Artist A ON AL.ArtistId = A.ArtistId
GROUP BY A.Name
ORDER BY TotalSales DESC
LIMIT 3;
