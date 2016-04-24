/*#################################################################################################################################
	
	Script Name:	CalculateLines.sql
	Purpose:		This script calculates the distance between two points using latitude and longitude measurements.
					
					This example is using the Natural Earth Populated Places dataset. The
					example using both geometry and geography datatypes.
					
					The example uses the Latitude and Longitude values from each populated place then generates the
					geography and geometry data type line objects between a single location and all other
					points in dataset.
	
					Documentation on STLineFromText https://msdn.microsoft.com/en-us/library/bb933976.aspx
						
	Author:			Ben Spaulding 
	Date:			4/2016


#################################################################################################################################*/

use NaturalEarthData

select 
	--t1 = the FROM XY
	t1.IdVal as ID, 
	t1.NAMEASCII as t1_Name, 
	t1.SOV0NAME as t1_SOV0NAME, 
	t1.Latitude as t1_Latitude, 
	t1.Longitude as t1_Longitude, 

	--t2 = the TO XY
	t2.IDVal as t2_ID, t2.NAMEASCII as t2_Name, 
	t2.SOV0NAME as t2_SOV0NAME, 
	t2.LATITUDE as t2_Latitide, 
	t2.LONGITUDE as t2_Longitude,

	--Calculate the geography line object from the FROM and TO XY values
	Geography::STLineFromText('LINESTRING('+cast(cast(t1.longitude as float)as varchar)+' '+cast(cast(t1.latitude as float)as varchar)+','+cast(cast(t2.longitude as float)as varchar)+' '+cast(cast(t2.latitude as float)as varchar)+')', 4326) as GeogLine,
	--Calculate the geometry line object from the FROM and TO XY values
	Geometry::STLineFromText('LINESTRING('+cast(cast(t1.longitude as float)as varchar)+' '+cast(cast(t1.latitude as float)as varchar)+','+cast(cast(t2.longitude as float)as varchar)+' '+cast(cast(t2.latitude as float)as varchar)+')', 4326) as GeomLine

--Use cross join to get all combinations of values
from dbo.Populated_Places t1 cross join dbo.Populated_Places t2

--Set where statement to only caclulate lines from Boston to all other US locations
where t1.SOV0NAME = 'United States' and  t2.SOV0NAME = 'United States'  and t1.IDVal != t2.IDVal and t1.NAMEASCII = 'Boston'
