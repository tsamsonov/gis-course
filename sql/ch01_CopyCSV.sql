CREATE TABLE IF NOT EXISTS postgis.geo_points (
	fid serial primary key,
	name text,
	comment text,
	height_abs real,
	height_add real,
	type text,
	x real, 
	y real
);
COPY postgis.geo_points 
	FROM '/Volumes/Data/Spatial/Satino/geo_points.csv' 
	DELIMITER as ',';