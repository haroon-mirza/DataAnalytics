select *
from StudentsPerformance


-- determining the average score between gender
-- females scored higher on average

select gender, (avg([writing score]) + avg([math score]) + avg([reading score])) / 3 as [average score overall]
from StudentsPerformance
group by gender




-- grouping each subject by gender
-- females scored higher on writing and reading, while men scored higher on math on average

select gender, avg([writing score]) as [writing score],  avg([math score]) as [math score], avg([reading score]) as [reading score]
from StudentsPerformance
group by gender


-- masters degrees score the highest on average, but bachelors score very close. Every other education level descends expectingly.

select distinct [parental level of education], (avg([writing score]) + avg([math score]) + avg([reading score])) / 3 as [average score overall]
from StudentsPerformance
group by [parental level of education]
order by [average score overall] desc


-- some high school education scored higher than high school education

select distinct [parental level of education], avg([writing score]) as [writing score],  avg([math score]) as [math score], avg([reading score]) as [reading score]
from StudentsPerformance
group by [parental level of education]
order by [writing score], [math score], [reading score] 



-- as expected, taking the test prep course increased the average score by 7.6 points.

select [test preparation course],  (avg([writing score]) + avg([math score]) + avg([reading score])) / 3 as [average score overall]
from StudentsPerformance
group by [test preparation course]



-- group E scores the highest on average

select distinct [race/ethnicity],  (avg([writing score]) + avg([math score]) + avg([reading score])) / 3 as [average score overall]
from StudentsPerformance
group by [race/ethnicity]


-- Highest scorers were raised by masters or bachelors levels of education and were from either group E, B, or D.

select distinct [race/ethnicity], [parental level of education], (avg([writing score]) + avg([math score]) + avg([reading score])) / 3 as [average score overall]
from StudentsPerformance
group by [race/ethnicity], [parental level of education], [test preparation course]
order by [average score overall] desc



--students who had standard lunch scored higher on average compared to students who had free/reduced lunch

select distinct [race/ethnicity], [lunch], (avg([writing score]) + avg([math score]) + avg([reading score])) / 3 as [average score overall]
from StudentsPerformance
group by [race/ethnicity], [lunch]
order by [average score overall] desc





-- For Tableau ---

-- 1 Gender Comparison

select gender, avg([writing score]) as [writing score],  avg([math score]) as [math score], avg([reading score]) as [reading score]
from StudentsPerformance
group by gender



-- 2 Education and Race Comparison

select distinct [race/ethnicity], [parental level of education], (avg([writing score]) + avg([math score]) + avg([reading score])) / 3 as [average score overall]
from StudentsPerformance
group by [race/ethnicity], [parental level of education], [test preparation course]
order by [average score overall] desc



-- 3 Education levels impact on scores

select distinct [parental level of education], avg([writing score]) as [writing score],  avg([math score]) as [math score], avg([reading score]) as [reading score]
from StudentsPerformance
group by [parental level of education]
order by [writing score], [math score], [reading score] 

-- 4 Simplified Gender Comparison

select gender, (avg([writing score]) + avg([math score]) + avg([reading score])) / 3 as [average score overall]
from StudentsPerformance
group by gender
