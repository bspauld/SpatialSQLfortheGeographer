/*
  
  Script:       GeomIntersect.sql
  Purpose:      Microsoft Transact SQL Script that calculate the intersection of two geometry objects.
  
                Two examples are provided here - one using variables, the other using an inner join
  
                from here: http://www.benjaminspaulding.com/2011/11/15/spatial-sql-geographer-part-1-spatial-sql/
                
  Instructions: Set proper table and field names and run the script.
  Author: Ben Spaulding - 2016
  
*/

--Using variables
DECLARE @poly_geom geometry
select @poly_geom = geom.STAsText()
From dbo.States_Provinces
where dbo.States_Provinces.name_1 like '%Massachusetts%'

DECLARE @line_geom geometry
select @line_geom = geom.STAsText()
from dbo.Roads
where IDval = 2974

SELECT @poly_geom.STIntersects(@line_geom) as IntersectValue, @poly_geom as input1, @line_geom as input2

--Using Inner Join - this should work.  I haven't tested it :( Will return all records that return TRUE intersection (1)

select * From dbo.States_Provinces P inner join dbo.Roads I on P.geom.STIntersects(I.geom) = 1 where p.NAME_1 = 'Massachusetts'
