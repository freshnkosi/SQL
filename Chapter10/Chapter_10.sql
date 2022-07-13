--------------------------------------------------------------
-- Practical SQL: A Beginner's Guide to Storytelling with Data
-- by Anthony DeBarros

-- Chapter 10 Code Examples
--------------------------------------------------------------

-- Listing 10-1: Create Census 2011-2015 ACS 5-Year stats table and import data

CREATE TABLE acs_2011_2015_stats (
    geoid varchar(14) CONSTRAINT geoid_key PRIMARY KEY,
    county varchar(50) NOT NULL,
    st varchar(20) NOT NULL,
    pct_travel_60_min numeric(5,3) NOT NULL,
    pct_bachelors_higher numeric(5,3) NOT NULL,
    pct_masters_higher numeric(5,3) NOT NULL,
    median_hh_income integer,
    CHECK (pct_masters_higher <= pct_bachelors_higher)
);

COPY acs_2011_2015_stats
FROM 'C:\YourDirectory\acs_2011_2015_stats.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

SELECT * FROM acs_2011_2015_stats;

-- Listing 10-2: Using corr(Y, X) to measure the relationship between 
-- education and income

SELECT corr(median_hh_income, pct_bachelors_higher)
    AS bachelors_income_r
FROM acs_2011_2015_stats;

-- Listing 10-3: Using corr(Y, X) on additional variables

SELECT
    round(
      corr(median_hh_income, pct_bachelors_higher)::numeric, 2
      ) AS bachelors_income_r,
    round(
      corr(pct_travel_60_min, median_hh_income)::numeric, 2
      ) AS income_travel_r,
    round(
      corr(pct_travel_60_min, pct_bachelors_higher)::numeric, 2
      ) AS bachelors_travel_r
FROM acs_2011_2015_stats;

-- Listing 10-4: Regression slope and intercept functions

SELECT
    round(
        regr_slope(median_hh_income, pct_bachelors_higher)::numeric, 2
        ) AS slope,
    round(
        regr_intercept(median_hh_income, pct_bachelors_higher)::numeric, 2
        ) AS y_intercept
FROM acs_2011_2015_stats;

-- Listing 10-5: Calculating the coefficient of determination, or r-squared

SELECT round(
        regr_r2(median_hh_income, pct_bachelors_higher)::numeric, 3
        ) AS r_squared
FROM acs_2011_2015_stats;

-- Bonus: Additional stats functions.
-- Variance
SELECT var_pop(median_hh_income)
FROM acs_2011_2015_stats;

-- Standard deviation of the entire population
SELECT stddev_pop(median_hh_income)
FROM acs_2011_2015_stats;

-- Covariance
SELECT covar_pop(median_hh_income, pct_bachelors_higher)
FROM acs_2011_2015_stats;

-- Listing 10-6: The rank() and dense_rank() window functions

CREATE TABLE widget_companies (
    id bigserial,
    company varchar(30) NOT NULL,
    widget_output integer NOT NULL
);

INSERT INTO widget_companies (company, widget_output)
VALUES
    ('Morse Widgets', 125000),
    ('Springfield Widget Masters', 143000),
    ('Best Widgets', 196000),
    ('Acme Inc.', 133000),
    ('District Widget Inc.', 201000),
    ('Clarke Amalgamated', 620000),
    ('Stavesacre Industries', 244000),
    ('Bowers Widget Emporium', 201000);

SELECT
    company,
    widget_output,
    rank() OVER (ORDER BY widget_output DESC),
    dense_rank() OVER (ORDER BY widget_output DESC)
FROM widget_companies;

-- Listing 10-7: Applying rank() within groups using PARTITION BY

CREATE TABLE store_sales (
    store varchar(30),
    category varchar(30) NOT NULL,
    unit_sales bigint NOT NULL,
    CONSTRAINT store_category_key PRIMARY KEY (store, category)
);

INSERT INTO store_sales (store, category, unit_sales)
VALUES
    ('Broders', 'Cereal', 1104),
    ('Wallace', 'Ice Cream', 1863),
    ('Broders', 'Ice Cream', 2517),
    ('Cramers', 'Ice Cream', 2112),
    ('Broders', 'Beer', 641),
    ('Cramers', 'Cereal', 1003),
    ('Cramers', 'Beer', 640),
    ('Wallace', 'Cereal', 980),
    ('Wallace', 'Beer', 988);

SELECT
    category,
    store,
    unit_sales,
    rank() OVER (PARTITION BY category ORDER BY unit_sales DESC)
FROM store_sales;

-- Listing 10-8: Create and fill a 2015 FBI crime data table

CREATE TABLE fbi_crime_data_2015 (
    st varchar(20),
    city varchar(50),
    population integer,
    violent_crime integer,
    property_crime integer,
    burglary integer,
    larceny_theft integer,
    motor_vehicle_theft integer,
    CONSTRAINT st_city_key PRIMARY KEY (st, city)
);

COPY fbi_crime_data_2015
FROM 'C:\YourDirectory\fbi_crime_data_2015.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

SELECT * FROM fbi_crime_data_2015
ORDER BY population DESC;

-- Listing 10-9: Find property crime rates per thousand in cities with 500,000
-- or more people

SELECT
    city,
    st,
    population,
    property_crime,
    round(
        (property_crime::numeric / population) * 1000, 1
        ) AS pc_per_1000
FROM fbi_crime_data_2015
WHERE population >= 500000
ORDER BY (property_crime::numeric / population) DESC;


--------------------------------------------------------------
-- Chapter 10: Statistical Functions in SQL
--------------------------------------------------------------

-- 1. In Listing 10-2, the correlation coefficient, or r value, of the
-- variables pct_bachelors_higher and median_hh_income was about .68.
-- Write a query to show the correlation between pct_masters_higher and
-- median_hh_income. Is the r value higher or lower? What might explain
-- the difference?

-- Answer:
-- The r value of pct_bachelors_higher and median_hh_income is about .57, which
-- shows a lower connection between percent master's degree or higher and
-- income than percent bachelor's degree or higher and income. One possible
-- explanation is that attaining a master's degree or higher may have a more
-- incremental impact on earnings than attaining a bachelor's degree.

SELECT
    round(
      corr(median_hh_income, pct_bachelors_higher)::numeric, 2
      ) AS bachelors_income_r,
    round(
      corr(median_hh_income, pct_masters_higher)::numeric, 2
      ) AS masters_income_r
FROM acs_2011_2015_stats;


-- 2. In the FBI crime data, Which cities with a population of 500,000 or
-- more have the highest rates of motor vehicle thefts (column
-- motor_vehicle_theft)? Which have the highest violent crime rates
-- (column violent_crime)?

-- Answer:
-- a) In 2015, Milwaukee and Albuquerque had the two highest rates of motor
-- vehicle theft:

SELECT
    city,
    st,
    population,
    motor_vehicle_theft,
    round(
        (motor_vehicle_theft::numeric / population) * 100000, 1
        ) AS vehicle_theft_per_100000
FROM fbi_crime_data_2015
WHERE population >= 500000
ORDER BY vehicle_theft_per_100000 DESC;

-- b) In 2015, Detroit and Memphis had the two highest rates of violent crime.

SELECT
    city,
    st,
    population,
    violent_crime,
    round(
        (violent_crime::numeric / population) * 100000, 1
        ) AS violent_crime_per_100000
FROM fbi_crime_data_2015
WHERE population >= 500000
ORDER BY violent_crime_per_100000 DESC;

-- 3. As a bonus challenge, revisit the libraries data in the table
-- pls_fy2014_pupld14a in Chapter 8. Rank library agencies based on the rate
-- of visits per 1,000 population (variable popu_lsa), and limit the query to
-- agencies serving 250,000 people or more.

-- Answer:
-- Cuyahoga County Public Library tops the rankings with 12,963 visits per
-- thousand people (or roughly 13 visits per person).

SELECT
    libname,
    stabr,
    visits,
    popu_lsa,
    round(
        (visits::numeric / popu_lsa) * 1000, 1
        ) AS visits_per_1000,
    rank() OVER (ORDER BY (visits::numeric / popu_lsa) * 1000 DESC)
FROM pls_fy2014_pupld14a
WHERE popu_lsa >= 250000;

