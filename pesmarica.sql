-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3308
-- Generation Time: Feb 07, 2021 at 09:48 PM
-- Server version: 8.0.18
-- PHP Version: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
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
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ime_prezime` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `autori`
--

INSERT INTO `autori` (`id`, `ime_prezime`) VALUES
(3, 'Đorđe Balašević'),
(4, 'Aca Lukas'),
(5, 'Parni Valjak'),
(6, 'Tap 011'),
(7, 'Van Gogh'),
(8, 'Toma Zdravkovic');

-- --------------------------------------------------------

--
-- Table structure for table `korisnici`
--

DROP TABLE IF EXISTS `korisnici`;
CREATE TABLE IF NOT EXISTS `korisnici` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ime_prezime` varchar(200) NOT NULL,
  `korisnicko_ime` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `lozinka` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `korisnici`
--

INSERT INTO `korisnici` (`id`, `ime_prezime`, `korisnicko_ime`, `email`, `lozinka`) VALUES
(1, 'korisnik', 'korisnik', 'korisnik@pesmarica.com', 'korisnik'),
(2, 'Petar Milojevic', 'Pera', 'petarmilojevic@gmail.com', 'pera'),
(3, 'Djordje Mitrovic', 'Djole', 'djordjemitrovic@gmail.com', 'djole'),
(4, 'Marko Manojlovic', 'Mare', 'markomanojlovic@gmail.com', 'mare'),
(5, 'Sladjana Mitic', 'Sladja', 'sladjanamitic@gmail.com', 'sladja'),
(6, 'Aleksandra Milenkovic', 'Akica', 'aleksandramilenkovic@gmail.com', 'akica');

-- --------------------------------------------------------

--
-- Table structure for table `pesme`
--

DROP TABLE IF EXISTS `pesme`;
CREATE TABLE IF NOT EXISTS `pesme` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `naziv` varchar(100) NOT NULL,
  `autor` int(11) NOT NULL,
  `zanr` int(11) NOT NULL,
  `tekst` varchar(10000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `tonalitet` varchar(50) NOT NULL,
  `akordi` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_autor` (`autor`),
  KEY `fk_zanr` (`zanr`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pesme`
--

INSERT INTO `pesme` (`id`, `naziv`, `autor`, `zanr`, `tekst`, `tonalitet`, `akordi`) VALUES
(1, 'D-mol', 3, 1, 'Dm          C             A7\r\nOdlutas ponekad, sanjam sam.\r\n             Dm         B\r\nPriznajem ne ide, ali pokusavam.\r\n       Dm A7 Dm\r\nI uvek dodje D-mol.\r\n             C            A7\r\nSpusti se ko lopov po zicama.\r\n        Dm                B\r\nRuke mi napuni, tvojim sitnicama.\r\n        Dm (A7)    Dm\r\nI tesko prodje sve to.\r\n\r\n      Gm       A7\r\nJedan D-mol me dobije,\r\n          Dm   B\r\nKako odes ti u sobi je.\r\n      Gm          A7           Dm\r\nGlupi D-mol, uvek sazna kad je to.\r\n          F           C\r\nUhvati me cvrsto i ne popusta.\r\n            A7          B\r\nLud je za tisinom to ne propusta.\r\n     Gm        A7         Dm\r\nVodi me u svoj plavicasti dol.\r\n        F      C\r\nJedan D-mol me razvali,\r\n            A7            B\r\nNeki bi to, prosto, tugom nazvali.\r\n     Gm          A7      Dm\r\nNije to.. cta je tuga za D-mol.\r\n\r\nPonekad te nema i sasvim sam.\r\nIzmisljam nacin da malo smuvam dan.\r\nAli je lukav D-mol.\r\nPusti da se svetla, svud\' priguse.\r\nSaceka poslednje zvezde namiguse.\r\nVuce mi rukav.. Idemo.\r\n\r\nPlasi me on, gde si ti?\r\nHiljadu se stvari moglo desti.\r\nGlupi D-mol, za kim tuguje svu noc?\r\nUzme me u svoju tamnu kosulju.\r\nNebo primi boju, tvojih ociju.\r\nZnam taj put, to je precica za bol.\r\nJedan D-mol me razvali,\r\nNeki bi to prosto tugom nazvali.\r\nNije to, cta je tuga za D-mol?', 'D-mol', 'Dm, C, A7. Dm, B'),
(2, 'JESEN U MENI', 5, 3, 'Ma sto da zelim, sve je tako daleko\r\n         Am                E\r\nI sad mi zao, sve bih opet ponovo\r\nDm        G      C             E\r\nNajljepsu pjesmu tebi bih pjevao\r\nDm       G            F           E\r\nHej kamo srece da sam pjevat mogao\r\n\r\n\r\n        Am                   E\r\nPtice u bijegu, tisina gradi zidove\r\n      Am                   E\r\nZvoni zbogom, rijeci kazne bozije\r\nDm        G   C       (E)\r\nTe tvoje usne, opojne\r\nDm         G      F               E\r\nJos uvijek sanjam kako su me ljubile\r\n\r\n\r\nDm                        G      G7    C\r\nJesen u meni tuguje, zasto sanjam cemprese\r\n      Dm        E     Am   A\r\nMoje ceste ne vode nikuda (bez tebe)\r\n  Dm                     G    G7    C\r\nJesen u meni caruje, a u tebi proljece\r\n             Dm   F                E\r\nNi sunce ne moze, ne moze kroz oblake\r\n            Am\r\nRano moja, hej ...\r\n\r\n\r\n                E\r\n... s kime sada putujes\r\n          Am                E\r\nMa sto da bilo, nemoj da mi tugujes\r\nDm        G      C             E\r\nNajljepsu pjesmu tebi bih pjevao\r\nDm       G            F           E\r\nHej kamo srece da sam pjevat mogao', 'A-mol', 'Am, E, Dm. G. C'),
(3, 'Ja Nisam Luzer', 3, 1, '          F#/C#          F#7 \r\nRodjen pod sedmom zvezdom magicnom \r\n \r\n        Hm                     G \r\nAli nad ovom zemljom generalno tragicnom \r\n \r\nD               F#7        Hm \r\nCemu sam blizi? Triput pogadjaj. \r\n \r\n \r\nNetko nad nama vrsi oglede \r\nAjde utuvi se pa pogledaj u poglede \r\nOvde je osmjeh dogadaj \r\n \r\nU supak kosmosa smo upali \r\nMnogi su dobrani zauvek prolupali \r\nCaruje virus apatije \r\n \r\nAl ti na mene stavi upitnik \r\nPa reci dal ti bato deluje ko gubitnik \r\nMa nema sanse, sta ti je \r\n \r\n \r\n   /C#   D        A \r\nJa nisam luzer, o naprotiv \r\n \r\n  /G    F#7   Hm \r\nMeni je osmeh lajtmotiv \r\n \r\n   /C#   D         A        /G \r\nJa nisam luzer, ja imam nas \r\n \r\nF#7              Hm \r\nA za svet k\'o te pita \r\n \r\n   /C#   D    A \r\nJa nisam cedo proseka \r\n \r\n/G      F#7     Hm \r\nMene ne vuce oseka \r\n \r\n  /C#      D       A       /G \r\nS tobom je tretman poseban \r\n \r\nF#             G \r\nsvaki je dan dolchevita \r\n \r\nF#7           Hm \r\ni svud je Holivud. \r\n\r\n\r\nNamlatim mesecno sest maraka \r\nUlje za i frtalj kile cvaraka     \r\nOlos mi veze ometa \r\n \r\nAli kad dodem kuci tu si ti \r\nE, tu ce tvrdjavicu malo teze srusiti \r\nTo im je izvan dometa \r\n \r\nJa nisam luzer... ', 'D-dur', 'D, F#7. Hm'),
(4, 'Sve Jos Mirise Na NJu', 5, 3, 'Em G A C Em \r\nNe pitaj me nocas nista, pusti me da sutim\r\n\r\nG H\r\nJa nocas trebam mir\r\n\r\nEm G A C\r\nStare rane opet peku, moje bitke dalje teku\r\n\r\nEm G H\r\nDuso, ti nemas nista s tim\r\n\r\n\r\n\r\n\r\nC G Am Em\r\nSa tvojeg izvora moja se dusa napila\r\n\r\nC G H\r\nZedna tvojih godina\r\n\r\nC G Am Em\r\nI sada mamurna pita gdje je utjeha\r\n\r\nG D Em\r\nGdje je mladost nestala\r\n\r\n\r\n\r\nIdu dani, ja ih pratim, ponekad do tebe svratim\r\nDuso, trazim zaborav\r\nMamim sate da se vrate, tragovima njenim hodam\r\nTiho, kao da je tu\r\n\r\n\r\n\r\nEm G D C\r\nSve jos mirise na nju, i dan i jutro sto ce doci\r\n\r\nEm G A H\r\nNakon ove noci, noci bez sna\r\n\r\nEm G A G D\r\nI dvjesto godina da ih brojim u samoci\r\n\r\nEm G H\r\nOtkako je otisla\r\n\r\n\r\n\r\nU mojim venama jos je njenog otrova\r\nJos je doza prejaka\r\nAl&#39; tebe ljubim da ne poludim\r\nSamo da zaboravim', 'E-mol', 'Em. G, A, C, Em'),
(5, 'Neko te ima noćas', 7, 3, 'Em             C  D         Em          C D\r\nHteo bih negde da te vidim, kao slučajno\r\nEm         C      D      Em\r\nU kom džepu ovaj grad te noćas sakrio\r\nC D             Em     C D\r\nSada ne mogu da zaspim O-o\r\nEm                 C       D    Em\r\nNešto se dogodilo, poludeo sam sasvim\r\nEm    C      D        Em      C  D\r\nOtkad mislim na tebe, sve se izmenilo\r\n\r\nI kad sam s tobom kao da hodam po vrelom asfaltu\r\nTaman kad se noge naviknu ti više nisi tu\r\nSada ne mogu da zaspim O-o\r\nNešto se dogodilo poludeo sam sasvim\r\nOtkad mislim na tebe sve se izmenilo\r\n\r\n\r\nRefren:\r\nEm    C   D\r\nNeko te ima noćas\r\nEm    C   D\r\nNeko te voli\r\nEm    C   D     Em\r\nNeko te ima to nisam ja\r\n      C  D\r\nTo nisam ja aaa-aa\r\n\r\n\r\nI kad sam s tobom, kao da padam a nikad ne padnem\r\nGde te sakrio ovaj grad, ne mogu da te pronadjem\r\nI ne mogu da zaspim Oo\r\nNešto se dogodilo, poludeo sam sasvim\r\nOtkad mislim na tebe, sve se izmenilo.', 'Em', 'Em, C, D, Em, C, D'),
(6, 'Spisak Razloga', 7, 3, 'Dm                A\r\nBilo je dana kada videla nisi,\r\nC                A#\r\npored mene svoje korake\r\nA#                 F\r\nBilo je dana ti si verovala,\r\n   A\r\nda ja sam taj ko te najbolje zna\r\n\r\nDm                F\r\nI tih dana sam te čuvao\r\nC                  A#\r\nNa golim leđima te nosio\r\nA#                  F\r\nTelom od nevolja te branio\r\nF         A\r\nDok ti si spavala, ja sam plakao\r\n\r\n\r\nRefren:\r\nA#      F             C       Dm\r\nNisi ti dobra, kol’ko loš sam ja\r\nA#      F            C    Dm\r\nNegde postoji spisak razloga\r\nA#    F          C   Dm\r\nDa se osećam k’o utešna\r\nA\r\nnagrada za tvoje poraze\r\n\r\n\r\nDm                A\r\nBilo je dana kada video nisam,\r\nC                A#\r\npored sebe tvoje korake\r\nA#      F\r\nU oluji peščanog sata,\r\nA\r\nmi smo se polako gubili', 'D-mol', 'Dm. A#, F, C'),
(7, 'Bele Ruže', 4, 5, 'Am\r\nNe pitaj me druze moj\r\nC\r\nne pitaj o zeni toj\r\nG                     Am\r\nnemoj drugu srce slomiti\r\nDm            C\r\nkada znas da, da se ona\r\nG                    Am\r\nmeni nikad nece vratiti\r\n\r\nRef. 2x\r\n\r\nC          G\r\nBele ruze, bele ruze\r\nDm                  Am\r\nbele ruze opet cvetaju\r\nDm       C\r\na u mome srcu, druze\r\nG                  Am\r\ncrne kise opet padaju\r\n\r\n\r\nAm\r\nKafana je prepuna\r\nC\r\na ja nigde nikoga\r\nG                     Am\r\nnemam para,nemam drugova\r\n\r\nDm\r\nSamo stari cigani\r\nC\r\nmoju pesmu sviraju\r\nG                   Am\r\nbele ruze,opet cvetaju\r\n\r\nRef. 2x', 'A-mol', 'Am, C. G. Am'),
(8, 'Nisam preživeo', 4, 5, 'Hm\r\nNedelja 28. avgust\r\nG\r\npetnaest casova i trideset minuta\r\nG Em\r\nvreme u gradu suncano i toplo\r\nEm\r\nsaobracaj gust i otezan\r\nF#m\r\nekipa radia Ljubav\r\n\r\nzeli vam prijatan dan\r\nHm-----------G\r\nNaocare crne u dzepu beli cvet\r\nEm--------------F#m\r\ni oprostajno pismo znam ga napamet\r\nHm---------------G\r\nu obe ruke svece u oku suza sja\r\nEm-----------F#m\r\nneko mi je umro taj neko sam ja\r\n\r\n--------Hm\r\nNisam preziveo neverstvo tvoje\r\nG\r\nda neko ima ono sto je moje\r\nEm\r\no, zar se tvoje telo dira\r\nF#\r\ntudjim rukama\r\nHm\r\nNisam preziveo to sto si lepa\r\nG\r\njos lepsa nego sto si sa mnom bila\r\nEmol\r\no, zar se tvoje usne ljube\r\nF#\r\ntudjim usnama\r\nF#\r\nUmro sam za tobom\r\n\r\numro sam, ti nisi\r\nE\r\nza mnom plakala\r\nHm----------G\r\nA oko mene ima hiljadu razloga\r\nEm-------------F#m\r\nda opet budem ziv i budem veseo\r\nHm-----------------G\r\ndevojke u haljinama crvenim setaju\r\nEm----------F#m\r\ni ptice pevaju meni svi smetaju', 'H-mol', 'Hm, G, E, Hm'),
(9, 'Dosadan Dan', 6, 7, 'D\r\nStigao je sajam, stigao je sajam, \r\nA\r\nuz\'o sam od Pere neke pare na zajam.\r\nEm \r\nTamo u hali 1 sve obična je roba,\r\nG                 A \r\nroboti, svemirski plodovi i brodovi.\r\n\r\n\r\nA u hali 2 na štandu 22 \r\ni po rednim brojem 222 \r\nprodaju se ćilimi neleteći i leteći \r\nja im kažem preteći, dajte jedan leteći \r\n\r\nI počnem da letim, i letim, i letim \r\ni letim, i letim, i letim, letim, letim \r\nPa se spustim, čisto da pokupim hranu \r\ni piće i ribe, i ribe, ribe, ribe \r\n\r\nTako letimo zajedno na ćilimu tom \r\nradimo svasta na ćilimu tom \r\nI tako baš mi je lepo, baš mi je super \r\nali to je samo jos jedan dosadan dan ', 'D-dur', 'D, A, Em, G, A'),
(10, 'Reka', 6, 7, 'C          G                    Am\r\n\r\nNegde u daljini jedna reka protice\r\n\r\n              F     G           C\r\n\r\nsklopim oci i vidim nas kraj nje\r\n\r\nko ta reka moja ljubav prema tebi je\r\n\r\nvecnija od reci najvece\r\n\r\nUsne tad u zanosu se vrelom stapaju\r\n\r\na mi smo jedini na svetu\r\n\r\nputujemo kao zvezde dve po svemiru\r\n\r\n                        G\r\n\r\nbol i tuga tada nestaju\r\n\r\nRefren:\r\n\r\n          F           C\r\n\r\nZagrli me sad, tu ostani\r\n\r\n               G    Am\r\n\r\ni deo moga srca postani\r\n\r\njer nema sile te da razdvoji\r\n\r\ndvoje u pravoj ljubavi\r\n\r\nZagrli me sad, tu ostani\r\n\r\ni deo moga srca postani\r\n\r\njer nema sile te da razdvoji\r\n\r\n           G         FG   C\r\n\r\ndvoje u pravoj ljubavi\r\n\r\nNegde u tisini dragi dodir budi me\r\n\r\npustam da me radost opije\r\n\r\nko taj dodir moja ljubav prema tebi je\r\n\r\nvecnija od pesme najbolje', 'C-dur', 'C, G, Am, F, G, C'),
(11, 'Hej Branka Branka', 8, 5, 'Cm            Bb Cm  \r\nPamtiš li ono le-to  \r\nFm                 Cm\r\nPamtiš li zvezdane noći  \r\nCm             Bb Cm  \r\nkad si mi tiho re-kla  \r\nBb            Cm  \r\nBez tebe neću moći  \r\n \r\nCm  \r\nHej Branka Branka Branka  \r\nBb           Cm\r\nReci mi Bran-ka  \r\nFm              Bb    Eb  Bb  Cm\r\nKo je kriv zbog našeg ras-tan-ka  \r\n \r\nPamtiš li onu jesen  \r\nPamtiš li dane noći  \r\nKad si mi tiho rekla  \r\nBez tebe neću moći  \r\n \r\nPamtiš li onu zimu  \r\nPamtiš li bele noći  \r\nKad si mi tiho rekla  \r\nBez tebe neću moći ', 'C-mol', 'Cm, Bb, Cm, Fm, Cm'),
(12, 'Kafana je moja Sudbina', 8, 5, 'Em                   B7       Em\r\nDa li si mi verovala zeno jedina ?\r\n                       Am           Em\r\nDa li si mi verovala , dal si prastala,\r\n        C            D7       G\r\nKad sam tebi dolazio mrtav umoran ?\r\n            Am       D7           G\r\nDa li si mi verovala da sam bio sam ?\r\n B7          Em  Em D\r\n..da sam bio sam.\r\n\r\n\r\nC         D         G  C         D7      G   E7\r\nKafana je moja sudbina,ona me je sebi uzela.\r\nAm                 Em B7       Em Em D\r\nKafana je moja istina,zeno jedina.\r\nC         D         G  C         D7      G   E7\r\nKafana je moja sudbina,ona me je sebi uzela.\r\nAm                 Em B7       Em\r\nKafana je moja istina,zeno jedina.\r\n\r\n\r\nD Em|GD7 G|GC D7|B7 Em|D Em|GD7 G|GC D7|B7 Em|\r\n\r\n\r\nEm                 B7         Em\r\nLutao sam godinama srecu trazio.\r\n                    Am           Em\r\nLutao sam godinama, dok sam svatio:\r\n       C               D7        G\r\nda na ovom belom svetu nema milosti,\r\n             Am         D7        G\r\nda bez tebe, duso moja, nema radosti.\r\n B7         Em  Em D\r\n..nema radosti. \r\n\r\nrefren\r\n\r\nD Em|GD7 G|GC D7|B7 Em|D Em|GD7 G|GC D7|B7 Em|\r\n\r\nEm                    B7       Em\r\nMozes li mi oprostiti zeno jedina ?\r\n                      Am         Em \r\nMozes li mi oprostiti sto si patila ?\r\n       C                    D7         G\r\nSto te suza na jastuku suza jutrom budila,\r\n             Am        D7       G\r\nsto te nocu mesto mene tama grlila,\r\n B7        Em Em D\r\n..zeno jedina. \r\n                    B7       Em  D Em\r\nrefren.x2 ...kraj.. zeno jedina', 'E-mol', 'Em, B7, Am, Em, C, D7, G');

-- --------------------------------------------------------

--
-- Table structure for table `zanrovi`
--

DROP TABLE IF EXISTS `zanrovi`;
CREATE TABLE IF NOT EXISTS `zanrovi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `naziv` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `zanrovi`
--

INSERT INTO `zanrovi` (`id`, `naziv`) VALUES
(1, 'Pop'),
(3, 'Rock and Roll'),
(5, 'Narodno'),
(6, 'Folk'),
(7, '90s');

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
