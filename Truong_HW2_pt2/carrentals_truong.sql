-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 04, 2020 at 04:42 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `carrentals_truong`
--
CREATE DATABASE IF NOT EXISTS `carrentals_truong` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `carrentals_truong`;

-- --------------------------------------------------------

--
-- Table structure for table `car`
--

DROP TABLE IF EXISTS `car`;
CREATE TABLE `car` (
  `Vehicle_ID` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `Model` varchar(255) NOT NULL,
  `Year` int(4) NOT NULL,
  `ID_no` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `car`
--

INSERT INTO `car` (`Vehicle_ID`, `type`, `Model`, `Year`, `ID_no`) VALUES
(1001, 'compact', 'Chevy', 2013, 1),
(1002, 'compact', 'Lexus', 2018, 2),
(1003, 'compact', 'Honda', 2005, 3),
(1004, 'compact', 'Hyundai', 2004, 4),
(1005, 'compact', 'Nissan', 2015, NULL),
(1006, 'medium', 'Kia', 2012, 5),
(1007, 'medium', 'Volkswagen', 2007, 6),
(1008, 'medium', 'Ford', 2005, 7),
(1009, 'medium', 'Subaru', 2013, NULL),
(1010, 'medium', 'Toyota', 2017, 8),
(1011, 'large', 'Acura', 2020, 9),
(1012, 'large', 'Lexus', 2012, NULL),
(1013, 'large', 'Toyota', 2005, 10),
(1014, 'large', 'Chevy', 2007, 11),
(1015, 'large', 'Mazda', 2011, NULL),
(1016, 'suv', 'Ford', 2021, 12),
(1017, 'suv', 'Jeep', 2008, 13),
(1018, 'suv', 'Acura', 2019, NULL),
(1019, 'suv', 'Subaru', 2010, 14),
(1020, 'suv', 'Dodge', 2006, NULL),
(1021, 'truck', 'Toyota', 2010, 15),
(1022, 'truck', 'Dodge', 2008, NULL),
(1023, 'truck', 'Nissan', 2004, 16),
(1024, 'truck', 'Honda', 2011, 17),
(1025, 'truck', 'Dodge', 2015, NULL),
(1026, 'van', 'Hyundai', 2009, 18),
(1027, 'van', 'Honda', 2014, 19),
(1028, 'van', 'Mazda', 2006, 20),
(1029, 'van', 'Toyota', 2017, NULL),
(1030, 'van', 'Chevy', 2012, NULL),
(1031, 'compact', 'Honda', 2001, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `car_type`
--

DROP TABLE IF EXISTS `car_type`;
CREATE TABLE `car_type` (
  `type` varchar(255) NOT NULL,
  `daily_rate` decimal(10,2) NOT NULL,
  `weekly_rate` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `car_type`
--

INSERT INTO `car_type` (`type`, `daily_rate`, `weekly_rate`) VALUES
('buggy', '5.72', '20.00'),
('compact', '11.80', '59.00'),
('large', '17.48', '87.40'),
('medium', '13.39', '66.95'),
('suv', '22.45', '112.25'),
('truck', '27.52', '137.60'),
('van', '34.36', '171.80');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `ID_no` int(11) NOT NULL,
  `Finit` varchar(1) NOT NULL,
  `Lname` varchar(255) NOT NULL,
  `Phone` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`ID_no`, `Finit`, `Lname`, `Phone`) VALUES
(1, 'H', 'Sherman', '833-630-0588'),
(2, 'F', 'Vasquez', '409-580-7151'),
(3, 'T', 'Crane', '213-603-2461'),
(4, 'C', 'Cross', '805-566-6162'),
(5, 'R', 'Casey', '545-216-8628'),
(6, 'J', 'Stein', '986-231-6732'),
(7, 'D', 'Nguyen', '662-265-3007'),
(8, 'M', 'Hamilton', '448-746-8820'),
(9, 'P', 'Wilkinson', '521-724-4163'),
(10, 'F', 'Garcia', '372-624-8160'),
(11, 'V', 'Griffin', '304-585-1458'),
(12, 'Z', 'Robertson', '675-796-0870'),
(13, 'L', 'Levy', '829-555-4632'),
(14, 'P', 'Summers', '794-320-8710'),
(15, 'M', 'Jenkins', '811-591-0621'),
(16, 'W', 'Valentine', '233-709-7034'),
(17, 'B', 'Chambers', '510-627-7398'),
(18, 'A', 'Gray', '382-466-4725'),
(19, 'T', 'Rocha', '566-261-9510'),
(20, 'P', 'Bass', '926-863-3554'),
(21, 'S', 'Johnson', '123-456-7890'),
(22, 'T', 'Le', '908-765-4321');

-- --------------------------------------------------------

--
-- Table structure for table `rentals`
--

DROP TABLE IF EXISTS `rentals`;
CREATE TABLE `rentals` (
  `Vehicle_ID` int(11) NOT NULL,
  `ID_no` int(11) DEFAULT NULL,
  `Available_now` tinyint(1) DEFAULT 1,
  `Amount_due` decimal(10,2) DEFAULT 0.00,
  `rtype` varchar(6) DEFAULT NULL,
  `no_days` int(11) DEFAULT 0,
  `no_weeks` int(11) DEFAULT 0,
  `start_date` date DEFAULT '2000-01-01',
  `end_date` date DEFAULT '2000-01-01'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rentals`
--

INSERT INTO `rentals` (`Vehicle_ID`, `ID_no`, `Available_now`, `Amount_due`, `rtype`, `no_days`, `no_weeks`, `start_date`, `end_date`) VALUES
(1001, 1, 0, '35.40', 'daily', 3, 0, '2020-04-27', '2020-04-30'),
(1002, 2, 0, '118.00', 'weekly', 0, 2, '2020-04-27', '2020-05-11'),
(1003, 3, 0, '47.20', 'daily', 4, 0, '2020-04-27', '2020-05-01'),
(1004, 4, 0, '118.00', 'weekly', 0, 2, '2020-04-27', '2020-05-11'),
(1005, NULL, 1, '0.00', NULL, 0, 0, '2000-01-01', '2000-01-01'),
(1006, 5, 0, '26.78', 'daily', 2, 0, '2020-04-13', '2020-04-15'),
(1007, 6, 0, '401.70', 'weekly', 0, 6, '2020-04-13', '2020-05-25'),
(1008, 7, 0, '120.51', 'daily', 9, 0, '2020-04-08', '2020-04-17'),
(1009, NULL, 1, '0.00', NULL, 0, 0, '2000-01-01', '2000-01-01'),
(1010, 8, 0, '535.60', 'weekly', 0, 8, '2020-03-18', '2020-05-13'),
(1011, 9, 0, '139.84', 'daily', 8, 0, '2020-03-18', '2020-03-26'),
(1012, NULL, 1, '0.00', NULL, 0, 0, '2000-01-01', '2000-01-01'),
(1013, 10, 0, '174.80', 'weekly', 0, 2, '2020-04-01', '2020-04-15'),
(1014, 11, 0, '104.88', 'daily', 6, 0, '2020-04-01', '2020-04-07'),
(1015, NULL, 1, '0.00', NULL, 0, 0, '2000-01-01', '2000-01-01'),
(1016, 12, 0, '449.00', 'weekly', 0, 4, '2020-01-14', '2020-02-11'),
(1017, 13, 0, '202.05', 'daily', 9, 0, '2020-04-23', '2020-05-02'),
(1018, NULL, 1, '0.00', NULL, 0, 0, '2000-01-01', '2000-01-01'),
(1019, 14, 0, '224.50', 'weekly', 0, 2, '2020-02-28', '2020-03-13'),
(1020, NULL, 1, '0.00', NULL, 0, 0, '2000-01-01', '2000-01-01'),
(1021, 15, 0, '137.60', 'daily', 5, 0, '2020-04-14', '2020-04-19'),
(1022, NULL, 1, '0.00', NULL, 0, 0, '2000-01-01', '2000-01-01'),
(1023, 16, 0, '825.60', 'weekly', 0, 6, '2020-03-11', '2020-04-22'),
(1024, 17, 0, '275.20', 'daily', 10, 0, '2020-02-22', '2020-03-03'),
(1025, NULL, 1, '0.00', NULL, 0, 0, '2000-01-01', '2000-01-01'),
(1026, 18, 0, '1374.40', 'weekly', 0, 8, '2020-02-11', '2020-04-07'),
(1027, 19, 0, '343.60', 'daily', 10, 0, '2020-04-10', '2020-04-20'),
(1028, 20, 0, '859.00', 'weekly', 0, 5, '2020-03-22', '2020-04-26'),
(1029, NULL, 1, '0.00', NULL, 0, 0, '2000-01-01', '2000-01-01'),
(1030, NULL, 1, '0.00', NULL, 0, 0, '2000-01-01', '2000-01-01'),
(1031, NULL, 1, '0.00', NULL, 0, 0, '2000-01-01', '2000-01-01');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `car`
--
ALTER TABLE `car`
  ADD PRIMARY KEY (`Vehicle_ID`),
  ADD KEY `ID_no` (`ID_no`),
  ADD KEY `type` (`type`);

--
-- Indexes for table `car_type`
--
ALTER TABLE `car_type`
  ADD PRIMARY KEY (`type`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`ID_no`);

--
-- Indexes for table `rentals`
--
ALTER TABLE `rentals`
  ADD PRIMARY KEY (`Vehicle_ID`),
  ADD KEY `ID_no` (`ID_no`) USING BTREE;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `car`
--
ALTER TABLE `car`
  ADD CONSTRAINT `car_ibfk_1` FOREIGN KEY (`ID_no`) REFERENCES `customer` (`ID_no`),
  ADD CONSTRAINT `car_ibfk_2` FOREIGN KEY (`type`) REFERENCES `car_type` (`type`);

--
-- Constraints for table `rentals`
--
ALTER TABLE `rentals`
  ADD CONSTRAINT `rentals_ibfk_2` FOREIGN KEY (`Vehicle_ID`) REFERENCES `car` (`Vehicle_ID`),
  ADD CONSTRAINT `rentals_ibfk_3` FOREIGN KEY (`ID_no`) REFERENCES `customer` (`ID_no`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
