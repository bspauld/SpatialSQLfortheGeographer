/*#################################################

Script Name: multi_points_to_Line.sql
Purpose: This script will take pairs of coordinates
 of the same line and convert them into a LineString 
that can be used to generate lines of the geometry 
data type. User will need to update the database, 
tables, and column names relevant to their own analysis.

Sample Sandy data tracks represent five day
models from the National Hurricane Center.

Prepping the data - The user will need to download 
the following file and load into their SQL database:

http://www.gisdoctor.com/downloads/Line_Parts.txt

Here is a quick script to take the text file and load 
it into a table generated for this exercise:

create table Spatial_Database.dbo.Distinct_Points
([ADVISNUM] varchar(3), [lat] float, [lon] float, 
[MaxWind] int)

BULK INSERT Spatial_Database.dbo.Distinct_Points
FROM 'Path to Line_Parts.txt file'
WITH (FIELDTERMINATOR =',',FirstRow = 2);

###################################################*/
 
--Set the database to process in
use Spatial_Database
--Drop temporary table
drop table #Sandy_hur_tracks
--Create new temporary table
create table #Sandy_hur_tracks
([EventID] int, [line] geometry)

--Declare cursor variable
DECLARE @eventID varchar(10)
--Declare text string that will store coordinate pairs to
--populate the LineString
DECLARE @coordString VARCHAR(MAX)

--Initialize the cursor using the ADVISNUM column
DECLARE db_cursor CURSOR FOR
select distinct ADVISNUM
from Spatial_Database.dbo.Distinct_Points
order by ADVISNUM asc

OPEN db_cursor
FETCH NEXT FROM db_cursor INTO @eventID

WHILE @@FETCH_STATUS = 0
BEGIN

-- Clear the coordinate string with each iteration of the 
-- cursor - otherwise the coordinate string will 
-- append itself each time
set @coordString = ''
--collect all coordinate pairs and add them to a single row. 
-- Coordinate pairs are separated by a comma.
select @coordString = (COALESCE(@coordString + ', ', ' ') + 
(cast(Lon as varchar) +' ' + CAST(lat as varchar)))
FROM Spatial_Database.dbo.Distinct_Points
WHERE ADVISNUM = @EventID

--Insert the eventId and coordinate pairs into the table.         
--Coordinate pairs string is used to build the LineString to      
--create the line geometry
insert into #Sandy_hur_tracks
select @eventID as EventID,
Geometry::STLineFromText('Linestring 
(' + right(@coordString,LEN(@coordString)-1) + ')' 
, 4326) as line

FETCH NEXT FROM db_cursor INTO @eventID
END
--Close and delete the cursor
CLOSE db_cursor
DEALLOCATE db_cursor

--Select results from the temp table.
use Spatial_Database
select * from #Sandy_hur_tracks 
