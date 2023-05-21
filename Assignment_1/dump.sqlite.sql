/*
Grouping by Narrow_Location to see the top employees with overal performance and employees with potential to be the best employees.
*/
WITH CTE AS (
    SELECT 
        Branch, 
  		geographical_region,
        Narrow_location, 
        Employee_ID, 
        Population * 3 AS Population_Total,
        customer_pa_2020 + customer_pa_2021 + customer_pa_2022 AS Customers_Total,
        (customer_pa_2020 + customer_pa_2021 + customer_pa_2022) / (population * 3.0) AS Customers_Over_Population_Percentage,
        LAG(Population * 3) OVER (PARTITION BY Narrow_location ORDER BY customer_pa_2020 + customer_pa_2021 + customer_pa_2022) AS Prev_Population_Total,
        LAG(customer_pa_2020 + customer_pa_2021 + customer_pa_2022) OVER (PARTITION BY Narrow_location ORDER BY customer_pa_2020 + customer_pa_2021 + customer_pa_2022) AS Prev_Customers_Total,
        ROW_NUMBER() OVER (PARTITION BY narrow_location ORDER BY (customer_pa_2020 + customer_pa_2021 + customer_pa_2022) / (population * 3.0) DESC) AS rn
    FROM 
        Exercise1
    GROUP BY 
        Branch, Narrow_location, Employee_ID, Population, customer_pa_2020, customer_pa_2021, customer_pa_2022
)
SELECT 
    Branch, 
    geographical_region,
    Narrow_location, 
    Employee_ID, 
    Population_Total,
    Customers_Total,
    Customers_Over_Population_Percentage
FROM 
    CTE
WHERE
    rn <= 2
ORDER BY 
    CASE
        WHEN Customers_Total > Prev_Customers_Total THEN Customers_Total
        ELSE Customers_Over_Population_Percentage
    END DESC,
    Population_Total DESC;



/*
Grouping by Branch to see the top employees with overal performance and employees with potential to be the best employees.
*/
WITH CTE AS (
    SELECT 
        Branch, 
  		geographical_region,
        Narrow_location, 
        Employee_ID, 
        Population * 3 AS Population_Total,
        customer_pa_2020 + customer_pa_2021 + customer_pa_2022 AS Customers_Total,
        (customer_pa_2020 + customer_pa_2021 + customer_pa_2022) / (population * 3.0) AS Customers_Over_Population_Percentage,
        LAG(Population * 3) OVER (PARTITION BY Narrow_location ORDER BY customer_pa_2020 + customer_pa_2021 + customer_pa_2022) AS Prev_Population_Total,
        LAG(customer_pa_2020 + customer_pa_2021 + customer_pa_2022) OVER (PARTITION BY Narrow_location ORDER BY customer_pa_2020 + customer_pa_2021 + customer_pa_2022) AS Prev_Customers_Total,
        ROW_NUMBER() OVER (PARTITION BY branch ORDER BY (customer_pa_2020 + customer_pa_2021 + customer_pa_2022) / (population * 3.0) DESC) AS rn
    FROM 
        Exercise1
    GROUP BY 
        Branch, Narrow_location, Employee_ID, Population, customer_pa_2020, customer_pa_2021, customer_pa_2022
)
SELECT 
    Branch, 
    geographical_region,
    Employee_ID, 
    Population_Total,
    Customers_Total,
    Customers_Over_Population_Percentage
FROM 
    CTE
WHERE
    rn <= 5
ORDER BY 
    CASE
        WHEN Customers_Total > Prev_Customers_Total THEN Customers_Total
        ELSE Customers_Over_Population_Percentage
    END DESC,
    Population_Total DESC;



/*
Grouping by Geographical_Region to see the top employees with overal performance and employees with potential to be the best employees.
*/    
WITH CTE AS (
    SELECT 
        Branch, 
  		geographical_region,
        Narrow_location, 
        Employee_ID, 
        Population * 3 AS Population_Total,
        customer_pa_2020 + customer_pa_2021 + customer_pa_2022 AS Customers_Total,
        (customer_pa_2020 + customer_pa_2021 + customer_pa_2022) / (population * 3.0) AS Customers_Over_Population_Percentage,
        LAG(Population * 3) OVER (PARTITION BY Narrow_location ORDER BY customer_pa_2020 + customer_pa_2021 + customer_pa_2022) AS Prev_Population_Total,
        LAG(customer_pa_2020 + customer_pa_2021 + customer_pa_2022) OVER (PARTITION BY Narrow_location ORDER BY customer_pa_2020 + customer_pa_2021 + customer_pa_2022) AS Prev_Customers_Total,
        ROW_NUMBER() OVER (PARTITION BY geographical_region ORDER BY (customer_pa_2020 + customer_pa_2021 + customer_pa_2022) / (population * 3.0) DESC) AS rn
    FROM 
        Exercise1
    GROUP BY 
        Branch, geographical_region, Narrow_location, Employee_ID
)
SELECT 
    geographical_region,
    Employee_ID, 
    Population_Total,
    Customers_Total,
    Customers_Over_Population_Percentage
FROM 
    CTE
WHERE
    rn <= 5
ORDER BY 
    CASE
        WHEN Customers_Total > Prev_Customers_Total THEN Customers_Total
        ELSE Customers_Over_Population_Percentage
    END DESC,
    Population_Total DESC;
   




