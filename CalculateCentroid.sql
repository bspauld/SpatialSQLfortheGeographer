/*
  
  Script:       CalculateCentroid.sql
  Purpose:      Microsoft Transact SQL Script that will calculate the geometric centroid of the polygons in a table. 
                Subquery will generate the centroid of each polygon record, and X and Y values can be derived in the
                outer query.
                
                Data and tables in script based off tutorial information
                from here: http://www.gisdoctor.com/site/2011/11/15/spatial-sql-geographer-part-1-spatial-sql/
  
  Instructions: Set proper table and field names and run the script.
  Author: Ben Spaulding - 2016
  
*/

select U.Region_Name, Centroid.STY as Longitude,
Centroid.STX as Latidude
 from
(	--select STCentroid for each geom 
	select geom.STCentroid() as Centroid, NAME as Region_Name
	 from dbo.world_countries
)U
