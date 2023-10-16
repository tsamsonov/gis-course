CREATE OR REPLACE VIEW geo_forest_parcels AS
	SELECT DISTINCT geo_points.* 
	FROM base.geo_points, base.forest, base.land_parcels
	WHERE st_within(geo_points.geom, forest.geom) 
	   AND st_overlaps(forest.geom, land_parcels.geom)
	   AND st_area(land_parcels.geom) > 10000