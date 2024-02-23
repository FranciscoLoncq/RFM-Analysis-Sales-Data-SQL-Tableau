--Preliminar inspection of the database
SELECT * FROM dbo.sales_data

--Checking for unique values
SELECT DISTINCT count(ORDERNUMBER) FROM sales_data
SELECT DISTINCT STATUS FROM sales_data --Good stat to plot
SELECT DISTINCT PRODUCTLINE FROM sales_data  --Good stat to plot
SELECT DISTINCT COUNTRY FROM sales_data --19 countries to plot
SELECT DISTINCT DEALSIZE FROM sales_data
SELECT DISTINCT TERRITORY FROM sales_data

SELECT DISTINCT MONTH_ID FROM sales_data
WHERE YEAR_ID = 2005

--Analysis
--Grouping sales by product line
SELECT PRODUCTLINE, ROUND(SUM(SALES),0) AS REVENUE
FROM SALES_DATA
GROUP BY PRODUCTLINE
ORDER BY SUM(SALES) desc

SELECT YEAR_ID, ROUND(SUM(SALES),0) AS REVENUE
FROM SALES_DATA
GROUP BY YEAR_ID
ORDER BY SUM(SALES) desc

--Low sales during 2005. Lets analyze how many months are in the dataset for that year
--Data only covered up to may

SELECT DEALSIZE, ROUND(SUM(SALES),0) AS REVENUE
FROM SALES_DATA
GROUP BY DEALSIZE
ORDER BY SUM(SALES) desc

--Medium Size deals are generating more revenue

--Which was the best month for sales in a specific year? How much was earned?
SELECT MONTH_ID, ROUND(SUM(SALES),0) AS REVENUE, COUNT (ORDERNUMBER) AS FREQUENCY
FROM SALES_DATA
WHERE YEAR_ID = 2004
GROUP BY MONTH_ID
ORDER BY SUM(SALES) desc

--November looks to be the most succesful month both in revenue and in volume of orders
--Which product is the best performer?
SELECT PRODUCTLINE, ROUND(SUM(SALES),0) AS REVENUE, COUNT(ORDERNUMBER) AS FREQUENCY
FROM SALES_DATA
WHERE MONTH_ID = 11
GROUP BY PRODUCTLINE
ORDER BY PRODUCTLINE, SUM(SALES) desc

--Who is the best customer? Calculating by using RFM analysis
--Recency: Last Order Date
--Frequency: Count of Total Orders
--Monetary Value: Total Spend


--We will create a CTE and then pass it into a Temp Table in order to avoid running all the code each time

DROP TABLE IF EXISTS #rfm
;WITH rfm AS
(
    SELECT
        CUSTOMERNAME,
        SUM(SALES) AS MonetaryValue,
        AVG(SALES) AS AvgMonetaryValue,
        COUNT(ORDERNUMBER) AS Frequency,
        MAX(ORDERDATE) AS Last_Order_Date,
        (SELECT MAX(ORDERDATE) FROM SALES_DATA) AS Max_Order_Date,
        DATEDIFF(DD, MAX(ORDERDATE), (SELECT MAX(ORDERDATE) FROM SALES_DATA)) AS Recency
    FROM SALES_DATA
    GROUP BY CUSTOMERNAME
),
rfm_calc AS 
(

SELECT 
    r.*,
    NTILE(4) OVER (ORDER BY Recency desc) AS rfm_recency,
    NTILE(4) OVER (ORDER BY Frequency) AS rfm_frequency,
    NTILE(4) OVER (ORDER BY MonetaryValue) AS rfm_monetary
FROM rfm r
)
SELECT 
	c.*, 
	rfm_recency+ rfm_frequency+ rfm_monetary as rfm_cell,
	cast(rfm_recency as varchar)+cast(rfm_frequency as varchar)+cast(rfm_monetary as varchar) as rfm_cell_string
into #rfm
from rfm_calc c;


--Now that we obtained a temp table with our data we can continue wih our customer segmentation analysis
--We will do so by using a CASE statement

SELECT CUSTOMERNAME, rfm_recency, rfm_frequency, rfm_monetary,
CASE	
	WHEN rfm_cell_string in (111, 112, 121, 122, 123, 132, 211, 212, 114, 141) THEN 'lost_customers' --lost customers
	WHEN rfm_cell_string in (133, 134, 143, 244, 334, 343, 344, 144) THEN 'slipping_away, cannot lose' --big spenders who have not purchased lately
	WHEN rfm_cell_string in (311, 411, 331) THEN 'new_customers' 
	WHEN rfm_cell_string in (222, 223, 233, 322) THEN 'potential churners' 
	WHEN rfm_cell_string in (323, 333, 321, 422, 332, 432) THEN 'active' --(Customers who buy often & recenctly but at low price points)
	WHEN rfm_cell_string in (423, 433, 434, 443, 444) THEN 'loyal'
	end rfm_segment

FROM #rfm

--What Products are most often sold together?
--SELECT * FROM sales_data WHERE ORDERNUMBER = 10411

SELECT DISTINCT ORDERNUMBER, stuff(

(SELECT ',' + PRODUCTCODE 
FROM sales_data p
WHERE ORDERNUMBER in 
	(

SELECT ORDERNUMBER
FROM (
	SELECT ORDERNUMBER, count(*) AS rn
FROM sales_data
WHERE status='Shipped'
GROUP BY ORDERNUMBER
) AS m
where rn=2
)
AND p.ORDERNUMBER = s.ORDERNUMBER
for xml path ('')), 1, 1, '') AS ProductCodes

FROM sales_data as S
ORDER BY 2 desc

--We obtain a table where we can see orders with only two products ordered together
--This will allow to indentify which are the most likely products to be sold in pairs


