-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 30, 2024 at 02:05 PM
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
  `remarks` enum('Passed','Failed','Dropped','Incomplete') DEFAULT NULL,
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
(45, 3, NULL, 'FE', 30, 10, 41, 60, 65.5, 50, NULL, NULL, NULL, 89, NULL, 'Passed', NULL, NULL, NULL, NULL),
(46, 12, NULL, 'PE', 21, 12, 30, 20, 50, 50, 80, NULL, NULL, NULL, NULL, 'Passed', NULL, NULL, NULL, NULL),
(47, 12, NULL, 'ME', 21, 30, 40, 50, 52, 35, NULL, 52, NULL, NULL, NULL, 'Passed', NULL, NULL, NULL, NULL),
(48, 12, NULL, 'SFE', 21, 30, 30, 35, 40, 30, NULL, NULL, 60, NULL, NULL, 'Passed', NULL, NULL, NULL, NULL),
(49, 12, NULL, 'FE', 25, 30, 30, 53, 52, 60, 0, 0, 0, 70, NULL, 'Passed', NULL, NULL, NULL, NULL),
(50, 12, NULL, 'FE', 25, 30, 30, 53, 52, 60, NULL, NULL, NULL, 42, NULL, 'Passed', NULL, NULL, NULL, NULL),
(51, 1, NULL, 'PE', 25, 30, 30, 53, 52, 60, 56, NULL, NULL, NULL, NULL, 'Passed', NULL, NULL, NULL, NULL),
(52, 1, NULL, 'ME', 25, 30, 30, 80, 52, 60, NULL, 60, NULL, NULL, NULL, 'Passed', NULL, NULL, NULL, NULL),
(53, 1, NULL, 'SFE', 30, 30, 30, 20, 30, 15, NULL, NULL, 90, NULL, NULL, 'Passed', NULL, NULL, NULL, NULL),
(55, 1, NULL, 'FE', 25, 30, 30, 53, 52, 60, NULL, NULL, NULL, 90, NULL, 'Passed', NULL, NULL, NULL, NULL),
(56, 10, NULL, 'PE', 90, 30, 30, 90, 52, 60, 80, NULL, NULL, NULL, NULL, 'Passed', NULL, NULL, NULL, NULL),
(57, 10, NULL, 'ME', 90, 30, 30, 90, 52, 60, NULL, 50, NULL, NULL, NULL, 'Passed', NULL, NULL, NULL, NULL),
(59, 10, NULL, 'FE', 25, 30, 30, 50, 52, 60, NULL, NULL, NULL, 90, NULL, 'Passed', NULL, NULL, NULL, NULL),
(61, 10, NULL, 'SFE', 90, 30, 30, 90, 52, 60, NULL, NULL, 70, NULL, NULL, 'Passed', NULL, NULL, NULL, NULL);

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
  `course` enum('BSIT','BSCS') NOT NULL,
  `status` enum('enrolled','dropped','incomplete') DEFAULT 'enrolled'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `lastname`, `firstname`, `middlename`, `gender`, `birthdate`, `birthplace`, `address`, `father`, `mother`, `created_at`, `course`, `status`) VALUES
(1, 'Muyano', 'Ieson Louis', 'De', 'Male', '1999-01-25', 'Region I', 'Mangaldan', 'Nelson ', 'Cynthia ', '2024-06-15 13:58:16', 'BSCS', NULL),
(2, 'Rover', 'Seyfert', 'Aerial', 'Male', '2000-12-05', 'Region 1', 'mangaldan,pangasinan', 'Arlecchino', 'Yin Lin', '2024-06-15 14:12:52', 'BSIT', NULL),
(3, 'Sevidal', 'Christine', 'C.', 'Male', '2003-12-07', 'Region 1', 'dagupan,pangasinan', 'Alhaitham', 'Candace', '2024-06-16 18:08:14', 'BSIT', NULL),
(4, 'Loyola', 'Joshua', 'H', 'Male', '2004-05-21', 'Dagupan', 'Dagupan,Pangasinan', '1', '2', '2024-06-17 12:31:05', 'BSIT', 'enrolled'),
(5, 'Hornada', 'Rocelle', 'L', 'Female', '2004-12-04', 'Dagupan', 'Dagupan,Pangasinan', '1', '2', '2024-06-17 13:03:44', 'BSIT', 'enrolled'),
(9, 'Escano', 'Piolo', 'C.', 'Male', '2004-12-05', 'Dagupan', 'Dagupan,Pangasinan', 'p', 'p', '2024-06-17 17:19:26', 'BSIT', 'enrolled'),
(10, 'picar', 'paolo', 'J', 'Male', '2001-12-04', 'Dagupan', 'Lingayen,Pangasinan', 'p', 'p', '2024-06-17 17:30:16', 'BSCS', 'enrolled'),
(11, 'Pesimo', 'Jasper', 'J', 'Male', '2005-12-03', 'region 1', 'bugallon, pangasinan', 'p', 'p', '2024-06-17 17:43:30', 'BSIT', 'enrolled'),
(12, 'Andrea', 'C', 'De Guzman', 'Female', '2000-12-06', 'region 1', 'Dagupan,Pangasinan', 'k', 'h', '2024-06-18 17:48:25', 'BSCS', 'enrolled');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
