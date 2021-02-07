-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jan 30, 2021 at 11:21 AM
-- Server version: 8.0.21
-- PHP Version: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pesmarica`
--

DELIMITER $$
--
-- Functions
--
DROP FUNCTION IF EXISTS `ime_autora`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ime_autora` (`id_aut` INT) RETURNS VARCHAR(200) CHARSET utf8 BEGIN
	DECLARE ime varchar(200);
    	SELECT ime_prezime INTO ime FROM autori WHERE id = id_aut;
	RETURN ime;
END$$

DROP FUNCTION IF EXISTS `naziv_zanra`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `naziv_zanra` (`id_zanr` INT) RETURNS VARCHAR(200) CHARSET utf8 BEGIN
	DECLARE ime_zanra varchar(200);
    	SELECT naziv INTO ime_zanra FROM zanrovi WHERE id = id_zanr;
    RETURN ime_zanra;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `administrator`
--

DROP TABLE IF EXISTS `administrator`;
CREATE TABLE IF NOT EXISTS `administrator` (
  `id` int NOT NULL AUTO_INCREMENT,
  `korisnicko_ime` varchar(100) NOT NULL,
  `lozinka` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `administrator`
--

INSERT INTO `administrator` (`id`, `korisnicko_ime`, `lozinka`) VALUES
(1, 'admin', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `autori`
--

DROP TABLE IF EXISTS `autori`;
CREATE TABLE IF NOT EXISTS `autori` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ime_prezime` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `korisnici`
--

DROP TABLE IF EXISTS `korisnici`;
CREATE TABLE IF NOT EXISTS `korisnici` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ime_prezime` varchar(200) NOT NULL,
  `korisnicko_ime` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `lozinka` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `korisnici`
--

INSERT INTO `korisnici` (`id`, `ime_prezime`, `korisnicko_ime`, `email`, `lozinka`) VALUES
(1, 'Korisnik', 'korisnik', 'korisnik@pesmarica.com', 'korisnik');

-- --------------------------------------------------------

--
-- Table structure for table `pesme`
--

DROP TABLE IF EXISTS `pesme`;
CREATE TABLE IF NOT EXISTS `pesme` (
  `id` int NOT NULL AUTO_INCREMENT,
  `naziv` varchar(100) NOT NULL,
  `autor` int NOT NULL,
  `zanr` int NOT NULL,
  `tekst` varchar(10000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `tonalitet` varchar(50) NOT NULL,
  `akordi` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_autor` (`autor`),
  KEY `fk_zanr` (`zanr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `zanrovi`
--

DROP TABLE IF EXISTS `zanrovi`;
CREATE TABLE IF NOT EXISTS `zanrovi` (
  `id` int NOT NULL AUTO_INCREMENT,
  `naziv` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `pesme`
--
ALTER TABLE `pesme`
  ADD CONSTRAINT `fk_autor` FOREIGN KEY (`autor`) REFERENCES `autori` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_zanr` FOREIGN KEY (`zanr`) REFERENCES `zanrovi` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
