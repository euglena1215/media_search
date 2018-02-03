DROP TABLE IF EXISTS images;

CREATE TABLE images (
  id integer primary key,
  title varchar(50),
  author varchar(50),
  url text,
  labels text,
  scores text
);

DELETE FROM images;

-- INSERT INTO images VALUES(
-- 	1, 
-- 	'Les visages de la Joconde', 
-- 	'Leonardo di ser Piero da Vinci', 
-- 	'http://www.mma.cs.tsukuba.ac.jp/syllabus/mmsearch/images/mona_lisa.jpg', 
-- 	0.2, 0.5, 0.5
-- );
-- INSERT INTO images VALUES(
-- 	2, 
-- 	'The Starry Night',
-- 	'Vincent van Gogh', 
-- 	'http://www.mma.cs.tsukuba.ac.jp/syllabus/mmsearch/images/starry_night.jpg', 
-- 	0.3, 0.4, 0.7
-- );
-- INSERT INTO images VALUES(
-- 	3, 
-- 	'The Jolly Flatboatmen in Port', 
-- 	'George Caleb Bingham', 
-- 	'http://www.mma.cs.tsukuba.ac.jp/syllabus/mmsearch/images/image3.jpg', 
-- 	0.8, 0.5, 0.7
-- );
-- INSERT INTO images VALUES(
-- 	4, 
-- 	'Waterfall 1961', 
-- 	'M.C. Escher', 
-- 	'http://www.mma.cs.tsukuba.ac.jp/syllabus/mmsearch/images/waterfall.jpg', 
-- 	0.5, 0.5, 0.5
-- );
-- INSERT INTO images VALUES(
-- 	5, 
-- 	'Garden of the Princess Louvre', 
-- 	'Claude Monet', 
-- 	'http://www.mma.cs.tsukuba.ac.jp/syllabus/mmsearch/images/garden-of-the-princess-louvre.jpg', 
-- 	0.1, 0.7, 0.4
-- );
