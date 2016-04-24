/*#################################################################################################################################
	
	Script Name:	Calculate_Distance.sql
	Purpose:		This script calculates the distance between two points using latitude and longitude measurements.
					
					This example is using the Natural Earth State/Provinces dataset. The
					example using both geometry and geography datatypes.
					
					The example calculates the Latitude and Longitude values from a centroid of the polygon and then generates the
					geography and geometry data type line objects.

	
					Documentation on STDistance http://technet.microsoft.com/en-us/library/bb933808.aspx
						
	Author:			Ben Spaulding 
	Date:			4/2016


*/

use NaturalEarthData

select 
	U.From_State,U.From_Centroid.STY as From_Latitude, U.From_Centroid.STX  as From_Longitude, 
	U.To_State,U.To_Centroid.STY as To_Latitude, U.To_Centroid.STX  as To_Longitude,
	--Set origin with Point and destination with the STDistance point
	--Calculate using Geometry Data Type - returns values in decimal degrees
	geometry::Point(U.From_Centroid.STY, U.From_Centroid.STX, 4326).STDistance(geometry::Point(U.To_Centroid.STY, U.To_Centroid.STX, 4326)) as Distance_Meters_Geometry,
	--Calculate using Geography Data Type - returns values in meters
	Geography::Point(U.From_Centroid.STY, U.From_Centroid.STX, 4326).STDistance(Geography::Point(U.To_Centroid.STY, U.To_Centroid.STX, 4326)) as Distance_Meters_Geography,
	--Calculate geography data type line from the centroids
	Geography::STLineFromText('LINESTRING('+cast(cast(U.From_Centroid.STX as float)as varchar)+' '+cast(cast(U.From_Centroid.STY as float)as varchar)+','+cast(cast(U.To_Centroid.STX as float)as varchar)+' '+cast(cast(U.To_Centroid.STY as float)as varchar)+')', 4326) as GeoglineShape,
	--Calculate the geometry data type line from the centroids
	Geometry::STLineFromText('LINESTRING('+cast(cast(U.From_Centroid.STX as float)as varchar)+' '+cast(cast(U.From_Centroid.STY as float)as varchar)+','+cast(cast(U.To_Centroid.STX as float)as varchar)+' '+cast(cast(U.To_Centroid.STY as float)as varchar)+')', 4326) as GeomlineShape
from
(
select  
	t1.Postal as From_State, t2.Postal as To_State,		
	t1.geom.STCentroid() as From_Centroid, t2.geom.STCentroid()as To_Centroid
	from dbo.States_Provinces t1 cross join dbo.States_Provinces t2
	--Set where statement to only select the measure distance from one centroid to others
	where t1.ISO =  'USA' and t2.ISO = 'USA'
) U
where U.From_State = 'MA'
order by U.From_State, U.To_State 
