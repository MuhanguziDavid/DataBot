-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 19, 2018 at 08:04 PM
-- Server version: 10.1.26-MariaDB
-- PHP Version: 7.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `databot`
--

-- --------------------------------------------------------

--
-- Table structure for table `eta`
--

CREATE TABLE `eta` (
  `id` int(11) NOT NULL,
  `username` varchar(48) NOT NULL,
  `password` varchar(48) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `eta`
--

INSERT INTO `eta` (`id`, `username`, `password`) VALUES
(2, 'lmkl', 'lmm'),
(3, 'mset', 'mset'),
(4, 'user1', 'user1'),
(5, 'user2', 'user2'),
(6, 'use', 'use'),
(7, 'add', 'add');

-- --------------------------------------------------------

--
-- Table structure for table `eta_data`
--

CREATE TABLE `eta_data` (
  `id` int(11) NOT NULL,
  `timestamp` varchar(48) NOT NULL,
  `open` double NOT NULL,
  `high` double NOT NULL,
  `low` double NOT NULL,
  `close` double NOT NULL,
  `adjusted_close` double NOT NULL,
  `volume` bigint(20) NOT NULL,
  `username` text NOT NULL,
  `ticker_Symbol` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `eta_user`
--

CREATE TABLE `eta_user` (
  `id` int(11) NOT NULL,
  `eta_id` int(11) NOT NULL,
  `username` varchar(16) NOT NULL,
  `password` varchar(24) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `eta_user`
--

INSERT INTO `eta_user` (`id`, `eta_id`, `username`, `password`) VALUES
(1, 3, 'rutaale', '1234'),
(2, 7, 'dave', '1234');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `eta`
--
ALTER TABLE `eta`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `eta_data`
--
ALTER TABLE `eta_data`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `eta_user`
--
ALTER TABLE `eta_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `eta_id` (`eta_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `eta`
--
ALTER TABLE `eta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `eta_data`
--
ALTER TABLE `eta_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16383;

--
-- AUTO_INCREMENT for table `eta_user`
--
ALTER TABLE `eta_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `eta_user`
--
ALTER TABLE `eta_user`
  ADD CONSTRAINT `eta_user_ibfk_1` FOREIGN KEY (`eta_id`) REFERENCES `eta` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
