#Build a country Map Table   (1)

select countryname,countrycode,city 
from zomato_project_2;


#Build a Calendar Table using the Column Datekey   (2)
SELECT 
    DISTINCT Datekey_Opening AS Datekey,
    YEAR(STR_TO_DATE(Datekey_Opening, '%d-%m-%Y')) AS Year,
    MONTH(STR_TO_DATE(Datekey_Opening, '%d-%m-%Y')) AS Monthno,
    MONTHNAME(STR_TO_DATE(Datekey_Opening, '%d-%m-%Y')) AS Monthfullname,
    CONCAT(YEAR(STR_TO_DATE(Datekey_Opening, '%d-%m-%Y')), '-', LEFT(MONTHNAME(STR_TO_DATE(Datekey_Opening, '%d-%m-%Y')), 3)) AS YearMonth,
    QUARTER(STR_TO_DATE(Datekey_Opening, '%d-%m-%Y')) AS Quarter,
    DAYOFWEEK(STR_TO_DATE(Datekey_Opening, '%d-%m-%Y')) AS Weekdayno,
    DAYNAME(STR_TO_DATE(Datekey_Opening, '%d-%m-%Y')) AS Weekdayname,
    CASE MONTH(STR_TO_DATE(Datekey_Opening, '%d-%m-%Y'))
        WHEN 4 THEN 'FM1' WHEN 5 THEN 'FM2' WHEN 6 THEN 'FM3'
        WHEN 7 THEN 'FM4' WHEN 8 THEN 'FM5' WHEN 9 THEN 'FM6'
        WHEN 10 THEN 'FM7' WHEN 11 THEN 'FM8' WHEN 12 THEN 'FM9'
        WHEN 1 THEN 'FM10' WHEN 2 THEN 'FM11' WHEN 3 THEN 'FM12'
    END AS FinancialMonth,
    CASE 
        WHEN MONTH(STR_TO_DATE(Datekey_Opening, '%d-%m-%Y')) BETWEEN 4 AND 6 THEN 'FQ1'
        WHEN MONTH(STR_TO_DATE(Datekey_Opening, '%d-%m-%Y')) BETWEEN 7 AND 9 THEN 'FQ2'
        WHEN MONTH(STR_TO_DATE(Datekey_Opening, '%d-%m-%Y')) BETWEEN 10 AND 12 THEN 'FQ3'
        ELSE 'FQ4'
    END AS FinancialQuarter
FROM zomato_project_2;

	# Find the Numbers of Resturants based on City and Country    (3)
    
select CountryName, City, count(RestaurantID) as Count 
	   from zomato_project_2
       group by CountryName, City;
       
 # Numbers of Resturants opening based on Year , Quarter , Month   (4)
  SELECT 
    YEAR AS Year, 
    QUARTER AS Quarter, 
    MONTH AS Month, 
    COUNT(RestaurantID) AS Count
FROM 
    zomato_project_2
    GROUP BY 1,2,3;
    
    
#Count of Resturants based on Average Ratings     (5)

select rating,count(restaurantid) as Num_Of_Restaurants
from zomato_project_2
group by 1;

# Create buckets based on Average Price of reasonable size and find out how many resturants 
#falls in each buckets                            (6)


create view Avg_Cost_For_Two as select * , 
	case 
		when Average_Cost_For_Two>0 and  Average_Cost_For_Two<=500 then "100-500"
        when  Average_Cost_For_Two>500 and  Average_Cost_For_Two<=1000 then "500-1000"
        when  Average_Cost_For_Two>1000 and  Average_Cost_For_Two<=1500 then "1000-1500"
        when  Average_Cost_For_Two>1500 and  Average_Cost_For_Two<=2000 then "1500-2000"
        else ">2000"
        end as Avg_Cost_For_Two_New
	from zomato_project_2
    ;
    select Avg_Cost_For_Two_New, count(restaurantid) as count 
    from Avg_Cost_For_Two group by Avg_Cost_For_Two_New;
    
    
#Percentage of Resturants based on "Has_Table_booking"                (7)
select Has_Table_booking, round(((count(restaurantid)/(select count(*) from zomato_project_2))*100),2) as Percent_Has_Table_booking 
from zomato_project_2
group by 1;


#.Percentage of Resturants based on "Has_Online_delivery"         (8)
		select Has_Online_delivery, round(((count(restaurantid)/(select count(*) from zomato_project_2))*100),2) as 
        Percent_Has_Online_delivery
		from zomato_project_2
        group by Has_Online_delivery;







 

  
       
       
