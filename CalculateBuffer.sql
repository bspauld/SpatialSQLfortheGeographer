/*
  
  Script:       CalculateBuffer.sql
  Purpose:      Microsoft Transact SQL Script that will calculate the buffer of a selected geometry record.  
  
                It is important to remember the units returned will be the same as the input units, so the
                example query input is decimal degrees.
                
                Data and tables in script based off tutorial information
                from here: http://www.gisdoctor.com/site/2011/11/15/spatial-sql-geographer-part-1-spatial-sql/
  
  Instructions: Set proper table and field names and run the script.
  Author: Ben Spaulding - 2016
  
*/

select geom.STBuffer(0.05) as buffer
from dbo.States_Provinces
where name_1 =  'Massachusetts'
