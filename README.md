# RFM-Analysis-Sales-Data-SQL-Tableau

## Overview:

In this project, we embark on a comprehensive exploration of a sales dataset to extract valuable insights into customers' past purchase behavior using data from the source [Kaggle: Sample Sales Data](https://www.kaggle.com/datasets/kyanyoga/sample-sales-data) The primary goal is to generate actionable analytics that can empower the sales team to make informed decisions. The analysis spans from initial data inspection to advanced analytics, covering a wide range of SQL techniques such as basic queries, subqueries, Common Table Expressions (CTEs), aggregate functions, and window functions. At my current analyst role, I am regulary asked to provide similar reports to the sales team in order for them to take acton based on the developement of sales of our different products and this porject allows me to showcase some of the skills I employ at the moment.

## Analysis

The journey begins with a preliminary examination of the sales_data table, where we assess unique values in key columns such as ORDERNUMBER, STATUS, PRODUCTLINE, COUNTRY, DEALSIZE, and TERRITORY. This initial step provides a foundational understanding of the dataset's diversity.

The analysis then progresses into more advanced SQL operations. We delve into grouping sales data by different dimensions, starting with PRODUCTLINE and YEAR_ID, to identify high-performing products and years contributing significantly to overall sales revenue.

To gain deeper insights into the dataset's temporal aspect, we analyze sales during 2005 and identify that data is only available until May. This insight leads to further investigations, including identifying the best month for sales in a specific year (2004) and assessing revenue generation based on deal sizes.

A crucial part of the project involves creating a customer segmentation analysis using the RFM technique. The process includes calculating Recency, Frequency, and MonetaryValue metrics for each customer. The resulting segmentation helps categorize customers into distinct groups such as 'lost_customers,' 'slipping_away,' 'new_customers,' 'potential churners,' 'active,' and 'loyal.' This segmentation provides a strategic framework for targeted actions by the sales team.

Finally, the project explores product associations by identifying orders with two products sold together. This analysis is conducted using the SQL XML Path function, which concatenates product codes for orders with exactly two products. Understanding product associations is valuable for optimizing marketing strategies and enhancing product bundling.

Throughout the project, various SQL skills are employed, ranging from basic queries to handling complex problems using subqueries, CTEs, aggregate functions, and window functions. The project emphasizes the practical application of these skills in a real-world context, mirroring scenarios where similar reports are generated to facilitate data-driven decision-making. Additionally, a tableau dashboard is created in order to display some of the key features of the analysis in a much more visual and appealing way to the stake holders.

## Links:
### Sample Sales Data (Kaggle)
[Dataset: Sample Sales Data](https://github.com/FranciscoLoncq/RFM-Analysis-Sales-Data-SQL-Tableau/blob/main/sales_data_sample.csv)

### RFM Analysis SQL Query
[SQL Analysis Query](https://github.com/FranciscoLoncq/RFM-Analysis-Sales-Data-SQL-Tableau/blob/main/SalesData%20Query.sql)

### Tableau
[Sales Dashboard 1](https://public.tableau.com/app/profile/francisco.loncq/viz/Kaggle_Sales_Dashboard_1/SalesDashboard)

[Sales Dashboard 2](https://public.tableau.com/app/profile/francisco.loncq/viz/Kaggle_Sales_Dashboard_2/SalesDashboard2)

### Credits
Angelina Frimpong
