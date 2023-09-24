CREATE TABLE postgis.hydro_measures (
	fid serial primary key,
	depth real,
	geom geography(point, 4326)
)