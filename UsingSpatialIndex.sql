/*
  
  Script:       UsingSpatialIndex.sql
  Purpose:      Microsoft Transact SQL Script that provides a basic example of STIntersects(), a where statement, and
                how to call a specific spatial index with the WITH statement. Calling the spatial index can 
                greatly improve query speed.
                
                Data and tables in script based off tutorial information
                from here: http://www.benjaminspaulding.com/2011/11/15/spatial-sql-geographer-part-1-spatial-sql/
  
  Instructions: Set proper table and field names and run the script.
  Author: Ben Spaulding - 2016
  
*/
--Select needed data.  Select * is usually a bad idea
select PP.*, SP.*
from Populated_Places PP
inner join States_Provinces SP with(Index(geom_sidx))
on PP.geom.STIntersects(SP.geom) = 1
where SP.NAME_0 = 'United States of America' 
and SP.NAME_1 = 'Massachusetts'
