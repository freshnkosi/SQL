--------------------------------------------------------------
-- Practical SQL: A Beginner's Guide to Storytelling with Data
-- by Anthony DeBarros

-- Chapter 8 Code Examples
--------------------------------------------------------------

-- Listing 8-1: Creating and filling the 2014 Public Libraries Survey table

CREATE TABLE pls_fy2014_pupld14a (
    stabr varchar(2) NOT NULL,
    fscskey varchar(6) CONSTRAINT fscskey2014_key PRIMARY KEY,
    libid varchar(20) NOT NULL,
    libname varchar(100) NOT NULL,
    obereg varchar(2) NOT NULL,
    rstatus integer NOT NULL,
    statstru varchar(2) NOT NULL,
    statname varchar(2) NOT NULL,
    stataddr varchar(2) NOT NULL,
    longitud numeric(10,7) NOT NULL,
    latitude numeric(10,7) NOT NULL,
    fipsst varchar(2) NOT NULL,
    fipsco varchar(3) NOT NULL,
    address varchar(35) NOT NULL,
    city varchar(20) NOT NULL,
    zip varchar(5) NOT NULL,
    zip4 varchar(4) NOT NULL,
    cnty varchar(20) NOT NULL,
    phone varchar(10) NOT NULL,
    c_relatn varchar(2) NOT NULL,
    c_legbas varchar(2) NOT NULL,
    c_admin varchar(2) NOT NULL,
    geocode varchar(3) NOT NULL,
    lsabound varchar(1) NOT NULL,
    startdat varchar(10),
    enddate varchar(10),
    popu_lsa integer NOT NULL,
    centlib integer NOT NULL,
    branlib integer NOT NULL,
    bkmob integer NOT NULL,
    master numeric(8,2) NOT NULL,
    libraria numeric(8,2) NOT NULL,
    totstaff numeric(8,2) NOT NULL,
    locgvt integer NOT NULL,
    stgvt integer NOT NULL,
    fedgvt integer NOT NULL,
    totincm integer NOT NULL,
    salaries integer,
    benefit integer,
    staffexp integer,
    prmatexp integer NOT NULL,
    elmatexp integer NOT NULL,
    totexpco integer NOT NULL,
    totopexp integer NOT NULL,
    lcap_rev integer NOT NULL,
    scap_rev integer NOT NULL,
    fcap_rev integer NOT NULL,
    cap_rev integer NOT NULL,
    capital integer NOT NULL,
    bkvol integer NOT NULL,
    ebook integer NOT NULL,
    audio_ph integer NOT NULL,
    audio_dl float NOT NULL,
    video_ph integer NOT NULL,
    video_dl float NOT NULL,
    databases integer NOT NULL,
    subscrip integer NOT NULL,
    hrs_open integer NOT NULL,
    visits integer NOT NULL,
    referenc integer NOT NULL,
    regbor integer NOT NULL,
    totcir integer NOT NULL,
    kidcircl integer NOT NULL,
    elmatcir integer NOT NULL,
    loanto integer NOT NULL,
    loanfm integer NOT NULL,
    totpro integer NOT NULL,
    totatten integer NOT NULL,
    gpterms integer NOT NULL,
    pitusr integer NOT NULL,
    wifisess integer NOT NULL,
    yr_sub integer NOT NULL
);

CREATE INDEX libname2014_idx ON pls_fy2014_pupld14a (libname);
CREATE INDEX stabr2014_idx ON pls_fy2014_pupld14a (stabr);
CREATE INDEX city2014_idx ON pls_fy2014_pupld14a (city);
CREATE INDEX visits2014_idx ON pls_fy2014_pupld14a (visits);

COPY pls_fy2014_pupld14a
FROM 'C:\YourDirectory\pls_fy2014_pupld14a.csv'
WITH (FORMAT CSV, HEADER);

-- Listing 8-2: Creating and filling the 2009 Public Libraries Survey table

CREATE TABLE pls_fy2009_pupld09a (
    stabr varchar(2) NOT NULL,
    fscskey varchar(6) CONSTRAINT fscskey2009_key PRIMARY KEY,
    libid varchar(20) NOT NULL,
    libname varchar(100) NOT NULL,
    address varchar(35) NOT NULL,
    city varchar(20) NOT NULL,
    zip varchar(5) NOT NULL,
    zip4 varchar(4) NOT NULL,
    cnty varchar(20) NOT NULL,
    phone varchar(10) NOT NULL,
    c_relatn varchar(2) NOT NULL,
    c_legbas varchar(2) NOT NULL,
    c_admin varchar(2) NOT NULL,
    geocode varchar(3) NOT NULL,
    lsabound varchar(1) NOT NULL,
    startdat varchar(10),
    enddate varchar(10),
    popu_lsa integer NOT NULL,
    centlib integer NOT NULL,
    branlib integer NOT NULL,
    bkmob integer NOT NULL,
    master numeric(8,2) NOT NULL,
    libraria numeric(8,2) NOT NULL,
    totstaff numeric(8,2) NOT NULL,
    locgvt integer NOT NULL,
    stgvt integer NOT NULL,
    fedgvt integer NOT NULL,
    totincm integer NOT NULL,
    salaries integer,
    benefit integer,
    staffexp integer,
    prmatexp integer NOT NULL,
    elmatexp integer NOT NULL,
    totexpco integer NOT NULL,
    totopexp integer NOT NULL,
    lcap_rev integer NOT NULL,
    scap_rev integer NOT NULL,
    fcap_rev integer NOT NULL,
    cap_rev integer NOT NULL,
    capital integer NOT NULL,
    bkvol integer NOT NULL,
    ebook integer NOT NULL,
    audio integer NOT NULL,
    video integer NOT NULL,
    databases integer NOT NULL,
    subscrip integer NOT NULL,
    hrs_open integer NOT NULL,
    visits integer NOT NULL,
    referenc integer NOT NULL,
    regbor integer NOT NULL,
    totcir integer NOT NULL,
    kidcircl integer NOT NULL,
    loanto integer NOT NULL,
    loanfm integer NOT NULL,
    totpro integer NOT NULL,
    totatten integer NOT NULL,
    gpterms integer NOT NULL,
    pitusr integer NOT NULL,
    yr_sub integer NOT NULL,
    obereg varchar(2) NOT NULL,
    rstatus integer NOT NULL,
    statstru varchar(2) NOT NULL,
    statname varchar(2) NOT NULL,
    stataddr varchar(2) NOT NULL,
    longitud numeric(10,7) NOT NULL,
    latitude numeric(10,7) NOT NULL,
    fipsst varchar(2) NOT NULL,
    fipsco varchar(3) NOT NULL
);

CREATE INDEX libname2009_idx ON pls_fy2009_pupld09a (libname);
CREATE INDEX stabr2009_idx ON pls_fy2009_pupld09a (stabr);
CREATE INDEX city2009_idx ON pls_fy2009_pupld09a (city);
CREATE INDEX visits2009_idx ON pls_fy2009_pupld09a (visits);

COPY pls_fy2009_pupld09a
FROM 'C:\YourDirectory\pls_fy2009_pupld09a.csv'
WITH (FORMAT CSV, HEADER);

-- Listing 8-3: Using count() for table row counts

SELECT count(*)
FROM pls_fy2014_pupld14a;

SELECT count(*)
FROM pls_fy2009_pupld09a;

-- Listing 8-4: Using count() for the number of values in a column

SELECT count(salaries)
FROM pls_fy2014_pupld14a;

-- Listing 8-5: Using count() for the number of distinct values in a column

SELECT count(libname)
FROM pls_fy2014_pupld14a;

SELECT count(DISTINCT libname)
FROM pls_fy2014_pupld14a;

-- Bonus: find duplicate libnames
SELECT libname, count(libname)
FROM pls_fy2014_pupld14a
GROUP BY libname
ORDER BY count(libname) DESC;

-- Bonus: see location of every Oxford Public Library
SELECT libname, city, stabr
FROM pls_fy2014_pupld14a
WHERE libname = 'OXFORD PUBLIC LIBRARY';

-- Listing 8-6: Finding the most and fewest visits using max() and min()
SELECT max(visits), min(visits)
FROM pls_fy2014_pupld14a;

-- Listing 8-7: Using GROUP BY on the stabr column

-- There are 56 in 2014.
SELECT stabr
FROM pls_fy2014_pupld14a
GROUP BY stabr
ORDER BY stabr;

-- Bonus: there are 55 in 2009.
SELECT stabr
FROM pls_fy2009_pupld09a
GROUP BY stabr
ORDER BY stabr;

-- Listing 8-8: Using GROUP BY on the city and stabr columns

SELECT city, stabr
FROM pls_fy2014_pupld14a
GROUP BY city, stabr
ORDER BY city, stabr;

-- Bonus: We can count some of the combos
SELECT city, stabr, count(*)
FROM pls_fy2014_pupld14a
GROUP BY city, stabr
ORDER BY count(*) DESC;

-- Listing 8-9: GROUP BY with count() on the stabr column

SELECT stabr, count(*)
FROM pls_fy2014_pupld14a
GROUP BY stabr
ORDER BY count(*) DESC;

-- Listing 8-10: GROUP BY with count() on the stabr and stataddr columns

SELECT stabr, stataddr, count(*)
FROM pls_fy2014_pupld14a
GROUP BY stabr, stataddr
ORDER BY stabr ASC, count(*) DESC;

-- Listing 8-11: Using the sum() aggregate function to total visits to
-- libraries in 2014 and 2009

-- 2014
SELECT sum(visits) AS visits_2014
FROM pls_fy2014_pupld14a
WHERE visits >= 0;

-- 2009
SELECT sum(visits) AS visits_2009
FROM pls_fy2009_pupld09a
WHERE visits >= 0;

-- Listing 8-12: Using sum() to total visits on joined 2014 and 2009 library tables

SELECT sum(pls14.visits) AS visits_2014,
       sum(pls09.visits) AS visits_2009
FROM pls_fy2014_pupld14a pls14 JOIN pls_fy2009_pupld09a pls09
ON pls14.fscskey = pls09.fscskey
WHERE pls14.visits >= 0 AND pls09.visits >= 0;

-- Listing 8-13: Using GROUP BY to track percent change in library visits by state

SELECT pls14.stabr,
       sum(pls14.visits) AS visits_2014,
       sum(pls09.visits) AS visits_2009,
       round( (CAST(sum(pls14.visits) AS decimal(10,1)) - sum(pls09.visits)) /
                    sum(pls09.visits) * 100, 2 ) AS pct_change
FROM pls_fy2014_pupld14a pls14 JOIN pls_fy2009_pupld09a pls09
ON pls14.fscskey = pls09.fscskey
WHERE pls14.visits >= 0 AND pls09.visits >= 0
GROUP BY pls14.stabr
ORDER BY pct_change DESC;

-- Listing 8-14: Using HAVING to filter the results of an aggregate query

SELECT pls14.stabr,
       sum(pls14.visits) AS visits_2014,
       sum(pls09.visits) AS visits_2009,
       round( (CAST(sum(pls14.visits) AS decimal(10,1)) - sum(pls09.visits)) /
                    sum(pls09.visits) * 100, 2 ) AS pct_change
FROM pls_fy2014_pupld14a pls14 JOIN pls_fy2009_pupld09a pls09
ON pls14.fscskey = pls09.fscskey
WHERE pls14.visits >= 0 AND pls09.visits >= 0
GROUP BY pls14.stabr
HAVING sum(pls14.visits) > 50000000
ORDER BY pct_change DESC;


----------------------------------------------------------------
-- Chapter 8: Extracting Information by Grouping and Summarizing
----------------------------------------------------------------

-- 1. We saw that library visits have declined in most places. But what is the
-- pattern in the use of technology in libraries? Both the 2014 and 2009 library
-- survey tables contain the columns gpterms (the number of internet-connected
-- computers used by the public) and pitusr (uses of public internet computers
-- per year). Modify the code in Listing 8-13 to calculate the percent change in
-- the sum of each column over time. Watch out for negative values!

-- Answer:
-- Use sum() on gpterms (computer terminals) by state, find percent change, and
-- then sort.

SELECT pls14.stabr,
       sum(pls14.gpterms) AS gpterms_2014,
       sum(pls09.gpterms) AS gpterms_2009,
       round( (CAST(sum(pls14.gpterms) AS decimal(10,1)) - sum(pls09.gpterms)) /
                    sum(pls09.gpterms) * 100, 2 ) AS pct_change
FROM pls_fy2014_pupld14a pls14 JOIN pls_fy2009_pupld09a pls09
ON pls14.fscskey = pls09.fscskey
WHERE pls14.gpterms >= 0 AND pls09.gpterms >= 0
GROUP BY pls14.stabr
ORDER BY pct_change DESC;

-- The query results show a consistent increase in the number of internet
-- computers used by the public in most states.

-- Use sum() on pitusr (uses of public internet computers per year) by state,
-- add percent change, and sort.

SELECT pls14.stabr,
       sum(pls14.pitusr) AS pitusr_2014,
       sum(pls09.pitusr) AS pitusr_2009,
       round( (CAST(sum(pls14.pitusr) AS decimal(10,1)) - sum(pls09.pitusr)) /
                    sum(pls09.pitusr) * 100, 2 ) AS pct_change
FROM pls_fy2014_pupld14a pls14 JOIN pls_fy2009_pupld09a pls09
ON pls14.fscskey = pls09.fscskey
WHERE pls14.pitusr >= 0 AND pls09.pitusr >= 0
GROUP BY pls14.stabr
ORDER BY pct_change DESC;

-- The query results show most states have seen a decrease in the total uses
-- of public internet computers per year.

-- 2. Both library survey tables contain a column called obereg, a two-digit
-- Bureau of Economic Analysis Code that classifies each library agency
-- according to a region of the United States, such as New England, Rocky
-- Mountains, and so on. Just as we calculated the percent change in visits
-- grouped by state, do the same to group percent changes in visits by US
-- regions using obereg. Consult the survey documentation to find the meaning
-- of each region code. For a bonus challenge, create a table with the obereg
-- code as the primary key and the region name as text, and join it to the
-- summary query to group by the region name rather than the code.

-- Answer:

-- a) sum() visits by region.

SELECT pls14.obereg,
       sum(pls14.visits) AS visits_2014,
       sum(pls09.visits) AS visits_2009,
       round( (CAST(sum(pls14.visits) AS decimal(10,1)) - sum(pls09.visits)) /
                    sum(pls09.visits) * 100, 2 ) AS pct_change
FROM pls_fy2014_pupld14a pls14 JOIN pls_fy2009_pupld09a pls09
ON pls14.fscskey = pls09.fscskey
WHERE pls14.visits >= 0 AND pls09.visits >= 0
GROUP BY pls14.obereg
ORDER BY pct_change DESC;

-- b) Bonus: creating the regions lookup table and adding it to the query.

CREATE TABLE obereg_codes (
    obereg varchar(2) CONSTRAINT obereg_key PRIMARY KEY,
    region varchar(50)
);

INSERT INTO obereg_codes
VALUES ('01', 'New England (CT ME MA NH RI VT)'),
       ('02', 'Mid East (DE DC MD NJ NY PA)'),
       ('03', 'Great Lakes (IL IN MI OH WI)'),
       ('04', 'Plains (IA KS MN MO NE ND SD)'),
       ('05', 'Southeast (AL AR FL GA KY LA MS NC SC TN VA WV)'),
       ('06', 'Soutwest (AZ NM OK TX)'),
       ('07', 'Rocky Mountains (CO ID MT UT WY)'),
       ('08', 'Far West (AK CA HI NV OR WA)'),
       ('09', 'Outlying Areas (AS GU MP PR VI)');

-- sum() visits by region.

SELECT obereg_codes.region,
       sum(pls14.visits) AS visits_2014,
       sum(pls09.visits) AS visits_2009,
       round( (CAST(sum(pls14.visits) AS decimal(10,1)) - sum(pls09.visits)) /
                    sum(pls09.visits) * 100, 2 ) AS pct_change
FROM pls_fy2014_pupld14a pls14 JOIN pls_fy2009_pupld09a pls09
   ON pls14.fscskey = pls09.fscskey
JOIN obereg_codes
   ON pls14.obereg = obereg_codes.obereg
WHERE pls14.visits >= 0 AND pls09.visits >= 0
GROUP BY obereg_codes.region
ORDER BY pct_change DESC;


-- 3. Thinking back to the types of joins you learned in Chapter 6, which join
-- type will show you all the rows in both tables, including those without a
-- match? Write such a query and add an IS NULL filter in a WHERE clause to
-- show agencies not included in one or the other table.

-- Answer: a FULL OUTER JOIN will show all rows in both tables.

SELECT pls14.libname, pls14.city, pls14.stabr, pls14.statstru, pls14.c_admin, pls14.branlib,
       pls09.libname, pls09.city, pls09.stabr, pls09.statstru, pls09.c_admin, pls09.branlib
FROM pls_fy2014_pupld14a pls14 FULL OUTER JOIN pls_fy2009_pupld09a pls09
ON pls14.fscskey = pls09.fscskey
WHERE pls14.fscskey IS NULL OR pls09.fscskey IS NULL;

-- Note: The IS NULL statements in the WHERE clause limit results to those
-- that do not appear in both tables.