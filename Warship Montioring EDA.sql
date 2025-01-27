select *
from warships_monitoring.data_monitoring;



# Daily Trend of Enemy Ships in the Black Sea
SELECT 
    DATE(`date`) AS day, 
    SUM(`black_sea.enemy_ships`) AS total_enemy_ships 
FROM 
    data_monitoring 
GROUP BY 
    day 
ORDER BY 
    day;
    
    
    
    
# Weekly Trend of Kalibr Carriers in the Mediterranean Sea
SELECT 
    YEAR(`date`) AS year, 
    WEEK(`date`) AS week, 
    SUM(`mediterranean_sea.kalibr_carriers`) AS total_kalibr_carriers 
FROM 
    data_monitoring 
GROUP BY 
    year, week 
ORDER BY 
    year, week;




# Total Salvos by Region
SELECT 
    'Black Sea' AS region, SUM(`black_sea.total_salvo`) AS total_salvos 
FROM 
    data_monitoring 
UNION ALL 
SELECT 
    'Azov Sea', SUM(`azov_sea.total_salvo`) 
FROM 
    data_monitoring 
UNION ALL 
SELECT 
    'Mediterranean Sea', SUM(`mediterranean_sea.total_salvo`) 
FROM 
    data_monitoring;
    
    
    
    
# Maximum Kalibr Carriers by Region
SELECT 
    MAX(`black_sea.kalibr_carriers`) AS max_black_sea_carriers, 
    MAX(`azov_sea.kalibr_carriers`) AS max_azov_sea_carriers, 
    MAX(`mediterranean_sea.kalibr_carriers`) AS max_mediterranean_carriers 
FROM 
    data_monitoring;
    
    
    
    
# Compare Total Enemy Ships Across Regions
SELECT 
    SUM(`black_sea.enemy_ships`) AS black_sea_total,
    SUM(`azov_sea.enemy_ships`) AS azov_sea_total,
    SUM(`mediterranean_sea.enemy_ships`) AS mediterranean_total
FROM 
    data_monitoring;
    
    
    
    
    
# Days with Unusually High Total Salvos
SELECT 
    DATE(`date`) AS day, 
    SUM(`black_sea.total_salvo` + `azov_sea.total_salvo` + `mediterranean_sea.total_salvo`) AS total_salvos 
FROM 
    data_monitoring 
GROUP BY 
    day 
HAVING 
    total_salvos > (
        SELECT AVG(`black_sea.total_salvo` + `azov_sea.total_salvo` + `mediterranean_sea.total_salvo`)
        FROM data_monitoring
    );


    

    

