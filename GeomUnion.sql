/*
  
  Script:       GeomUnion.sql
  Purpose:      Microsoft Transact SQL Script that will calculate the geometric union between two polygon objects.  
  
                Data and tables in script based off tutorial information
                from here: http://www.gisdoctor.com/site/2011/11/15/spatial-sql-geographer-part-1-spatial-sql/
  
  Instructions: Set proper table and field names and run the script.
  Author: Ben Spaulding - 2016
  
*/

DECLARE @poly_geom geometry
select @poly_geom = geom.STAsText()
from dbo.world_countries
where dbo.world_countries.ADMIN = 'Germany'

DECLARE @poly_geom2 geometry
select @poly_geom2 = geom.STAsText()
from dbo.world_countries
where dbo.world_countries.ADMIN = 'Switzerland'

SELECT @poly_geom2.STUnion(@poly_geom) as UnionGeo
