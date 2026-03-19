/* SECTION 1: Overall Insights
==================================================
	Count the total number of inspections by borough.

	Calculate the distribution of grades (A, B, C, etc.) across NYC.

	Identify the most common inspection types (Initial, Re-inspection, Pre-permit).
*/

SELECT COUNT(*)
FROM cleaned_inspection_data;

SELECT COUNT(DISTINCT camis)
FROM cleaned_inspection_data;
-- There are 30361 unique restaurants inspected in NYC.

-- Count the total number of inspections by borough.
SELECT boro, count(camis) AS inspections_boro
FROM cleaned_inspection_data
GROUP BY boro
ORDER BY inspections_boro DESC;
/*
Manhattan leads with 106,783 inspections, followed by Brooklyn and Queens with 74888 and 70693 inspections
respectively
*/

SELECT boro
FROM cleaned_inspection_data
WHERE boro = '0';

UPDATE cleaned_inspection_data
SET boro = 'Not Specified'
WHERE boro = '0';

-- Calculate the distribution of grades (A, B, C, etc.) across NYC.
SELECT boro,COUNT(boro) AS total_num,
       SUM(case WHEN grade = 'A' THEN 1 ELSE 0 END) AS num_A,
       SUM(case WHEN grade = 'B' THEN 1 ELSE 0 END) AS num_B,
       SUM(case WHEN grade = 'C' THEN 1 ELSE 0 END) AS num_C,
       SUM(case WHEN grade = 'N' THEN 1 ELSE 0 END) AS num_N,
       SUM(case WHEN grade = 'P' THEN 1 ELSE 0 END) AS num_P,
       SUM(case WHEN grade = 'Z' THEN 1 ELSE 0 END) AS num_Z       
FROM cleaned_inspection_data
WHERE grade != 'Not Graded'
GROUP BY boro
ORDER BY total_num DESC;
-- Manhattan leads with the highest number of restaurants with grade A restaurants(36908);Brooklyn has 36036 grade A.

SELECT boro,
       ROUND(SUM(case WHEN grade = 'A' THEN 1 ELSE 0 END) / COUNT(boro) * 100,2) AS per_A,
       ROUND(SUM(case WHEN grade = 'B' THEN 1 ELSE 0 END) / COUNT(boro) * 100,2) AS per_B,
       ROUND(SUM(case WHEN grade = 'C' THEN 1 ELSE 0 END) / COUNT(boro) * 100,2) AS per_C,
       ROUND(SUM(case WHEN grade = 'N' THEN 1 ELSE 0 END) / COUNT(boro) * 100,2) AS per_N,
       ROUND(SUM(case WHEN grade = 'P' THEN 1 ELSE 0 END) / COUNT(boro) * 100,2) AS per_P,
       ROUND(SUM(case WHEN grade = 'Z' THEN 1 ELSE 0 END) / COUNT(boro) * 100,2) AS per_Z       
FROM cleaned_inspection_data
WHERE grade != 'Not Graded'
GROUP BY boro
ORDER BY per_A DESC;
-- Staten Island lead with highest rate of grade A (72.59%) ,followed by Manhattan with 70.06% 

-- Identify the most common inspection types (Initial, Re-inspection, Pre-permit).
SELECT inspection_program, count(inspection_program) AS num_inspection_program
FROM cleaned_inspection_data
WHERE inspection_program != 'Not Specified'
GROUP BY inspection_program
ORDER BY num_inspection_program DESC;

SELECT inspection_type_performed, count(inspection_type_performed) AS num_inspection_type
FROM cleaned_inspection_data
WHERE inspection_type_performed != 'Not Specified'
GROUP BY inspection_type_performed
ORDER BY num_inspection_type DESC;
/*
The commonest inspection programs are Cycle inspection, pre-permit and adminstrative Miscellaneous inspections.
Initial inspections was the highest number of inspection phases with 205252 inspections. 
Re-inspection and Reopening inspection followed with 72471 and 3607 respectively
*/

/* SECTION 2: Violation Analysis
========================================
	Find the top 5 most frequent violations (e.g., “Evidence of mice,” “Improper food temperature”).

	Compare critical vs. non-critical violations.

	See which boroughs or neighborhoods have the highest rate of critical violations.
*/
-- Find the top 5 most frequent violations (e.g., “Evidence of mice,” “Improper food temperature”).
SELECT violation_category,
       count(violation_category) num_violation
FROM cleaned_inspection_data
GROUP BY violation_category
ORDER BY num_violation DESC
LIMIT 5;
/*
The top 5 number of violations were issues related to facility maintenance (73430), 
food protection and pest control (54678), food worker hygiene and other food protection (52022), 
Time and Temperature Control for Safety(36742) and Garbage, Waste Disposal and Pest Management(33802).
*/

-- Compare critical vs. non-critical violations.
SELECT critical_flag,
       COUNT(critical_flag) AS num_critical_flag,
       ROUND((COUNT(critical_flag)/(
							        SELECT COUNT(critical_flag) 
									FROM cleaned_inspection_data 
							        WHERE critical_flag != 'Not Applicable'
							        ) 
        ) * 100, 2) AS rat_critical_flag                   
FROM cleaned_inspection_data
WHERE critical_flag != 'Not Applicable'
GROUP BY critical_flag;
/*
There were 153133 critical violations (54.44%) as compared to 128152 non-critical violations (45.56%).
*/


-- which boroughs or neighborhoods have the highest rate of critical violations.alter
SELECT boro,
       ROUND(SUM(CASE WHEN critical_flag = 'Critical' THEN 1 ELSE 0 END) / COUNT(critical_flag) * 100, 2) AS rat_critical,
       ROUND(SUM(CASE WHEN critical_flag = 'Not Critical' THEN 1 ELSE 0 END) / COUNT(critical_flag) * 100, 2) AS rat_not_critical
FROM cleaned_inspection_data
WHERE critical_flag != 'Not Applicable'
GROUP BY boro
ORDER BY rat_critical DESC;
/*
All the boroughs had more than 50% of the restaurants flagged for critical violations.
The analysis reveals that 55.7% of inspections in Staten Island had critical violations.
Queens borough has 55% of inspections flagged with critical violations
Brooklyn had 54.9% of inspections flagged with critical violations.
*/

/* SECTION 3: Cuisine Analysis
========================================
	Compare grades by cuisine type (e.g., Chinese vs American vs Italian).

	Find the top 5 cuisines with the lowest average scores.

	Identify cuisines with the highest proportion of “Critical” violations.
*/
-- Compare grades by cuisine type (e.g., Chinese vs American vs Italian).
SELECT cuisine_geographic_category,
       ROUND(SUM(case WHEN grade = 'A' THEN 1 ELSE 0 END) / COUNT(cuisine_geographic_category) * 100,2) AS per_A,
       ROUND(SUM(case WHEN grade = 'B' THEN 1 ELSE 0 END) / COUNT(cuisine_geographic_category) * 100,2) AS per_B,
       ROUND(SUM(case WHEN grade = 'C' THEN 1 ELSE 0 END) / COUNT(cuisine_geographic_category) * 100,2) AS per_C,
       ROUND(SUM(case WHEN grade = 'N' THEN 1 ELSE 0 END) / COUNT(cuisine_geographic_category) * 100,2) AS per_N,
       ROUND(SUM(case WHEN grade = 'P' THEN 1 ELSE 0 END) / COUNT(cuisine_geographic_category) * 100,2) AS per_P,
       ROUND(SUM(case WHEN grade = 'Z' THEN 1 ELSE 0 END) / COUNT(cuisine_geographic_category) * 100,2) AS per_Z       
FROM cleaned_inspection_data
WHERE grade != 'Not Graded'
GROUP BY cuisine_geographic_category
ORDER BY per_A DESC;
-- Top 3 cuisine with highest grades are North American(75.38% grade A), Neutral(74.97% grade A) and European(68.65% grade A) 

SELECT cuisine_description,
       ROUND(SUM(case WHEN grade = 'A' THEN 1 ELSE 0 END) / COUNT(cuisine_description) * 100,2) AS per_A,
       ROUND(SUM(case WHEN grade = 'B' THEN 1 ELSE 0 END) / COUNT(cuisine_description) * 100,2) AS per_B,
       ROUND(SUM(case WHEN grade = 'C' THEN 1 ELSE 0 END) / COUNT(cuisine_description) * 100,2) AS per_C,
       ROUND(SUM(case WHEN grade = 'N' THEN 1 ELSE 0 END) / COUNT(cuisine_description) * 100,2) AS per_N,
       ROUND(SUM(case WHEN grade = 'P' THEN 1 ELSE 0 END) / COUNT(cuisine_description) * 100,2) AS per_P,
       ROUND(SUM(case WHEN grade = 'Z' THEN 1 ELSE 0 END) / COUNT(cuisine_description) * 100,2) AS per_Z  
FROM cleaned_inspection_data
WHERE grade != 'Not Graded' AND
      (cuisine_description = 'chinese' OR cuisine_description = 'American' OR cuisine_description = 'Italian')
GROUP BY cuisine_description
ORDER BY per_A DESC;
-- Compare to American(74.14% grade A) and Italian(74.20% grade A), Chinese(55.20% grade A) cuisine restaurant has bad food safty performance

-- Find the top 5 cuisines with the lowest average scores.
SELECT cuisine_description,
       ROUND(SUM(case WHEN grade = 'A' THEN 1 ELSE 0 END) / COUNT(cuisine_description) * 100,2) AS per_A,
       ROUND(SUM(case WHEN grade = 'B' THEN 1 ELSE 0 END) / COUNT(cuisine_description) * 100,2) AS per_B,
       ROUND(SUM(case WHEN grade = 'C' THEN 1 ELSE 0 END) / COUNT(cuisine_description) * 100,2) AS per_C,
       ROUND(SUM(case WHEN grade = 'N' THEN 1 ELSE 0 END) / COUNT(cuisine_description) * 100,2) AS per_N,
       ROUND(SUM(case WHEN grade = 'P' THEN 1 ELSE 0 END) / COUNT(cuisine_description) * 100,2) AS per_P,
       ROUND(SUM(case WHEN grade = 'Z' THEN 1 ELSE 0 END) / COUNT(cuisine_description) * 100,2) AS per_Z  
FROM cleaned_inspection_data
WHERE grade != 'Not Graded' 
GROUP BY cuisine_description
ORDER BY per_C DESC
LIMIT 5;
/* 
The Filipino(25.97% grade C),Bangladeshi(24.16% grade C),Creole(24.12% grade C),Pakistani(22.94 grade C) 
 and African(21.72% grade C) are the top 5 cuisine with lowest score 
*/

-- Identify cuisines with the highest proportion of “Critical” violations.
SELECT cuisine_description,
       ROUND(SUM(CASE WHEN critical_flag = 'Critical' THEN 1 ELSE 0 END) / COUNT(critical_flag) * 100, 2) AS rat_cuisine_critical
FROM cleaned_inspection_data
WHERE critical_flag != 'Not Applicable'
GROUP BY cuisine_description
ORDER BY rat_cuisine_critical DESC;

SELECT cuisine_description,
       ROUND(SUM(CASE WHEN critical_flag = 'Critical' THEN 1 ELSE 0 END) / COUNT(critical_flag) * 100, 2) AS rat_cuisine_critical
FROM cleaned_inspection_data
WHERE critical_flag != 'Not Applicable'
GROUP BY cuisine_description
ORDER BY rat_cuisine_critical DESC;

SELECT cuisine_geographic_category,
       ROUND(SUM(CASE WHEN critical_flag = 'Critical' THEN 1 ELSE 0 END) / COUNT(critical_flag) * 100, 2) AS rat_cuisine_critical
FROM cleaned_inspection_data
WHERE critical_flag != 'Not Applicable'
GROUP BY cuisine_geographic_category
ORDER BY rat_cuisine_critical DESC;

SELECT thematic_cuisine_category,
       ROUND(SUM(CASE WHEN critical_flag = 'Critical' THEN 1 ELSE 0 END) / COUNT(critical_flag) * 100, 2) AS rat_cuisine_critical
FROM cleaned_inspection_data
WHERE critical_flag != 'Not Applicable'
GROUP BY thematic_cuisine_category
ORDER BY rat_cuisine_critical DESC;
/*
 The cuisine with the highest proportion of 'Critical' are Czech(69.23%), Creole(60.32%), Bangladeshi(60.12%) and Pakistani(59.93%); 
 The geographic cuisine with the highest proportion of 'Critical' is South Asian(58.94%);
 The geographic cuisine with the highest proportion of 'Critical' are Ethnic cuisine(55.65%) and Fine dining(55.36%)
*/


/*
Recommendations
=======================

	1. Improve re-inspection frequency in high-risk areas and restaurants
    2. Targeted education for cuisines with frequent violations.
    3. A city campaign to train food workers on hygiene and safety.
    4. Restaurants should adhere to temperature control guidelines.
    5. Pass legislation for restaurants to have internal quality assurance managers to ensure compliance to the health codes.
*/

