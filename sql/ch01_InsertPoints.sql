DELETE from postgis.hydro_measures;
-- INSERT INTO postgis.hydro_measures(fid, depth, geom)
-- VALUES
-- 	(1, 1.23, ST_GeomFromText('POINT (36.37802128 55.21121827)')),
-- 	(2, 1.57, ST_GeomFromText('POINT (36.37834198 55.21127511)')),
-- 	(3, 0.78, ST_GeomFromText('POINT (36.37861509 55.21139158)')),
-- 	(4, 0.95, ST_GeomFromText('POINT (36.37905934 55.21137259)')),
-- 	(5, 1.11, ST_GeomFromText('POINT (36.37938529 55.21125473)'));

INSERT INTO postgis.hydro_measures(fid, depth, geom)
VALUES
	(1, 1.23, 'POINT (36.37802128 55.21121827)'::geography),
	(2, 1.57, 'POINT (36.37834198 55.21127511)'::geography),
	(3, 0.78, 'POINT (36.37861509 55.21139158)'::geography),
	(4, 0.95, 'POINT (36.37905934 55.21137259)'::geography),
	(5, 1.11, 'POINT (36.37938529 55.21125473)'::geography);