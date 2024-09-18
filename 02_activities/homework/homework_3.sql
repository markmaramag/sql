-- AGGREGATE
/* 1. Write a query that determines how many times each vendor has rented a booth 
at the farmer’s market by counting the vendor booth assignments per vendor_id. */

SELECT v.vendor_id, 
       v.vendor_name, 
       COUNT(*) AS booth_rentals
-- Select the vendor ID, vendor name, and count of booth rentals
FROM vendor_booth_assignments AS vba
-- Join the vendor and vendoor booth assignments table to display vendor names
INNER JOIN vendor AS v
    -- Match the vendor_id in both tables
    ON v.vendor_id = vba.vendor_id
-- Group the results by vendor ID and name to count booth rentals per vendor
GROUP BY v.vendor_id, v.vendor_name;

/* 2. The Farmer’s Market Customer Appreciation Committee wants to give a bumper 
sticker to everyone who has ever spent more than $2000 at the market. Write a query that generates a list 
of customers for them to give stickers to, sorted by last name, then first name. 

HINT: This query requires you to join two tables, use an aggregate function, and use the HAVING keyword. */

SELECT c.customer_id, 
       c.customer_last_name, 
       c.customer_first_name, 
       -- Calculate the total amount spent by each customer (quantity * cost per unit)
       SUM(cp.quantity * cp.cost_to_customer_per_qty) AS total_spent
-- Select from the customer table (alias as 'c')
FROM customer AS c
-- Join with the customer_purchases table (alias as 'cp') on customer_id
JOIN customer_purchases AS cp
    ON c.customer_id = cp.customer_id
-- Group by customer ID, last name, and first name to summarize spending per customer
GROUP BY c.customer_id, c.customer_last_name, c.customer_first_name
-- Filter the results to include only customers who spent more than $2000
HAVING SUM(cp.quantity * cp.cost_to_customer_per_qty) > 2000
-- Sort the results alphabetically by last name, then first name
ORDER BY c.customer_last_name, c.customer_first_name;

--Temp Table
/* 1. Insert the original vendor table into a temp.new_vendor and then add a 10th vendor: 
Thomass Superfood Store, a Fresh Focused store, owned by Thomas Rosenthal

HINT: This is two total queries -- first create the table from the original, then insert the new 10th vendor. 
When inserting the new vendor, you need to appropriately align the columns to be inserted 
(there are five columns to be inserted, I've given you the details, but not the syntax) 

-> To insert the new row use VALUES, specifying the value you want for each column:
VALUES(col1,col2,col3,col4,col5) 
*/

-- Drop the table if it already exists
DROP TABLE IF EXISTS temp.new_vendor;

-- Create a new temporary table and insert data from the original vendor table
CREATE TABLE temp.new_vendor AS
SELECT *
FROM vendor;

-- Insert a new vendor into the temp.new_vendor table
INSERT INTO temp.new_vendor (vendor_id, vendor_name, vendor_type, vendor_owner_first_name, vendor_owner_last_name)
VALUES (10, 'Thomass Superfood Store', 'Fresh Focused', 'Thomas', 'Rosenthal');

-- Check the contents of the temp.new_vendor table
SELECT *
FROM temp.new_vendor;


-- Date
/*1. Get the customer_id, month, and year (in separate columns) of every purchase in the customer_purchases table.

HINT: you might need to search for strfrtime modifers sqlite on the web to know what the modifers for month 
and year are! */

/* 2. Using the previous query as a base, determine how much money each customer spent in April 2022. 
Remember that money spent is quantity*cost_to_customer_per_qty. 

HINTS: you will need to AGGREGATE, GROUP BY, and filter...
but remember, STRFTIME returns a STRING for your WHERE statement!! */

