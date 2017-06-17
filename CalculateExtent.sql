/*
  
  Script:       CalculateExtent.sql
  Purpose:      Microsoft Transact SQL Script that will calculate the extent (or bounding box) of the selected
                geometry.  
                
                Data and tables in script based off tutorial information
                from here: http://www.benjaminspaulding.com/2011/11/15/spatial-sql-geographer-part-1-spatial-sql/
  
  Instructions: Set proper table and field names and run the script.
  Author: Ben Spaulding - 2016
  
*/
--Example to find STEnvelope() result for selected geometry record

select
geom.STEnvelope() as boundingbox
from dbo.States_Provinces
where NAME_1 = 'Massachusetts'


--Example to convert the results of geom.STEnvelope() to readable coordinates

select
geom.STEnvelope() as BoundingBox,
geom.STEnvelope().ToString() as BoundingBoxString
from dbo.States_Provinces
where NAME_1 = 'Massachusetts'

--Example that returns the min/max coordinates for the four corners using STEnvelope and STPoint
select
	 MIN(geom.STEnvelope().STPointN(1).STX) as ULX
	,MIN(geom.STEnvelope().STPointN(1).STY) as ULY 
	,MAX(geom.STEnvelope().STPointN(3).STX) as LRX 
	,MAX(geom.STEnvelope().STPointN(3).STY) as LRY 
from dbo.States_Provinces
where NAME_1 = 'Massachusetts'

