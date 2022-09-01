USE shark;
SELECT * FROM pitches;

-- total no. of episodes
SELECT count(DISTINCT `Episode Number`) AS total
FROM pitches;

-- pitches(total different ideas/startup)
SELECT count(DISTINCT Brand)
FROM pitches;

-- total startups who got funding
SELECT count(`Investment Amount (In Lakhs INR)`) AS 'funded'
FROM pitches
WHERE `Investment Amount (In Lakhs INR)`>0;

-- total startups not got funded
SELECT count(`Investment Amount (In Lakhs INR)`) AS 'not funded'
FROM pitches
WHERE `Investment Amount (In Lakhs INR)`=0;

-- M II(both funded n not in 1 table)
SELECT b.success, b.total - b.success AS 'fail', b.total
FROM
--  2for taking sum of 1,0's which will give total success and total count as total pitches
(SELECT sum(a.converted) AS 'success',count(*) AS 'total'
FROM(
-- first subquery for selecting 1 and 0 for yes or no
SELECT `Investment Amount (In Lakhs INR)`,
	   (CASE when `Investment Amount (In Lakhs INR)`>0 then 1 else 0 
	   end )AS 'converted'
       FROM pitches
	) a
    )b;
    
-- success perctenage 
SELECT (q.success/q.total)*100 AS 'success rate'
FROM
(SELECT count(*) as 'total',sum(s.sa) AS 'success'
FROM
	(SELECT `Investment Amount (In Lakhs INR)`,
			CASE WHEN `Investment Amount (In Lakhs INR)`>0 THEN 1 ELSE 0 end AS 'sa'
	FROM pitches
	) s
    )q;
 
 -- total males
 SELECT sum(Male) AS 'males'
 FROM pitches;
 
 -- total females
  SELECT sum(Female) AS 'females'
 FROM pitches;
 
 
--  Gender ratio
SELECT sum(Male)/sum(Female) AS 'gender ratio'
FROM pitches;

-- total amount invested
SELECT sum(`Investment Amount (In Lakhs INR)`) AS 'total amount (Lakhs)'
FROM pitches;

-- highest funding
SELECT max(`Investment Amount (In Lakhs INR)`) AS 'max investment(80)'
FROM pitches;

-- avg investment
SELECT avg(`Investment Amount (In Lakhs INR)`) AS 'avg investment(lakhs)'
FROM pitches
WHERE `Investment Amount (In Lakhs INR)`>0;


-- highest equity percentage
SELECT *
FROM pitches
GROUP BY Equity
ORDER BY Equity DESC
LIMIT 1;

-- IMP avg equity taken(only where funding happened bcoz where 0 ,there is no funding)
SELECT avg(Equity)
FROM pitches
WHERE Equity>0;


-- pitches where atleast 1 woman was there
SELECT *
FROM pitches
WHERE Female>0;

-- pitches converted having atleast 1 women
SELECT count(*)
FROM(
SELECT *
FROM pitches
WHERE `Investment Amount (In Lakhs INR)`>0)a
WHERE a.Female>0;


-- most avg age group coming for pitches
SELECT Avg_age, count(Avg_age)
FROM pitches
GROUP BY Avg_age
ORDER BY 2 DESC;

-- sector from which deals are coming
SELECT Sector,count(Sector)
FROM pitches
GROUP BY Sector
ORDER BY 2 DESC;

-- areas 
SELECT Location,count(Location)
FROM pitches
GROUP BY Location 
ORDER BY 2 DESC;

-- most number of deals
SELECT Partners, count(Partners)
FROM pitches
WHERE Partners != '-'
GROUP BY Partners
ORDER BY 2 DESC;

-- Highest amount invested by each Sharks
SELECT `Ashneer Amount Invested`
FROM pitches
ORDER BY 1 desc
limit 1;

SELECT `mita Amount Invested`
FROM pitches
ORDER BY 1 desc
limit 1;

SELECT `Anupam Amount Invested`
FROM pitches
ORDER BY 1 desc
limit 1;

SELECT `Aman Amount Invested`
FROM pitches
ORDER BY 1 desc
limit 1;

SELECT `Vineeta Amount Invested`
FROM pitches
ORDER BY 1 desc
limit 1;

SELECT `Peyush Amount Invested`
FROM pitches
ORDER BY 1 desc
limit 1;


-- MATRIX OF SHARKS AND INVESTEMENTS

SELECT 'Ashneer' AS Shark,count(`Ashneer Amount Invested`) AS total_deals_present,
	   sum(b.funded) AS total_deals_success,
       sum(`Ashneer Amount Invested`) AS 'total invested(lakhs)'
FROM(
SELECT 'Ashneer' AS Shark,a.`Ashneer Amount Invested`,
	CASE WHEN a.`Ashneer Amount Invested`>0 THEN 1 ELSE 0 end AS'funded'
FROM(
SELECT 'Ashneer' AS Shark,`Episode Number`,`Ashneer Amount Invested`
FROM pitches
WHERE `Ashneer Amount Invested` = 0 OR `Ashneer Amount Invested`>0)a
)b
UNION
SELECT 'mita' AS Shark,count(`mita Amount Invested`) AS total_deals_present,
	   sum(b.funded) AS total_deals_success,
       sum(`mita Amount Invested`) AS 'total invested(lakhs)'
FROM(
SELECT 'mita' AS Shark,a.`mita Amount Invested`,
	CASE WHEN a.`mita Amount Invested`>0 THEN 1 ELSE 0 end AS'funded'
FROM(
SELECT 'mita' AS Shark,`Episode Number`,`mita Amount Invested`
FROM pitches
WHERE `mita Amount Invested` = 0 OR `mita Amount Invested`>0)a
)b
UNION
SELECT 'Anupam' AS Shark,count(`Anupam Amount Invested`) AS total_deals_present,
	   sum(b.funded) AS total_deals_success,
       sum(`Anupam Amount Invested`) AS 'total invested(lakhs)'
FROM(
SELECT 'Anupam' AS Shark,a.`Anupam Amount Invested`,
	CASE WHEN a.`Anupam Amount Invested`>0 THEN 1 ELSE 0 end AS'funded'
FROM(
SELECT 'Anupam' AS Shark,`Episode Number`,`Anupam Amount Invested`
FROM pitches
WHERE `Anupam Amount Invested` = 0 OR `Anupam Amount Invested`>0)a
)b
UNION
SELECT 'Vineeta' AS Shark,count(`Vineeta Amount Invested`) AS total_deals_present,
	   sum(b.funded) AS total_deals_success,
       sum(`Vineeta Amount Invested`) AS 'total invested(lakhs)'
FROM(
SELECT 'Vineeta' AS Shark,a.`Vineeta Amount Invested`,
	CASE WHEN a.`Vineeta Amount Invested`>0 THEN 1 ELSE 0 end AS'funded'
FROM(
SELECT 'Vineeta' AS Shark,`Episode Number`,`Vineeta Amount Invested`
FROM pitches
WHERE `Vineeta Amount Invested` = 0 OR `Vineeta Amount Invested`>0)a
)b
UNION
SELECT 'Aman' AS Shark,count(`Aman Amount Invested`) AS total_deals_present,
	   sum(b.funded) AS total_deals_success,
       sum(`Aman Amount Invested`) AS 'total invested(lakhs)'
FROM(
SELECT 'Aman' AS Shark,a.`Aman Amount Invested`,
	CASE WHEN a.`Aman Amount Invested`>0 THEN 1 ELSE 0 end AS'funded'
FROM(
SELECT 'Aman' AS Shark,`Episode Number`,`Aman Amount Invested`
FROM pitches
WHERE `Aman Amount Invested` = 0 OR `Aman Amount Invested`>0)a
)b
UNION
SELECT 'Peyush' AS Shark,count(`Peyush Amount Invested`) AS total_deals_present,
	   sum(b.funded) AS total_deals_success,
       sum(`Peyush Amount Invested`) AS 'total invested(lakhs)'
FROM(
SELECT 'Peyush' AS Shark,a.`Peyush Amount Invested`,
	CASE WHEN a.`Peyush Amount Invested`>0 THEN 1 ELSE 0 end AS'funded'
FROM(
SELECT 'Peyush' AS Shark,`Episode Number`,`Peyush Amount Invested`
FROM pitches
WHERE `Peyush Amount Invested` !='')a
)b
UNION
SELECT 'Ghazal' AS Shark,count(`Ghazal Amount Invested`) AS total_deals_present,
	   sum(b.funded) AS total_deals_success,
       sum(`Ghazal Amount Invested`) AS 'total invested(lakhs)'
FROM(
SELECT 'Ghazal' AS Shark,a.`Ghazal Amount Invested`,
	CASE WHEN a.`Ghazal Amount Invested`>0 THEN 1 ELSE 0 end AS'funded'
FROM(
SELECT 'Ghazal' AS Shark,`Episode Number`,`Ghazal Amount Invested`
FROM pitches
WHERE `Ghazal Amount Invested` != '')a
)b