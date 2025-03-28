-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 15, 2024 at 06:08 PM
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
-- Database: `gradingsys`
--

-- --------------------------------------------------------

--
-- Table structure for table `grades`
--

CREATE TABLE `grades` (
  `id` int(11) NOT NULL,
  `student_id` int(11) DEFAULT NULL,
  `period` enum('PE','ME','SFE','FE') DEFAULT NULL,
  `quizzes` float DEFAULT NULL,
  `academic_projects` float DEFAULT NULL,
  `recitation` float DEFAULT NULL,
  `performance_task` float DEFAULT NULL,
  `activity_sheets` float DEFAULT NULL,
  `assignments` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `grades`
--

INSERT INTO `grades` (`id`, `student_id`, `period`, `quizzes`, `academic_projects`, `recitation`, `performance_task`, `activity_sheets`, `assignments`) VALUES
(1, 1, 'PE', 89, 80, 90, 90, 90, 90),
(2, 1, 'ME', 89, 80, 90, 90, 90, 90),
(3, 1, 'SFE', 89, 80, 90, 90, 90, 90),
(4, 1, 'FE', 89, 80, 90, 90, 90, 90);

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
  `course` enum('BSIT','BSCS') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `lastname`, `firstname`, `middlename`, `gender`, `birthdate`, `birthplace`, `address`, `father`, `mother`, `course`, `created_at`) VALUES
(1, 'Muyano', 'Ieson Louis', 'C', 'Male', '0000-00-00', 'Region I', 'Mangaldan', 'Nelson Muyano', 'Cynthia Muyano', 'BSCS', '2024-06-15 13:58:16'),
(2, 'Rover', 'Seyfert', 'Aerial', 'Male', '2000-12-05', 'Region 1', 'mangaldan,pangasinan', 'Arlecchino', 'Yin Lin', 'BSIT', '2024-06-15 14:12:52');

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
(6, 'professor', '$2y$10$vE8XIzkuAxmBQKrNQGb0auXDO0mcBuim1Y0a8hqJy7179.TBV6yWS', 'professor');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `grades`
--
ALTER TABLE `grades`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
