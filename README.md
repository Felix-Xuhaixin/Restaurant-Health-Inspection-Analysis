# **New York City Restaurant Health Inspection Analysis**

---

## 📌 Project Overview

NYC restaurant health inspections are designed to protect public health by ensuring food safety, sanitation, and regulatory compliance across all food service establishments. Inspectors check for compliance with New York City Health Code and New York State Sanitary Code, which set standards for cleanliness, food storage, pest control, and employee hygiene. The dataset includes restaurant details, location, cuisine descriptions, inspection results, grades, and violation types.

### 🙏 Credit

- **[Analyst Builder](https://www.analystbuilder.com/projects/restaurant-health-inspection-analysis-nyc-FhAOm)** for the datasets and the directions for the analysis.

- **[NYC Environmental Health Services team at DOHMH](https://github.com/nycehs/NYC_geography)** for the topo-json of NYC.


## 🎯 Objectives

- To identify common health violations
- To analyze trends by cuisine and geography
- To find variations in grades and violations across boroughs and over time.
- To provide actionable recommendations.

## 🛠️ Tools Used

- Python: Pandas, SQLAlchemy, pymysql
- MySQL Workbench  
- Tableau Public

## 🧠 Skills Demonstrated

- Data cleaning and transformation with Python  
- SQL analysis using CTEs, subqueries, joins, and aggregations  
- Interactive dashboards with Tableau Public  

---

## ⚙️ Methodology  

### 📥 Data Loading  
Raw data was imported into a Jupyter notebook using `pandas`, cleaned and transformed, then exported to MySQL Workbench via `SQLAlchemy` and `pymysql`.


### 🧹 Data Cleaning  

1. **Initial Inspection**  
   Reviewed structure and content of the raw dataset. 

2. **Duplicate Removal**
   First, renamed all columns to lowercase and replaced spaces with underscores for consistency.Then dropped rows with identical `camis`, `inspection_date`, and `violation_code`.

3. **Type Conversion**  
   Converted date fields (`inspection_date`, `grade_date`, `record_date`) to datetime format.
   
4. **Remove Irrelevant Columns**
   Dropped fields which were irrelevant for the  analysis: 'building', 'phone', 'latitude', 'longitude', 'community_board', 'council_district', 'census_tract', 'bin','bbl','nta', 'location_point1'.

5. **Standardising the Cuisine_Description Columns**
   Standardized `cuisine_description` by:  
   - **Geographic origin** (e.g., African, European, American)  
   - **Thematic grouping** (e.g., ethnic, fast food, beverage)

6. **Standardising the Cuisine_Description Columns**
   Split `inspection_type` into two new columns: `inspection_program` and `inspection_phase`.

10. **Standardising Violation Code**  
   Mapped 148 violation codes into broader categories using [NYC Health Code](https://codelibrary.amlegal.com/codes/newyorkcity/latest/NYCrules/0-0-0-43593).

11. **Working With Null Values**  
   Filled gaps in 'grade', 'grade_date', 'inspection_program', 'inspection_type','scroe', 'violation_code', 'violation_description and 'zipcode'.



### 📊 Exploratory Data Analysis (EDA)

The cleaned data was exported to MySQL workbench and then connected to Tableau Public for the analysis. Several techniques like aggregations, CTEs, and joins were used to glean insights using SQL. I then used Power BI to visualise the data and mapped NYC using zipcodes to identify violation hotspots across the city.

---

## 🔍 Key Findings  

### 📌 Overall Insights  
- There were **288867 total inspections** in over **30,360 different restaurants** across the city. **Manhattan** leads with 106,783 inspections, followed by Brooklyn and Queens with 74888 and 70693 inspections respectively.

- Manhattan leads with the highest number of restaurants with **grade A restaurants(36908)**; Brooklyn has 36036 grade A.
- Staten Island lead with highest rate of grade A (72.59%) , followed by Manhattan with 70.06%.
- The commonest inspection programs are **Cycle inspection, pre-permit and adminstrative Miscellaneous inspections**. **Initial inspections** was the highest number of inspection phases with 205252 inspections. Re-inspection and Reopening inspection followed with 72471 and 3607 respectively


### 🚨 Violation Analysis 

- The top 5 violations were **Facility Maintenance** (73430), **Food Protection & Pest Control** (54678), **Food Worker Hygiene and Other Food Protection** (52022), **Time and Temperature Control for Safety** (36742) and **Garbage, Waste Disposal and Pest Management** (33802).

- There were 153133 **critical** violations (54.44%) as compared to 128152 **non-critical** violations (45.56%).

- All the boroughs had more than 50% of the restaurants flagged for critical violations. The analysis reveals that 55.7% of inspections in **Staten Island** had critical violations. **Queens** borough has 55% of inspections flagged with critical violations. **Brooklyn** had 54.9% of inspections flagged with critical violations.


### 🍽️ Cuisine Analysis  

- Top 3 cuisine with highest grades are **North American**(75.38% grade A), **Neutral**(74.97% grade A) and **European**(68.65% grade A).
- The **Filipino**(25.97% grade C),**Bangladeshi**(24.16% grade C),**Creole**(24.12% grade C),**Pakistani**(22.94 grade C) and **African**(21.72% grade C) are the top 5 cuisine with lowest score.
- The cuisine with the highest proportion of 'Critical' are Czech(69.23%), Creole(60.32%), Bangladeshi(60.12%) and Pakistani(59.93%); The geographic cuisine with the highest proportion of 'Critical' is South Asian(58.94%); The geographic cuisine with the highest proportion of 'Critical' are Ethnic cuisine(55.65%) and Fine dining(55.36%) 


## 💡 Recommendations 

1. Improve re-inspection frequency in high-risk areas and restaurants
2. Targeted education for cuisines with frequent violations.
3. A city campaign to train food workers on hygiene and safety.
4. Restaurants should adhere to temperature control guidelines.
5. Pass legislation for restaurants to have internal quality assurance managers to ensure compliance to the health codes.


📬 Contact
If you'd like to connect, collaborate, or discuss this project further:

📧 **Email:** felix.xuhaixin@gmail.com

🧠 **GitHub Profile:** [Felix Xu](https://github.com/Felix-Xuhaixin)




