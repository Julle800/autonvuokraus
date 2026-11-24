-- Autonvuokraus: taulut ja yksi esimerkkirivi kustakin

-- Näin käytät tiedostoa:
-- 1. Luo ensin tyhjä tietokanta phpMyAdminissa (Uusi - anna nimeksi autonvuokraus).
-- 2. Valitse tietokanta vasemmalta.
-- 3. Valitse Tuonti (Import), valitse tämä tiedosto ja paina Suorita.

-- Tiedostossa ei ole CREATE DATABASE- eikä USE-riviä tarkoituksella: tietokanta tehdään ensin käsin.

-- TEE ITSE: lisää tietoja niin, että autoja on 7, asiakkaita 6 ja vuokrauksia 4.
-- Voit kirjoittaa lisää INSERT-lauseita tähän tiedostoon tai lisätä rivit suoraan phpMyAdminissa (taulun Lisää-välilehti).
-- Tee ainakin kaksi autoa vuokratuksi: auto.onkovapaa = 0 ja sopimus, jossa palautettu on NULL.
-- Voit myös tehdä taulut itse phpMyAdminissa (Luo taulu) tämän tiedoston mallin mukaan.

-- Huom: tiedosto poistaa ensin vanhat taulut auto, asiakas ja sopimus ja tekee ne uudestaan.
-- Tuonti nollaa siis näiden taulujen sisällön.

-- Vierasavaimia (FOREIGN KEY) ei ole. Ne lisätään lisätehtävässä F.
-- Siihen asti taulujen yhteys (asiakasid ja autoid) tarkistetaan PHP-koodissa.

SET NAMES utf8mb4;

DROP TABLE IF EXISTS sopimus;
DROP TABLE IF EXISTS asiakas;
DROP TABLE IF EXISTS auto;

-- Taulu auto: yksi rivi per vuokra-auto
-- onkoautomaatti: 1 = automaatti, 0 = manuaali
-- onkovapaa: 1 = vapaana, 0 = vuokrattu
CREATE TABLE auto (
  id INT NOT NULL AUTO_INCREMENT,
  rekno VARCHAR(10) NOT NULL,
  valmistaja VARCHAR(100) NOT NULL,
  malli VARCHAR(100) NOT NULL,
  onkoautomaatti TINYINT(1) NOT NULL DEFAULT 0,
  moottori VARCHAR(50) NOT NULL,
  istumapaikat INT NOT NULL,
  hinta DECIMAL(6,2) NOT NULL,
  onkovapaa TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (id),
  UNIQUE KEY rekno (rekno)
) DEFAULT CHARSET=utf8mb4;

-- Taulu asiakas: yksi rivi per asiakas
-- saika = syntymäaika (muoto VVVV-KK-PP)
CREATE TABLE asiakas (
  id INT NOT NULL AUTO_INCREMENT,
  etunimi VARCHAR(100) NOT NULL,
  sukunimi VARCHAR(100) NOT NULL,
  katuosoite VARCHAR(150) NOT NULL,
  postitoimipaikka VARCHAR(100) NOT NULL,
  puhelin VARCHAR(20) NOT NULL,
  saika DATE NOT NULL,
  email VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
) DEFAULT CHARSET=utf8mb4;

-- Taulu sopimus: yksi rivi per vuokraus
-- asiakasid viittaa taulun asiakas sarakkeeseen id
-- autoid viittaa taulun auto sarakkeeseen id
-- palautettu: päivä jona auto palautettiin, NULL = auto on vielä vuokrattuna
CREATE TABLE sopimus (
  id INT NOT NULL AUTO_INCREMENT,
  asiakasid INT NOT NULL,
  autoid INT NOT NULL,
  aloituspvm DATE NOT NULL,
  lopetuspvm DATE NOT NULL,
  palautettu DATE NULL DEFAULT NULL,
  PRIMARY KEY (id),
  KEY asiakasid (asiakasid),
  KEY autoid (autoid)
) DEFAULT CHARSET=utf8mb4;

-- Esimerkkirivit (yksi kustakin taulusta). Lisää loput itse.
INSERT INTO auto (rekno, valmistaja, malli, onkoautomaatti, moottori, istumapaikat, hinta, onkovapaa) VALUES
('ABC-313', 'Toyota', 'Corolla', 1, 'bensa', 5, 101.00, 1);

INSERT INTO asiakas (etunimi, sukunimi, katuosoite, postitoimipaikka, puhelin, saika, email) VALUES
('Liisa', 'Meikäläinen', 'Kotikatu 11 A 3', '00100 Helsinki', '0501234567', '2004-10-08', 'liisa.meikalainen@example.com');

-- Vuokraus: asiakas 1 on vuokrannut auton 1 ja palauttanut sen (palautettu ei ole NULL)
INSERT INTO sopimus (asiakasid, autoid, aloituspvm, lopetuspvm, palautettu) VALUES
(1, 1, '2026-11-01', '2026-11-05', '2026-11-05');

-- TEE ITSE: lisää 6 autoa, 5 asiakasta ja 3 vuokrausta lisää.
-- Muista: avoimessa vuokrauksessa palautettu on NULL ja auton onkovapaa on 0.

INSERT INTO auto (rekno, valmistaja, malli, onkoautomaatti, moottori, istumapaikat, hinta, onkovapaa) VALUES
('DEF-224', 'Volkswagen', 'Golf', 0, 'diesel', 5, 89.00, 0),           -- vuokrattu
('GHI-135', 'Skoda', 'Octavia', 0, 'bensa', 5, 95.00, 1),              -- vapaa
('JKL-446', 'Tesla', 'Model 3', 1, 'sähkö', 5, 149.00, 1),             -- vapaa
('MNO-557', 'Ford', 'Transit Custom', 0, 'diesel', 9, 129.00, 0),      -- vuokrattu
('PQR-668', 'Kia', 'Ceed', 0, 'hybridi', 5, 92.00, 1),                 -- vapaa
('STU-779', 'Volvo', 'XC60', 1, 'hybridi', 5, 139.00, 1);              -- vapaa


INSERT INTO asiakas (etunimi, sukunimi, katuosoite, postitoimipaikka, puhelin, saika, email) VALUES
('Matti', 'Virtanen', 'Mannerheimintie 42 B 12', '00250 Helsinki', '0401112233', '1990-03-15', 'matti.virtanen@example.com'),
('Aino', 'Korhonen', 'Hämeenkatu 8', '33100 Tampere', '0452223344', '1985-07-22', 'aino.korhonen@example.com'),
('Jussi', 'Nieminen', 'Satamakatu 5 C 7', '20100 Turku', '0503334455', '1978-12-01', 'jussi.nieminen@example.com'),
('Elina', 'Mäkelä', 'Kauppakatu 19', '40100 Jyväskylä', '0414445566', '1999-05-30', 'elina.makela@example.com'),
('Pekka', 'Laine', 'Torikatu 3 A 1', '90100 Oulu', '0405556677', '1969-09-18', 'pekka.laine@example.com');


INSERT INTO sopimus (asiakasid, autoid, aloituspvm, lopetuspvm, palautettu) VALUES
(2, 2, '2026-11-20', '2026-11-27', NULL),
(3, 5, '2026-11-22', '2026-11-26', NULL),
(4, 3, '2026-11-10', '2026-11-14', '2026-11-14');