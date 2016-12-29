/*
    Script:   MultiPointtoLineFast.sql

    Purpose:  This script will take pairs of coordinates of the same line and convert them into a LineString 
              that can be used to generate lines of the geometry data type. User will need to update the database, 
              tables, and column names relevant to their own analysis.

              Script uses a simple join only preserving the records that are next in order. This is a much
              faster script than the cursor in the MultiPointtoLine.sql example in this project.

              Sample Sandy data tracks represent five day models from the National Hurricane Center.

              Prepping the data - The user will need to download the following file and load into their SQL database:
              http://www.gisdoctor.com/downloads/Line_Parts.txt

              Here is a quick script to take the text file and load it into a table generated for this exercise:

              create table Spatial_Database.dbo.Distinct_Points
              ([ADVISNUM] varchar(3), [lat] float, [lon] float, [rowID] int Identity(1,1),[MaxWind] int)

              BULK INSERT Spatial_Database.dbo.Distinct_Points
              FROM 'Path to Line_Parts.txt file'
              WITH (FIELDTERMINATOR =',',FirstRow = 2);

*/

SELECT f.ADVISNUM as ADVISNUM
      ,f.[rowID] as [rowID]
      ,f.[Lon] as Lon1
      ,f.[Lat] as Lat1
	    ,t.lon as Lon2
	    ,t.lat as Lat2
	  ,Geometry::STLineFromText('LINESTRING('+cast(cast(f.lon as float)as varchar)+' '+cast(cast(f.lat as float)as varchar)+','+cast(cast(t.lon as float)as varchar)+' '+cast(cast(t.lat as float)as varchar)+')', 4326) as coordsegment
FROM [dbo].[Distinct_Points] f join
[dbo].[Distinct_Points] t on f.ADVISNUM = t.ADVISNUM
where f.[rowID] = t.[rowID] -1  
