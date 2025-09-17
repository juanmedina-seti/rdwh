SELECT genero, album, q AS canciones_vendidas
FROM (
SELECT g.Name genero, a.Title album, SUM(ii.Quantity) q,
RANK ( ) OVER (PARTITION BY t.GenreId ORDER BY SUM(ii.Quantity) DESC) r
FROM invoice_items ii
JOIN tracks t USING (TrackId)
JOIN albums a USING (AlbumId)
JOIN genres g USING (GenreId)
GROUP BY t.GenreId, a.AlbumId
)
WHERE r = 1
ORDER BY q DESC, genero, album;