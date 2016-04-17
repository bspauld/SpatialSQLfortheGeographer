/*
  
  Script:       GeomDifference.sql
  Purpose:      Microsoft Transact SQL Script that calculate the geometric difference between two selected
                polygon objects.  
                
                Data and tables in script based off tutorial information
                from here: http://www.gisdoctor.com/site/2011/11/15/spatial-sql-geographer-part-1-spatial-sql/
  
  Instructions: Set proper table and field names and run the script.
  Author: Ben Spaulding - 2016
  
*/

DECLARE @poly_geom geometry
select @poly_geom = geom.STAsText()
From dbo.States_Provinces
where dbo.States_Provinces.name_1 = 'Massachusetts'

DECLARE @USA geometry
select @USA = geom.STAsText()
from dbo.world_countries
where dbo.world_countries.ID = 236

SELECT @USA.STDifference(@poly_geom) as Part1andPart2
