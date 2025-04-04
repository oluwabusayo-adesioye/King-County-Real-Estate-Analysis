SELECT *
FROM [king county house_sales]

--1.	What factors have the strongest correlation with higher sale prices?
SELECT building_grade,
	   number_of_bathrooms,
	   number_of_bedrooms,
	   ROUND(AVG(sale_price_adjusted_for_inflation), 0) AS avg_adjusted_sale_price,
	   ROUND(AVG(total_living_area_sq_ft), 0) AS avg_living_area,
	   ROUND(AVG(lot_size_sq_ft), 0) AS avg_lot_size,
	   COUNT(*) AS total_homes
FROM [king county house_sales]
GROUP BY building_grade,
	     number_of_bathrooms,
		 number_of_bedrooms
ORDER BY avg_adjusted_sale_price DESC;

--2. How do home prices vary by property type and zip code?
SELECT zip_code,
	   property_type,
	   COUNT(*) AS homes_sold,
	   ROUND(AVG(sale_price_adjusted_for_inflation), 0) AS avg_inflation_adjusted_sale_price
FROM [king county house_sales]
GROUP BY zip_code, property_type
ORDER BY avg_inflation_adjusted_sale_price DESC;

--3. How does inflation-adjusted pricing affect real estate trends?
SELECT YEAR(sale_date) AS sale_year,
	   ROUND(AVG(sale_price), 0) AS avg_sale_price,
	   ROUND(AVG(sale_price_adjusted_for_inflation), 0) AS avg_inflation_adjusted_price
FROM [king county house_sales]
GROUP BY YEAR(sale_date)
ORDER BY sale_year;

--4. Which locations have the highest proportion of new vs. old constructions, and do new homes sell for more?
SELECT zip_code,
       COUNT(CASE WHEN new_construction = 'True' THEN 1 END) AS New_Homes,
       COUNT(CASE WHEN new_construction = 'False' THEN 1 END) AS Old_Homes,
       ROUND(AVG(CASE WHEN new_construction = 'True' THEN sale_price_adjusted_for_inflation END), 0) AS Avg_New_Homes_Price,
       ROUND(AVG(CASE WHEN new_construction = 'False' THEN sale_price_adjusted_for_inflation END), 0) AS Avg_Old_Homes_Price
FROM [king county house_sales]
GROUP BY zip_code
ORDER BY New_Homes DESC;
