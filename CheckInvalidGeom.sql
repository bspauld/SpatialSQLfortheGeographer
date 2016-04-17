/*
  
  Script:       CheckInvalidGeom.sql
  Purpose:      Microsoft Transact SQL Script that will check data to see any invalid geometries exist in described geomerty data.  
                Data and tables in script based off tutorial information
                from here: http://www.gisdoctor.com/site/2011/11/15/spatial-sql-geographer-part-1-spatial-sql/
  
  Instructions: Set proper table and field names and run the script.
  Author: Ben Spaulding - 2016
  
*/

--Check to see if any records still have any invalid geometries. 
select  ID, geom.STIsValid() as ValidCheck,
geom, geom.ToString() as Spatial_Text_String
from dbo.States_Provinces
where geom.STIsValid() != 1
