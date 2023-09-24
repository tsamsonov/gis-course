ALTER TABLE postgis.geo_points 
	ADD IF NOT EXISTS geom geometry(point, 32637);
UPDATE postgis.geo_points
	SET geom = ST_Point(x, y)