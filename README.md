# Child_Mortality_Trend(Ages 0-5, 2010): Continent, Country and 10 Causes of Death

# Table Of Contents

- [Objective](#objectives)
- [Data Source](#data-source)
- [Stages](#Stages)
- [Design](#Design)
  - [Dashboard-components-required](#Dashboard-components-required)
  - [Tools](#Tools)
- [Development](#Development)
  - [Data exploration](#Data-exploration)
  - [Transform the data](#Transform-the-data)
  - [Create the SQL view](#Create-the-SQL-view)
- [Testing](#Testing)
  - [Data Quality Test](#Data-Quality-Test)
- [Visualization](Visualization)
  - [Results](Results)
  - [Dax Measure](Dax-Measure)
-[Analysis](Analysis)
  -[Findings](Findings) 

## Objectives

- Trend Analysis

The trends in the causes of death over the year range.

- Top Causes of Death

The distribution of deaths by cause and identify the top causes of death.

- Geographical Analysis

The geographical distribution of deaths by cause and identify any continental pattern.

- Year Variation

The yearly variations in the number of deaths for each cause and highlight any trends.

## Data source

The data used in this project, titled 'Child_Mortality_Trend(Ages 0-5, 2010): Continent, Country and 10 Causes of Death' is sourced from kaggle (an Excel extract). [see here to find it.](https://www.kaggle.com/datasets/willianoliveiragibin/diarrheal-diseases) This dataset exclusively comprises information regarding the causes of death among children under 5 years old , detailing the number of deaths recorded per cause, per continent, per contry and per year over consecutive years(1990 to 2019).

## Stages

- Design
- Development
- Testing
- Analysis

## Design

### Dashboard components required
- Total number of death per cause
- Total number of death per cause per continent
- Total number of death per cause per country
- Total number of death
- A Slicer to select the preferred year
- With these on the dashboard all question can be answered.

## Tools

| Tool | Purpose |
| --- | --- |
| Excel | Exploring the data |
| SQL Server | Cleaning, testing, and analyzing the data |
| Power BI | Visualizing the data via intractive dashboards |

## Development

### Pseudocode

- General approach in creating this solution from start to finish

1. Explore the data in Excel
2. Load the data into SQL Sever
3. Clean the data with SQL
4. Test the data with SQL
5. Visualize the data in power BI
6. Generate the findings based on the insights

### Data exploration 
#### Observations
  1. There are only 13 columns that contain the data we need for this analysis.
  2. On country column, there is 'World' which is not needed because is not a country.
  3. The year needed for this analysis is 2010 to 2019 but the dataset is having 1990 to 2019.
  4. Renaming country column to desire name, from 'Entity' to 'country' and on the country column there is 'Micronesia(country)' instead of 'Micronesia'.
  5. On the code column, there are '0' values.
  6. For one of the objectives to be achieved, a continent column is needed and countries will be assign to thier respective continent. 


  ## Data cleaning
  - To refine the dataset to ensure it is structured and ready for analysis.
##### Selecting the necessary columns
```sql
--Selecting the necessary columns.
--Out of the 29 causes of death in this dataset I'll be selecting 10 causes of death to analyse.

SELECT
     Entity,
     code,
     Year,
     Malaria,
     Measles,
     Tuberculosis,
     Neoplasms,
     Meningitis,
     HIV_AIDS,
     Syphilis,
     Diarrheal_diseases,
     Nutritional_deficiencies,
     Whooping_cough
FROM 
   causes_of_death_in_children_under_5
```
##### Selecting the year range
```sql
--selecting the year range needed for the analysis (2010 to 2019).
--Removing 'world' from the country column because it's not a country name.

SELECT
     Entity,
     code,
     Year,
     Malaria,
     Measles,
     Tuberculosis,
     Neoplasms,
     Meningitis,
     HIV_AIDS,
     Syphilis,
     Diarrheal_diseases,
     Nutritional_deficiencies,
     Whooping_cough
FROM 
   causes_of_death_in_children_under_5
WHERE Year >= '2010' AND Year <= '2019' --Selecting the year range to be analyzed
		AND Entity <> 'World' --Removing 'world' from the country column
ORDER BY Year
```
##### Renaming column to desire name
```sql
--Renaming column to desire name.
--The column to be rename is the 'Entity' to 'Country'.

SELECT
     Entity AS Country, --Renaming column (Entity) to desire name(Country)
     code,
     Year,
     Malaria,
     Measles,
     Tuberculosis,
     Neoplasms,
     Meningitis,
     HIV_AIDS,
     Syphilis,
     Diarrheal_diseases,
     Nutritional_deficiencies,
     Whooping_cough
FROM 
   causes_of_death_in_children_under_5
WHERE Year >= '2010' AND Year <= '2019' 
		AND Entity <> 'World'
```
##### Renaming a country name from 'Micronesia(country)' to 'Micronesia'
```sql
--Renaming a country name from 'Micronesia(country)' to 'Micronesia'.

UPDATE causes_of_death_in_children_under_5
SET Entity = 'Micronesia'
WHERE Entity like 'Micronesia(country)';
```
##### Removing '0' value the from the 'code' column
```sql
--Removing '0' value the from the 'code' column.

SELECT
     Entity AS Country,
     code,
     Year,
     Malaria,
     Measles,
     Tuberculosis,
     Neoplasms,
     Meningitis,
     HIV_AIDS,
     Syphilis,
     Diarrheal_diseases,
     Nutritional_deficiencies,
     Whooping_cough
FROM 
   causes_of_death_in_children_under_5
WHERE Year >= '2010' AND Year <= '2019' 
		AND Entity <> 'World'
    AND code <> '0' --To remove '0' value in code column
```

## Transform the data

##### Creating the 'continent' column
```sql
--Creating the 'continent' column.

ALTER TABLE causes_of_death_in_children_under_5
ADD continent VARCHAR(100);

UPDATE causes_of_death_in_children_under_5
SET continent = 
    CASE 
        -- Africa
        WHEN Entity IN (
            'Algeria', 'Angola', 'Benin', 'Botswana', 'Burkina Faso', 'Burundi', 'Cape Verde', 'Central African Republic',
            'Chad', 'Comoros', 'Congo', 'Djibouti', 'Egypt', 'Equatorial Guinea', 'Eritrea', 'Eswatini', 'Ethiopia', 
            'Gabon', 'Gambia', 'Ghana', 'Guinea', 'Guinea-Bissau', 'Ivory Coast', 'Kenya', 'Lesotho', 'Liberia', 'Libya', 
            'Madagascar', 'Malawi', 'Mali', 'Mauritania', 'Mauritius', 'Morocco', 'Mozambique', 'Namibia', 'Niger', 'Nigeria', 
            'Rwanda', 'Sao Tome and Principe', 'Senegal', 'Seychelles', 'Sierra Leone', 'Somalia', 'South Africa', 'South Sudan',
            'Sudan', 'Tanzania', 'Togo', 'Tunisia', 'Uganda', 'Zambia', 'Zimbabwe', 'Cameroon', 'Cote d''lvoire', 'Democratic Republic of Congo'
        ) THEN 'Africa'
        -- Asia
        WHEN Entity IN (
            'Afghanistan', 'Armenia', 'Azerbaijan', 'Bahrain', 'Bangladesh', 'Bhutan', 'Brunei', 'Cambodia', 'China', 'Cyprus', 
            'Georgia', 'India', 'Indonesia', 'Iran', 'Iraq', 'Israel', 'Japan', 'Jordan', 'Kazakhstan', 'Kuwait', 'Kyrgyzstan', 
            'Laos', 'Lebanon', 'Malaysia', 'Maldives', 'Mongolia', 'Myanmar', 'Nepal', 'North Korea', 'Oman', 'Pakistan', 'Palestine', 
            'Philippines', 'Qatar', 'Saudi Arabia', 'Singapore', 'South Korea', 'Sri Lanka', 'Syria', 'Taiwan', 'Tajikistan', 'Thailand', 
            'Timor-Leste', 'Turkey', 'Turkmenistan', 'United Arab Emirates', 'Uzbekistan', 'Vietnam', 'Yemen', 'East Timor'
        ) THEN 'Asia'
        -- Europe
        WHEN Entity IN (
            'Albania', 'Andorra', 'Austria', 'Belarus', 'Belgium', 'Bosnia and Herzegovina', 'Bulgaria', 'Croatia', 'Czech Republic', 
            'Denmark', 'Estonia', 'Finland', 'France', 'Germany', 'Greece', 'Hungary', 'Iceland', 'Ireland', 'Italy', 'Kosovo', 
            'Latvia', 'Liechtenstein', 'Lithuania', 'Luxembourg', 'Malta', 'Moldova', 'Monaco', 'Montenegro', 'Netherlands', 
            'North Macedonia', 'Norway', 'Poland', 'Portugal', 'Romania', 'Russia', 'San Marino', 'Serbia', 'Slovakia', 'Slovenia', 
            'Spain', 'Sweden', 'Switzerland', 'Ukraine', 'United Kingdom', 'Vatican City'
        ) THEN 'Europe'
        -- North America
        WHEN Entity IN (
            'Antigua and Barbuda', 'Bahamas', 'Barbados', 'Belize', 'Canada', 'Costa Rica', 'Cuba', 'Dominica', 'Dominican Republic', 
            'El Salvador', 'Grenada', 'Guatemala', 'Haiti', 'Honduras', 'Jamaica', 'Mexico', 'Nicaragua', 'Panama', 'Saint Kitts and Nevis', 
            'Saint Lucia', 'Saint Vincent and the Grenadines', 'Trinidad and Tobago', 'United States', 'Bermuda', 'Czechia', 'Greenland', 'Puerto Rico',
			'United States Virgin Islands'
        ) THEN 'North America'
        -- South America
        WHEN Entity IN (
            'Argentina', 'Bolivia', 'Brazil', 'Chile', 'Colombia', 'Ecuador', 'Guyana', 'Paraguay', 'Peru', 'Suriname', 'Uruguay', 'Venezuela'
        ) THEN 'South America'
        -- Oceania
        WHEN Entity IN (
            'Australia', 'Fiji', 'Kiribati', 'Marshall Islands', 'Micronesia', 'Nauru', 'New Zealand', 'Palau', 'Papua New Guinea', 
            'Samoa', 'Solomon Islands', 'Tonga', 'Tuvalu', 'Vanuatu', 'Cook Islands', 'American Samoa', 'Guam', 'Tokelau'
        ) THEN 'Oceania'
        -- Default: Unknown or Other
        ELSE 'Others'
    END;
```

### Create the SQL view

```sql
CREATE VIEW view_causes_of_death_in_children_under_5  as
SELECT
     Entity AS Country,
     continent, --the continent that's just created
     code,
     Year,
     Malaria,
     Measles,
     Tuberculosis,
     Neoplasms,
     Meningitis,
     HIV_AIDS,
     Syphilis,
     Diarrheal_diseases,
     Nutritional_deficiencies,
     Whooping_cough
FROM 
   causes_of_death_in_children_under_5
WHERE Year >= '2010' AND Year <= '2019' 
		AND Entity <> 'World'
    AND code <> '0'
```
## Testing
- Here are the data quality tests conducted:
#### Data Quality Test
After creating the SQL view, the data will be tested to check if they are in the right datatype.
1. The columns should be 14.(Verified)
2. The Year must be 2010 t0 2019.(Verified)
3. The Country, code, continent column must be string format, and other columns must be numerical.(Verified)
4. Each records must be unique in the dataset (Duplicate Count Check).(Verified)

##### Column count check
```sql
--Column count check

SELECT COUNT (*) AS column_count
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'view_causes_of_death_in_children_under_5'
```
![Column Count Check](https://github.com/TomiwaPro/Child_Mortality_Trend/assets/160256704/627343d9-2a23-4c2a-8104-b96acd9523e1)

##### Year range check
```sql
--The Year range check

SELECT MIN(Year) AS min_year, MAX(Year) AS max_year
FROM view_causes_of_death_in_children_under_5;
```
![Year Range Check](https://github.com/TomiwaPro/Child_Mortality_Trend/assets/160256704/6c555c4d-f9be-4772-b2c7-22522f775ff1)

##### Data Type Check
```sql
--Data Type Check
--The Country, code, continent column must be string format, and other columns must be numerical.

SELECT
	COLUMN_NAME,
	DATA_TYPE
FROM
	INFORMATION_SCHEMA.COLUMNS
WHERE
	TABLE_NAME = 'view_causes_of_death_in_children_under_5'

--The continent column datatype is 'varchar', which is very much okay.
```
![Data Type Check](https://github.com/TomiwaPro/Child_Mortality_Trend/assets/160256704/14dd6a8e-1e45-4def-a456-0c78c8f62402)

##### Duplicate Count Check
```sql
--Duplicate Count Check(10 years is to be analysed so the Country count should not be more than 10)
SELECT Country,
	COUNT(*) as duplicate_count
FROM
	view_causes_of_death_in_children_under_5
GROUP BY
	country
HAVING COUNT(*) > 10;
```
![Duplicate Count Check](https://github.com/TomiwaPro/Child_Mortality_Trend/assets/160256704/f3740aea-468c-4b03-b747-d46b8932b8fc)

## Visualization


### Results

[Gif of power BI Dashboard](https://github.com/TomiwaPro/Child_Mortality_Trend/assets/160256704/6bb69cc2-750c-4263-afb3-c293c9b5a3cd)

### Dax Measure

#### Total Number of death
```sql
Total Number of death =
SUMX(view_causes_of_death_in_children_under_5, view_causes_of_death_in_children_under_5[Diarrheal_diseases] +
 view_causes_of_death_in_children_under_5[HIV_AIDS] + view_causes_of_death_in_children_under_5[Malaria] +
view_causes_of_death_in_children_under_5[Measles] + view_causes_of_death_in_children_under_5[Meningitis] +
view_causes_of_death_in_children_under_5[Neoplasms] + view_causes_of_death_in_children_under_5[Nutritional_deficiencies] +
 view_causes_of_death_in_children_under_5[Syphilis] + view_causes_of_death_in_children_under_5[Tuberculosis] +
view_causes_of_death_in_children_under_5[Whooping_cough])
```
## Analysis

### Findings
- Total Number of death is 19.27Millions.
- 2010 is the Year with the highest death rate of 2.46Millions.
- The Total number of death per year decreases as the year increase, this shows that the continents gets better in terms of medical care for kids under 5 years old.
- Africa has the highest number of death over the year range, which makes it the continent with the poorest medical care for kids under 5 years old from this analysis.
- Nigeria has the highest number of death over the year range, which makes it the country with the poorest medical care for kids under 5 years old from this analysis.
- For the causes of death, Diarrheal diseases has the highest death count over the year range, which shows that WHO, and the healthcare bodies of each continent and Country needs to take the diarrheal diseases treatment and prevention more seriously and other causes of death.

## Conclusion

Thank you for taking the time to explore this project! I'm thrilled to share the achievements and outcomes that I've accomplished.

Moving forward, I'm excited about the potential for future enhancements and improvements to futher benefit my clients.

If you have any questions, inquiries, or feedback, please don't hesitate to reach out to me at [Contact me](tomiwaprofficial@gmail.com).

Once again,thank you for your interest in my project. I am open to data analyst roles.[Refer me](https://www.linkedin.com/in/tomiwapro/)

Best regards,
[Ayotomiwa Alao]
