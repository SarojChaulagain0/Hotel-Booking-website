-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 25, 2023 at 09:14 PM
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
-- Database: `hoteldb`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `BookingID` int(11) NOT NULL,
  `CustomerID` int(11) DEFAULT NULL,
  `RoomTypeID` int(11) DEFAULT NULL,
  `CheckInDate` date DEFAULT NULL,
  `NumOfPersons` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`BookingID`, `CustomerID`, `RoomTypeID`, `CheckInDate`, `NumOfPersons`) VALUES
(22, 27, 2, '2024-02-12', 2),
(23, 28, 2, '2024-02-12', 2),
(24, 30, 1, '2024-12-14', 2),
(25, 31, 1, '2024-01-12', 2);

--
-- Triggers `bookings`
--
DELIMITER $$
CREATE TRIGGER `before_insert_bookings` BEFORE INSERT ON `bookings` FOR EACH ROW BEGIN
    DECLARE bookings_count INT;
    
    -- Get the current count of bookings for the RoomTypeID
    SELECT COUNT(*) INTO bookings_count
    FROM bookings
    WHERE RoomTypeID = NEW.RoomTypeID;

    -- Check if the count exceeds the maximum limit (2)
    IF bookings_count >= 2 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Exceeded maximum limit of 2 bookings for this RoomTypeID';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `CustomerID` int(11) NOT NULL,
  `FullName` varchar(100) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Phone` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`CustomerID`, `FullName`, `Email`, `Phone`) VALUES
(26, 'Saroj Chaulagain', 'sarojchaulagain73@gmail.com', '0415858585'),
(27, 'Saroj Chaulagain', 'sarojchaulagain73@gmail.com', '0415858585'),
(28, 'Saroj Chaulagain', 'sarojchaulagain73@gmail.com', '0415858585'),
(29, 'Saroj Chaulagain', 'sarojchaulagain73@gmail.com', '0415858585'),
(30, 'Saroj Chaulagain', 'sarojchaulagain73@gmail.com', '0415858585'),
(31, 'Saroj Chaulagain', 'sarojchaulagain73@gmail.com', '0415858585');

-- --------------------------------------------------------

--
-- Table structure for table `roomtypes`
--

CREATE TABLE `roomtypes` (
  `RoomTypeID` int(11) NOT NULL,
  `RoomTypeName` varchar(50) NOT NULL,
  `BedType` varchar(20) NOT NULL,
  `RoomSize` varchar(20) NOT NULL,
  `RoomFacilities` varchar(255) NOT NULL,
  `PricePerNight` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roomtypes`
--

INSERT INTO `roomtypes` (`RoomTypeID`, `RoomTypeName`, `BedType`, `RoomSize`, `RoomFacilities`, `PricePerNight`) VALUES
(1, 'Standard Twin', 'Twin', '300 sqft', 'WiFi, TV, AC', 100.00),
(2, 'Executive Twin', 'Twin', '350 sqft', 'WiFi, TV, AC, Mini-bar', 120.00),
(3, 'Superior Suite', 'King', '400 sqft', 'WiFi, TV, AC, Kitchenette', 150.00),
(4, 'Deluxe Suite', 'King', '450 sqft', 'WiFi, TV, AC, Kitchenette, Jacuzzi', 200.00),
(5, 'Executive Suite', 'King', '500 sqft', 'WiFi, TV, AC, Kitchenette, Jacuzzi', 250.00),
(6, 'Presidential Suite', 'King', '600 sqft', 'WiFi, TV, AC, Kitchenette, Jacuzzi, Private Pool', 500.00);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`BookingID`),
  ADD KEY `CustomerID` (`CustomerID`),
  ADD KEY `RoomTypeID` (`RoomTypeID`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`CustomerID`);

--
-- Indexes for table `roomtypes`
--
ALTER TABLE `roomtypes`
  ADD PRIMARY KEY (`RoomTypeID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `BookingID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `CustomerID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`),
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`RoomTypeID`) REFERENCES `roomtypes` (`RoomTypeID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
