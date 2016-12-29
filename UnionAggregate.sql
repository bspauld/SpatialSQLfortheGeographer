/*#################################################################################################################################
	
	Script Name:	UnionAggregate.sql
	Purpose:		  This script provides an example of UnionAggregate, a union tool for spatial data.  Think of it like a MERGE in 
                a GIS.
										         
                This example is using the Natural Earth Populated Places dataset. The
					      example using the geometry datatypes.
											
					      Online documentation here https://msdn.microsoft.com/en-us/library/ff929310.aspx
						
	Author:			  Ben Spaulding 
	Date:			    12/2016
#################################################################################################################################*/


select  
    pp.IdVal as ID, 
		pp.NAMEASCII as t1_Name, 
		geometry::UnionAggregate( pp.geom ) as geom
FROM dbo.Populated_Places pp
group by pp.IdVal,pp.NAMEASCII
