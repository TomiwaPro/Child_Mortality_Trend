

/*

DATA CLEANING
--Steps
  1.Removing irrelevant rows by only selecting the columns needed.
  2. Removing irrelevant columns by only selecting the columns needed.
  3. Rename some column names to desire name.
  4.Removing '0' values.
  5. For one of the objectives to be achieved, a continent column is needed and countries will be assign to there respective continent. 

*/

--The two datasets for the analysis will be cleaned.

--Let clean 'causes_of_death_in_children_under_5' first,
--Selecting the necessary rows.
--The year needed for this analysis is 2009 to 2019 but the dataset is having 1990 to 2019.
--Also on the country column there is 'World' which is not needed because is not a country.


SELECT *
FROM 
	causes_of_death_in_children_under_5
WHERE Year >= '2010' AND Year <= '2019' AND Entity <> 'World'
ORDER BY Year

--Selecting the necessary columns.
--Out of the 29 causes of death in this dataset I'll be selecting 10 causes of death to analyse.
SELECT Entity,
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
ORDER BY Year

--Renaming column to desire name.
--The column to be rename is the 'Entity' to 'Country'
SELECT Entity AS Country,--Renaming column (Entity) to desire name(Coountry)
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
ORDER BY Year

--Removing the rows in the 'code' column where there is '0'

SELECT Entity AS Country,
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
		          AND code <> '0' --To remove '0' value in code column
		          AND Entity <> 'World'
ORDER BY Year



UPDATE causes_of_death_in_children_under_5
SET Entity = 'Micronesia'
WHERE Entity like 'Micronesia(country)';


--SELECT Entity
--FROM causes_of_death_in_children_under_5

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

--To check if the continent column added to the dataset

SELECT Entity AS Country,
		code,
		Year,
		continent,
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
		          AND code <> '0' --To remove '0' value in code column
		          AND Entity <> 'World'
				  



--SQL view will be use to join the two datasets and the data needed for this analysis(project) will only be extracted from this dataset

CREATE VIEW view_causes_of_death_in_children_under_5  as
SELECT Entity AS Country,
		code,
		Year,
	continent,
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
		          AND code <> '0'
		          AND Entity <> 'World'

Select *
FROM view_causes_of_death_in_children_under_5

/*
#Data Quality Test
--After creating the Sql view, the data will be tested to check if they are in the right datatype.
1. The columns should be 14.(Verified)
2. The Year must be 2010 t0 2019.(Verified)
3. The Country, code, continent column must be string format, and other columns must be numerical.(Verified)
4. Each records must be unique in the dataset (Duplicate Count Check).(Verified)

Column count - 14
-Data types
	Country = NVARCHAR
	code = NVARCHAR
	continent = NVARCHAR
	Year = INTEGER
	Malaria = INTEGER
	Measles = INTEGER
	Tuberculosis = INTEGER
	Neoplasms = INTEGER
	Meningitis = INTEGER
	HIV_AIDS = INTEGER
	Syphilis = INTEGER
	Diarrheal_diseases = INTEGER
	Nutritional_deficiencies = INTEGER
	Whooping_cough  = INTEGER

Duplicate Count must be 10, since the Year is 2010 to 2019 i.e 10 years

*/

--1. Column count check

SELECT COUNT (*) AS column_count
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'view_causes_of_death_in_children_under_5'

--2. The Year range check

SELECT MIN(Year) AS min_year, MAX(Year) AS max_year
FROM view_causes_of_death_in_children_under_5;

--Data Type Check
--3. The Country, code, continent column must be string format, and other columns must be numerical.

SELECT
	COLUMN_NAME,
	DATA_TYPE
FROM
	INFORMATION_SCHEMA.COLUMNS
WHERE
	TABLE_NAME = 'view_causes_of_death_in_children_under_5'

--The continent column datatype is 'varchar', which is very much okay.

--Duplicate Count Check(10 years is to be analysed so the Country count should not be more than 10)
SELECT Country,
	COUNT(*) as duplicate_count
FROM
	view_causes_of_death_in_children_under_5
GROUP BY
	country
HAVING COUNT(*) > 10;


SELECT*
FROM view_causes_of_death_in_children_under_5
