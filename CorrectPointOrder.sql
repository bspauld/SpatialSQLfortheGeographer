/*
  
  Script:       CorrectPointOrder.sql
  Purpose:      Microsoft Transact SQL Script that will correct the order of points in a polygon in described geomerty data.  
                Data and tables in script based off tutorial information
                from here: http://www.benjaminspaulding.com/2011/11/15/spatial-sql-geographer-part-1-spatial-sql/
  
  Instructions: Set proper table and field names and run the script.
  Author: Ben Spaulding - 2016
  
*/

update dbo.States_Provinces
set geom = geometry::STGeomFromWKB
(geom.STUnion(geom.STStartPoint()).STAsBinary(),geom.STSrid)
