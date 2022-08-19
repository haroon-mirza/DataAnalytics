select * from vgsales


-- For Tableau


-- Sales per Genre globally

select Genre, count(Global_Sales) as Sales
from vgsales
group by Genre
order by Genre desc



-- 2010s sales

select genre,Global_Sales
from vgsales
where Year > 2000 and Year < 2010


-- 90s sales
select genre,Global_Sales
from vgsales
where Year > 1990 and Year < 2000


--80s sales
select genre,Global_Sales 
from vgsales
where Year > 1980 and Year < 1990


-- Sales by Publisher

 select Publisher, count(Global_Sales) as Sales
 from vgsales
 group by Publisher
 order by Sales desc


-- Sales by Platform

 select Platform, count(Global_Sales) as Sales
 from vgsales
 group by Platform
 order by Sales desc