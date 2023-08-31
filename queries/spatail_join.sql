SELECT * 
FROM reltypes R, soiltypes S
WHERE st_area(S.geom) < 10000 AND st_area(R.geom) < 10000
AND st_intersects(R.geom, s.geom)
