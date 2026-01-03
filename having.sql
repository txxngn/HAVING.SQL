--WHERE clause (which filters the rows which are to be grouped), then how exactly do we filter the grouped rows?
--Luckily, SQL allows us to do this by adding an additional HAVING clause which is used specifically with the GROUP BY clause to allow us to filter grouped rows from the result set.
    
--How many of the sales reps have more than 5 accounts that they manage?

SELECT s.id, s.name, COUNT(*) AS num_accounts
FROM accounts a
JOIN sales_reps s
    ON a.sales_rep_id = s.id
GROUP BY s.id, s.name
HAVING COUNT(*) > 5
ORDER BY num_accounts;

/*
and technically, we can get this using a SUBQUERY as shown below. 
This same logic can be used for the other queries, 
but this will not be shown.
*/
SELECT COUNT(*) num_reps_above5
FROM
    (SELECT s.id, s.name, COUNT(*) num_accounts
        FROM accounts a
        JOIN sales_reps s
        ON s.id = a.sales_rep_id
        GROUP BY s.id, s.name
        HAVING COUNT(*) > 5
        ORDER BY num_accounts
    ) AS Table1;


--How many accounts have more than 20 orders?
SELECT a.id, a.name, COUNT(*) num_orders
FROM accounts a
JOIN orders o
    ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING COUNT (*) > 20
ORDER BY num_orders;

--Which account has the most orders?
SELECT a.name, COUNT (*) AS num_orders
FROM accounts a
JOIN orders o
    ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY num_orders DESC
LIMIT 1;


--How many accounts spent more than 30,000 usd total across all orders?
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
    ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING SUM(o.total_amt_usd) > 30000
ORDER BY total_spent;

--Which account has spent the most?
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
    ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total_spent DESC
LIMIT 1;

--Which accounts used FACEBOOK as a CHANNEL to contact customers more than 6 times?
SELECT a.id, a.name, w.channel, COUNT(*) AS use_of_channel
FROM accounts a
JOIN web_events w
    ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
HAVING COUNT(*) > 6 AND w.channel = 'facebook'
ORDER BY use_of_channel;

 
--Which account used facebook most as a channel?
SELECT a.id, a.name, w.channel, COUNT(*) AS use_of_channel
FROM accounts a
JOIN web_events w
    ON a.id = w.account_id
WHERE w.channel = 'facebook'
GROUP BY a.id, a.name, w.channel
ORDER BY use_of_channel DESC
LIMIT 1;


--Which channel was most frequently used by most accounts?
SELECT a.id, a.name, w.channel, COUNT(*) AS use_of_channel
FROM accounts a
JOIN web_events w
    ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
ORDER BY use_of_channel DESC
LIMIT 10;

