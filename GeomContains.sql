
/*
  
  Script:       GeomContains.sql
  Purpose:      Microsoft Transact SQL Script that will find the geometry point records that are contained by
                the selected polygon value.  
                
                Data and tables in script based off tutorial information
                from here: http://www.benjaminspaulding.com/2011/11/15/spatial-sql-geographer-part-1-spatial-sql/
  
  Instructions: Set proper table and field names and run the script.
  Author: Ben Spaulding - 2016
  
*/


DECLARE @poly_geom geometry
select @poly_geom = geom.STAsText()
From dbo.States_Provinces
where dbo.States_Provinces.name_1 = 'Massachusetts'

DECLARE @pointgeom geometry
select @pointgeom = geom.STAsText()
from dbo.Populated_Places
where NAMEASCII = 'Boston'

SELECT @poly_geom.STContains(@pointgeom) as ContainValue, @pointgeom as input1, @poly_geom as input2
