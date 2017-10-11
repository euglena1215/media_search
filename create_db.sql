CREATE TABLE IF NOT EXISTS images (
  id integer primary key,
  title varchar(50),
  author varchar(50),
  url text
);

DELETE FROM images;

INSERT INTO images VALUES(1, 'Les visages de la Joconde', 'Leonardo di ser Piero da Vinci', 'http://www.louvre.fr/francais/magazine/peint/joconde/jocon_f.htm');
INSERT INTO images VALUES(2, 'The Starry Night', 'Vincent van Gogh', 'http://www.moma.org/docs/collection/paintsculpt/c58.htm');
INSERT INTO images VALUES(3, 'The Jolly Flatboatmen in Port', 'George Caleb Bingham', 'http://www.slam.org/am1.html');
INSERT INTO images VALUES(4, 'Waterfall 1961', 'M.C. Escher', 'http://national.gallery.ca/slidekits/slidekit_escher/sk_escher10.html');
INSERT INTO images VALUES(5, 'Garden of the Princess Louvre', 'Claude Monet', 'http://www.monetalia.com/paintings/monet-garden-of-the-princess-louvre.aspx');
