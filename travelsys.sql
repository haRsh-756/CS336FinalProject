CREATE DATABASE  IF NOT EXISTS `travelreservation` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

UNLOCK TABLES;
USE `travelreservation`;
-- MySQL dump 10.13  Distrib 8.0.34, for macos13 (arm64)
--
-- Host: 127.0.0.1    Database: travelreservation
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `username` varchar(300) NOT NULL,
  `password` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES ('admin123','password123'),('admin456','password456'),('admin789','password789');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aircraft`
--

DROP TABLE IF EXISTS `aircraft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aircraft` (
  `aircraft_id` varchar(5) NOT NULL,
  `num_seats` int NOT NULL,
  PRIMARY KEY (`aircraft_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aircraft`
--

LOCK TABLES `aircraft` WRITE;
/*!40000 ALTER TABLE `aircraft` DISABLE KEYS */;
INSERT INTO `aircraft` VALUES ('AA101',20),('AA102',20),('AA103',20),('DA401',20),('DA402',20),('DA403',20),('UA501',20),('UA502',20),('UA503',20),('UA504',20);
/*!40000 ALTER TABLE `aircraft` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airline`
--

DROP TABLE IF EXISTS `airline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airline` (
  `airline_id` varchar(5) NOT NULL,
  PRIMARY KEY (`airline_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airline`
--

LOCK TABLES `airline` WRITE;
/*!40000 ALTER TABLE `airline` DISABLE KEYS */;
INSERT INTO `airline` VALUES ('AA'),('DA'),('UA');
/*!40000 ALTER TABLE `airline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airport`
--

DROP TABLE IF EXISTS `airport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airport` (
  `airport_id` varchar(5) NOT NULL,
  PRIMARY KEY (`airport_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airport`
--

LOCK TABLES `airport` WRITE;
/*!40000 ALTER TABLE `airport` DISABLE KEYS */;
INSERT INTO `airport` VALUES ('BOS'),('EWR'),('JFK'),('LGA'),('PHL');
/*!40000 ALTER TABLE `airport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `username` varchar(300) NOT NULL,
  `password` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES ('',''),('user123','password123'),('user456','password456'),('user789','password789');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custrep`
--

DROP TABLE IF EXISTS `custrep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `custrep` (
  `username` varchar(300) NOT NULL,
  `password` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custrep`
--

LOCK TABLES `custrep` WRITE;
/*!40000 ALTER TABLE `custrep` DISABLE KEYS */;
INSERT INTO `custrep` VALUES ('custrep123','password123'),('custrep456','password456');
/*!40000 ALTER TABLE `custrep` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flights`
--

DROP TABLE IF EXISTS `flights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flights` (
  `airline_id` varchar(5) NOT NULL,
  `aircraft_id` varchar(5) NOT NULL,
  `from_airport` varchar(5) NOT NULL,
  `from_date` date NOT NULL,
  `from_time` time NOT NULL,
  `to_airport` varchar(5) NOT NULL,
  `to_date` date NOT NULL,
  `to_time` time NOT NULL,
  `is_domestic` tinyint(1) NOT NULL,
  `flight_num` int NOT NULL AUTO_INCREMENT,
  `flight_type` varchar(20) NOT NULL,
  `num_stops` int NOT NULL,
  `eco_price` float NOT NULL,
  `bus_price` float NOT NULL,
  `fir_price` float NOT NULL,
  PRIMARY KEY (`flight_num`),
  KEY `airline_id` (`airline_id`),
  KEY `aircraft_id` (`aircraft_id`),
  KEY `from_airport` (`from_airport`),
  KEY `to_airport` (`to_airport`),
  CONSTRAINT `flights_ibfk_1` FOREIGN KEY (`airline_id`) REFERENCES `airline` (`airline_id`),
  CONSTRAINT `flights_ibfk_2` FOREIGN KEY (`aircraft_id`) REFERENCES `aircraft` (`aircraft_id`),
  CONSTRAINT `flights_ibfk_3` FOREIGN KEY (`from_airport`) REFERENCES `airport` (`airport_id`),
  CONSTRAINT `flights_ibfk_4` FOREIGN KEY (`to_airport`) REFERENCES `airport` (`airport_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flights`
--

LOCK TABLES `flights` WRITE;
/*!40000 ALTER TABLE `flights` DISABLE KEYS */;
INSERT INTO `flights` VALUES ('AA','AA101','EWR','2023-12-14','11:25:11','BOS','2023-12-14','08:24:29',1,1000,'One Way',2,290.79,482.03,651.7),('AA','AA102','EWR','2023-12-15','19:13:19','PHL','2023-12-15','02:12:03',1,1001,'Round Trip',0,167.61,493.05,530.3),('DA','DA402','EWR','2023-12-16','08:37:07','JFK','2023-12-16','17:17:52',1,1002,'One Way',0,135.23,374.74,542.31),('DA','DA401','EWR','2023-12-17','09:20:18','LGA','2023-12-17','03:17:35',0,1003,'One Way',2,170.59,414.08,530.53),('UA','UA502','PHL','2023-12-18','01:20:39','BOS','2023-12-18','01:20:09',0,1004,'Round Trip',1,198.61,379.79,618.35),('DA','DA403','PHL','2023-12-19','19:10:36','LGA','2023-12-19','20:25:24',0,1005,'One Way',2,223.53,385.08,563.7),('UA','UA501','PHL','2023-12-20','02:27:39','JFK','2023-12-20','02:59:50',1,1006,'Round Trip',2,145.42,344.65,523.7),('UA','UA503','BOS','2023-12-21','16:52:51','LGA','2023-12-21','21:56:26',1,1007,'One Way',0,298.47,375.02,552.74),('AA','AA103','BOS','2023-12-22','15:13:02','JFK','2023-12-22','17:34:47',1,1008,'One Way',0,114.36,358.89,655.74),('UA','UA504','LGA','2023-12-23','01:20:09','JFK','2023-12-23','04:58:40',1,1009,'Round Trip',2,172.53,431.45,679.28),('AA','AA101','EWR','2023-12-12','03:33:02','BOS','2023-12-12','19:06:56',0,1010,'Round Trip',1,567,850.5,1275.75),('AA','AA101','EWR','2023-12-13','07:04:44','BOS','2023-12-13','04:00:57',0,1011,'Round Trip',1,197,295.5,443.25),('AA','AA101','EWR','2023-12-14','22:39:35','BOS','2023-12-14','09:01:20',0,1012,'One Way',1,502,753,1129.5),('AA','AA101','EWR','2023-12-15','17:31:51','BOS','2023-12-15','18:53:45',1,1013,'One Way',0,327,490.5,735.75),('AA','AA101','EWR','2023-12-16','17:18:48','BOS','2023-12-16','05:55:19',0,1014,'Round Trip',1,493,739.5,1109.25),('AA','AA101','EWR','2023-12-17','09:23:33','BOS','2023-12-17','18:19:02',1,1015,'One Way',1,236,354,531),('AA','AA102','EWR','2023-12-12','19:42:38','PHL','2023-12-12','19:33:32',0,1016,'Round Trip',1,428,642,963),('AA','AA102','EWR','2023-12-13','00:58:10','PHL','2023-12-13','12:48:55',1,1017,'Round Trip',1,443,664.5,996.75),('AA','AA102','EWR','2023-12-14','20:00:31','PHL','2023-12-14','09:20:30',0,1018,'One Way',2,556,834,1251),('AA','AA102','EWR','2023-12-15','06:45:16','PHL','2023-12-15','19:38:44',0,1019,'Round Trip',1,391,586.5,879.75),('AA','AA102','EWR','2023-12-16','16:32:34','PHL','2023-12-16','09:07:45',1,1020,'One Way',2,597,895.5,1343.25),('AA','AA102','EWR','2023-12-17','00:12:52','PHL','2023-12-17','07:13:40',0,1021,'Round Trip',2,244,366,549),('AA','AA102','EWR','2023-12-18','20:46:26','PHL','2023-12-18','00:35:14',0,1022,'One Way',0,125,187.5,281.25),('DA','DA402','EWR','2023-12-13','16:19:46','JFK','2023-12-13','09:44:02',1,1023,'Round Trip',2,543,814.5,1221.75),('DA','DA402','EWR','2023-12-14','06:40:39','JFK','2023-12-14','11:57:21',0,1024,'One Way',2,164,246,369),('DA','DA402','EWR','2023-12-15','00:55:24','JFK','2023-12-15','12:35:06',0,1025,'Round Trip',1,226,339,508.5),('DA','DA402','EWR','2023-12-16','15:02:41','JFK','2023-12-16','09:56:45',0,1026,'Round Trip',1,296,444,666),('DA','DA402','EWR','2023-12-17','20:15:14','JFK','2023-12-17','17:38:38',1,1027,'Round Trip',1,166,249,373.5),('DA','DA402','EWR','2023-12-18','03:27:10','JFK','2023-12-18','18:56:22',0,1028,'Round Trip',0,276,414,621),('DA','DA402','EWR','2023-12-19','04:45:03','JFK','2023-12-19','09:04:32',0,1029,'One Way',1,255,382.5,573.75),('DA','DA401','EWR','2023-12-14','08:52:51','LGA','2023-12-14','03:55:12',0,1030,'Round Trip',0,374,561,841.5),('DA','DA401','EWR','2023-12-15','14:12:04','LGA','2023-12-15','07:32:18',0,1031,'Round Trip',2,376,564,846),('DA','DA401','EWR','2023-12-16','18:00:22','LGA','2023-12-16','12:39:37',1,1032,'One Way',1,130,195,292.5),('DA','DA401','EWR','2023-12-17','16:55:42','LGA','2023-12-17','08:04:18',0,1033,'Round Trip',1,354,531,796.5),('DA','DA401','EWR','2023-12-18','12:24:15','LGA','2023-12-18','14:35:31',0,1034,'Round Trip',0,475,712.5,1068.75),('DA','DA401','EWR','2023-12-19','12:30:10','LGA','2023-12-19','07:30:57',0,1035,'One Way',2,579,868.5,1302.75),('DA','DA401','EWR','2023-12-20','10:12:13','LGA','2023-12-20','15:09:56',0,1036,'Round Trip',0,175,262.5,393.75),('UA','UA502','PHL','2023-12-15','13:57:20','BOS','2023-12-15','03:54:47',0,1037,'Round Trip',2,441,661.5,992.25),('UA','UA502','PHL','2023-12-16','20:54:42','BOS','2023-12-16','12:06:21',0,1038,'One Way',0,517,775.5,1163.25),('UA','UA502','PHL','2023-12-17','11:08:09','BOS','2023-12-17','00:24:54',1,1039,'One Way',1,298,447,670.5),('UA','UA502','PHL','2023-12-18','14:54:32','BOS','2023-12-18','02:43:40',0,1040,'One Way',0,139,208.5,312.75),('UA','UA502','PHL','2023-12-19','22:23:38','BOS','2023-12-19','09:04:07',0,1041,'One Way',0,526,789,1183.5),('UA','UA502','PHL','2023-12-20','23:18:58','BOS','2023-12-20','06:55:34',0,1042,'One Way',1,189,283.5,425.25),('UA','UA502','PHL','2023-12-21','04:40:17','BOS','2023-12-21','08:13:57',1,1043,'Round Trip',0,538,807,1210.5),('DA','DA403','PHL','2023-12-16','09:52:07','LGA','2023-12-16','09:56:29',0,1044,'Round Trip',2,226,339,508.5),('DA','DA403','PHL','2023-12-17','12:14:58','LGA','2023-12-17','18:33:17',0,1045,'Round Trip',0,309,463.5,695.25),('DA','DA403','PHL','2023-12-18','01:05:27','LGA','2023-12-18','11:22:05',0,1046,'Round Trip',2,140,210,315),('DA','DA403','PHL','2023-12-19','05:52:06','LGA','2023-12-19','17:46:15',0,1047,'One Way',2,503,754.5,1131.75),('DA','DA403','PHL','2023-12-20','19:43:20','LGA','2023-12-20','12:05:26',0,1048,'Round Trip',2,570,855,1282.5),('DA','DA403','PHL','2023-12-21','22:23:29','LGA','2023-12-21','13:07:56',0,1049,'Round Trip',0,163,244.5,366.75),('DA','DA403','PHL','2023-12-22','11:37:39','LGA','2023-12-22','16:18:22',0,1050,'Round Trip',1,547,820.5,1230.75),('UA','UA501','PHL','2023-12-17','17:39:58','JFK','2023-12-17','11:21:54',1,1051,'One Way',0,323,484.5,726.75),('UA','UA501','PHL','2023-12-18','04:07:04','JFK','2023-12-18','15:43:21',0,1052,'Round Trip',1,145,217.5,326.25),('UA','UA501','PHL','2023-12-19','15:19:02','JFK','2023-12-19','18:36:53',0,1053,'One Way',1,120,180,270),('UA','UA501','PHL','2023-12-20','10:53:36','JFK','2023-12-20','08:04:37',0,1054,'One Way',1,100,150,225),('UA','UA501','PHL','2023-12-21','00:30:10','JFK','2023-12-21','02:12:02',0,1055,'Round Trip',0,156,234,351),('UA','UA501','PHL','2023-12-22','23:01:03','JFK','2023-12-22','05:39:07',0,1056,'One Way',2,471,706.5,1059.75),('UA','UA501','PHL','2023-12-23','03:02:17','JFK','2023-12-23','10:32:01',0,1057,'Round Trip',0,153,229.5,344.25),('UA','UA503','BOS','2023-12-18','05:38:09','LGA','2023-12-18','17:19:38',0,1058,'One Way',2,163,244.5,366.75),('UA','UA503','BOS','2023-12-19','17:32:06','LGA','2023-12-19','13:17:51',1,1059,'One Way',1,545,817.5,1226.25),('UA','UA503','BOS','2023-12-20','13:28:52','LGA','2023-12-20','02:02:39',0,1060,'Round Trip',2,593,889.5,1334.25),('UA','UA503','BOS','2023-12-21','23:44:09','LGA','2023-12-21','05:35:27',1,1061,'One Way',2,558,837,1255.5),('UA','UA503','BOS','2023-12-22','03:41:49','LGA','2023-12-22','04:55:53',0,1062,'One Way',0,338,507,760.5),('UA','UA503','BOS','2023-12-23','07:54:52','LGA','2023-12-23','16:03:30',0,1063,'Round Trip',2,404,606,909),('UA','UA503','BOS','2023-12-24','09:30:15','LGA','2023-12-24','07:09:29',1,1064,'One Way',1,410,615,922.5),('AA','AA103','BOS','2023-12-19','18:50:28','JFK','2023-12-19','13:55:43',0,1065,'One Way',2,304,456,684),('AA','AA103','BOS','2023-12-20','10:58:50','JFK','2023-12-20','14:18:05',0,1066,'One Way',1,115,172.5,258.75),('AA','AA103','BOS','2023-12-21','23:13:21','JFK','2023-12-21','11:22:04',1,1067,'Round Trip',0,557,835.5,1253.25),('AA','AA103','BOS','2023-12-22','14:05:33','JFK','2023-12-22','06:52:08',0,1068,'One Way',0,532,798,1197),('AA','AA103','BOS','2023-12-23','23:19:34','JFK','2023-12-23','04:09:39',1,1069,'One Way',2,262,393,589.5),('AA','AA103','BOS','2023-12-24','04:18:13','JFK','2023-12-24','17:06:32',0,1070,'Round Trip',1,357,535.5,803.25),('AA','AA103','BOS','2023-12-25','04:05:07','JFK','2023-12-25','10:22:06',0,1071,'One Way',1,516,774,1161),('UA','UA504','LGA','2023-12-20','18:05:18','JFK','2023-12-20','13:18:50',1,1072,'Round Trip',2,363,544.5,816.75),('UA','UA504','LGA','2023-12-21','16:30:00','JFK','2023-12-21','20:36:12',0,1073,'One Way',1,251,376.5,564.75),('UA','UA504','LGA','2023-12-22','12:09:14','JFK','2023-12-22','23:28:58',1,1074,'Round Trip',2,134,201,301.5),('UA','UA504','LGA','2023-12-23','20:59:27','JFK','2023-12-23','18:15:14',1,1075,'One Way',1,502,753,1129.5),('UA','UA504','LGA','2023-12-24','05:41:24','JFK','2023-12-24','22:51:19',0,1076,'One Way',1,448,672,1008),('UA','UA504','LGA','2023-12-25','23:44:40','JFK','2023-12-25','23:05:05',1,1077,'One Way',0,561,841.5,1262.25),('UA','UA504','LGA','2023-12-26','12:53:33','JFK','2023-12-26','10:52:27',0,1078,'Round Trip',1,565,847.5,1271.25);
/*!40000 ALTER TABLE `flights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qna`
--

DROP TABLE IF EXISTS `qna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qna` (
  `question` varchar(3000) DEFAULT NULL,
  `answer` varchar(3000) DEFAULT NULL,
  `q_id` int NOT NULL AUTO_INCREMENT,
  `customer` varchar(300) DEFAULT NULL,
  `answered_by` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`q_id`),
  KEY `customer` (`customer`),
  CONSTRAINT `qna_ibfk_1` FOREIGN KEY (`customer`) REFERENCES `customer` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qna`
--

LOCK TABLES `qna` WRITE;
/*!40000 ALTER TABLE `qna` DISABLE KEYS */;
INSERT INTO `qna` VALUES ('How can I change the date of my flight?','You cannot change the date of your flight, You will need to purchase a different ticket',1,'user123','Mike'),('What is the baggage allowance for my flight to Paris?','The baggage allowance varies depending on your ticket type. Please refer to your ticket details for specific information.',2,'user456','Josh'),('Can I book a seat with extra legroom?',NULL,3,'user789',NULL),('Is it possible to get a refund if I cancel my flight?','Yes, you can get a refund, but it depends on the type of ticket you purchased. Please check our cancellation policy.',4,'user123','Sean'),('How do I add a meal preference to my booking?',NULL,5,'user456',NULL);
/*!40000 ALTER TABLE `qna` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket` (
  `username` varchar(300) NOT NULL,
  `from_airport` varchar(5) NOT NULL,
  `to_airport` varchar(5) NOT NULL,
  `from_date` date NOT NULL,
  `from_time` time NOT NULL,
  `airline_id` varchar(5) NOT NULL,
  `aircraft_id` varchar(5) NOT NULL,
  `flight_num` int NOT NULL,
  `seat_num` int NOT NULL,
  `class` varchar(20) NOT NULL,
  `f_Name` varchar(100) NOT NULL,
  `l_Name` varchar(100) NOT NULL,
  `id_num` int NOT NULL AUTO_INCREMENT,
  `total_fare` float NOT NULL,
  `p_date` date NOT NULL,
  `p_time` time NOT NULL,
  `num_stops` int DEFAULT NULL,
  PRIMARY KEY (`id_num`),
  KEY `username` (`username`),
  KEY `airline_id` (`airline_id`),
  KEY `aircraft_id` (`aircraft_id`),
  KEY `from_airport` (`from_airport`),
  KEY `to_airport` (`to_airport`),
  KEY `flight_num` (`flight_num`),
  CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`username`) REFERENCES `customer` (`username`),
  CONSTRAINT `ticket_ibfk_2` FOREIGN KEY (`airline_id`) REFERENCES `airline` (`airline_id`),
  CONSTRAINT `ticket_ibfk_3` FOREIGN KEY (`aircraft_id`) REFERENCES `aircraft` (`aircraft_id`),
  CONSTRAINT `ticket_ibfk_4` FOREIGN KEY (`from_airport`) REFERENCES `airport` (`airport_id`),
  CONSTRAINT `ticket_ibfk_5` FOREIGN KEY (`to_airport`) REFERENCES `airport` (`airport_id`),
  CONSTRAINT `ticket_ibfk_6` FOREIGN KEY (`flight_num`) REFERENCES `flights` (`flight_num`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
INSERT INTO `ticket` VALUES ('user123','BOS','EWR','2023-12-15','09:30:00','AA','AA101',1000,15,'Economy','Alice','Smith',10001,350.5,'2023-12-10','07:00:00',0),('user456','PHL','JFK','2023-12-20','17:45:00','DA','DA402',1003,21,'Business','Bob','Johnson',10002,450.75,'2023-12-15','16:00:00',0),('user789','LGA','EWR','2023-12-18','06:00:00','UA','UA502',1005,10,'First Class','Carol','Davis',10003,550,'2023-12-12','20:30:00',0),('user123','JFK','BOS','2023-12-22','11:15:00','AA','AA102',1007,30,'Economy','Dave','Wilson',10004,300,'2023-12-17','10:00:00',0),('user456','EWR','PHL','2023-12-25','20:00:00','DA','DA401',1009,25,'Business','Eve','Miller',10005,400.25,'2023-12-20','18:30:00',0),('user789','JFK','LGA','2024-01-05','14:00:00','AA','AA102',1000,32,'Economy','Frank','Brown',10006,360,'2024-01-01','12:00:00',0),('user123','EWR','PHL','2024-01-10','08:15:00','UA','UA501',1005,16,'First Class','Grace','Taylor',10007,600,'2024-01-05','07:00:00',0),('user456','BOS','EWR','2024-01-12','19:30:00','DA','DA402',1005,24,'Business','Henry','White',10008,500,'2024-01-08','18:00:00',0),('user789','LGA','JFK','2024-01-15','06:45:00','AA','AA101',1003,8,'Economy','Irene','Harris',10009,320,'2024-01-10','05:30:00',0),('user123','PHL','BOS','2024-01-18','21:00:00','UA','UA502',1008,20,'Business','Jack','Martinez',10010,480,'2024-01-14','20:00:00',0),('user123','BOS','PHL','2023-12-16','20:54:42','UA','UA502',1038,17,'Business','Adam','Rog',10011,925.5,'2023-12-12','20:57:34',0);
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waitlist`
--

DROP TABLE IF EXISTS `waitlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `waitlist` (
  `username` varchar(300) DEFAULT NULL,
  `flight_num` int DEFAULT NULL,
  `f_name` varchar(100) DEFAULT NULL,
  `l_name` varchar(100) DEFAULT NULL,
  KEY `username` (`username`),
  KEY `flight_num` (`flight_num`),
  CONSTRAINT `waitlist_ibfk_1` FOREIGN KEY (`username`) REFERENCES `customer` (`username`),
  CONSTRAINT `waitlist_ibfk_2` FOREIGN KEY (`flight_num`) REFERENCES `flights` (`flight_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waitlist`
--

LOCK TABLES `waitlist` WRITE;
/*!40000 ALTER TABLE `waitlist` DISABLE KEYS */;
INSERT INTO `waitlist` VALUES ('user123',1001,'Michael', 'Scott');
/*!40000 ALTER TABLE `waitlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-12 21:18:24
