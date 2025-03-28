-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 29, 2024 at 07:17 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `anime_collections`
--
CREATE DATABASE IF NOT EXISTS `anime_collections` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `anime_collections`;

-- --------------------------------------------------------

--
-- Table structure for table `anime_collections`
--

CREATE TABLE `anime_collections` (
  `id` int(11) NOT NULL,
  `collection_id` varchar(50) NOT NULL,
  `title` varchar(255) NOT NULL,
  `season` int(11) NOT NULL,
  `episodes` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `status` varchar(50) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `anime_collections`
--

INSERT INTO `anime_collections` (`id`, `collection_id`, `title`, `season`, `episodes`, `price`, `image_path`, `status`, `description`) VALUES
(1, '1', 'Naruto Collection', 1, 220, 1500.00, 'naruto_collection.png', 'Active', 'Complete collection of Naruto series.'),
(2, '2', 'Dragon Ball Z Collection', 1, 291, 500.00, 'dragon_ball_z_collection.png', 'Active', 'Experience the epic battles of Goku and friends.'),
(3, '3', 'One Piece Collection', 1, 1000, 1300.00, 'one_piece_collection.jpg', 'Active', 'Set sail for the Grand Line with Luffy and his crew.'),
(4, '4', 'Attack on Titan Collection', 4, 75, 3409.00, 'attack_on_titan_collection.jpg', 'Active', 'Join the fight against the Titans and uncover the truth.'),
(5, '5', 'My Hero Academia Collection', 5, 113, 1200.00, 'my_hero_academia_collection.jpg', 'Active', 'Witness the journey of young heroes in training.'),
(6, '6', 'Demon Slayer Collection', 2, 26, 3000.00, 'demon_slayer_collection.jpg', 'Active', 'Follow Tanjiro Kamado on his quest to defeat demons.'),
(7, '7', 'Fullmetal Alchemist Collection', 2, 64, 1650.00, 'fullmetal_alchemist_collection.jpg', 'Active', 'Experience the alchemy and adventure of the Elric brothers.'),
(8, '8', 'Hunter x Hunter Collection', 2, 148, 2300.00, 'hunter_x_hunter_collection.jpg', 'Active', 'Join Gon Freecss on his journey to become a Hunter.'),
(9, '9', 'Sword Art Online Collection', 3, 100, 1000.00, 'sword_art_online_collection.jpg', 'Active', 'Enter the virtual world of Sword Art Online.'),
(10, '10', 'Tokyo Ghoul Collection', 2, 48, 1200.00, 'tokyo_ghoul_collection.jpg', 'Active', 'Explore the dark and thrilling world of ghouls.'),
(11, '11', 'Death Note Collection', 1, 37, 1200.00, 'death_note_collection.jpg', 'Active', 'Discover the deadly game of intellect between Light and L.');

-- --------------------------------------------------------

--
-- Table structure for table `anime_purchase`
--

CREATE TABLE `anime_purchase` (
  `purchaseID` int(11) NOT NULL,
  `collection_id` varchar(255) NOT NULL,
  `purchaseDate` date NOT NULL,
  `title` varchar(255) NOT NULL,
  `unitPrice` float NOT NULL DEFAULT 0,
  `quantity` int(11) NOT NULL DEFAULT 0,
  `vendorID` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `anime_purchase`
--

INSERT INTO `anime_purchase` (`purchaseID`, `collection_id`, `purchaseDate`, `title`, `unitPrice`, `quantity`, `vendorID`) VALUES
(39, '1', '2024-05-24', 'Naruto Collection', 1600, 10, 3),
(40, '2', '2023-05-18', 'Dragon Ball Z Collection', 2341, 2, 4),
(41, '4', '2024-05-07', 'Attack on Titan Collection', 1234, 3, 3),
(42, '1', '2024-05-24', 'Naruto Collection', 345, 12, 4),
(43, '5', '2024-05-03', 'My Hero Academia Collection', 35, 3, 3),
(44, '5', '2024-05-16', 'My Hero Academia Collection', 3000, 2, 1),
(45, '5', '2024-05-21', 'My Hero Academia Collection', 3000, 10, 2),
(46, '4', '2022-05-19', 'Attack on Titan Collection', 1200, 4, 3),
(47, '2', '2023-05-10', 'Dragon Ball Z Collection', 2, 1, 2),
(48, '1', '2021-05-12', 'Naruto Collection', 2, 9, 1),
(50, '14', '2020-05-15', 'Hiking Bag', 1000, 5, 4),
(51, '11', '2021-05-11', 'Death Note Collection', 1121, 1, 1),
(52, '1', '2023-05-21', 'Naruto Collection', 1235, 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `anime_sale`
--

CREATE TABLE `anime_sale` (
  `saleID` int(11) NOT NULL,
  `collection_id` varchar(255) NOT NULL,
  `customerID` int(11) NOT NULL,
  `customerName` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `saleDate` date NOT NULL,
  `discount` float NOT NULL DEFAULT 0,
  `quantity` int(11) NOT NULL DEFAULT 0,
  `unitPrice` float(10,0) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `anime_sale`
--

INSERT INTO `anime_sale` (`saleID`, `collection_id`, `customerID`, `customerName`, `title`, `saleDate`, `discount`, `quantity`, `unitPrice`) VALUES
(1, '3', 4, 'Juan Dela Cruz', 'One Piece Collection', '2018-05-24', 5, 2, 1300),
(2, '1', 39, 'Maria Santos', 'Naruto Collection', '2018-05-24', 0, 111, 1500),
(3, '4', 18, 'Jose Rizal', 'Attack on Titan Collection', '2018-05-24', 2, 1, 3409),
(4, '5', 25, 'Corazon Aquino', 'My Hero Academia Collection', '2018-05-24', 2, 1, 1200),
(5, '6', 24, 'Manny Pacquiao', 'Demon Slayer Collection', '2018-05-24', 0, 1, 3000),
(6, '7', 14, 'Lea Salonga', 'Fullmetal Alchemist Collection', '2018-05-24', 1.5, 1, 1650),
(7, '3', 4, 'Juan Dela Cruz', 'One Piece Collection', '2018-05-24', 0, 3, 1300),
(8, '8', 4, 'Juan Dela Cruz', 'Hunter x Hunter Collection', '2018-05-14', 2.1, 1, 2300),
(9, '6', 26, 'Manny Pacquiao', 'Demon Slayer Collection', '2018-05-14', 0, 1, 3000),
(10, '5', 25, 'Corazon Aquino', 'My Hero Academia Collection', '2018-05-14', 2, 9, 1200),
(11, '10', 26, 'Manny Pacquiao', 'Tokyo Ghoul Collection', '2018-04-05', 1, 7, 1000),
(12, '1', 14, 'Lea Salonga', 'Naruto Collection', '2018-05-14', 0, 2, 1500),
(13, '3', 38, 'Jose Rizal', 'One Piece Collection', '2018-05-24', 0, 0, 1300),
(14, '10', 39, 'Maria Santos', 'Tokyo Ghoul Collection', '2018-05-17', 1, 1, 1000),
(15, '14', 38, 'Jose Rizal', 'Hiking Bag', '2018-05-24', 1.5, 1, 1200),
(16, '1', 14, 'Lea Salonga', 'Naruto Collection', '2018-05-24', 10, 1, 1500),
(17, '4', 14, 'Lea Salonga', 'Attack on Titan Collection', '2018-05-18', 2, 1, 3409);

-- --------------------------------------------------------

--
-- Table structure for table `anime_vendor`
--

CREATE TABLE `anime_vendor` (
  `suppID` int(11) NOT NULL,
  `fullName` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile` int(11) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(30) DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'Active',
  `createdOn` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `anime_vendor`
--

INSERT INTO `anime_vendor` (`suppID`, `fullName`, `email`, `mobile`, `address`, `city`, `status`, `createdOn`) VALUES
(1, 'ABC Kompanya', '', 2343567, '80, Ground Floor, ABC Shopping Complex', 'Maynila', 'Active', '2018-05-04 21:48:44'),
(2, 'Halimbawa Supplier 222', 'sample@volvo.com', 99828282, '123, A Road, B avenue', 'Nugegoda', 'Disabled', '2018-05-04 22:12:02'),
(3, 'Johnson at Johnsons Ko.', '', 32323, '34, Malwatta Road, Kottawa', 'Maharagama', 'Active', '2018-05-04 22:28:33'),
(4, 'Louise Vitton Bag', 'vitton@vitton.usa.com', 323234938, '45, Palmer Valley, 5th Crossing', 'Palo Alto', 'Active', '2018-05-04 22:29:41'),
(6, 'Test Supplier', 'test@vendor.com', 43434, 'Test address', 'Test City', 'Active', '2018-05-04 22:53:14'),
(7, 'Mga Komyuter ng Bags Co.', '', 1111, 'Sea Road, Bambalapitiya', 'Lungsod ng Maynila', 'Active', '2018-05-15 02:36:54'),
(8, 'Bagong Bags Exporters', '', 191938930, '123, A Road, B avenue, ', 'Colpetty', 'Active', '2018-05-16 04:36:53'),
(9, 'A', 'a@gmail.com', 999995, 'Manila', 'Lungsod ng Maynila', 'Active', '2020-07-30 03:40:25');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `anime_collections`
--
ALTER TABLE `anime_collections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `anime_purchase`
--
ALTER TABLE `anime_purchase`
  ADD PRIMARY KEY (`purchaseID`);

--
-- Indexes for table `anime_sale`
--
ALTER TABLE `anime_sale`
  ADD PRIMARY KEY (`saleID`);

--
-- Indexes for table `anime_vendor`
--
ALTER TABLE `anime_vendor`
  ADD PRIMARY KEY (`suppID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `anime_collections`
--
ALTER TABLE `anime_collections`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `anime_purchase`
--
ALTER TABLE `anime_purchase`
  MODIFY `purchaseID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `anime_sale`
--
ALTER TABLE `anime_sale`
  MODIFY `saleID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `anime_vendor`
--
ALTER TABLE `anime_vendor`
  MODIFY `suppID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- Database: `dbgrading`
--
CREATE DATABASE IF NOT EXISTS `dbgrading` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `dbgrading`;

-- --------------------------------------------------------

--
-- Table structure for table `ay`
--

CREATE TABLE `ay` (
  `AY_ID` int(11) NOT NULL,
  `ACADYR` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `class`
--

CREATE TABLE `class` (
  `CLASS_ID` int(11) NOT NULL,
  `CLASS_CODE` varchar(30) NOT NULL,
  `SUBJ_ID` int(11) NOT NULL,
  `INST_ID` int(11) NOT NULL,
  `SYID` int(11) NOT NULL,
  `AY` varchar(11) NOT NULL,
  `DAY` varchar(20) NOT NULL,
  `C_TIME` varchar(11) NOT NULL,
  `IDNO` int(11) NOT NULL,
  `ROOM` varchar(30) NOT NULL DEFAULT 'NONE',
  `SECTION` varchar(30) NOT NULL DEFAULT 'NONE'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `class`
--

INSERT INTO `class` (`CLASS_ID`, `CLASS_CODE`, `SUBJ_ID`, `INST_ID`, `SYID`, `AY`, `DAY`, `C_TIME`, `IDNO`, `ROOM`, `SECTION`) VALUES
(3, 'Spiral Filipino', 438, 1, 0, '2013-2014', 'MWF', '7:30-8:30', 0, 'Room01', 'A'),
(4, 'Spiral English', 439, 1, 0, '2013-2014', 'NONE', 'NONE', 0, 'NONE', 'NONE'),
(5, 'Spiral Science', 441, 6, 0, '2013-2014', 'NONE', 'NONE', 0, 'NONE', 'NONE'),
(6, 'Spiral T.L.E', 442, 6, 0, '2013-2014', 'NONE', 'NONE', 0, 'NONE', 'NONE'),
(7, 'Spiral A.P', 443, 6, 0, '2013-2014', 'NONE', 'NONE', 0, 'NONE', 'NONE'),
(8, 'Spiral Religion', 444, 6, 0, '2013-2014', 'NONE', 'NONE', 0, 'NONE', 'NONE'),
(9, 'Spiral EsP.', 445, 6, 0, '2013-2014', 'NONE', 'NONE', 0, 'NONE', 'NONE'),
(10, 'Spiral Mathematics', 440, 7, 0, '2013-2014', 'NONE', 'NONE', 0, 'NONE', 'NONE'),
(11, 'MAPEH', 447, 7, 0, '2013-2014', 'NONE', 'NONE', 0, 'NONE', 'NONE'),
(12, 'Spiral Science', 469, 5, 0, '2013-2014', 'NONE', 'NONE', 0, 'NONE', 'NONE'),
(13, 'Spiral T.L.E.', 471, 5, 0, '2013-2014', 'NONE', 'NONE', 0, 'NONE', 'NONE'),
(14, 'Spiral MAPEH', 472, 5, 0, '2013-2014', 'NONE', 'NONE', 0, 'NONE', 'NONE'),
(15, 'Values Education', 473, 5, 0, '2013-2014', 'NONE', 'NONE', 0, 'NONE', 'NONE'),
(16, 'CAT', 474, 5, 0, '2013-2014', 'NONE', 'NONE', 0, 'NONE', 'NONE'),
(17, 'Computer', 475, 5, 0, '2013-2014', 'NONE', 'NONE', 0, 'NONE', 'NONE');

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `COURSE_ID` int(11) NOT NULL,
  `COURSE_NAME` varchar(30) NOT NULL,
  `COURSE_LEVEL` int(11) NOT NULL DEFAULT 1,
  `COURSE_MAJOR` varchar(30) NOT NULL DEFAULT 'None',
  `COURSE_DESC` varchar(255) NOT NULL,
  `DEPT_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`COURSE_ID`, `COURSE_NAME`, `COURSE_LEVEL`, `COURSE_MAJOR`, `COURSE_DESC`, `DEPT_ID`) VALUES
(47, 'Grade 7', 7, '', 'Grade 7', 2),
(48, 'Grade 8', 8, '', 'Grade 8 ', 1),
(49, 'Grade 9', 9, '', 'Grade 9', 1),
(50, 'Grade 10', 10, '', 'Grade 10', 1),
(53, 'Grade 11', 11, '', 'Grade 11 ', 1),
(54, 'Grade 12', 0, '', '2nd year of Senior High', 2);

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `DEPT_ID` int(11) NOT NULL,
  `DEPARTMENT_NAME` varchar(30) NOT NULL,
  `DEPARTMENT_DESC` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`DEPT_ID`, `DEPARTMENT_NAME`, `DEPARTMENT_DESC`) VALUES
(1, 'High School', 'High School Department'),
(2, 'Junior High', 'Junior Higschool');

-- --------------------------------------------------------

--
-- Table structure for table `grades`
--

CREATE TABLE `grades` (
  `GRADE_ID` int(11) NOT NULL,
  `IDNO` int(11) NOT NULL,
  `SUBJ_ID` int(11) NOT NULL,
  `INST_ID` int(11) NOT NULL,
  `SYID` int(30) NOT NULL,
  `FIRST` int(11) NOT NULL,
  `SECOND` int(11) NOT NULL,
  `THIRD` int(11) NOT NULL,
  `FOURTH` int(11) NOT NULL,
  `AVE` float NOT NULL,
  `DAY` varchar(30) NOT NULL,
  `G_TIME` time NOT NULL,
  `ROOM` varchar(30) NOT NULL,
  `REMARKS` text NOT NULL,
  `COMMENT` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `grades`
--

INSERT INTO `grades` (`GRADE_ID`, `IDNO`, `SUBJ_ID`, `INST_ID`, `SYID`, `FIRST`, `SECOND`, `THIRD`, `FOURTH`, `AVE`, `DAY`, `G_TIME`, `ROOM`, `REMARKS`, `COMMENT`) VALUES
(1, 20004277, 438, 1, 0, 30, 67, 0, 0, 3.85, 'NONE', '00:00:00', '', 'Failed', ''),
(2, 20004277, 439, 0, 0, 0, 0, 0, 0, 0, 'NONE', '00:00:00', '', 'NONE', ''),
(3, 20004207, 438, 0, 0, 0, 0, 0, 0, 0, 'NONE', '00:00:00', '', 'NONE', ''),
(4, 20004207, 439, 0, 0, 0, 0, 0, 0, 0, 'NONE', '00:00:00', '', 'NONE', ''),
(5, 20004180, 438, 0, 0, 0, 0, 0, 0, 0, 'NONE', '00:00:00', '', 'NONE', ''),
(6, 20004180, 439, 0, 0, 0, 0, 0, 0, 0, 'NONE', '00:00:00', '', 'NONE', ''),
(7, 20004180, 440, 0, 0, 0, 0, 0, 0, 0, 'NONE', '00:00:00', '', 'NONE', ''),
(8, 20004180, 441, 6, 0, 60, 78, 80, 90, 77, 'NONE', '00:00:00', '', 'Passed', ''),
(9, 20004180, 442, 0, 0, 0, 0, 0, 0, 0, 'NONE', '00:00:00', '', 'NONE', ''),
(10, 20004180, 443, 6, 0, 90, 89, 78, 90, 87, 'NONE', '00:00:00', '', 'Passed', ''),
(11, 20004180, 444, 0, 0, 0, 0, 0, 0, 0, 'NONE', '00:00:00', '', 'NONE', ''),
(12, 20004180, 445, 0, 0, 0, 0, 0, 0, 0, 'NONE', '00:00:00', '', 'NONE', ''),
(13, 20004180, 447, 7, 0, 20, 55, 65, 40, 45, 'NONE', '00:00:00', '', 'Failed', ''),
(14, 20004623, 438, 0, 0, 0, 0, 0, 0, 0, 'NONE', '00:00:00', '', 'NONE', ''),
(15, 20004623, 439, 0, 0, 0, 0, 0, 0, 0, 'NONE', '00:00:00', '', 'NONE', ''),
(16, 20004623, 440, 0, 0, 0, 0, 0, 0, 0, 'NONE', '00:00:00', '', 'NONE', ''),
(17, 20004623, 441, 6, 0, 80, 80, 78, 80, 80, 'NONE', '00:00:00', '', 'Passed', ''),
(18, 20004623, 442, 0, 0, 0, 0, 0, 0, 0, 'NONE', '00:00:00', '', 'NONE', ''),
(19, 20004623, 443, 0, 0, 0, 0, 0, 0, 0, 'NONE', '00:00:00', '', 'NONE', ''),
(20, 20004623, 444, 0, 0, 0, 0, 0, 0, 0, 'NONE', '00:00:00', '', 'NONE', ''),
(21, 20004623, 445, 0, 0, 0, 0, 0, 0, 0, 'NONE', '00:00:00', '', 'NONE', ''),
(22, 20004623, 447, 0, 0, 0, 0, 0, 0, 0, 'NONE', '00:00:00', '', 'NONE', ''),
(23, 6231415, 438, 0, 0, 0, 0, 0, 0, 0, 'NONE', '00:00:00', '', 'NONE', ''),
(24, 6231415, 439, 0, 0, 0, 0, 0, 0, 0, 'NONE', '00:00:00', '', 'NONE', ''),
(25, 6231415, 440, 0, 0, 0, 0, 0, 0, 0, 'NONE', '00:00:00', '', 'NONE', ''),
(26, 6231415, 441, 0, 0, 0, 0, 0, 0, 0, 'NONE', '00:00:00', '', 'NONE', ''),
(27, 6231415, 442, 0, 0, 0, 0, 0, 0, 0, 'NONE', '00:00:00', '', 'NONE', ''),
(28, 6231415, 443, 0, 0, 0, 0, 0, 0, 0, 'NONE', '00:00:00', '', 'NONE', ''),
(29, 6231415, 444, 0, 0, 0, 0, 0, 0, 0, 'NONE', '00:00:00', '', 'NONE', ''),
(30, 6231415, 445, 0, 0, 0, 0, 0, 0, 0, 'NONE', '00:00:00', '', 'NONE', ''),
(31, 6231415, 447, 7, 0, 90, 88, 91, 92, 90, 'NONE', '00:00:00', '', 'Passed', ''),
(32, 6231415, 446, 0, 0, 0, 0, 0, 0, 0, 'NONE', '00:00:00', '', 'NONE', ''),
(33, 6231415, 474, 0, 0, 0, 0, 0, 0, 0, 'NONE', '00:00:00', '', 'NONE', ''),
(44, 6231415, 448, 0, 6, 0, 0, 0, 0, 0, 'NONE', '00:00:00', '', 'NONE', ''),
(45, 696969, 439, 0, 7, 0, 0, 0, 0, 0, 'NONE', '00:00:00', '', 'NONE', ''),
(46, 696969, 441, 6, 7, 65, 40, 52, 75, 58, 'NONE', '00:00:00', '', 'Failed', ''),
(49, 696969, 440, 7, 7, 6, 40, 32, 65, 36, 'NONE', '00:00:00', '', 'Failed', ''),
(50, 696969, 475, 5, 7, 90, 91, 92, 95, 92, 'NONE', '00:00:00', '', 'Passed', ''),
(51, 696969, 473, 5, 7, 80, 90, 80, 95, 86, 'NONE', '00:00:00', '', 'Passed', '');

-- --------------------------------------------------------

--
-- Table structure for table `instructor`
--

CREATE TABLE `instructor` (
  `INST_ID` int(30) NOT NULL,
  `INST_FULLNAME` varchar(255) NOT NULL,
  `INST_ADDRESS` varchar(255) NOT NULL,
  `INST_SEX` varchar(20) NOT NULL DEFAULT 'Male',
  `INST_STATUS` varchar(20) NOT NULL DEFAULT 'Single',
  `SPECIALIZATION` text NOT NULL,
  `INST_EMAIL` varchar(255) NOT NULL,
  `EMPLOYMENT_STATUS` varchar(40) NOT NULL DEFAULT 'Probationary'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `instructor`
--

INSERT INTO `instructor` (`INST_ID`, `INST_FULLNAME`, `INST_ADDRESS`, `INST_SEX`, `INST_STATUS`, `SPECIALIZATION`, `INST_EMAIL`, `EMPLOYMENT_STATUS`) VALUES
(1, 'Joken Villanueva', 'Suay Himamaylan City', 'M', 'Single', 'Computer Etc.', 'joken000189561@gmail.com', 'Probationary'),
(2, 'Erick jason Batuto', 'Kabanakalan City', 'M', 'Married', 'Computer ekc...', 'ejbatuto@hotmail.com', 'Regular'),
(3, 'Joel Bagolcol', 'KCC-TC', 'M', 'Single', 'Automotive', 'joel@yahoo.com', 'Probationary'),
(5, 'Allan', 'No whar', 'M', 'Single', 'Computer ekc...', 'allan@yahoo.com', 'Regular'),
(6, 'sdfsdfsdg', 'dfdf', 'M', 'Single', 'sdfsdf', 'joken@gmail.com', 'dfsdf'),
(7, 'George Wilson', 'Sample Address', 'M', 'Single', 'Sample', 'gwilson@sample.com', 'Regular');

-- --------------------------------------------------------

--
-- Table structure for table `level`
--

CREATE TABLE `level` (
  `YR_ID` int(11) NOT NULL,
  `LEVEL` varchar(30) NOT NULL,
  `LEVEL_DESCRIPTION` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `major`
--

CREATE TABLE `major` (
  `MAJOR_ID` int(11) NOT NULL,
  `MAJOR` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `major`
--

INSERT INTO `major` (`MAJOR_ID`, `MAJOR`) VALUES
(1, 'English'),
(2, 'General'),
(3, 'Marketing Management'),
(4, 'Financial Management'),
(5, 'Filipino'),
(6, 'Philosophy'),
(7, 'Math');

-- --------------------------------------------------------

--
-- Table structure for table `photo`
--

CREATE TABLE `photo` (
  `PHOTO_ID` int(11) NOT NULL,
  `FILENAME` text NOT NULL,
  `TYPE` varchar(30) NOT NULL,
  `SIZE` int(30) NOT NULL,
  `CAPTION` varchar(255) NOT NULL,
  `IDNO` int(11) NOT NULL,
  `PRIMARY` varchar(20) NOT NULL DEFAULT 'no'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

CREATE TABLE `room` (
  `ROOM_ID` int(11) NOT NULL,
  `ROOM_NAME` varchar(30) NOT NULL,
  `ROOM_DESC` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`ROOM_ID`, `ROOM_NAME`, `ROOM_DESC`) VALUES
(0, 'Room01', 'Room01'),
(2, 'Room02', 'Room 02'),
(4, 'Room 03', 'Room 03');

-- --------------------------------------------------------

--
-- Table structure for table `schoolyr`
--

CREATE TABLE `schoolyr` (
  `SYID` int(11) NOT NULL,
  `AY` varchar(30) NOT NULL,
  `SEMESTER` varchar(20) NOT NULL,
  `COURSE_ID` int(11) NOT NULL,
  `IDNO` int(30) NOT NULL,
  `CATEGORY` varchar(30) NOT NULL DEFAULT 'ENROLLED',
  `DATE_RESERVED` datetime NOT NULL,
  `DATE_ENROLLED` datetime NOT NULL,
  `STATUS` varchar(30) NOT NULL DEFAULT 'New'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `schoolyr`
--

INSERT INTO `schoolyr` (`SYID`, `AY`, `SEMESTER`, `COURSE_ID`, `IDNO`, `CATEGORY`, `DATE_RESERVED`, `DATE_ENROLLED`, `STATUS`) VALUES
(1, '2013-2014', 'First', 47, 20004277, 'ENROLLED', '2014-03-12 02:10:03', '0000-00-00 00:00:00', 'New'),
(2, '2013-2014', 'First', 47, 20004207, 'ENROLLED', '2014-03-12 02:32:19', '0000-00-00 00:00:00', 'New'),
(3, '2014-2015', 'First', 48, 20004277, 'ENROLLED', '2014-03-13 03:18:56', '0000-00-00 00:00:00', 'Continuing'),
(4, '2013-2014', 'First', 47, 20004180, 'ENROLLED', '2014-03-24 08:28:35', '0000-00-00 00:00:00', 'New'),
(5, '2013-2014', 'First', 47, 20004623, 'ENROLLED', '2014-03-24 09:16:15', '0000-00-00 00:00:00', 'New'),
(6, '2018-2019', 'First', 47, 6231415, 'ENROLLED', '2021-01-28 07:34:09', '0000-00-00 00:00:00', 'New'),
(7, '2019-2020', 'First', 50, 696969, 'ENROLLED', '2021-03-23 06:45:55', '0000-00-00 00:00:00', 'New'),
(8, '2013-2014', 'First', 47, 696969, 'ENROLLED', '2021-03-23 06:55:09', '0000-00-00 00:00:00', 'New');

-- --------------------------------------------------------

--
-- Table structure for table `semester`
--

CREATE TABLE `semester` (
  `SEM_ID` int(11) NOT NULL,
  `SEM` varchar(15) NOT NULL DEFAULT 'First'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `semester`
--

INSERT INTO `semester` (`SEM_ID`, `SEM`) VALUES
(1, 'First'),
(2, 'Second'),
(3, 'Summer');

-- --------------------------------------------------------

--
-- Table structure for table `studentsubjects`
--

CREATE TABLE `studentsubjects` (
  `STUDSUBJ_ID` int(11) NOT NULL,
  `IDNO` int(11) NOT NULL,
  `SUBJ_ID` int(11) NOT NULL,
  `LEVEL` int(11) NOT NULL,
  `SEMESTER` varchar(30) NOT NULL,
  `SY` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `studentsubjects`
--

INSERT INTO `studentsubjects` (`STUDSUBJ_ID`, `IDNO`, `SUBJ_ID`, `LEVEL`, `SEMESTER`, `SY`) VALUES
(6, 20004207, 11, 1, 'First', '2013-2014'),
(8, 20004207, 13, 1, 'First', '2013-2014'),
(9, 20004207, 14, 1, 'First', '2013-2014'),
(10, 20004207, 15, 1, 'First', '2013-2014'),
(13, 20004277, 13, 1, 'First', '2013-2014'),
(14, 20004277, 14, 1, 'First', '2013-2014'),
(15, 20004277, 15, 1, 'First', '2013-2014');

-- --------------------------------------------------------

--
-- Table structure for table `subject`
--

CREATE TABLE `subject` (
  `SUBJ_ID` int(11) NOT NULL,
  `SUBJ_CODE` varchar(30) NOT NULL,
  `SUBJ_DESCRIPTION` varchar(255) NOT NULL,
  `UNIT` int(2) NOT NULL,
  `PRE_REQUISITE` varchar(30) NOT NULL DEFAULT 'None',
  `COURSE_ID` int(11) NOT NULL,
  `AY` varchar(30) NOT NULL,
  `SEMESTER` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `subject`
--

INSERT INTO `subject` (`SUBJ_ID`, `SUBJ_CODE`, `SUBJ_DESCRIPTION`, `UNIT`, `PRE_REQUISITE`, `COURSE_ID`, `AY`, `SEMESTER`) VALUES
(438, 'Spiral Filipino', 'Filipino for Grade 7 - Spiral Filipino', 3, '', 47, '2013-2014', 'First'),
(439, 'Spiral English', 'English for Grade 7', 3, '', 47, '2013-2014', 'First'),
(440, 'Spiral Mathematics', 'Mathematics for Grade 7 - Spiral Math', 3, '', 47, '2013-2014', 'First'),
(441, 'Spiral Science', 'Science for Grade 7', 3, '', 47, '2013-2014', 'First'),
(442, 'Spiral T.L.E', 'T.L.E for Grade 7', 3, '', 47, '2013-2014', 'First'),
(443, 'Spiral A.P', 'Araling Panlipunan for Grade 7', 3, '', 47, '2013-2014', 'First'),
(444, 'Spiral Religion', 'rekligion for Grade 7', 3, '', 47, '2013-2014', 'First'),
(445, 'Spiral EsP.', 'EsP. for Grade 7', 3, '', 47, '2013-2014', 'First'),
(446, 'MAPEH', 'MAPEH for Grade 8 ', 3, '', 47, '2013-2014', 'First'),
(447, 'MAPEH', 'MAPEH for Grade 7', 3, '', 47, '2013-2014', 'First'),
(448, 'Religion', 'Religion for Grade 8', 3, '', 48, '2013-2014', 'First'),
(449, 'Spiral Filipino', 'Filipino for Grade 8 ', 3, '', 48, '2013-2014', 'First'),
(450, 'Spiral English', 'English for Grade 8', 3, '', 48, '2013-2014', 'First'),
(451, 'Spiral Mathematics', 'Mathematics for Grade 8 ', 3, '', 48, '2013-2014', 'First'),
(452, 'Spiral Science', 'Science for Grade ', 3, '', 48, '2013-2014', 'First'),
(453, 'Spiral T.L.E.', 'T.L.E for Grade 7 ', 3, '', 48, '2013-2014', 'First'),
(454, 'Spiral A.P.', 'Araling Panlipunan for Grade 8', 3, '', 48, '2013-2014', 'First'),
(455, 'Spiral EsP.', 'EsP. for Grade 7', 3, '', 48, '2013-2014', 'First'),
(457, 'Spiral Filipino', 'Filipino for Grade 9', 3, '', 49, '2013-2014', 'First'),
(458, 'Spiral English', 'English for Grade 9', 3, '', 49, '2013-2014', 'First'),
(459, 'Spiral Mathematics', 'Mathematics for Grade 9', 3, '', 49, '2013-2014', 'First'),
(460, 'Spiral Science', 'Science for Grade 9', 3, '', 49, '2013-2014', 'First'),
(461, 'Spiral A.P.', 'Araling Panlipunan for Grade 9', 3, '', 49, '2013-2014', 'First'),
(462, 'Spiral T.L.E.', 'T.L.E for Grade 9', 3, '', 49, '2013-2014', 'First'),
(463, 'Spiral MAPEH', 'MAPEH for Grade 9', 3, '', 49, '2013-2014', 'First'),
(464, 'Values Education', 'Values Education for Grade 9', 3, '', 49, '2013-2014', 'First'),
(465, 'Computer', 'Computer for grade 9', 3, '', 49, '2013-2014', 'First'),
(466, 'Religion IV', 'Religion for Grade 10', 3, '', 50, '2013-2014', 'First'),
(467, 'Spiral Filipino', 'Filipino for Grade 10', 3, '', 50, '2013-2014', 'First'),
(468, 'Spiral Mathematics', 'Mathematics for Grade 10', 3, '', 50, '2013-2014', 'First'),
(469, 'Spiral Science', 'Science for Grade 10', 3, '', 50, '2013-2014', 'First'),
(471, 'Spiral T.L.E.', 'T.L.E for Grade 10', 3, '', 50, '2013-2014', 'First'),
(472, 'Spiral MAPEH', 'MAPEH for Grade 10', 3, '', 50, '2013-2014', 'First'),
(473, 'Values Education', 'Values Education for Grade 10', 3, '', 50, '2013-2014', 'First'),
(474, 'CAT', 'Citizens Advancement Training', 3, '', 50, '2013-2014', 'First'),
(475, 'Computer', 'Computer for grade 10', 3, '', 50, '2013-2014', 'First'),
(476, 'hjgjhggh', 'gj', 3, '', 51, '2013-2014', 'First');

-- --------------------------------------------------------

--
-- Table structure for table `tblrequirements`
--

CREATE TABLE `tblrequirements` (
  `REQ_ID` int(30) NOT NULL,
  `NSO` varchar(5) NOT NULL DEFAULT 'no',
  `BAPTISMAL` varchar(5) NOT NULL DEFAULT 'no',
  `ENTRANCE_TEST_RESULT` varchar(5) NOT NULL DEFAULT 'no',
  `MARRIAGE_CONTRACT` varchar(5) NOT NULL DEFAULT 'no',
  `CERTIFICATE_OF_TRANSFER` varchar(5) NOT NULL DEFAULT 'no',
  `IDNO` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblrequirements`
--

INSERT INTO `tblrequirements` (`REQ_ID`, `NSO`, `BAPTISMAL`, `ENTRANCE_TEST_RESULT`, `MARRIAGE_CONTRACT`, `CERTIFICATE_OF_TRANSFER`, `IDNO`) VALUES
(20, 'Yes', 'Yes', 'Yes', 'No', 'No', 20004277),
(21, 'Yes', 'Yes', 'Yes', 'No', 'No', 20004207),
(22, 'Yes', 'Yes', 'Yes', 'No', 'No', 20004180),
(26, 'Yes', 'Yes', 'Yes', 'No', 'No', 20004623),
(30, 'Yes', 'Yes', 'Yes', 'No', 'Yes', 20004749),
(32, 'Yes', 'Yes', 'Yes', 'No', 'Yes', 20003333),
(35, 'Yes', 'Yes', 'No', 'No', 'No', 20001482),
(36, 'Yes', 'Yes', 'Yes', 'No', 'Yes', 20001937),
(37, 'Yes', 'Yes', 'Yes', 'No', 'No', 20001648),
(38, 'Yes', 'Yes', 'Yes', 'No', 'Yes', 20002408),
(39, 'Yes', 'Yes', 'Yes', 'No', 'Yes', 20005936),
(40, 'No', 'No', 'No', 'No', 'No', 20001550),
(41, 'Yes', 'Yes', 'Yes', 'No', 'No', 20002270),
(47, 'Yes', 'Yes', 'Yes', 'No', 'No', 20001658),
(48, 'Yes', 'No', 'No', 'No', 'No', 20001550),
(51, 'Yes', 'Yes', 'Yes', 'No', 'Yes', 20001673),
(55, 'Yes', 'Yes', 'Yes', 'No', 'Yes', 20002106),
(58, 'Yes', 'Yes', 'No', 'Yes', 'No', 123456),
(59, 'Yes', 'Yes', 'Yes', 'No', 'No', 6231415),
(60, 'Yes', 'Yes', 'Yes', 'No', 'Yes', 696969);

-- --------------------------------------------------------

--
-- Table structure for table `tblstuddetails`
--

CREATE TABLE `tblstuddetails` (
  `DETAIL_ID` int(11) NOT NULL,
  `FATHER` varchar(255) NOT NULL,
  `FATHER_OCCU` varchar(255) NOT NULL,
  `MOTHER` varchar(255) NOT NULL,
  `MOTHER_OCCU` varchar(255) NOT NULL,
  `BOARDING` varchar(5) NOT NULL DEFAULT 'no',
  `WITH_FAMILY` varchar(5) NOT NULL DEFAULT 'yes',
  `GUARDIAN` varchar(255) NOT NULL,
  `GUARDIAN_ADDRESS` varchar(255) NOT NULL,
  `OTHER_PERSON_SUPPORT` varchar(255) NOT NULL,
  `ADDRESS` text NOT NULL,
  `IDNO` int(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblstuddetails`
--

INSERT INTO `tblstuddetails` (`DETAIL_ID`, `FATHER`, `FATHER_OCCU`, `MOTHER`, `MOTHER_OCCU`, `BOARDING`, `WITH_FAMILY`, `GUARDIAN`, `GUARDIAN_ADDRESS`, `OTHER_PERSON_SUPPORT`, `ADDRESS`, `IDNO`) VALUES
(20, 'Walter Da-anoy', 'Employee', 'Jessielyn Da-anoy', 'Housewife', 'No', 'No', '', '', '', '', 20004277),
(21, 'Mario P. Amparado', 'OFW', 'Yolly D. Odasco', 'Housewife', 'Yes', 'No', 'Domingga Gomez', '', '', '', 20004207),
(22, 'robert P. ferrer', 'fisherman', 'josephene b. ferrer', 'Housewife', 'Yes', 'Yes', 'josephene b ferrer', 'brgy.cayhagan,sipalay city,neg.occ.', 'sister', '', 20004180),
(26, 'Luis Balico', 'N/A', 'Leonisa Balico', 'N/A', 'No', 'Yes', 'Mary Ann Balico', 'Brgy Isidro Village, Talubangi Kabankalan City', 'N/A', '', 20004623),
(30, 'Rollen Gealon', 'Laborer', 'Marife Gealon', 'Housewife', 'No', 'Yes', 'Mr. & Mrs Rollen Gealon', 'Brgy.2 Ilog, Neg.Occ', '', '', 20004749),
(32, 'Leve Voluntate', 'Farmer', 'Lerma Voluntate', 'Deceased', 'No', 'Yes', '', '', 'Mr.Von Martir', 'Bacolod City', 20003333),
(35, 'Adriano Bayog', 'Farmer', 'Mamerna Dulana', 'housekeeper', 'Yes', 'No', 'Seminary Fathers', 'Kabankalan City', 'Parish', 'La Castellana', 20001482),
(36, 'Ruben J. Principe', '', 'Evelina Gumawa Principe', '', 'No', 'No', '', '', '', '', 20001937),
(37, 'Deceased', 'Deceased', 'Lorna Bandolos', 'Housewife', 'No', 'Yes', '', 'Lorna Bandolos', '', 'Brgy Dancalan Ilog Negros Occidental', 20001648),
(38, 'AMBROCIO SERION', 'FARMER', 'NORMENDA SERION', 'HOUSE WIFE', 'No', 'No', 'JONALYN BUGALON', 'Kabankalan City', 'JONALYN BUGALON', 'KABANKALAN CITY', 20002408),
(39, 'no', '', 'Merlita Macurio', 'housewife', 'No', 'No', 'Gerom Bello', 'Brgy,1 fzo subd.', '', '', 20005936),
(40, 'b', '', '', '', 'No', 'No', '', '', '', '', 20001550),
(41, 'Mr. Edgar C. Macario', 'Farmer', 'Mrs. Hilda F. Macario', 'Housewife', 'No', 'Yes', 'Mrs. Imelda M. Gatoc', 'Cabintagan, Brgy. Linao Kabankalan City, Negros Occidental', 'Mr. Robert C. Macario', 'Brgy. Salong Kabankalan City', 20002270),
(47, 'Alex Flores', 'Carpenter', 'Nelfa L. Flores', 'Brgy. Custodian', 'No', 'Yes', 'Nelfa L. Flores', 'Brgy. Camugao, Kabankalan City', 'Maria Elena T. Flores', 'Brgy. Camugao, Kabankalan City', 20001658),
(48, 'BENIGNO B. CORTEZ', 'FARMER', 'TERESITA P. CORTEZ', 'HOUSE WIFE', 'Yes', 'No', 'BENIGNO B. CORTEZ', 'TABUGON,kABANKALAN CITY', 'NONE', 'NONE', 20001550),
(51, 'Jesus M. Gamala', 'Farmer', 'Carmen N. Gamala', 'Housewife', 'Yes', 'No', 'Saro Yana', 'Bonifacio St.Kabankalan City', 'Jeza Gamala', 'DasmariÃ±as Cavite', 20001673),
(55, 'Benjie Melanio Sr.', 'Farmer', 'Delia Melanio', 'Housewife', 'No', 'Yes', 'Benjie Melanio', 'Brgy. Linao', '', '', 20002106),
(58, '', '', '', '', 'No', 'No', '', '', '', '', 123456),
(59, 'James Smith', 'Software Engineer', 'Cynthia Smith', 'House Wife', 'Yes', 'No', '', 'Sample Address', '', '', 6231415),
(60, 'Demo Name', 'Demo Occ', 'Demo Name M', 'Demo Occ M', 'Yes', 'Yes', 'Demo Name M', 'Demo Address Address', 'None', 'Demo Address', 696969);

-- --------------------------------------------------------

--
-- Table structure for table `tblstudent`
--

CREATE TABLE `tblstudent` (
  `S_ID` int(11) NOT NULL,
  `IDNO` int(20) NOT NULL,
  `FNAME` varchar(40) NOT NULL,
  `LNAME` varchar(40) NOT NULL,
  `MNAME` varchar(40) NOT NULL,
  `SEX` varchar(10) NOT NULL DEFAULT 'Male',
  `BDAY` date NOT NULL,
  `BPLACE` text NOT NULL,
  `STATUS` varchar(30) NOT NULL,
  `AGE` int(30) NOT NULL,
  `NATIONALITY` varchar(40) NOT NULL,
  `RELIGION` varchar(255) NOT NULL,
  `CONTACT_NO` varchar(40) NOT NULL,
  `HOME_ADD` text NOT NULL,
  `EMAIL` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblstudent`
--

INSERT INTO `tblstudent` (`S_ID`, `IDNO`, `FNAME`, `LNAME`, `MNAME`, `SEX`, `BDAY`, `BPLACE`, `STATUS`, `AGE`, `NATIONALITY`, `RELIGION`, `CONTACT_NO`, `HOME_ADD`, `EMAIL`) VALUES
(17, 20004277, 'JESTERRAMY', 'DA-ANOY ', 'PATETE', 'F', '1995-06-14', 'Butuan City', 'Single', 19, 'Filipino', 'roman catholic', '09099754195', 'Brgy Camugao Kabankalan City', 'jesterramy14@yahoo.com'),
(18, 20004207, 'LHENYL GRACE', 'AMPARADO', 'ODASCO', 'F', '1995-08-27', 'Lancaan Dasmarinas Cavite', 'Single', 18, 'Filipino', 'roman catholic', '09263621995', 'Yao Yao Cauayan negros Occidental', 'lhenylgraceamparado@yahoo.com'),
(19, 20004180, 'MYLENE', 'FERRER', 'BALUCAN', 'F', '1972-05-22', 'brgy.cayhagan,sipalay city,neg.occ.', 'Single', 18, 'Filipino', 'roman catholic', '091071717257', 'brgy.cayhagan,sipalay city,neg.occ.', 'macaferrer@yahoo.com'),
(23, 20004623, 'SHARAH MAE', 'BALICO', 'PILLONES', 'F', '1990-11-01', 'Tagoloan Misamis Oriental', 'Single', 23, 'Filipino', 'Catholic', '09216230993', 'Brgy Isidro Village, Talubangi Kabankalan City', 'Sharahmae_balico@yahoo.com'),
(27, 20004749, 'JAMAICA JAIRAH', 'GEALON', 'DELA CRUZ', 'F', '1994-01-12', 'Brgy.2 Ilog,Neg.Occ.', 'Single', 19, 'Filipino', 'Roman Catholic', '09089917220', 'Brgy.2 Ilog Negros Occidental', 'gealon12@yahoo.com.ph'),
(29, 20003333, 'JENEBIE', 'VOLUNTATE', 'TABUCON', 'F', '1991-06-17', 'Kabankalan', 'Single', 22, 'Filipino', 'Roman Catholic', '09102247024', 'Brgy.Camansi,Kabankalan City,Neg.Occ.', 'jhen1704_cute@yahoo.com'),
(32, 20001482, 'ALDREN', 'BAYOG', 'DULANA ', 'M', '1993-12-27', 'La Castellana', 'Single', 20, 'Filipino', 'Roman Catholic', '09077898435', 'Kabankalan City', 'Aldz_bayog@yahoo.com'),
(33, 20001937, 'MERRY GRACE', 'PRINCIPE', 'GUMAWA', 'F', '1988-03-12', 'Candoni', 'Single', 25, 'Filipino', 'Roman Catholic', '09094397440', 'Pabera St.Brgy.East,Candoni, Negros Occidental', 'merrygraceprincipe@yahoo.com'),
(34, 20001648, 'SHIELA MARIE', 'BANDOLOS', 'TADAYA', 'F', '1990-08-21', 'Brgy. Dancalan Ilog Negros Occidental', 'Single', 22, 'Filipino', 'Roman Catholic', '09095596773', 'Brgy. Dancalan Ilog Negros Occidental', 'Marie_Bandolos@yahoo.com'),
(35, 20002408, 'ANALYN', 'SERION', 'ONLAGADA', 'F', '1993-10-30', 'Bry. TAMPALON KABANKALAN CITY', 'Single', 20, 'Filipino', 'Catholic', '09476154838', 'Kabankalan City', 'Analynserion@yahoo.com'),
(36, 20005936, 'JEAN', 'MACURIO', 'GONDAO', 'F', '1994-10-29', 'Brgy.Bantayan', 'Single', 19, 'Filipino', 'Baptist', '09125341710', 'Brgy. Bantayan Kabankalan City', 'jean_29_jake@yahoo.com'),
(37, 20001550, 'BENIGNO', 'CORTEZ', 'LACPAO', 'M', '1992-02-03', 'DUMAGUETE', 'Single', 21, 'FILIPINO', 'BAPTIST', '09097313999', 'TABUGON,KABANKALAN CITY,NEGROS OCCIDENTAL', 'deadlyjay_23@yahoo.com'),
(38, 20002270, 'ARHIL JUN', 'MACARIO', 'FERNANDEZ', 'M', '1993-06-12', 'Cabintagan, Brgy. Linao', 'Single', 20, 'Filipino', 'Roman Catholic', '09489776185', 'Cabintagan, Brgy. Linao Kabankalan City, Negros Occidental', 'elehra_jun_09@yahoo.com'),
(44, 20001658, 'STEVE', 'FLORES', 'LIPER', 'M', '1993-01-02', 'Brgy. Camugao, Kabankalan City', 'Single', 21, 'Filipino', 'Roman Catholic', '09077659710', 'Brgy. Camugao, Kabankalan City', 'skevinz_23@ymail.com'),
(48, 20001673, 'CARJEI', 'GAMALA', 'NAZARETH', 'M', '1993-04-28', 'Bulata', 'Single', 20, 'Filipino', 'Catholic', '09484207156', 'Bulata Cauyan Negros Occidental', 'kai_luv@yahoo.com'),
(52, 20002106, 'JEROM', 'MELANIO', 'BANDOLON', 'M', '1992-10-12', 'Kabankalan City', 'Single', 21, 'Filipino', 'Cathilic', '09303950074', 'Brgy. Linao, Kabankalan City', 'melaniojerom@yahoo.com'),
(55, 123456, 'KEVIN', 'GARGAR', 'DFD', 'M', '2013-07-13', 'bacolod city', 'Single', 12, '', '', '', '', 'Kev@yahoo.cpm'),
(56, 6231415, 'John', 'Smith', 'D', 'M', '2000-06-23', 'Sample City', 'Single', 15, 'Filipino', 'Roman Catholic', '+12354987', 'Sample Address', 'jsmith@sample.com'),
(57, 696969, 'James', 'Williams', 'Rk', 'M', '2003-06-04', 'Demo Place', 'Single', 17, 'Demooo', 'Buddhist', '9876543210', 'Demo Home', 'james@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `useraccounts`
--

CREATE TABLE `useraccounts` (
  `ACCOUNT_ID` int(11) NOT NULL,
  `ACCOUNT_NAME` varchar(255) NOT NULL,
  `ACCOUNT_USERNAME` varchar(255) NOT NULL,
  `ACCOUNT_PASSWORD` text NOT NULL,
  `ACCOUNT_TYPE` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `useraccounts`
--

INSERT INTO `useraccounts` (`ACCOUNT_ID`, `ACCOUNT_NAME`, `ACCOUNT_USERNAME`, `ACCOUNT_PASSWORD`, `ACCOUNT_TYPE`) VALUES
(1, 'Logan Smith', 'adminlogan@gmail.com', 'f865b53623b121fd34ee5426c792e5c33af8c227', 'Administrator'),
(3, 'Joken Villanueva', 'joken@yahoo.com', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 'Administrator'),
(4, 'Hatch Villanueva', 'hatchvillanueva16@gmail.com', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 'Registrar'),
(6, 'joenin', 'joenin@yahoo.com', '25f3c6036a19460cd5d3f302fa7b99e5be56cb0e', 'Encoder'),
(8, 'joken', 'j@y.c', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 'Student'),
(9, 'Allan', 'allan@yahoo.com', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 'Teacher'),
(10, 'sdfsdfsdg', 'joken@gmail.com', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 'Teacher'),
(11, 'George Wilson', 'gwilson@sample.com', 'e67a0311df4d7de4eb50c3fc1e012b4823a6917d', 'Teacher'),
(12, 'Harry Den', 'harryden@gmail.com', '23a0b5e4fb6c6e8280940920212ecd563859cb3c', 'Student'),
(13, 'demo', 'demo', '89e495e7941cf9e40e6980d14a16bf023ccd4c91', 'Course In-charge');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ay`
--
ALTER TABLE `ay`
  ADD PRIMARY KEY (`AY_ID`),
  ADD UNIQUE KEY `acadyr` (`ACADYR`);

--
-- Indexes for table `class`
--
ALTER TABLE `class`
  ADD PRIMARY KEY (`CLASS_ID`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`COURSE_ID`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`DEPT_ID`);

--
-- Indexes for table `grades`
--
ALTER TABLE `grades`
  ADD PRIMARY KEY (`GRADE_ID`);

--
-- Indexes for table `instructor`
--
ALTER TABLE `instructor`
  ADD PRIMARY KEY (`INST_ID`),
  ADD UNIQUE KEY `INST_EMAIL` (`INST_EMAIL`);

--
-- Indexes for table `level`
--
ALTER TABLE `level`
  ADD PRIMARY KEY (`YR_ID`);

--
-- Indexes for table `major`
--
ALTER TABLE `major`
  ADD PRIMARY KEY (`MAJOR_ID`);

--
-- Indexes for table `photo`
--
ALTER TABLE `photo`
  ADD PRIMARY KEY (`PHOTO_ID`);

--
-- Indexes for table `room`
--
ALTER TABLE `room`
  ADD PRIMARY KEY (`ROOM_ID`);

--
-- Indexes for table `schoolyr`
--
ALTER TABLE `schoolyr`
  ADD PRIMARY KEY (`SYID`);

--
-- Indexes for table `semester`
--
ALTER TABLE `semester`
  ADD PRIMARY KEY (`SEM_ID`);

--
-- Indexes for table `studentsubjects`
--
ALTER TABLE `studentsubjects`
  ADD PRIMARY KEY (`STUDSUBJ_ID`);

--
-- Indexes for table `subject`
--
ALTER TABLE `subject`
  ADD PRIMARY KEY (`SUBJ_ID`);

--
-- Indexes for table `tblrequirements`
--
ALTER TABLE `tblrequirements`
  ADD PRIMARY KEY (`REQ_ID`);

--
-- Indexes for table `tblstuddetails`
--
ALTER TABLE `tblstuddetails`
  ADD PRIMARY KEY (`DETAIL_ID`);

--
-- Indexes for table `tblstudent`
--
ALTER TABLE `tblstudent`
  ADD PRIMARY KEY (`S_ID`),
  ADD UNIQUE KEY `IDNO` (`IDNO`);

--
-- Indexes for table `useraccounts`
--
ALTER TABLE `useraccounts`
  ADD PRIMARY KEY (`ACCOUNT_ID`),
  ADD UNIQUE KEY `ACCOUNT_USERNAME` (`ACCOUNT_USERNAME`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ay`
--
ALTER TABLE `ay`
  MODIFY `AY_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `class`
--
ALTER TABLE `class`
  MODIFY `CLASS_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `course`
--
ALTER TABLE `course`
  MODIFY `COURSE_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `department`
--
ALTER TABLE `department`
  MODIFY `DEPT_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `grades`
--
ALTER TABLE `grades`
  MODIFY `GRADE_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `instructor`
--
ALTER TABLE `instructor`
  MODIFY `INST_ID` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `level`
--
ALTER TABLE `level`
  MODIFY `YR_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `major`
--
ALTER TABLE `major`
  MODIFY `MAJOR_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `photo`
--
ALTER TABLE `photo`
  MODIFY `PHOTO_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `room`
--
ALTER TABLE `room`
  MODIFY `ROOM_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `schoolyr`
--
ALTER TABLE `schoolyr`
  MODIFY `SYID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `semester`
--
ALTER TABLE `semester`
  MODIFY `SEM_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `studentsubjects`
--
ALTER TABLE `studentsubjects`
  MODIFY `STUDSUBJ_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `subject`
--
ALTER TABLE `subject`
  MODIFY `SUBJ_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=477;

--
-- AUTO_INCREMENT for table `tblrequirements`
--
ALTER TABLE `tblrequirements`
  MODIFY `REQ_ID` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `tblstuddetails`
--
ALTER TABLE `tblstuddetails`
  MODIFY `DETAIL_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `tblstudent`
--
ALTER TABLE `tblstudent`
  MODIFY `S_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `useraccounts`
--
ALTER TABLE `useraccounts`
  MODIFY `ACCOUNT_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- Database: `dbms`
--
CREATE DATABASE IF NOT EXISTS `dbms` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `dbms`;

-- --------------------------------------------------------

--
-- Table structure for table `dept`
--

CREATE TABLE `dept` (
  `deptno` int(4) NOT NULL,
  `dname` varchar(20) DEFAULT NULL,
  `loc` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dept`
--

INSERT INTO `dept` (`deptno`, `dname`, `loc`) VALUES
(1, 'Administrative', 'Dagupan'),
(2, 'Sales', 'Baguio'),
(3, 'Production', 'Tarlac');

-- --------------------------------------------------------

--
-- Table structure for table `emp`
--

CREATE TABLE `emp` (
  `empno` int(4) NOT NULL,
  `ename` varchar(20) DEFAULT NULL,
  `deptno` int(4) DEFAULT NULL,
  `sal` double DEFAULT NULL,
  `Mgr` int(4) DEFAULT NULL,
  `HireDate` date DEFAULT NULL,
  `Comm` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `emp`
--

INSERT INTO `emp` (`empno`, `ename`, `deptno`, `sal`, `Mgr`, `HireDate`, `Comm`) VALUES
(1, 'Dads', 1, 10000, NULL, '1990-06-07', NULL),
(2, 'Rhommelyn', 2, 8500, 1, '1992-06-08', NULL),
(3, 'Leny', 1, 9600, 1, '1992-07-06', NULL),
(4, 'Eudz', 3, 9740, 1, '1999-08-07', NULL),
(5, 'Arnold', 2, 7500, 2, '1995-07-06', 1000),
(6, 'Mark', 2, 7000, 2, '1996-08-09', 800),
(7, 'Jen', 3, 8700, 4, '1997-09-09', 900),
(8, 'Rose', 1, 8000, 3, '1991-08-08', 1200),
(9, 'Roland', 1, 6000, 3, '1995-09-10', 800),
(10, 'Peter', 3, 5000, 4, '1998-11-11', 560),
(11, 'Micah', 3, 4500, 4, '1994-12-12', 750),
(12, 'Karen', 2, 4600, 2, '1995-06-05', 500),
(13, 'Kim', 1, 4500, 3, '1997-04-28', 0),
(14, 'Rolly', 3, 5000, 4, '1997-05-28', 510),
(15, '3', 4, 50000, 0, '2024-02-05', 40000),
(16, '', 0, 0, 0, '0000-00-00', 0),
(17, 'is', 3, 12000, 0, '0000-00-00', 5000);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dept`
--
ALTER TABLE `dept`
  ADD PRIMARY KEY (`deptno`);

--
-- Indexes for table `emp`
--
ALTER TABLE `emp`
  ADD PRIMARY KEY (`empno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `dept`
--
ALTER TABLE `dept`
  MODIFY `deptno` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `emp`
--
ALTER TABLE `emp`
  MODIFY `empno` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- Database: `gradingsys`
--
CREATE DATABASE IF NOT EXISTS `gradingsys` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `gradingsys`;

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `id` int(11) NOT NULL,
  `subject_code` varchar(20) NOT NULL,
  `subject_name` varchar(100) NOT NULL,
  `course_code` varchar(20) NOT NULL,
  `course_title` varchar(100) NOT NULL,
  `instructor` varchar(100) NOT NULL,
  `schedule` varchar(50) NOT NULL,
  `section` varchar(20) NOT NULL,
  `room_number` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`id`, `subject_code`, `subject_name`, `course_code`, `course_title`, `instructor`, `schedule`, `section`, `room_number`) VALUES
(1, '', '', 'CCS101', 'Introduction to Computer Science', 'Dr. Smith', '', '', ''),
(2, '', '', 'CCS102', 'Data Structures', 'Prof. Johnson', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `grades`
--

CREATE TABLE `grades` (
  `id` int(11) NOT NULL,
  `student_id` int(11) DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL,
  `period` enum('1','2','3','4','PE','ME','SFE','FE') DEFAULT NULL,
  `quizzes` float DEFAULT NULL,
  `academic_projects` float DEFAULT NULL,
  `recitation` float DEFAULT NULL,
  `performance_task` float DEFAULT NULL,
  `activity_sheets` float DEFAULT NULL,
  `assignments` float DEFAULT NULL,
  `prelim_exam` float DEFAULT NULL,
  `midterm_exam` float DEFAULT NULL,
  `semi_final_exam` float DEFAULT NULL,
  `final_exam` float DEFAULT NULL,
  `exam_score` float DEFAULT NULL,
  `remarks` varchar(20) DEFAULT NULL,
  `lec_lab` enum('LEC','LAB') DEFAULT NULL,
  `units` int(11) DEFAULT NULL,
  `total_units` int(11) DEFAULT NULL,
  `total_load_units` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `grades`
--

INSERT INTO `grades` (`id`, `student_id`, `course_id`, `period`, `quizzes`, `academic_projects`, `recitation`, `performance_task`, `activity_sheets`, `assignments`, `prelim_exam`, `midterm_exam`, `semi_final_exam`, `final_exam`, `exam_score`, `remarks`, `lec_lab`, `units`, `total_units`, `total_load_units`) VALUES
(37, 2, NULL, 'PE', 30, 20, 60, 22, 21, 41, 80, NULL, NULL, NULL, NULL, 'Passed', NULL, NULL, NULL, NULL),
(40, 2, NULL, 'SFE', 30, 20, 60, 22, 21, 41, NULL, NULL, 88, NULL, NULL, 'Passed', NULL, NULL, NULL, NULL),
(41, 2, NULL, 'FE', 20, 10, 41, 60, 65.5, 50, NULL, NULL, NULL, 89, NULL, 'Passed', NULL, NULL, NULL, NULL),
(42, 3, NULL, 'PE', 30, 20, 60, 22, 21, 41, 80, NULL, NULL, NULL, NULL, 'Passed', NULL, NULL, NULL, NULL),
(43, 3, NULL, 'ME', 30, 25, 50, 22, 21, 41, NULL, 85, NULL, NULL, NULL, 'Passed', NULL, NULL, NULL, NULL),
(44, 3, NULL, 'SFE', 30, 23, 60, 22, 24, 41, NULL, NULL, 88, NULL, NULL, 'Passed', NULL, NULL, NULL, NULL),
(45, 3, NULL, 'FE', 30, 10, 41, 60, 65.5, 50, NULL, NULL, NULL, 89, NULL, 'Passed', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `middlename` varchar(50) NOT NULL,
  `gender` enum('Male','Female') NOT NULL,
  `birthdate` date NOT NULL,
  `birthplace` varchar(100) NOT NULL,
  `address` text NOT NULL,
  `father` varchar(100) NOT NULL,
  `mother` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `course` enum('BSIT','BSCS') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `lastname`, `firstname`, `middlename`, `gender`, `birthdate`, `birthplace`, `address`, `father`, `mother`, `created_at`, `course`) VALUES
(1, 'Muyano', 'Ieson Louis', 'Cabrera', 'Male', '1999-01-25', 'Region I', 'Mangaldan', 'Nelson ', 'Cynthia ', '2024-06-15 13:58:16', 'BSCS'),
(2, 'Rover', 'Seyfert', 'Aerial', 'Male', '2000-12-05', 'Region 1', 'mangaldan,pangasinan', 'Arlecchino', 'Yin Lin', '2024-06-15 14:12:52', 'BSIT'),
(3, 'Sevidal', 'Christine', 'C.', 'Male', '2003-12-07', 'Region 1', 'dagupan,pangasinan', 'Alhaitham', 'Candace', '2024-06-16 18:08:14', 'BSIT'),
(4, 'Loyola', 'Joshua', 'H', 'Male', '2004-05-21', 'Dagupan', 'Dagupan,Pangasinan', '1', '2', '2024-06-17 12:31:05', 'BSIT'),
(5, 'Hornada', 'Rocelle', 'L', 'Female', '2004-12-04', 'Dagupan', 'Dagupan,Pangasinan', '1', '2', '2024-06-17 13:03:44', 'BSIT'),
(9, 'Escano', 'Piolo', 'C.', 'Male', '2004-12-05', 'Dagupan', 'Dagupan,Pangasinan', 'p', 'p', '2024-06-17 17:19:26', 'BSIT'),
(10, 'picar', 'paolo', 'J', 'Male', '2001-12-04', 'Dagupan', 'Lingayen,Pangasinan', 'p', 'p', '2024-06-17 17:30:16', 'BSCS'),
(11, 'Pesimo', 'Jasper', 'J', 'Male', '2005-12-03', 'region 1', 'bugallon, pangasinan', 'p', 'p', '2024-06-17 17:43:30', 'BSIT'),
(12, 'Andrea', 'C', 'De Guzman', 'Female', '2000-12-06', 'region 1', 'Dagupan,Pangasinan', 'k', 'h', '2024-06-18 17:48:25', 'BSCS');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','professor') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`) VALUES
(5, 'admin', '$2y$10$fKRJp9I/B561QQMLu.oG9.BfHkvRKGsYD3GP31PmCJEp1I6dzwi16', 'admin'),
(6, 'professor', '$2y$10$vE8XIzkuAxmBQKrNQGb0auXDO0mcBuim1Y0a8hqJy7179.TBV6yWS', 'professor'),
(0, '', '$2y$10$Rn4Z6DD9v3AMo5LqWeF32OTdfWZXdNuUswspnfbP82gsuPKOt6VCy', ''),
(0, '', '$2y$10$5LKp.XkxjTenMz42DL9NsOyirAEIYSGD9hQ657xS9Mb4XVQBdYdz2', ''),
(0, '', '$2y$10$9YWDZ6t03YYXx/f63e5YwuxZQH6nzKi18Zgj5oU3SZQr23y67U14K', ''),
(0, 'admin', '$2y$10$vZ.shhtkI4dmc1zXAd05XeVbJ64H07ByRo54Bk8OOcKyuZ9tS7hVq', 'admin'),
(0, 'ieson', '$2y$10$Kk/1BtNsf7uLu9hXLlW1uOhju6.xLTALcYyM8geegLnBqfYXIIGNC', 'professor'),
(0, 'rocelle', '$2y$10$U4ZMTwRINQ3Y9LTWSYen2exm6Hnaq.pWVB4L.4SbUUI0y3CEUOltG', 'admin'),
(0, 'rocelle', '$2y$10$RokLjY4T60uGXqj5F6QdCOjX9iHvSe022YQ/MnyysGZOSd3SaNKwm', 'admin');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `grades`
--
ALTER TABLE `grades`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `grades`
--
ALTER TABLE `grades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `grades`
--
ALTER TABLE `grades`
  ADD CONSTRAINT `fk_course` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE;
--
-- Database: `grading_db`
--
CREATE DATABASE IF NOT EXISTS `grading_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `grading_db`;

-- --------------------------------------------------------

--
-- Table structure for table `advisers`
--

CREATE TABLE `advisers` (
  `adviser_id` int(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `grade_id` varchar(5) NOT NULL,
  `section` varchar(20) NOT NULL,
  `program` varchar(5) NOT NULL,
  `school_year` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `ATT_ID` int(30) NOT NULL,
  `STUDENT_ID` int(30) NOT NULL,
  `SYI_ID` int(30) NOT NULL,
  `MONTH` varchar(15) NOT NULL,
  `DAYS_OF_CLASSES` int(5) NOT NULL,
  `DAYS_PRESENT` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`ATT_ID`, `STUDENT_ID`, `SYI_ID`, `MONTH`, `DAYS_OF_CLASSES`, `DAYS_PRESENT`) VALUES
(1, 1, 1, 'June', 10, 10),
(2, 1, 1, 'July', 10, 10),
(3, 1, 1, 'August', 10, 10),
(4, 1, 1, 'September', 10, 10),
(5, 1, 1, 'October', 10, 10),
(6, 1, 1, 'November', 10, 10),
(7, 1, 1, 'December', 10, 10),
(8, 1, 1, 'January', 10, 10),
(9, 1, 1, 'February', 10, 10),
(10, 1, 1, 'March', 10, 10),
(11, 1, 1, 'April', 10, 10),
(12, 1, 1, 'May', 10, 10),
(13, 1, 2, 'June', 0, 0),
(14, 1, 2, 'July', 0, 0),
(15, 1, 2, 'August', 0, 0),
(16, 1, 2, 'September', 0, 0),
(17, 1, 2, 'October', 0, 0),
(18, 1, 2, 'November', 0, 0),
(19, 1, 2, 'December', 0, 0),
(20, 1, 2, 'January', 0, 0),
(21, 1, 2, 'February', 0, 0),
(22, 1, 2, 'March', 0, 0),
(23, 1, 2, 'April', 0, 0),
(24, 1, 2, 'May', 0, 0),
(25, 2, 3, 'June', 30, 30),
(26, 2, 3, 'July', 30, 30),
(27, 2, 3, 'August', 31, 25),
(28, 2, 3, 'September', 21, 12),
(29, 2, 3, 'October', 24, 22),
(30, 2, 3, 'November', 21, 19),
(31, 2, 3, 'December', 19, 1),
(32, 2, 3, 'January', 21, 14),
(33, 2, 3, 'February', 15, 15),
(34, 2, 3, 'March', 14, 12),
(35, 2, 3, 'April', 25, 21),
(36, 2, 3, 'May', 12, 12);

-- --------------------------------------------------------

--
-- Table structure for table `awss`
--

CREATE TABLE `awss` (
  `id` int(200) NOT NULL,
  `ff` int(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `data_b`
--

CREATE TABLE `data_b` (
  `db_id` int(10) NOT NULL,
  `db_name` varchar(50) NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `data_base`
--

CREATE TABLE `data_base` (
  `db_id` int(10) NOT NULL,
  `dn_name` varchar(50) NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `grade`
--

CREATE TABLE `grade` (
  `grade_id` int(10) NOT NULL,
  `grade` varchar(10) NOT NULL,
  `status` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `grade`
--

INSERT INTO `grade` (`grade_id`, `grade`, `status`) VALUES
(1, '1st Year', ''),
(2, '2nd Year', ''),
(3, '3rd Year', ''),
(4, '0', ''),
(5, '4th Year', '');

-- --------------------------------------------------------

--
-- Table structure for table `grades_per_subject`
--

CREATE TABLE `grades_per_subject` (
  `ID` int(11) NOT NULL,
  `STUDENT_ID` int(30) NOT NULL,
  `YEAR` int(5) NOT NULL,
  `SUBJECT` varchar(20) NOT NULL,
  `PERIODIC_GRADING` int(5) NOT NULL,
  `GRADES` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `history_log`
--

CREATE TABLE `history_log` (
  `log_id` int(10) NOT NULL,
  `transaction` varchar(200) NOT NULL,
  `user_id` int(5) NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `history_log`
--

INSERT INTO `history_log` (`log_id`, `transaction`, `user_id`, `date_added`) VALUES
(1, 'logged out', 4, '2020-10-14 23:58:21'),
(2, 'logged in', 1, '2020-10-14 23:58:27'),
(3, 'added 2016-2017 in the school year list', 1, '2020-10-14 23:58:42'),
(4, 'added 2017-2018 in the school year list', 1, '2020-10-14 23:58:53'),
(5, 'added 2018-2019 in the school year list', 1, '2020-10-14 23:59:07'),
(6, 'added 2019-2020 in the school year list', 1, '2020-10-14 23:59:19'),
(7, 'updated 2016-2017 as the current school year ', 1, '2020-10-14 23:59:29'),
(8, 'added 7 in the grades list', 1, '2020-10-14 23:59:44'),
(9, 'added 8 in the grades list', 1, '2020-10-14 23:59:49'),
(10, 'added 9 in the grades list', 1, '2020-10-14 23:59:53'),
(11, 'added 10 in the grades list', 1, '2020-10-15 00:00:01'),
(12, 'added Englis in the subject list', 1, '2020-10-15 00:00:39'),
(13, 'added Math in the subject list', 1, '2020-10-15 00:00:50'),
(14, 'added John Smith as new student', 1, '2020-10-15 00:02:28'),
(15, 'added record of m m', 0, '2020-10-15 00:10:07'),
(16, 'updated 2017-2018 as the current school year ', 1, '2020-10-15 00:11:02'),
(17, 'added record of m m', 0, '2020-10-15 00:16:00'),
(18, 'printed John Smith permanent record', 1, '2020-10-15 00:16:49'),
(19, 'printed Promoted Student List of 2017-2018', 1, '2020-10-15 00:17:22'),
(20, 'logged out', 1, '2020-10-15 00:17:55'),
(21, 'logged in', 2, '2020-10-15 00:18:03'),
(22, 'logged in', 2, '2024-06-05 19:20:24'),
(23, 'printed Promoted Student List of 2016-2017', 2, '2024-06-05 19:20:36'),
(24, 'logged out', 2, '2024-06-05 19:46:01'),
(25, 'logged in', 2, '2024-06-06 22:40:43'),
(26, 'logged in', 2, '2024-06-06 22:47:57'),
(27, 'logged in', 2, '2024-06-06 22:48:00'),
(28, 'logged in', 2, '2024-06-06 22:48:02'),
(29, 'logged in', 2, '2024-06-06 23:05:05'),
(30, 'updated 1 in the subject list', 2, '2024-06-06 23:07:28'),
(31, 'updated 1 in the curriculum list', 0, '2024-06-06 23:07:42'),
(32, 'updated 1 in the curriculum list', 0, '2024-06-06 23:07:43'),
(33, 'added aerial seyf as new student', 2, '2024-06-06 23:09:53'),
(34, 'added record of ', 2, '2024-06-06 23:15:18'),
(35, 'printed Promoted Student List of 2017-2018', 2, '2024-06-06 23:17:30'),
(36, 'printed aerial seyf permanent record', 2, '2024-06-06 23:19:30'),
(37, 'updated 1 in the curriculum list', 0, '2024-06-06 23:20:02'),
(38, 'logged in', 2, '2024-06-06 23:23:48'),
(39, 'logged out', 2, '2024-06-06 23:24:10'),
(40, 'logged in', 1, '2024-06-06 23:24:30'),
(41, 'updated 2017-2018 as the current school year ', 1, '2024-06-06 23:25:06'),
(42, 'updated 2017-2018 as the current school year ', 1, '2024-06-06 23:26:01'),
(43, 'updated 1 in the grades list', 1, '2024-06-06 23:26:26'),
(44, 'updated 2 in the grades list', 1, '2024-06-06 23:26:36'),
(45, 'updated 3 in the grades list', 1, '2024-06-06 23:26:43'),
(46, 'added 4th Year in the grades list', 1, '2024-06-06 23:26:51'),
(47, 'updated 4 in the grades list', 1, '2024-06-06 23:27:01'),
(48, 'printed  Student List of 2016-2017', 1, '2024-06-06 23:27:36'),
(49, 'printed aerial seyf permanent record', 1, '2024-06-06 23:27:44'),
(50, 'logged out', 1, '2024-06-06 23:30:10'),
(51, 'logged in', 1, '2024-06-07 08:20:15'),
(52, 'logged out', 1, '2024-06-07 08:21:33'),
(53, 'logged in', 2, '2024-06-07 08:29:20'),
(54, 'logged in', 1, '2024-06-07 08:29:30'),
(55, 'logged out', 1, '2024-06-07 08:29:34'),
(56, 'logged in', 2, '2024-06-07 08:33:41'),
(57, 'logged out', 2, '2024-06-07 08:33:43'),
(58, 'logged in', 2, '2024-06-07 08:43:21'),
(59, 'logged out', 2, '2024-06-07 08:43:25'),
(60, 'logged in', 1, '2024-06-12 22:42:39'),
(61, 'printed Promoted Student List of 2016-2017', 1, '2024-06-12 22:44:10'),
(62, 'printed aerial seyf permanent record', 1, '2024-06-12 22:46:01'),
(63, 'printed Promoted Student List of 2016-2017', 1, '2024-06-12 22:49:07'),
(64, 'printed aerial seyf permanent record', 1, '2024-06-12 22:55:31'),
(65, 'logged out', 1, '2024-06-12 22:58:46'),
(66, 'logged in', 2, '2024-06-12 22:59:02'),
(67, 'updated 1 in the curriculum list', 0, '2024-06-12 22:59:40'),
(68, 'updated 1 in the curriculum list', 0, '2024-06-12 22:59:40'),
(69, 'logged out', 2, '2024-06-12 23:23:17'),
(70, 'logged in', 1, '2024-06-12 23:23:25'),
(71, 'logged in', 1, '2024-06-13 01:31:50'),
(72, 'logged in', 1, '2024-06-13 01:50:58'),
(73, 'logged in', 1, '2024-06-13 02:04:36'),
(74, 'logged in', 1, '2024-06-15 21:30:46'),
(75, 'logged in', 1, '2024-06-15 21:44:41'),
(76, 'logged in', 1, '2024-06-15 23:44:36'),
(77, 'logged in', 1, '2024-06-16 01:27:10');

-- --------------------------------------------------------

--
-- Table structure for table `program`
--

CREATE TABLE `program` (
  `PROGRAM_ID` int(20) NOT NULL,
  `PROGRAM` varchar(10) NOT NULL,
  `DESCRIPTION` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `program`
--

INSERT INTO `program` (`PROGRAM_ID`, `PROGRAM`, `DESCRIPTION`) VALUES
(1, 'Regular', 'Regular');

-- --------------------------------------------------------

--
-- Table structure for table `promotion_candidates`
--

CREATE TABLE `promotion_candidates` (
  `id` int(10) NOT NULL,
  `STUDENT_ID` int(10) NOT NULL,
  `SY` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `promotion_candidates`
--

INSERT INTO `promotion_candidates` (`id`, `STUDENT_ID`, `SY`) VALUES
(1, 1, '2016-2017');

-- --------------------------------------------------------

--
-- Table structure for table `school_year`
--

CREATE TABLE `school_year` (
  `SY_ID` int(10) NOT NULL,
  `school_year` varchar(10) NOT NULL,
  `status` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `school_year`
--

INSERT INTO `school_year` (`SY_ID`, `school_year`, `status`) VALUES
(1, '2022-2023', 'No'),
(2, '2023-2024', 'Yes'),
(3, '2021-2022', 'No'),
(4, '2019-2020', 'No');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `STUDENT_ID` int(50) NOT NULL,
  `LRN_NO` int(12) NOT NULL,
  `LASTNAME` varchar(30) NOT NULL,
  `FIRSTNAME` varchar(30) NOT NULL,
  `MIDDLENAME` varchar(30) NOT NULL,
  `GENDER` varchar(10) NOT NULL,
  `DATE_OF_BIRTH` date NOT NULL,
  `STREET` varchar(30) NOT NULL,
  `PROVINCE` varchar(30) NOT NULL,
  `TOWN` varchar(30) NOT NULL,
  `BRGY` varchar(30) NOT NULL,
  `PARENT_GUARDIAN` varchar(50) NOT NULL,
  `P_ADDRESS` varchar(60) NOT NULL,
  `INT_COURSE_COMP` varchar(50) NOT NULL,
  `SCHOOL_YEAR` varchar(10) NOT NULL,
  `GEN_AVE` int(6) NOT NULL,
  `TOTAL_NO_OF_YEAR` int(5) NOT NULL,
  `PROGRAM` varchar(20) NOT NULL,
  `BIRTH_PLACE` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student_info`
--

CREATE TABLE `student_info` (
  `STUDENT_ID` int(50) NOT NULL,
  `LRN_NO` varchar(15) NOT NULL,
  `LASTNAME` varchar(30) NOT NULL,
  `FIRSTNAME` varchar(30) NOT NULL,
  `MIDDLENAME` varchar(30) NOT NULL,
  `GENDER` varchar(10) NOT NULL,
  `DATE_OF_BIRTH` date NOT NULL,
  `ADDRESS` varchar(20) NOT NULL,
  `BIRTH_PLACE` varchar(50) NOT NULL,
  `PARENT_GUARDIAN` varchar(50) NOT NULL,
  `P_ADDRESS` varchar(60) NOT NULL,
  `INT_COURSE_COMP` varchar(50) NOT NULL,
  `SCHOOL_YEAR` varchar(10) NOT NULL,
  `GEN_AVE` varchar(6) NOT NULL,
  `TOTAL_NO_OF_YEARS` varchar(5) NOT NULL,
  `PROGRAM` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `student_info`
--

INSERT INTO `student_info` (`STUDENT_ID`, `LRN_NO`, `LASTNAME`, `FIRSTNAME`, `MIDDLENAME`, `GENDER`, `DATE_OF_BIRTH`, `ADDRESS`, `BIRTH_PLACE`, `PARENT_GUARDIAN`, `P_ADDRESS`, `INT_COURSE_COMP`, `SCHOOL_YEAR`, `GEN_AVE`, `TOTAL_NO_OF_YEARS`, `PROGRAM`) VALUES
(1, '12345648', 'Smith', 'John', 'C', 'MALE', '1999-06-23', 'Sample', 'My Town', 'My guardian', 'Sample', 'Sample', '2015-2016', '95', '6', '1'),
(2, '1234050', 'seyf', 'aerial', 'cab', 'FEMALE', '2005-12-08', 'mangaldan,pangasinan', 'Dagupan', 'nelson muyano', 'Mangaldan,Pangasinan', 'College', '2023-2024', '90', '6', '1');

-- --------------------------------------------------------

--
-- Table structure for table `student_int_info`
--

CREATE TABLE `student_int_info` (
  `ID` int(30) NOT NULL,
  `STUDENT_ID` varchar(30) NOT NULL,
  `INT_COURSE_COMP` varchar(50) NOT NULL,
  `SCHOOL_YEAR_START` year(4) NOT NULL,
  `SCHOOL_YEAR_ENDS` year(4) NOT NULL,
  `GEN_AVE` int(5) NOT NULL,
  `TOTAL_NO_YEARS` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student_year_info`
--

CREATE TABLE `student_year_info` (
  `SYI_ID` int(11) NOT NULL,
  `STUDENT_ID` int(30) NOT NULL,
  `SCHOOL` varchar(100) NOT NULL,
  `YEAR` varchar(15) NOT NULL,
  `SECTION` varchar(10) NOT NULL,
  `TOTAL_NO_OF_YEAR` int(5) NOT NULL,
  `SCHOOL_YEAR` varchar(10) NOT NULL,
  `ADVANCE_UNIT` varchar(10) NOT NULL,
  `LACK_UNIT` varchar(10) NOT NULL,
  `ADVISER` varchar(40) NOT NULL,
  `GEN_AVE` varchar(10) NOT NULL,
  `RANK` varchar(10) NOT NULL,
  `TO_BE_CLASSIFIED` varchar(10) NOT NULL,
  `TDAYS_OF_CLASSES` int(5) NOT NULL,
  `TDAYS_PRESENT` int(5) NOT NULL,
  `ACTION` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `student_year_info`
--

INSERT INTO `student_year_info` (`SYI_ID`, `STUDENT_ID`, `SCHOOL`, `YEAR`, `SECTION`, `TOTAL_NO_OF_YEAR`, `SCHOOL_YEAR`, `ADVANCE_UNIT`, `LACK_UNIT`, `ADVISER`, `GEN_AVE`, `RANK`, `TO_BE_CLASSIFIED`, `TDAYS_OF_CLASSES`, `TDAYS_PRESENT`, `ACTION`) VALUES
(1, 1, 'School', '1', 'A', 7, '2016-2017', '', '', '', '90', '', 'Grade 8', 120, 120, 'Promoted'),
(2, 1, 'School', '2', 'a', 8, '2017-2018', '', '', '', '88.125', '', '', 0, 0, 'Promoted'),
(3, 2, 'School', '1', '1', 7, '2017-2018', '', '', 'Cabansag, Rina', '0', '', '', 263, 213, 'Promoted');

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `SUBJECT_ID` int(11) NOT NULL,
  `SUBJECT` varchar(50) NOT NULL,
  `FOR` varchar(10) NOT NULL,
  `DESCRIPTION` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`SUBJECT_ID`, `SUBJECT`, `FOR`, `DESCRIPTION`) VALUES
(1, 'English', 'All', 'English'),
(2, 'Math', 'All', 'Math');

-- --------------------------------------------------------

--
-- Table structure for table `total_grades_subjects`
--

CREATE TABLE `total_grades_subjects` (
  `TGS_ID` int(30) NOT NULL,
  `STUDENT_ID` int(30) NOT NULL,
  `SYI_ID` int(30) NOT NULL,
  `SUBJECT` int(20) NOT NULL,
  `1ST_GRADING` varchar(10) NOT NULL,
  `2ND_GRADING` varchar(10) NOT NULL,
  `3RD_GRADING` varchar(10) NOT NULL,
  `4TH_GRADING` varchar(10) NOT NULL,
  `UNITS` varchar(10) NOT NULL,
  `FINAL_GRADES` varchar(10) NOT NULL,
  `PASSED_FAILED` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `total_grades_subjects`
--

INSERT INTO `total_grades_subjects` (`TGS_ID`, `STUDENT_ID`, `SYI_ID`, `SUBJECT`, `1ST_GRADING`, `2ND_GRADING`, `3RD_GRADING`, `4TH_GRADING`, `UNITS`, `FINAL_GRADES`, `PASSED_FAILED`) VALUES
(1, 1, 1, 1, '90', '90', '90', '90', '1', '90.00', 'PASSED'),
(2, 1, 1, 2, '90', '90', '90', '90', '1', '90.00', 'PASSED'),
(3, 1, 2, 1, '90', '90', '90', '90', '1', '90.00', 'PASSED'),
(4, 1, 2, 2, '85', '88', '87', '85', '1', '86.25', 'PASSED'),
(5, 2, 3, 1, '90', '85', '90', '88', '3', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `USER_ID` int(11) NOT NULL,
  `LASTNAME` varchar(30) NOT NULL,
  `FIRSTNAME` varchar(30) NOT NULL,
  `USER` varchar(10) NOT NULL,
  `PASSWORD` text NOT NULL,
  `USER_TYPE` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`USER_ID`, `LASTNAME`, `FIRSTNAME`, `USER`, `PASSWORD`, `USER_TYPE`) VALUES
(1, 'admin', 'admin', 'admin', '0192023a7bbd73250516f069df18b500', 'ADMINISTRATOR'),
(2, 'staff', 'staff', 'staff', 'de9bf5643eabf80f4a56fda3bbb84483', 'STAFF');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `advisers`
--
ALTER TABLE `advisers`
  ADD PRIMARY KEY (`adviser_id`);

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`ATT_ID`);

--
-- Indexes for table `data_b`
--
ALTER TABLE `data_b`
  ADD PRIMARY KEY (`db_id`);

--
-- Indexes for table `data_base`
--
ALTER TABLE `data_base`
  ADD PRIMARY KEY (`db_id`);

--
-- Indexes for table `grade`
--
ALTER TABLE `grade`
  ADD PRIMARY KEY (`grade_id`);

--
-- Indexes for table `grades_per_subject`
--
ALTER TABLE `grades_per_subject`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `history_log`
--
ALTER TABLE `history_log`
  ADD PRIMARY KEY (`log_id`);

--
-- Indexes for table `program`
--
ALTER TABLE `program`
  ADD PRIMARY KEY (`PROGRAM_ID`);

--
-- Indexes for table `promotion_candidates`
--
ALTER TABLE `promotion_candidates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `school_year`
--
ALTER TABLE `school_year`
  ADD PRIMARY KEY (`SY_ID`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`STUDENT_ID`);

--
-- Indexes for table `student_info`
--
ALTER TABLE `student_info`
  ADD PRIMARY KEY (`STUDENT_ID`);

--
-- Indexes for table `student_int_info`
--
ALTER TABLE `student_int_info`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `student_year_info`
--
ALTER TABLE `student_year_info`
  ADD PRIMARY KEY (`SYI_ID`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`SUBJECT_ID`);

--
-- Indexes for table `total_grades_subjects`
--
ALTER TABLE `total_grades_subjects`
  ADD PRIMARY KEY (`TGS_ID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`USER_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `advisers`
--
ALTER TABLE `advisers`
  MODIFY `adviser_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `ATT_ID` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `data_b`
--
ALTER TABLE `data_b`
  MODIFY `db_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `data_base`
--
ALTER TABLE `data_base`
  MODIFY `db_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `grade`
--
ALTER TABLE `grade`
  MODIFY `grade_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `grades_per_subject`
--
ALTER TABLE `grades_per_subject`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `history_log`
--
ALTER TABLE `history_log`
  MODIFY `log_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT for table `program`
--
ALTER TABLE `program`
  MODIFY `PROGRAM_ID` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `promotion_candidates`
--
ALTER TABLE `promotion_candidates`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `school_year`
--
ALTER TABLE `school_year`
  MODIFY `SY_ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `STUDENT_ID` int(50) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student_info`
--
ALTER TABLE `student_info`
  MODIFY `STUDENT_ID` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `student_int_info`
--
ALTER TABLE `student_int_info`
  MODIFY `ID` int(30) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student_year_info`
--
ALTER TABLE `student_year_info`
  MODIFY `SYI_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `subjects`
--
ALTER TABLE `subjects`
  MODIFY `SUBJECT_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `total_grades_subjects`
--
ALTER TABLE `total_grades_subjects`
  MODIFY `TGS_ID` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `USER_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- Database: `ims_db`
--
CREATE DATABASE IF NOT EXISTS `ims_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `ims_db`;

-- --------------------------------------------------------

--
-- Table structure for table `ims_brand`
--

CREATE TABLE `ims_brand` (
  `id` int(11) NOT NULL,
  `categoryid` int(11) NOT NULL,
  `bname` varchar(250) NOT NULL,
  `status` enum('active','inactive') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `ims_brand`
--

INSERT INTO `ims_brand` (`id`, `categoryid`, `bname`, `status`) VALUES
(1, 2, 'hubbybyte', 'active'),
(2, 2, 'Bandai', 'active'),
(3, 2, 'Pop-up parade', 'active'),
(4, 1, 'ichiban kuji', 'active'),
(5, 1, 'rakuten', 'active'),
(6, 1, 'offbrand', 'active'),
(7, 3, 'Gunpla', 'active'),
(8, 3, 'otaku', 'active'),
(9, 3, 'Nikke', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `ims_category`
--

CREATE TABLE `ims_category` (
  `categoryid` int(11) NOT NULL,
  `name` varchar(250) NOT NULL,
  `status` enum('active','inactive') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `ims_category`
--

INSERT INTO `ims_category` (`categoryid`, `name`, `status`) VALUES
(0, 'motor', 'active'),
(1, 'Figurines', 'active'),
(2, 'Phone', 'active'),
(3, 'Limited Merch', 'active'),
(4, 'Manga', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `ims_customer`
--

CREATE TABLE `ims_customer` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `address` text NOT NULL,
  `mobile` varchar(15) NOT NULL,
  `Amount` double(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `ims_customer`
--

INSERT INTO `ims_customer` (`id`, `name`, `address`, `mobile`, `Amount`) VALUES
(1, 'Ieson Louis C.', 'Sample Address', '63947483647', 25000.00),
(2, 'Seyfert', 'Mangaldan Pangasinan', '63947483647', 35000.00);

-- --------------------------------------------------------

--
-- Table structure for table `ims_order`
--

CREATE TABLE `ims_order` (
  `order_id` int(11) NOT NULL,
  `product_id` varchar(255) NOT NULL,
  `total_shipped` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `ims_order`
--

INSERT INTO `ims_order` (`order_id`, `product_id`, `total_shipped`, `customer_id`, `order_date`) VALUES
(1, '1', 5, 1, '2022-06-20 08:20:40'),
(2, '2', 3, 2, '2022-06-20 08:20:48');

-- --------------------------------------------------------

--
-- Table structure for table `ims_product`
--

CREATE TABLE `ims_product` (
  `pid` int(11) NOT NULL,
  `categoryid` int(11) NOT NULL,
  `brandid` int(11) NOT NULL,
  `pname` varchar(300) NOT NULL,
  `model` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit` varchar(150) NOT NULL,
  `base_price` double(10,2) NOT NULL,
  `tax` decimal(4,2) NOT NULL,
  `minimum_order` double(10,2) NOT NULL,
  `supplier` int(11) NOT NULL,
  `status` enum('active','inactive') NOT NULL,
  `date` date NOT NULL,
  `image` varchar(255) NOT NULL DEFAULT 'imageNotAvailable.jpg'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ims_product`
--

INSERT INTO `ims_product` (`pid`, `categoryid`, `brandid`, `pname`, `model`, `description`, `quantity`, `unit`, `base_price`, `tax`, `minimum_order`, `supplier`, `status`, `date`, `image`) VALUES
(2, 1, 4, 'Gintama', 'P-1002', 'ANIME MERCH', 15, 'Box', 7500.00, 12.00, 1.00, 2, 'active', '0000-00-00', 'Illustration5.png'),
(3, 3, 7, 'K-on', 'P-1003', 'ANIME MERCH', 20, 'Bags', 350.00, 12.00, 1.00, 3, 'active', '0000-00-00', 'hitoribocchi1.png'),
(1, 2, 1, 'One-Piece', 'P-1001', 'usce auctor faucibus efficitur.', 10, 'Bottles', 500.00, 12.00, 1.00, 1, 'active', '0000-00-00', 'pa-san2.png'),
(4, 2, 1, 'One-Piece', 'P-1001', 'ANIME MERCH', 10, 'Bags', 500.00, 12.00, 1.00, 1, 'active', '0000-00-00', 'Andy.png'),
(0, 1, 4, 'K-on', 'P-1003', '123', 20, 'Bags', 350.00, 12.00, 1.00, 1, 'active', '0000-00-00', 'imageNotAvailable.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `ims_purchase`
--

CREATE TABLE `ims_purchase` (
  `purchase_id` int(11) NOT NULL,
  `supplier_id` varchar(255) NOT NULL,
  `product_id` varchar(255) NOT NULL,
  `quantity` varchar(255) NOT NULL,
  `purchase_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `ims_purchase`
--

INSERT INTO `ims_purchase` (`purchase_id`, `supplier_id`, `product_id`, `quantity`, `purchase_date`) VALUES
(1, '1', '1', '25', '2022-06-20 08:20:07'),
(2, '2', '2', '35', '2022-06-20 08:20:14'),
(3, '3', '3', '10', '2022-06-20 08:20:29'),
(0, '3', '2', '123', '2024-05-09 16:47:28');

-- --------------------------------------------------------

--
-- Table structure for table `ims_supplier`
--

CREATE TABLE `ims_supplier` (
  `supplier_id` int(11) NOT NULL,
  `supplier_name` varchar(200) NOT NULL,
  `mobile` varchar(50) NOT NULL,
  `address` text NOT NULL,
  `status` enum('active','inactive') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `ims_supplier`
--

INSERT INTO `ims_supplier` (`supplier_id`, `supplier_name`, `mobile`, `address`, `status`) VALUES
(1, 'Supplier 101', '09645987123', 'Over Here', 'active'),
(2, 'Supplier 102', '094568791252', 'Over There', 'active'),
(3, 'Supplier 103', '09789897879', 'Anywhere There', 'active');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ims_category`
--
ALTER TABLE `ims_category`
  ADD PRIMARY KEY (`categoryid`);

--
-- Indexes for table `ims_customer`
--
ALTER TABLE `ims_customer`
  ADD PRIMARY KEY (`id`);
--
-- Database: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Table structure for table `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(10) UNSIGNED NOT NULL,
  `dbase` varchar(255) NOT NULL DEFAULT '',
  `user` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `query` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Table structure for table `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) NOT NULL,
  `col_name` varchar(64) NOT NULL,
  `col_type` varchar(64) NOT NULL,
  `col_length` text DEFAULT NULL,
  `col_collation` varchar(64) NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) DEFAULT '',
  `col_default` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

--
-- Dumping data for table `pma__central_columns`
--

INSERT INTO `pma__central_columns` (`db_name`, `col_name`, `col_type`, `col_length`, `col_collation`, `col_isNull`, `col_extra`, `col_default`) VALUES
('shop_inventory', 'description', 'text', '', 'latin1_swedish_ci', 0, ',', '');

-- --------------------------------------------------------

--
-- Table structure for table `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `column_name` varchar(64) NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) NOT NULL DEFAULT '',
  `transformation_options` varchar(255) NOT NULL DEFAULT '',
  `input_transformation` varchar(255) NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) NOT NULL,
  `settings_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

-- --------------------------------------------------------

--
-- Table structure for table `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL,
  `export_type` varchar(10) NOT NULL,
  `template_name` varchar(64) NOT NULL,
  `template_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

-- --------------------------------------------------------

--
-- Table structure for table `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Table structure for table `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db` varchar(64) NOT NULL DEFAULT '',
  `table` varchar(64) NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `item_type` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Table structure for table `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

--
-- Dumping data for table `pma__recent`
--

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('root', '[{\"db\":\"grading_db\",\"table\":\"student_info\"},{\"db\":\"resultgrading\",\"table\":\"tblstudent\"},{\"db\":\"resultgrading\",\"table\":\"tblfinalresult\"},{\"db\":\"resultgrading\",\"table\":\"tblfaculty\"},{\"db\":\"resultgrading\",\"table\":\"tbldepartment\"},{\"db\":\"resultgrading\",\"table\":\"tblcourse\"},{\"db\":\"resultgrading\",\"table\":\"tblcgparesult\"},{\"db\":\"resultgrading\",\"table\":\"tblassignedadmin\"},{\"db\":\"resultgrading\",\"table\":\"tblstaff\"},{\"db\":\"grading_db\",\"table\":\"student_int_info\"}]');

-- --------------------------------------------------------

--
-- Table structure for table `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) NOT NULL DEFAULT '',
  `master_table` varchar(64) NOT NULL DEFAULT '',
  `master_field` varchar(64) NOT NULL DEFAULT '',
  `foreign_db` varchar(64) NOT NULL DEFAULT '',
  `foreign_table` varchar(64) NOT NULL DEFAULT '',
  `foreign_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Table structure for table `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `search_name` varchar(64) NOT NULL DEFAULT '',
  `search_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float UNSIGNED NOT NULL DEFAULT 0,
  `y` float UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `display_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `prefs` text NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

--
-- Dumping data for table `pma__table_uiprefs`
--

INSERT INTO `pma__table_uiprefs` (`username`, `db_name`, `table_name`, `prefs`, `last_update`) VALUES
('root', 'ims_db', 'ims_product', '{\"sorted_col\":\"`ims_product`.`image` DESC\"}', '2024-05-12 15:25:34'),
('root', 'shop_inventory', 'item', '{\"sorted_col\":\"`item`.`description` ASC\"}', '2024-05-05 19:06:01'),
('root', 'shop_inventory', 'sale', '{\"CREATE_TIME\":\"2024-04-21 14:15:12\",\"col_order\":[1,0,2,3,4,5,6,7,8],\"col_visib\":[1,1,1,1,1,1,1,1,1]}', '2024-05-05 17:56:02'),
('root', 'shop_inventory', 'vendor', '{\"sorted_col\":\"`vendor`.`address2` DESC\"}', '2024-05-05 17:52:46');

-- --------------------------------------------------------

--
-- Table structure for table `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text NOT NULL,
  `schema_sql` text DEFAULT NULL,
  `data_sql` longtext DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Dumping data for table `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2024-06-05 10:06:51', '{\"Console\\/Mode\":\"collapse\",\"Server\\/hide_db\":\"\",\"Server\\/only_db\":\"\"}');

-- --------------------------------------------------------

--
-- Table structure for table `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) NOT NULL,
  `tab` varchar(64) NOT NULL,
  `allowed` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Table structure for table `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) NOT NULL,
  `usergroup` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indexes for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indexes for table `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indexes for table `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indexes for table `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indexes for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indexes for table `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indexes for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indexes for table `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indexes for table `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indexes for table `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indexes for table `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indexes for table `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indexes for table `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Database: `products`
--
CREATE DATABASE IF NOT EXISTS `products` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `products`;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `category` varchar(100) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `category`, `price`, `quantity`) VALUES
(1, 'Laptop', 'Electronics', 999.99, 10),
(2, 'T-shirt', 'Clothing', 19.99, 50),
(3, 'Headphones', 'Electronics', 49.99, 30),
(4, 'Book', 'Books', 12.50, 100),
(5, 'Sneakers', 'Footwear', 79.99, 20),
(6, '', '', 0.00, 0);

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `supplier_id` int(11) NOT NULL,
  `supplier_name` varchar(255) NOT NULL,
  `contact_email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`supplier_id`, `supplier_name`, `contact_email`) VALUES
(1, 'Supplier 1', 'supplier1@example.com'),
(2, 'Supplier 2', 'supplier2@example.com'),
(3, 'Supplier 3', 'supplier3@example.com'),
(4, 'Supplier 4', 'supplier4@example.com'),
(5, 'Supplier 5', 'supplier5@example.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`supplier_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `supplier_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- Database: `regis`
--
CREATE DATABASE IF NOT EXISTS `regis` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `regis`;

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `cart_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `cart_qty` int(11) NOT NULL,
  `cart_stock_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `cart_uniqid` varchar(35) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expired`
--

CREATE TABLE `expired` (
  `exp_id` int(11) NOT NULL,
  `exp_itemName` varchar(50) NOT NULL,
  `exp_itemPrice` float NOT NULL,
  `exp_itemQty` int(11) NOT NULL,
  `exp_expiredDate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `expired`
--

INSERT INTO `expired` (`exp_id`, `exp_itemName`, `exp_itemPrice`, `exp_itemQty`, `exp_expiredDate`) VALUES
(1, 'haha', 5.6, 7, '2017-08-18'),
(2, 'haha', 5.6, 12, '2017-03-23'),
(3, 'sipons', 3.5, 3, '2017-03-31'),
(4, '111', 7.5, 34, '2017-04-14'),
(5, '111', 7.5, 13, '2017-04-21'),
(6, 'haha', 5.6, 23, '2017-04-12'),
(7, 'sipons', 3.5, 123, '2017-04-08'),
(8, '111', 7.5, 123, '2017-04-08'),
(9, '111', 7.5, 23, '2017-05-04');

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

CREATE TABLE `item` (
  `item_id` int(11) NOT NULL,
  `item_name` varchar(50) NOT NULL,
  `item_price` double NOT NULL,
  `item_type_id` int(11) NOT NULL,
  `item_code` varchar(35) NOT NULL,
  `item_brand` varchar(50) NOT NULL,
  `item_grams` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `item`
--

INSERT INTO `item` (`item_id`, `item_name`, `item_price`, `item_type_id`, `item_code`, `item_brand`, `item_grams`) VALUES
(1, 'sipons', 3.5, 1, '131313', 'Brand Ni Siya', '500ml'),
(2, 'haha', 5.6, 2, '12321', '12321321', '1232213'),
(3, '11112', 9.54, 1, '111', '111', '11'),
(4, 'Lala', 15, 2, '12321', '12321321', '1232213'),
(5, '111124', 9.2354, 1, '111', '111', '11'),
(6, '1111246', 9.2354, 1, '111as', '111', '11'),
(7, '111', 54000, 1, '12', '45', '8787');

-- --------------------------------------------------------

--
-- Table structure for table `item_type`
--

CREATE TABLE `item_type` (
  `item_type_id` int(11) NOT NULL,
  `item_type_desc` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `item_type`
--

INSERT INTO `item_type` (`item_type_id`, `item_type_desc`) VALUES
(1, 'Tablet'),
(2, 'Syrup'),
(3, 'Test');

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `sales_id` int(11) NOT NULL,
  `item_code` varchar(35) NOT NULL,
  `generic_name` varchar(35) NOT NULL,
  `brand` varchar(35) NOT NULL,
  `gram` varchar(35) NOT NULL,
  `type` varchar(35) NOT NULL,
  `qty` int(11) NOT NULL,
  `price` float NOT NULL,
  `date_sold` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`sales_id`, `item_code`, `generic_name`, `brand`, `gram`, `type`, `qty`, `price`, `date_sold`) VALUES
(1, '131313', 'sipons', 'Brand Ni Siya', '500ml', 'Tablet', 4, 3.5, '2017-03-22 22:03:36'),
(2, '12321', 'haha', '12321321', '1232213', 'Syrup', 2, 5.6, '2017-03-22 22:03:36'),
(3, '131313', 'sipons', 'Brand Ni Siya', '500ml', 'Tablet', 3, 3.5, '2017-03-22 22:07:38'),
(4, '131313', 'sipons', 'Brand Ni Siya', '500ml', 'Tablet', 1, 3.5, '2017-03-22 22:08:09'),
(5, '12321', 'haha', '12321321', '1232213', 'Syrup', 2, 5.6, '2017-03-22 22:08:09'),
(6, '12321', 'haha', '12321321', '1232213', 'Syrup', 1, 5.6, '2017-03-22 22:09:47'),
(7, '12321', 'haha', '12321321', '1232213', 'Syrup', 1, 5.6, '2017-03-22 22:09:47'),
(8, '131313', 'sipons', 'Brand Ni Siya', '500ml', 'Tablet', 1, 3.5, '2017-03-22 22:09:47'),
(9, '131313', 'sipons', 'Brand Ni Siya', '500ml', 'Tablet', 2, 3.5, '2017-03-22 22:10:11'),
(10, '12321', 'haha', '12321321', '1232213', 'Syrup', 1, 5.6, '2017-03-22 22:10:11'),
(11, '12321', 'Lala', '12321321', '1232213', 'Syrup', 1, 15, '2017-03-28 07:04:50'),
(12, '111', '11112', '111', '11', 'Tablet', 2, 9.54, '2024-04-29 04:00:42'),
(13, '111', '11112', '111', '11', 'Tablet', 12, 9.54, '2024-05-27 14:19:14');

-- --------------------------------------------------------

--
-- Table structure for table `stock`
--

CREATE TABLE `stock` (
  `stock_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `stock_qty` int(11) NOT NULL,
  `stock_expiry` date NOT NULL,
  `stock_added` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `stock_manufactured` date NOT NULL,
  `stock_purchased` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `stock`
--

INSERT INTO `stock` (`stock_id`, `item_id`, `stock_qty`, `stock_expiry`, `stock_added`, `stock_manufactured`, `stock_purchased`) VALUES
(7, 3, 9, '2017-04-22', '2024-05-27 14:19:08', '2017-04-20', '2017-04-14');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `user_account` varchar(50) NOT NULL,
  `user_pass` varchar(35) NOT NULL,
  `user_type` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `user_account`, `user_pass`, `user_type`) VALUES
(1, 'admin', '21232f297a57a5a743894a0e4a801fc3', 1),
(2, 'admin2', '21232f297a57a5a743894a0e4a801fc3', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `expired`
--
ALTER TABLE `expired`
  ADD PRIMARY KEY (`exp_id`);

--
-- Indexes for table `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `item_type_id` (`item_type_id`);

--
-- Indexes for table `item_type`
--
ALTER TABLE `item_type`
  ADD PRIMARY KEY (`item_type_id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`sales_id`);

--
-- Indexes for table `stock`
--
ALTER TABLE `stock`
  ADD PRIMARY KEY (`stock_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `expired`
--
ALTER TABLE `expired`
  MODIFY `exp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `item`
--
ALTER TABLE `item`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `item_type`
--
ALTER TABLE `item_type`
  MODIFY `item_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `sales_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `stock`
--
ALTER TABLE `stock`
  MODIFY `stock_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`),
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `item`
--
ALTER TABLE `item`
  ADD CONSTRAINT `item_ibfk_1` FOREIGN KEY (`item_type_id`) REFERENCES `item_type` (`item_type_id`);

--
-- Constraints for table `stock`
--
ALTER TABLE `stock`
  ADD CONSTRAINT `stock_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`);
--
-- Database: `resultgrading`
--
CREATE DATABASE IF NOT EXISTS `resultgrading` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `resultgrading`;

-- --------------------------------------------------------

--
-- Table structure for table `tbladmin`
--

CREATE TABLE `tbladmin` (
  `Id` int(20) NOT NULL,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `otherName` varchar(255) NOT NULL,
  `emailAddress` varchar(255) NOT NULL,
  `phoneNo` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `staffId` varchar(255) NOT NULL,
  `adminTypeId` int(20) NOT NULL,
  `isAssigned` int(10) NOT NULL,
  `isPasswordChanged` int(10) NOT NULL,
  `dateCreated` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbladmin`
--

INSERT INTO `tbladmin` (`Id`, `firstName`, `lastName`, `otherName`, `emailAddress`, `phoneNo`, `password`, `staffId`, `adminTypeId`, `isAssigned`, `isPasswordChanged`, `dateCreated`) VALUES
(1, 'Liam', 'Moore', 'Admin', 'admin@mail.com', '7777777777', 'f2d0ff370380124029c2b807a924156c', 'AD123', 1, 1, 0, ''),
(2, 'asd', 'asd', 'asd', 'asd@mail.com', '8885554447', 'f2d0ff370380124029c2b807a924156c', '1121', 1, 1, 0, '2022-06-13'),
(3, 'Test', 'Admin', 'ta', 'test@mail.com', '4587458888', 'f2d0ff370380124029c2b807a924156c', 'TEST10', 1, 1, 0, '2022-06-13');

-- --------------------------------------------------------

--
-- Table structure for table `tbladmintype`
--

CREATE TABLE `tbladmintype` (
  `Id` int(20) NOT NULL,
  `adminTypeName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbladmintype`
--

INSERT INTO `tbladmintype` (`Id`, `adminTypeName`) VALUES
(1, 'Super Administrator'),
(2, 'Administrator');

-- --------------------------------------------------------

--
-- Table structure for table `tblassignedadmin`
--

CREATE TABLE `tblassignedadmin` (
  `id` int(11) NOT NULL,
  `dateAssigned` varchar(200) NOT NULL,
  `staffId` int(11) NOT NULL,
  `facultyId` int(11) NOT NULL,
  `departmentId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblassignedadmin`
--

INSERT INTO `tblassignedadmin` (`id`, `dateAssigned`, `staffId`, `facultyId`, `departmentId`) VALUES
(1, '2022-06-13', 0, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tblcgparesult`
--

CREATE TABLE `tblcgparesult` (
  `Id` int(11) NOT NULL,
  `matricNo` varchar(50) NOT NULL,
  `cgpa` varchar(50) NOT NULL,
  `classOfDiploma` varchar(50) NOT NULL,
  `dateAdded` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblcgparesult`
--

INSERT INTO `tblcgparesult` (`Id`, `matricNo`, `cgpa`, `classOfDiploma`, `dateAdded`) VALUES
(1, 'SGS100', '1.38', 'Fail', '2022-06-13'),
(2, '10101', '3.38', 'Upper Credit', '2022-06-15'),
(3, '14750', '3.35', 'Upper Credit', '2022-06-15'),
(4, 'SGS123', '3.49', 'Upper Credit', '2022-06-16');

-- --------------------------------------------------------

--
-- Table structure for table `tblcourse`
--

CREATE TABLE `tblcourse` (
  `Id` int(11) NOT NULL,
  `courseTitle` varchar(255) NOT NULL,
  `courseCode` varchar(255) NOT NULL,
  `courseUnit` int(10) NOT NULL,
  `facultyId` varchar(255) NOT NULL,
  `departmentId` varchar(255) NOT NULL,
  `levelId` varchar(10) NOT NULL,
  `semesterId` varchar(20) NOT NULL,
  `dateAdded` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblcourse`
--

INSERT INTO `tblcourse` (`Id`, `courseTitle`, `courseCode`, `courseUnit`, `facultyId`, `departmentId`, `levelId`, `semesterId`, `dateAdded`) VALUES
(1, 'Programming Intro', 'PI01', 5, '1', '1', '1', '1', '2022-06-13'),
(2, 'Networking', 'NT100', 5, '1', '1', '1', '2', '2022-06-13'),
(3, 'Law of Contract', 'LC1', 6, '3', '3', '1', '1', '2022-06-15'),
(4, 'Administrative Law', 'AL2', 6, '3', '3', '1', '2', '2022-06-15'),
(5, 'Constitutional Law', 'CL12', 6, '3', '3', '1', '1', '2022-06-15'),
(6, 'Law of Crimes', 'LC8', 5, '3', '3', '1', '2', '2022-06-15'),
(7, 'Labour and Industrial Law', 'LII8', 6, '3', '3', '1', '2', '2022-06-15'),
(8, 'Property Law', 'PLi5', 6, '3', '3', '1', '1', '2022-06-15'),
(9, 'Electrical Machines', 'EM12', 5, '4', '5', '1', '1', '2022-06-16'),
(10, 'Power Systems', 'PS77', 4, '4', '5', '1', '1', '2022-06-16'),
(11, 'Control Systems', 'CS69', 5, '4', '5', '1', '1', '2022-06-16'),
(12, 'Signals and Systems', 'SS88', 5, '4', '5', '1', '1', '2022-06-16'),
(13, 'Microprocessors', 'MCP8', 3, '4', '5', '1', '1', '2022-06-16'),
(14, 'Fundamentals of Computing', 'FC25', 5, '4', '5', '1', '2', '2022-06-16'),
(15, 'Mathematics II', 'MM895', 6, '4', '5', '1', '2', '2022-06-16'),
(16, 'Physics Laboratory', 'PL08', 3, '4', '5', '1', '2', '2022-06-16'),
(17, 'Physics II', 'P225', 5, '4', '5', '1', '2', '2022-06-16');

-- --------------------------------------------------------

--
-- Table structure for table `tbldepartment`
--

CREATE TABLE `tbldepartment` (
  `Id` int(20) NOT NULL,
  `departmentName` varchar(255) NOT NULL,
  `facultyId` int(20) NOT NULL,
  `dateCreated` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbldepartment`
--

INSERT INTO `tbldepartment` (`Id`, `departmentName`, `facultyId`, `dateCreated`) VALUES
(1, 'IT Dept', 1, '2022-06-13'),
(2, 'Accounting', 2, '2022-06-15'),
(3, 'Law Science', 3, '2022-06-15'),
(4, 'Industrial Engineering', 4, '2022-06-15'),
(5, 'Electrical Engineering', 4, '2022-06-15');

-- --------------------------------------------------------

--
-- Table structure for table `tblfaculty`
--

CREATE TABLE `tblfaculty` (
  `Id` int(20) NOT NULL,
  `facultyName` varchar(255) NOT NULL,
  `dateCreated` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblfaculty`
--

INSERT INTO `tblfaculty` (`Id`, `facultyName`, `dateCreated`) VALUES
(1, 'Faculty 1', '2022-06-13'),
(2, 'Faculty 2', '2022-06-15'),
(3, 'Faculty 3', '2022-06-15'),
(4, 'Faculty 4', '2022-06-15');

-- --------------------------------------------------------

--
-- Table structure for table `tblfinalresult`
--

CREATE TABLE `tblfinalresult` (
  `Id` int(10) NOT NULL,
  `matricNo` varchar(50) NOT NULL,
  `levelId` varchar(10) NOT NULL,
  `semesterId` varchar(10) NOT NULL,
  `sessionId` varchar(10) NOT NULL,
  `totalCourseUnit` varchar(10) NOT NULL,
  `totalScoreGradePoint` varchar(10) NOT NULL,
  `gpa` varchar(255) NOT NULL,
  `classOfDiploma` varchar(50) NOT NULL,
  `dateAdded` varchar(25) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblfinalresult`
--

INSERT INTO `tblfinalresult` (`Id`, `matricNo`, `levelId`, `semesterId`, `sessionId`, `totalCourseUnit`, `totalScoreGradePoint`, `gpa`, `classOfDiploma`, `dateAdded`) VALUES
(1, 'SGS100', '1', '1', '1', '5', '0', '0', 'Fail', '2022-06-13'),
(2, 'SGS100', '1', '2', '1', '5', '13.75', '2.75', 'Lower Credit', '2022-06-13'),
(3, '10101', '1', '1', '1', '5', '17.5', '3.5', 'Distinction', '2022-06-15'),
(4, '10101', '1', '2', '1', '5', '16.25', '3.25', 'Upper Credit', '2022-06-15'),
(5, '14750', '1', '1', '1', '18', '63', '3.5', 'Distinction', '2022-06-15'),
(6, '14750', '1', '2', '1', '17', '54.25', '3.19', 'Upper Credit', '2022-06-15'),
(7, 'SGS123', '1', '1', '1', '22', '81', '3.68', 'Distinction', '2022-06-16'),
(8, 'SGS123', '1', '2', '1', '19', '62.25', '3.28', 'Upper Credit', '2022-06-16');

-- --------------------------------------------------------

--
-- Table structure for table `tbllevel`
--

CREATE TABLE `tbllevel` (
  `Id` int(20) NOT NULL,
  `levelName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbllevel`
--

INSERT INTO `tbllevel` (`Id`, `levelName`) VALUES
(1, 'Level One'),
(2, 'Level Two');

-- --------------------------------------------------------

--
-- Table structure for table `tblresult`
--

CREATE TABLE `tblresult` (
  `Id` int(10) NOT NULL,
  `matricNo` varchar(50) NOT NULL,
  `levelId` varchar(10) NOT NULL,
  `semesterId` varchar(10) NOT NULL,
  `sessionId` varchar(10) NOT NULL,
  `courseCode` varchar(50) NOT NULL,
  `courseUnit` varchar(50) NOT NULL,
  `score` varchar(50) NOT NULL,
  `scoreGradePoint` varchar(50) NOT NULL,
  `scoreLetterGrade` varchar(10) NOT NULL,
  `totalScoreGradePoint` varchar(50) NOT NULL,
  `dateAdded` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblresult`
--

INSERT INTO `tblresult` (`Id`, `matricNo`, `levelId`, `semesterId`, `sessionId`, `courseCode`, `courseUnit`, `score`, `scoreGradePoint`, `scoreLetterGrade`, `totalScoreGradePoint`, `dateAdded`) VALUES
(1, 'SGS100', '1', '1', '1', 'PI01', '5', '30', '0', 'F', '0', '2022-06-13'),
(2, 'SGS100', '1', '2', '1', 'NT100', '5', '55', '2.75', 'BC', '13.75', '2022-06-13'),
(3, '10101', '1', '1', '1', 'PI01', '5', '72', '3.5', 'A', '17.5', '2022-06-15'),
(4, '10101', '1', '2', '1', 'NT100', '5', '68', '3.25', 'AB', '16.25', '2022-06-15'),
(5, '14750', '1', '1', '1', 'LC1', '6', '60', '3', 'B', '18', '2022-06-15'),
(6, '14750', '1', '1', '1', 'CL12', '6', '79', '4', 'AA', '24', '2022-06-15'),
(7, '14750', '1', '1', '1', 'PLi5', '6', '72', '3.5', 'A', '21', '2022-06-15'),
(8, '14750', '1', '2', '1', 'AL2', '6', '68', '3.25', 'AB', '19.5', '2022-06-15'),
(9, '14750', '1', '2', '1', 'LC8', '5', '57', '2.75', 'BC', '13.75', '2022-06-15'),
(10, '14750', '1', '2', '1', 'LII8', '6', '73', '3.5', 'A', '21', '2022-06-15'),
(11, 'SGS123', '1', '1', '1', 'EM12', '5', '63', '3', 'B', '15', '2022-06-16'),
(12, 'SGS123', '1', '1', '1', 'PS77', '4', '73', '3.5', 'A', '14', '2022-06-16'),
(13, 'SGS123', '1', '1', '1', 'CS69', '5', '80', '4', 'AA', '20', '2022-06-16'),
(14, 'SGS123', '1', '1', '1', 'SS88', '5', '82', '4', 'AA', '20', '2022-06-16'),
(15, 'SGS123', '1', '1', '1', 'MCP8', '3', '79', '4', 'AA', '12', '2022-06-16'),
(16, 'SGS123', '1', '2', '1', 'FC25', '5', '65', '3.25', 'AB', '16.25', '2022-06-16'),
(17, 'SGS123', '1', '2', '1', 'MM895', '6', '60', '3', 'B', '18', '2022-06-16'),
(18, 'SGS123', '1', '2', '1', 'PL08', '3', '72', '3.5', 'A', '10.5', '2022-06-16'),
(19, 'SGS123', '1', '2', '1', 'P225', '5', '74', '3.5', 'A', '17.5', '2022-06-16');

-- --------------------------------------------------------

--
-- Table structure for table `tblsemester`
--

CREATE TABLE `tblsemester` (
  `Id` int(20) NOT NULL,
  `semesterName` varchar(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblsemester`
--

INSERT INTO `tblsemester` (`Id`, `semesterName`) VALUES
(1, 'First Sem'),
(2, 'Second Sem');

-- --------------------------------------------------------

--
-- Table structure for table `tblsession`
--

CREATE TABLE `tblsession` (
  `Id` int(20) NOT NULL,
  `sessionName` varchar(30) NOT NULL,
  `isActive` int(5) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblsession`
--

INSERT INTO `tblsession` (`Id`, `sessionName`, `isActive`) VALUES
(1, '2022/2023', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tblstaff`
--

CREATE TABLE `tblstaff` (
  `Id` int(20) NOT NULL,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `otherName` varchar(255) NOT NULL,
  `emailAddress` varchar(255) NOT NULL,
  `phoneNo` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `staffId` varchar(255) NOT NULL,
  `isAssigned` int(10) NOT NULL,
  `isPasswordChanged` int(10) NOT NULL,
  `dateCreated` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblstaff`
--

INSERT INTO `tblstaff` (`Id`, `firstName`, `lastName`, `otherName`, `emailAddress`, `phoneNo`, `password`, `staffId`, `isAssigned`, `isPasswordChanged`, `dateCreated`) VALUES
(3, 'Bamidele', 'Bayo', 'olakunle', 'Bamidele@gmail.com', '07065903222', '12345', 'STF001111', 1, 0, '2020-06-21'),
(4, 'busola', 'keji', 'busayo', 'KemisolAde@gmail.com', '09073930022', '12345', 'STF002', 1, 0, '2020-06-21'),
(14, 'Samuel', 'Samuel', 'John', 'SamuelJohn@yahoo.com', '09087654321', '12345', 'STF0032', 1, 0, '2020-09-14'),
(15, 'asd', 'asd', 'asd', 'asd@asd.ccc', '5555666654', '12345', '444', 0, 0, '2022-06-15');

-- --------------------------------------------------------

--
-- Table structure for table `tblstudent`
--

CREATE TABLE `tblstudent` (
  `Id` int(20) NOT NULL,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `otherName` varchar(255) NOT NULL,
  `matricNo` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `levelId` int(10) NOT NULL,
  `facultyId` int(10) NOT NULL,
  `departmentId` int(10) NOT NULL,
  `sessionId` int(10) NOT NULL,
  `dateCreated` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblstudent`
--

INSERT INTO `tblstudent` (`Id`, `firstName`, `lastName`, `otherName`, `matricNo`, `password`, `levelId`, `facultyId`, `departmentId`, `sessionId`, `dateCreated`) VALUES
(17, 'Craig', 'Rodriguez', 'cr', 'SGS100', 'codeastro', 1, 1, 1, 1, '2022-06-13'),
(18, 'Edith', 'Beck', 'el', '10101', 'codeastro', 1, 1, 1, 1, '2022-06-15'),
(19, 'Chasity', 'Wilson', 'cw', '14750', 'codeastro', 1, 3, 3, 1, '2022-06-15'),
(20, 'Noel', 'Jacobs', 'nj', 'SGS123', 'codeastro', 1, 4, 5, 1, '2022-06-16'),
(21, 'Janet', 'Reyes', 'jjr', 'SGS124', 'codeastro', 1, 4, 5, 1, '2022-06-16'),
(22, 'Travis', 'Parton', 'ttp', 'SGS125', 'codeastro', 1, 4, 5, 1, '2022-06-16'),
(23, 'Colin', 'Farell', 'cff', 'SGS126', 'codeastro', 1, 4, 5, 1, '2022-06-16'),
(24, 'Peter', 'Falcone', 'pfr', 'SGS127', 'codeastro', 1, 4, 5, 1, '2022-06-16'),
(25, 'Zayn', 'Roberts', 'Zr', 'SGS128', 'codeastro', 1, 4, 5, 1, '2022-06-16'),
(26, 'Norman', 'Parbon', 'Nr', 'SGS129', 'codeastro', 1, 4, 4, 1, '2022-06-16'),
(27, 'Timothy', 'Herera', 'Th', 'SGS131', 'codeastro', 1, 2, 2, 1, '2022-06-16'),
(28, 'Nicholas', 'Ducc', 'Nd', 'SGS132', 'codeastro', 1, 3, 3, 1, '2022-06-16'),
(29, 'Joan', 'Havens', 'Jh', 'SGS133', 'codeastro', 1, 2, 2, 1, '2022-06-16');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbladmin`
--
ALTER TABLE `tbladmin`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `tbladmintype`
--
ALTER TABLE `tbladmintype`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `tblassignedadmin`
--
ALTER TABLE `tblassignedadmin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblcgparesult`
--
ALTER TABLE `tblcgparesult`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `tblcourse`
--
ALTER TABLE `tblcourse`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `tbldepartment`
--
ALTER TABLE `tbldepartment`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `tblfaculty`
--
ALTER TABLE `tblfaculty`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `tblfinalresult`
--
ALTER TABLE `tblfinalresult`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `tbllevel`
--
ALTER TABLE `tbllevel`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `tblresult`
--
ALTER TABLE `tblresult`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `tblsemester`
--
ALTER TABLE `tblsemester`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `tblsession`
--
ALTER TABLE `tblsession`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `tblstaff`
--
ALTER TABLE `tblstaff`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `tblstudent`
--
ALTER TABLE `tblstudent`
  ADD PRIMARY KEY (`Id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbladmin`
--
ALTER TABLE `tbladmin`
  MODIFY `Id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbladmintype`
--
ALTER TABLE `tbladmintype`
  MODIFY `Id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tblassignedadmin`
--
ALTER TABLE `tblassignedadmin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tblcgparesult`
--
ALTER TABLE `tblcgparesult`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tblcourse`
--
ALTER TABLE `tblcourse`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `tbldepartment`
--
ALTER TABLE `tbldepartment`
  MODIFY `Id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tblfaculty`
--
ALTER TABLE `tblfaculty`
  MODIFY `Id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tblfinalresult`
--
ALTER TABLE `tblfinalresult`
  MODIFY `Id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tbllevel`
--
ALTER TABLE `tbllevel`
  MODIFY `Id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tblresult`
--
ALTER TABLE `tblresult`
  MODIFY `Id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `tblsemester`
--
ALTER TABLE `tblsemester`
  MODIFY `Id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tblsession`
--
ALTER TABLE `tblsession`
  MODIFY `Id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tblstaff`
--
ALTER TABLE `tblstaff`
  MODIFY `Id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `tblstudent`
--
ALTER TABLE `tblstudent`
  MODIFY `Id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
--
-- Database: `sample`
--
CREATE DATABASE IF NOT EXISTS `sample` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `sample`;

-- --------------------------------------------------------

--
-- Table structure for table `dept`
--

CREATE TABLE `dept` (
  `deptno` int(4) NOT NULL,
  `dname` varchar(20) DEFAULT NULL,
  `loc` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dept`
--

INSERT INTO `dept` (`deptno`, `dname`, `loc`) VALUES
(1, 'Administrative', 'Dagupan'),
(2, 'Sales', 'Baguio'),
(3, 'Production', 'Tarlac');

-- --------------------------------------------------------

--
-- Table structure for table `emp`
--

CREATE TABLE `emp` (
  `empno` int(4) NOT NULL,
  `ename` varchar(20) DEFAULT NULL,
  `deptno` int(4) DEFAULT NULL,
  `sal` double DEFAULT NULL,
  `Mgr` int(4) DEFAULT NULL,
  `HireDate` date DEFAULT NULL,
  `Comm` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `emp`
--

INSERT INTO `emp` (`empno`, `ename`, `deptno`, `sal`, `Mgr`, `HireDate`, `Comm`) VALUES
(1, 'Dads', 1, 10000, NULL, '1990-06-07', NULL),
(2, 'Rhommelyn', 2, 8500, 1, '1992-06-08', NULL),
(3, 'Leny', 1, 9600, 1, '1992-07-06', NULL),
(4, 'Eudz', 3, 9740, 1, '1999-08-07', NULL),
(5, 'Arnold', 2, 7500, 2, '1995-07-06', 1000),
(6, 'Mark', 2, 7000, 2, '1996-08-09', 800),
(7, 'Jen', 3, 8700, 4, '1997-09-09', 900),
(8, 'Rose', 1, 8000, 3, '1991-08-08', 1200),
(9, 'Roland', 1, 6000, 3, '1995-09-10', 800),
(10, 'Peter', 3, 5000, 4, '1998-11-11', 560),
(11, 'Micah', 3, 4500, 4, '1994-12-12', 750),
(12, 'Karen', 2, 4600, 2, '1995-06-05', 500),
(13, 'Kim', 1, 4500, 3, '1997-04-28', 0),
(14, 'Rolly', 3, 5000, 4, '1997-05-28', 510),
(15, 'ieson', 2, 50000, 0, '1999-11-20', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dept`
--
ALTER TABLE `dept`
  ADD PRIMARY KEY (`deptno`);

--
-- Indexes for table `emp`
--
ALTER TABLE `emp`
  ADD PRIMARY KEY (`empno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `dept`
--
ALTER TABLE `dept`
  MODIFY `deptno` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `emp`
--
ALTER TABLE `emp`
  MODIFY `empno` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- Database: `sample1`
--
CREATE DATABASE IF NOT EXISTS `sample1` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `sample1`;

-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE `images` (
  `id` int(6) UNSIGNED NOT NULL,
  `file_name` varchar(100) NOT NULL,
  `file_path` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `images`
--
ALTER TABLE `images`
  MODIFY `id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Database: `shop_inventory`
--
CREATE DATABASE IF NOT EXISTS `shop_inventory` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `shop_inventory`;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customerID` int(11) NOT NULL,
  `fullName` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `mobile` int(11) NOT NULL,
  `phone2` int(11) DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `district` varchar(30) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'Active',
  `createdOn` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customerID`, `fullName`, `email`, `mobile`, `phone2`, `address`, `address2`, `city`, `district`, `status`, `createdOn`) VALUES
(4, 'Bill Gates', 'bill@microsoft.com', 993737, 772484884, '45, Palo Alto House, Marine Drive', 'South Carolina', 'Microsoft', 'Kurunegala', 'Active', '2018-04-30 15:14:02'),
(14, 'Steve Jobs', 'sjobs@apple.com', 333829832, 0, '1st Floor, Apple House, ', 'Las Vegas Street', 'Las Vegas', 'Monaragala', 'Disabled', '2018-05-01 12:03:10'),
(18, 'Asitha Silva', 'asitha@gmail.com', 777987654, 0, 'No. 3, Radcliff Avenue, School Lane', 'Kalutara South', 'Kalutara', 'Kalutara', 'Active', '2018-05-02 09:52:28'),
(24, 'Sunil Perera', 'Sunil@gypsies.sound', 338393932, 413837293, '67/7, Perera Villa, Jayasekara Avenue', 'Mount Lavinia', 'Ratmalana', 'Colombo', 'Active', '2018-05-02 10:48:37'),
(25, 'Theresa May', 'may34@uk.gov.com', 329393903, 777833737, '12, Downing Street', 'London', 'London', 'Matale', 'Active', '2018-05-03 02:28:07'),
(26, 'Sachin Tendulkar', 'sachintendulkar@icc.com', 444958303, 84792838, '789-4, Apartment 3, ', 'Cric Complex', 'New Delhi', 'Puttalam', 'Active', '2018-05-03 02:28:38'),
(38, 'Nuwan Perara', 'nuwan@yahoo.com', 839378202, 0, 'Nuwan Villa, Lower Street,', 'North Mulativu', 'Mullaitivu', 'Mullaitivu', 'Active', '2018-05-05 11:17:49'),
(39, 'Amal Silverton', 'amals452@yahoo.com', 232345676, 0, 'Amal\'s House, Amal\'s Street,', 'Amal Road', 'Ambalangoda', 'Galle', 'Active', '2018-05-05 13:27:06'),
(40, 'Andrew Symonds', 'symonds@cricket.au.com', 123, 0, '23, Oak View Avenue', 'Western Australia', 'Melbourne', 'Colombo', 'Disabled', '2018-05-13 01:20:23'),
(41, 'Mark Taylor', '', 111, 0, '111', '', '', 'Colombo', 'Active', '2018-05-13 01:24:54'),
(42, 'Nelson Mandela', 'sjobs@apple.com', 333829832, 0, '1st Floor, Apple House, ', 'Las Vegas Street', 'Las Vegas', 'Kalutara', 'Disabled', '2018-05-13 02:39:41');

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

CREATE TABLE `item` (
  `productID` int(11) NOT NULL,
  `itemNumber` varchar(255) NOT NULL,
  `itemName` varchar(255) NOT NULL,
  `discount` float NOT NULL DEFAULT 0,
  `stock` int(11) NOT NULL DEFAULT 0,
  `unitPrice` float NOT NULL DEFAULT 0,
  `imageURL` varchar(255) NOT NULL DEFAULT 'imageNotAvailable.jpg',
  `status` varchar(255) NOT NULL DEFAULT 'Active',
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `item`
--

INSERT INTO `item` (`productID`, `itemNumber`, `itemName`, `discount`, `stock`, `unitPrice`, `imageURL`, `status`, `description`) VALUES
(34, '1', 'First Bag', 0, 28, 1500, '1525670999_1.png', 'Active', ''),
(35, '2', 'School Bag', 0, 5, 500, '1525681111_661539.png', 'Active', ''),
(36, '3', 'Office Bag', 0, 5, 1300, '1525709924_office bag.jpg', 'Active', ''),
(37, '4', 'Leather Bag', 2, 6, 3409, '1525710010_leather bag.jpg', 'Active', ''),
(38, '5', 'Travel Bag', 2, 17, 1200, '1525706032_travel bag.jpg', 'Active', ''),
(39, '6', 'Gym Bag', 0, 0, 3000, '1525710463_gym bag.jpg', 'Active', ''),
(40, '7', 'Handbag', 1.5, 10, 1650, '1525713267_handbag.jpg', 'Active', ''),
(41, '8', 'Laptop Bag', 2.1, 9, 2300, '1525750683_661539.png', 'Active', ''),
(43, '10', 'Sports Bag', 1, 92, 1000, '1525756289_sports bag.jpg', 'Active', ''),
(45, '11', 'First Aid Bag', 1.5, 11, 1200, '1525787551_first aid bag.jpg', 'Active', ''),
(49, '14', 'Hiking Bag', 1.5, 6, 1200, '1526297640_hiking bag.jpg', 'Active', 'This is a hiking bag. Ideal for long distance hikes. Light-weight and water proof.'),
(50, '191', 'Dakimakura', 45, 500, 2000, '1718279418_20240606135251.png', 'Active', 'Pillow');

-- --------------------------------------------------------

--
-- Table structure for table `purchase`
--

CREATE TABLE `purchase` (
  `purchaseID` int(11) NOT NULL,
  `itemNumber` varchar(255) NOT NULL,
  `purchaseDate` date NOT NULL,
  `itemName` varchar(255) NOT NULL,
  `unitPrice` float NOT NULL DEFAULT 0,
  `quantity` int(11) NOT NULL DEFAULT 0,
  `vendorName` varchar(255) NOT NULL DEFAULT 'Test Vendor',
  `vendorID` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `purchase`
--

INSERT INTO `purchase` (`purchaseID`, `itemNumber`, `purchaseDate`, `itemName`, `unitPrice`, `quantity`, `vendorName`, `vendorID`) VALUES
(39, '1', '2018-05-24', 'First Bag', 1600, 10, 'Johnson and Johnsons Co.', 3),
(40, '2', '2018-05-18', 'First Bag', 2341, 2, 'Louise Vitton Bag', 4),
(41, '4', '2018-05-07', 'Leather Bag', 1234, 3, 'Johnson and Johnsons Co.', 3),
(42, '1', '2018-05-24', 'First Bag', 345, 12, 'Louise Vitton Bag', 4),
(43, '5', '2018-05-03', 'Travel Bag', 35, 3, 'Johnson and Johnsons Co.', 3),
(44, '5', '2018-05-16', 'Travel Bag', 3000, 2, 'ABC Company', 1),
(45, '5', '2018-05-21', 'Travel Bag', 3000, 10, 'Sample Vendor 222', 2),
(46, '4', '2018-05-19', 'Leather Bag', 1200, 4, 'Johnson and Johnsons Co.', 3),
(47, '2', '2018-05-10', 'School Bag', 2, 1, 'Sample Vendor 222', 2),
(48, '1', '2018-05-12', 'Handbag', 2, 9, 'ABC Company', 1),
(50, '14', '2018-05-15', 'Hiking Bag', 1000, 5, 'Louise Vitton Bag', 4),
(51, '11', '2018-05-11', 'First Aid Bag', 1121, 1, 'ABC Company', 1),
(52, '1', '2018-05-21', 'First Bag', 1235, 2, 'Sample Vendor 222', 2);

-- --------------------------------------------------------

--
-- Table structure for table `sale`
--

CREATE TABLE `sale` (
  `saleID` int(11) NOT NULL,
  `itemNumber` varchar(255) NOT NULL,
  `customerID` int(11) NOT NULL,
  `customerName` varchar(255) NOT NULL,
  `itemName` varchar(255) NOT NULL,
  `saleDate` date NOT NULL,
  `discount` float NOT NULL DEFAULT 0,
  `quantity` int(11) NOT NULL DEFAULT 0,
  `unitPrice` float(10,0) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `sale`
--

INSERT INTO `sale` (`saleID`, `itemNumber`, `customerID`, `customerName`, `itemName`, `saleDate`, `discount`, `quantity`, `unitPrice`) VALUES
(1, '3', 4, 'Bill Gates', 'Office Bag', '2018-05-24', 5, 2, 1300),
(2, '1', 39, 'Amal Silverton', 'First Bag', '2018-05-24', 0, 111, 1500),
(3, '4', 18, 'Asitha Silva', 'Leather Bag', '2018-05-24', 2, 1, 3409),
(4, '5', 25, 'Theresa May', 'Travel Bag', '2018-05-24', 2, 1, 1200),
(5, '6', 24, 'Sunil Perera', 'Gym Bag', '2018-05-24', 0, 1, 3000),
(6, '7', 14, 'Steve Jobs', 'Handbag', '2018-05-24', 1.5, 1, 1650),
(7, '3', 4, 'Bill Gates', 'Office Bag', '2018-05-24', 0, 3, 1300),
(8, '8', 4, 'Bill Gates', 'Laptop Bag', '2018-05-14', 2.1, 1, 2300),
(9, '6', 26, 'Sachin Tendulkar', 'Gym Bag', '2018-05-14', 0, 1, 3000),
(10, '5', 25, 'Theresa May', 'Travel Bag', '2018-05-14', 2, 9, 1200),
(11, '10', 26, 'Sachin Tendulkar', 'Sports Bag', '2018-04-05', 1, 7, 1000),
(12, '1', 14, 'Steve Jobs', 'First Bag', '2018-05-14', 0, 2, 1500),
(13, '3', 38, 'Nuwan Perara', 'Office Bag', '2018-05-24', 0, 0, 1300),
(14, '10', 39, 'Amal Silverton', 'Sports Bag', '2018-05-17', 1, 1, 1000),
(15, '14', 38, 'Nuwan Perara', 'Hiking Bag', '2018-05-24', 1.5, 1, 1200),
(16, '1', 14, 'Steve Jobs', 'First Bag', '2018-05-24', 10, 1, 1500),
(17, '4', 14, 'Steve Jobs', 'Leather Bag', '2018-05-18', 2, 1, 3409);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `userID` int(11) NOT NULL,
  `fullName` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'Active'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`userID`, `fullName`, `username`, `password`, `status`) VALUES
(5, 'Guest', 'guest', '81dc9bdb52d04dc20036dbd8313ed055', 'Active'),
(6, 'a', 'a', '0cc175b9c0f1b6a831c399e269772661', 'Active'),
(7, 'admin', 'admin', '21232f297a57a5a743894a0e4a801fc3', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `vendor`
--

CREATE TABLE `vendor` (
  `vendorID` int(11) NOT NULL,
  `fullName` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile` int(11) NOT NULL,
  `phone2` int(11) DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `district` varchar(30) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'Active',
  `createdOn` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `vendor`
--

INSERT INTO `vendor` (`vendorID`, `fullName`, `email`, `mobile`, `phone2`, `address`, `address2`, `city`, `district`, `status`, `createdOn`) VALUES
(1, 'ABC Company', '', 2343567, 0, '80, Ground Floor, ABC Shopping Complex', '46th Avenue', 'Kolpetty', 'Colombo', 'Active', '2018-05-05 05:48:44'),
(2, 'Sample Vendor 222', 'sample@volvo.com', 99828282, 283730183, '123, A Road, B avenue', 'Pitipana', 'Nugegoda', 'Mannar', 'Disabled', '2018-05-05 06:12:02'),
(3, 'Johnson and Johnsons Co.', '', 32323, 0, '34, Malwatta Road, Kottawa', 'Pannipitiya', 'Maharagama', 'Colombo', 'Active', '2018-05-05 06:28:33'),
(4, 'Louise Vitton Bag', 'vitton@vitton.usa.com', 323234938, 0, '45, Palmer Valley, 5th Crossing', 'Delaware', 'Palo Alto', 'Batticaloa', 'Active', '2018-05-05 06:29:41'),
(6, 'Test Vendor', 'test@vendor.com', 43434, 47569937, 'Test address', 'Test address 2', 'Test City', 'Trincomalee', 'Active', '2018-05-05 06:53:14'),
(7, 'Bags Co. Exporters Ltd.', '', 1111, 0, 'Sea Road, Bambalapitiya', '', '', 'Colombo', 'Active', '2018-05-15 10:36:54'),
(8, 'New Bags Exporters', '', 191938930, 0, '123, A Road, B avenue, ', 'Gilford Crescent', 'Colpetty', 'Colombo', 'Active', '2018-05-16 12:36:53'),
(9, 'A', 'a@gmail.com', 999995, 98866767, 'manila', 'Metro Manila', 'Manila City', 'Ampara', 'Active', '2020-07-30 11:40:25');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customerID`);

--
-- Indexes for table `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`productID`);

--
-- Indexes for table `purchase`
--
ALTER TABLE `purchase`
  ADD PRIMARY KEY (`purchaseID`);

--
-- Indexes for table `sale`
--
ALTER TABLE `sale`
  ADD PRIMARY KEY (`saleID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`userID`);

--
-- Indexes for table `vendor`
--
ALTER TABLE `vendor`
  ADD PRIMARY KEY (`vendorID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customerID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `item`
--
ALTER TABLE `item`
  MODIFY `productID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `purchase`
--
ALTER TABLE `purchase`
  MODIFY `purchaseID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `sale`
--
ALTER TABLE `sale`
  MODIFY `saleID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `userID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `vendor`
--
ALTER TABLE `vendor`
  MODIFY `vendorID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- Database: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
