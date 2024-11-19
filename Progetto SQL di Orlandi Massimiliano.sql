--World Coutry Information dataset (WCIT) QUERIES


--1) |Country,Density, Urban population| 

--This query compares the population density with the percentage of the urban population in each country, 
-- ordering the results in descending numerical order. I used the "REPLACE-NUMERIC" construct due to different data format of the database WCIT.
SELECT 
    wcit."Country", 
    REPLACE(wcit."Density ", ',', '')::NUMERIC AS Numeric_Density, 
    wcit."Urban_population"
FROM 
    "World Country Information tab" AS wcit
ORDER BY 
    Numeric_Density;



--2) |Country, Numeric GDP, Life expectancy, Infant Mortality|

--This query correlates a country's GDP with its life expectancy and infant mortality rates.
-- It first cleans the "GDP" column by removing commas and dollar signs, then converts it to a numeric type for proper sorting.
SELECT  "Country", 
		REPLACE(REPLACE("GDP",',',''),'$','')::NUMERIC AS "Numeric GDP",
		"Life expectancy", 
       	"Infant mortality"
FROM "World Country Information tab"
ORDER BY "Numeric GDP" DESC;


--3) |Country, education, GDP| 

-- This query examines the relationship between education enrollment rates
-- and economic factors like unemployment and GDP per capita.
SELECT "Country", "Gross primary education enrollment (%)", 
		"Gross tertiary education enrollment (%)", 
		"Unemployment rate", 
	REPLACE(REPLACE("GDP",',',''),'$','')::NUMERIC AS "Numeric GDP"
FROM "World Country Information tab"
ORDER BY "Numeric GDP" DESC;





--Global Missing Migrants dataset (WMM) QUERIES


--1) |Incident Type and Region Analysis|

-- This query analyzes the types of migration incidents by region.
SELECT "Incident Type", "Region of Incident", COUNT(*) AS "Total Events"
FROM "World Missing Migrants"
GROUP BY "Incident Type", "Region of Incident"
ORDER BY "Total Events" DESC;


--2) |Demographic Analysis-Year|

-- This query looks at the age and gender distribution of migrants involved in incidents.
SELECT  "Incident year",COUNT(*)AS "Total Events-Year", SUM("Number of Females") AS "Females", SUM("Number of Males") AS "Males", SUM("Number of Children") AS "Children" 
FROM "World Missing Migrants"
GROUP BY "Incident year"
ORDER BY "Incident year";


--3) |Temporal Trends|

-- This query examines how migration incidents have evolved over the years.
SELECT "Incident year", COUNT(*) AS "Number of Incidents", SUM("Number of Dead") AS "Total Deaths", SUM("Minimum Estimated Number of Missing") AS "Minimum Estimated Number of Missings"
FROM "World Missing Migrants"
GROUP BY "Incident year"
ORDER BY "Incident year";




--Global Data on Sustainable Energy (WSE) QUERIES

--1) |Energy quotas through the years|

-- This query compares the use of different kind of energy for each country through the years.
SELECT "Entity" as Country, "Year", "Electricity from renewables (TWh)", "Electricity from fossil fuels (TWh)","Electricity from nuclear (TWh)"
FROM "World Sustainable Energy"
ORDER BY "Year", "Entity";



-- JOIN Query between WCIT and WSE

--Comparison on Renewable Energy and Economic Indicators
SELECT
    wcit."Country",
    wse."Entity" AS Energy_Entity,
    wse."Year",
    wse."Renewable energy share in the total final energy consumption (%)",
    wcit."GDP",
    wcit."Tax revenue (%)"
FROM
    "World Country Information tab" AS wcit
JOIN
    "World Sustainable Energy" AS wse ON wcit."Country" = wse."Entity"
ORDER BY REPLACE(REPLACE(wcit."GDP", '$', ''), ',', '')::NUMERIC DESC;