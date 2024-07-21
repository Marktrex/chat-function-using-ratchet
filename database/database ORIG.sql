-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 19, 2024 at 05:11 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;

-- --------------------------------------------------------

--
-- Table structure for table `chatrooms`
--

CREATE TABLE `chatrooms` (
  `id` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `msg` varchar(200) NOT NULL,
  `created_on` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `chatrooms`
--

INSERT INTO `chatrooms` (`id`, `userid`, `msg`, `created_on`) VALUES
(6, 20, 'test', '2023-11-08 06:00:19'),
(7, 20, 'oh shee\nHAHAHHA\n', '2023-11-08 06:00:25'),
(8, 21, 'heeyyy', '2023-11-09 04:07:44'),
(9, 20, 'testing\n', '2023-11-09 04:10:17'),
(10, 21, 'ocakes', '2023-11-09 04:10:23'),
(11, 20, 'bug\n', '2023-11-09 04:50:54'),
(12, 22, 'hello\n', '2023-11-10 01:58:54'),
(13, 20, 'hi\n', '2023-11-10 01:59:22'),
(14, 22, 'bat eto nasasave\n', '2023-11-10 02:02:42'),
(15, 1, 'im the admin\n', '2023-11-10 02:23:17'),
(16, 1, 'helola', '2023-11-10 04:02:09'),
(17, 1, 'hey', '2023-11-10 04:18:51'),
(18, 21, 'helo', '2023-11-10 04:19:00'),
(19, 1, 'heuy', '2023-11-10 04:19:06'),
(20, 1, 'loe', '2023-11-10 04:20:30'),
(21, 21, 'eleven twenty one', '2023-11-10 04:21:23'),
(22, 21, 'what', '2023-11-10 05:21:24'),
(23, 21, 'hgey', '2023-11-10 05:21:39'),
(24, 1, 'xd', '2024-07-19 05:07:19');

-- --------------------------------------------------------

--
-- Table structure for table `chat_message`
--

CREATE TABLE `chat_message` (
  `chat_message_id` int(11) NOT NULL,
  `to_user_id` int(11) NOT NULL,
  `from_user_id` int(11) NOT NULL,
  `chat_message` mediumtext NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('Yes','No') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chat_message`
--

INSERT INTO `chat_message` (`chat_message_id`, `to_user_id`, `from_user_id`, `chat_message`, `timestamp`, `status`) VALUES
(8, 22, 20, 'hello', '2023-11-09 18:05:07', 'Yes'),
(9, 21, 22, 'g', '2023-11-09 18:12:06', 'Yes'),
(10, 1, 20, 'hey', '2023-11-09 18:23:04', 'Yes'),
(11, 1, 20, 'hey', '2023-11-09 18:24:02', 'Yes'),
(12, 1, 23, 'hello', '2023-11-09 18:54:09', 'Yes'),
(13, 23, 1, 'huh', '2023-11-09 19:03:05', 'Yes'),
(14, 21, 1, 'bug', '2023-11-09 19:03:15', 'Yes'),
(15, 1, 23, 'ewan ko', '2023-11-09 19:03:34', 'Yes'),
(16, 23, 1, 'what is status', '2023-11-09 19:07:58', 'Yes'),
(17, 1, 23, 'test', '2023-11-09 19:18:11', 'Yes'),
(18, 1, 23, 'owshee', '2023-11-09 19:20:48', 'Yes'),
(19, 21, 1, 'hey', '2023-11-09 20:18:19', 'Yes'),
(20, 21, 1, 'heeu', '2023-11-09 20:18:25', 'Yes'),
(21, 23, 1, 'heuy', '2023-11-09 20:18:29', 'Yes'),
(22, 21, 1, 'hey', '2023-11-09 20:19:15', 'Yes'),
(23, 23, 1, 'hello', '2023-11-09 20:21:54', 'Yes'),
(24, 21, 1, 'bakit ayaw lumitaw', '2023-11-09 20:22:33', 'Yes'),
(25, 21, 1, 'eu', '2023-11-09 20:27:40', 'Yes'),
(26, 1, 23, 'what', '2023-11-09 20:27:48', 'Yes'),
(27, 23, 1, 'what', '2023-11-09 20:28:23', 'Yes'),
(28, 21, 1, 'eu', '2023-11-09 20:30:28', 'Yes'),
(29, 21, 1, 'hel', '2023-11-09 20:31:20', 'Yes'),
(30, 23, 1, 'oi', '2023-11-09 20:31:24', 'Yes'),
(31, 21, 23, 'heuy', '2023-11-09 20:31:58', 'Yes'),
(32, 21, 23, 'what', '2023-11-09 20:32:03', 'Yes'),
(33, 1, 23, 'hey', '2023-11-09 20:34:57', 'Yes'),
(34, 21, 23, 'test', '2023-11-09 20:46:45', 'Yes'),
(35, 21, 23, 'test', '2023-11-09 20:47:04', 'Yes'),
(36, 1, 23, 'test', '2023-11-09 20:47:11', 'Yes'),
(37, 1, 23, 'test naman', '2023-11-09 20:47:32', 'Yes'),
(38, 1, 23, 'heu', '2023-11-09 20:49:32', 'Yes'),
(39, 23, 1, 'gey', '2023-11-09 20:51:07', 'Yes'),
(40, 1, 23, 'hello', '2023-11-09 20:56:15', 'Yes'),
(41, 23, 1, 'hoy', '2023-11-09 20:59:18', 'Yes'),
(42, 1, 21, 'test', '2023-11-09 21:22:01', 'Yes'),
(43, 23, 1, 'test', '2023-11-10 19:02:09', 'Yes'),
(44, 21, 1, 'hey', '2023-11-10 19:02:14', 'Yes'),
(45, 1, 21, 'what', '2023-11-10 19:02:23', 'Yes'),
(46, 23, 21, 'seeshg', '2023-11-10 19:02:26', 'Yes'),
(47, 23, 1, 'ey', '2023-11-10 19:32:38', 'Yes'),
(48, 21, 1, 'ey', '2023-11-10 19:32:50', 'Yes'),
(49, 1, 21, 'what', '2023-11-10 19:32:59', 'Yes'),
(50, 1, 21, 'test', '2023-11-10 19:33:12', 'Yes'),
(51, 21, 1, 'whgat', '2023-11-10 19:33:18', 'Yes'),
(52, 21, 1, 'what', '2023-11-10 19:33:24', 'Yes'),
(53, 1, 21, 'nothing', '2023-11-10 19:33:31', 'Yes'),
(54, 21, 1, 'tes', '2023-11-10 19:50:38', 'Yes'),
(55, 21, 1, 'hey', '2023-11-10 19:56:01', 'Yes'),
(56, 1, 21, 'hello', '2023-11-10 19:56:09', 'Yes'),
(57, 21, 1, 'hey', '2023-11-10 20:02:17', 'Yes'),
(58, 23, 1, 'bobo', '2024-07-18 21:07:44', 'Yes'),
(59, 21, 1, 'hole shit', '2024-07-18 21:07:56', 'Yes');

-- --------------------------------------------------------

--
-- Table structure for table `chat_user_table`
--

CREATE TABLE `chat_user_table` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(250) NOT NULL,
  `user_email` varchar(250) NOT NULL,
  `user_password` varchar(100) NOT NULL,
  `user_profile` varchar(100) NOT NULL,
  `user_status` enum('Disabled','Enable') NOT NULL,
  `user_created_on` datetime NOT NULL,
  `user_verification_code` varchar(100) NOT NULL,
  `user_login_status` enum('Logout','Login') NOT NULL,
  `user_token` varchar(100) NOT NULL,
  `user_connection_id` int(5) NOT NULL,
  `user_type` varchar(35) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chat_user_table`
--

INSERT INTO `chat_user_table` (`user_id`, `user_name`, `user_email`, `user_password`, `user_profile`, `user_status`, `user_created_on`, `user_verification_code`, `user_login_status`, `user_token`, `user_connection_id`, `user_type`) VALUES
(1, 'Admin', 'Admin@gmail.com', 'tester', 'images/1609831140.png', 'Enable', '2023-11-10 13:46:19', 'e0f9cddd1c75be5c3da989a5ea97be5a', 'Login', 'aff8bb51b5233f44df0d93bdd1106eaf', 94, 'Admin'),
(21, 'aries', 'marcdavid0902@gmail.com', 'banana', 'images/1015079441.jpg', 'Enable', '2023-11-09 16:04:23', '6238d942c896028f724fdf9ce2de5163', 'Logout', '635cdaa10f50a6c7d480cc884cd71527', 544, 'User'),
(23, 'markpogi', 'sinicchi123@gmail.com', 'tester', 'images/1699624331.png', 'Enable', '2023-11-10 14:52:11', '887562c850783461104f0daa91774946', 'Login', '7538e005c8e3c2c853fafc099aa8cdc4', 2177, 'User');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chatrooms`
--
ALTER TABLE `chatrooms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `chat_message`
--
ALTER TABLE `chat_message`
  ADD PRIMARY KEY (`chat_message_id`);

--
-- Indexes for table `chat_user_table`
--
ALTER TABLE `chat_user_table`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `chatrooms`
--
ALTER TABLE `chatrooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `chat_message`
--
ALTER TABLE `chat_message`
  MODIFY `chat_message_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `chat_user_table`
--
ALTER TABLE `chat_user_table`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
