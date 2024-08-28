select * from CrimesOnWomenData;

alter table CrimesOnWomenData
drop column column1;


-- Q1. Which state has the highest number of reported crimes against women?

SELECT State, SUM(Rape + K_A + DD + AoW + AoM + DV + WT) AS total_crimes
FROM CrimesOnWomenData
GROUP BY State
Order by total_crimes desc;

-- Q2. Which state has the lowest number of reported crimes against women?

SELECT State, SUM(Rape + K_A + DD + AoW + AoM + DV + WT) AS total_crimes
FROM CrimesOnWomenData
GROUP BY State
Order by total_crimes ASC;

-- Q3. What is the average number of crimes reported per year in each state?

SELECT State, AVG(Rape + K_A + DD + AoW + AoM + DV + WT) AS Average_crimes_per_year
FROM CrimesOnWomenData
GROUP BY State
Order by Average_crimes_per_year desc; 

-- Q4. Which year recorded the highest total number of crimes against women?

SELECT Year, SUM(Rape + K_A + DD + AoW + AoM + DV + WT) AS total_crimes
FROM CrimesOnWomenData
GROUP BY Year
Order by total_crimes desc;

-- Q5.  What is the most common type of crime against women across all states?

SELECT 'Rape' AS crime_type, SUM(rape) AS total_cases
FROM CrimesOnWomenData
UNION
SELECT 'Kidnapping & Abduction' AS crime_type, SUM(K_A) AS total_cases
FROM CrimesOnWomenData
UNION
SELECT 'Dowry Deaths' AS crime_type, SUM(DD) AS total_cases
FROM CrimesOnWomenData
UNION
SELECT 'Assault on Women' AS crime_type, SUM(AoW) AS total_cases
FROM CrimesOnWomenData
UNION
SELECT 'Insult to Modesty' AS crime_type, SUM(AoM) AS total_cases
FROM CrimesOnWomenData
UNION
SELECT 'Domestic Violence' AS crime_type, SUM(DV) AS total_cases
FROM CrimesOnWomenData
UNION
SELECT 'Trafficking' AS crime_type, SUM(WT) AS total_cases
FROM CrimesOnWomenData
ORDER BY total_cases DESC;

-- Q6. Which states have the highest and lowest reported cases for each crime type over the years?

WITH crime_case AS (SELECT State,
MAX(rape) AS highest_Rape, MIN(rape) AS lowest_Rape,
MAX(K_A) AS highest_KA, MIN(K_A) AS lowest_KA, 
MAX(DD) AS highest_DD, MIN(DD) AS lowest_DD,
MAX(Aow) AS highest_AoW, MIN(AoW) AS lowest_AoW,
MAX(AoM) AS highest_AoM, MIN(AoM) AS lowest_AoM,
MAX(DV) AS highest_DV, MIN(DV) AS lowest_DV,
MAX(WT) AS highest_WT, MIN(WT) AS lowest_WT
FROM CrimesOnWomenData
GROUP BY State)
-- Q. Which state reported the lowest number of dowry deaths? 

-- METHOD 1:
SELECT TOP 1 State, lowest_DD FROM crime_case ORDER BY lowest_DD ASC;
-- METHOD 2:
SELECT TOP 1 State, MIN(DD) AS lowest_dowry_deaths
FROM CrimesOnWomenData
GROUP BY State;

-- Q. Which state reported the heighest number of rape?

-- METHOD 1:
SELECT TOP 1 State, highest_Rape FROM crime_case ORDER BY highest_Rape DESC;

-- METHOD 2:
SELECT State, rape AS highest_Rape
FROM CrimesOnWomenData
WHERE rape = (SELECT MAX(rape) FROM CrimesOnWomenData);

-- Q. Which state reported the lowest number of rape?

-- METHOD 1:
SELECT TOP 1 State, highest_Rape FROM crime_case ORDER BY highest_Rape ASC;

-- METHOD 2:
SELECT State, rape AS lowest_Rape
FROM CrimesOnWomenData
WHERE rape = (SELECT MIN(rape) FROM CrimesOnWomenData);

-- Q7. 2nd highest state

SELECT TOP 1 State, rape
FROM CrimesOnWomenData
WHERE rape < (SELECT MAX(rape) FROM CrimesOnWomenData)
ORDER BY rape DESC;




