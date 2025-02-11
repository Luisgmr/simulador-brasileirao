-- MySQL dump 10.13  Distrib 8.0.40, for macos14 (arm64)
--
-- Host: 100.104.103.66    Database: brasileirao
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `partidas`
--

DROP TABLE IF EXISTS `partidas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `partidas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `time_casa_id` int NOT NULL,
  `time_fora_id` int NOT NULL,
  `gols_casa` int DEFAULT '0',
  `gols_fora` int DEFAULT '0',
  `data_partida` datetime NOT NULL,
  `rodada` int NOT NULL,
  `campeonato` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `time_casa_id` (`time_casa_id`),
  KEY `time_fora_id` (`time_fora_id`),
  CONSTRAINT `partidas_ibfk_1` FOREIGN KEY (`time_casa_id`) REFERENCES `times` (`id`) ON DELETE CASCADE,
  CONSTRAINT `partidas_ibfk_2` FOREIGN KEY (`time_fora_id`) REFERENCES `times` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=381 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partidas`
--

LOCK TABLES `partidas` WRITE;
/*!40000 ALTER TABLE `partidas` DISABLE KEYS */;
INSERT INTO `partidas` VALUES (1,13,20,NULL,NULL,'2024-04-01 15:00:00',1,'Brasileirao2024'),(2,19,12,NULL,NULL,'2024-04-01 15:00:00',1,'Brasileirao2024'),(3,14,6,NULL,NULL,'2024-04-01 15:00:00',1,'Brasileirao2024'),(4,8,16,NULL,NULL,'2024-04-01 15:00:00',1,'Brasileirao2024'),(5,1,2,NULL,NULL,'2024-04-01 15:00:00',1,'Brasileirao2024'),(6,7,17,NULL,NULL,'2024-04-01 15:00:00',1,'Brasileirao2024'),(7,18,5,NULL,NULL,'2024-04-01 15:00:00',1,'Brasileirao2024'),(8,11,9,NULL,NULL,'2024-04-01 15:00:00',1,'Brasileirao2024'),(9,15,4,NULL,NULL,'2024-04-01 15:00:00',1,'Brasileirao2024'),(10,3,10,NULL,NULL,'2024-04-01 15:00:00',1,'Brasileirao2024'),(11,6,13,NULL,NULL,'2024-04-04 15:00:00',2,'Brasileirao2024'),(12,12,20,NULL,NULL,'2024-04-04 15:00:00',2,'Brasileirao2024'),(13,16,19,NULL,NULL,'2024-04-04 15:00:00',2,'Brasileirao2024'),(14,2,14,3,1,'2024-04-04 15:00:00',2,'Brasileirao2024'),(15,17,8,NULL,NULL,'2024-04-04 15:00:00',2,'Brasileirao2024'),(16,5,1,NULL,NULL,'2024-04-04 15:00:00',2,'Brasileirao2024'),(17,9,7,NULL,NULL,'2024-04-04 15:00:00',2,'Brasileirao2024'),(18,4,18,NULL,NULL,'2024-04-04 15:00:00',2,'Brasileirao2024'),(19,10,11,NULL,NULL,'2024-04-04 15:00:00',2,'Brasileirao2024'),(20,3,15,NULL,NULL,'2024-04-04 15:00:00',2,'Brasileirao2024'),(21,13,2,NULL,NULL,'2024-04-07 15:00:00',3,'Brasileirao2024'),(22,12,6,NULL,NULL,'2024-04-07 15:00:00',3,'Brasileirao2024'),(23,20,16,NULL,NULL,'2024-04-07 15:00:00',3,'Brasileirao2024'),(24,19,17,NULL,NULL,'2024-04-07 15:00:00',3,'Brasileirao2024'),(25,14,5,NULL,NULL,'2024-04-07 15:00:00',3,'Brasileirao2024'),(26,8,9,NULL,NULL,'2024-04-07 15:00:00',3,'Brasileirao2024'),(27,1,4,NULL,NULL,'2024-04-07 15:00:00',3,'Brasileirao2024'),(28,7,10,NULL,NULL,'2024-04-07 15:00:00',3,'Brasileirao2024'),(29,18,3,NULL,NULL,'2024-04-07 15:00:00',3,'Brasileirao2024'),(30,11,15,NULL,NULL,'2024-04-07 15:00:00',3,'Brasileirao2024'),(31,5,13,NULL,NULL,'2024-04-10 15:00:00',4,'Brasileirao2024'),(32,16,6,NULL,NULL,'2024-04-10 15:00:00',4,'Brasileirao2024'),(33,2,12,NULL,NULL,'2024-04-10 15:00:00',4,'Brasileirao2024'),(34,17,20,NULL,NULL,'2024-04-10 15:00:00',4,'Brasileirao2024'),(35,9,19,NULL,NULL,'2024-04-10 15:00:00',4,'Brasileirao2024'),(36,4,14,NULL,NULL,'2024-04-10 15:00:00',4,'Brasileirao2024'),(37,10,8,NULL,NULL,'2024-04-10 15:00:00',4,'Brasileirao2024'),(38,3,1,NULL,NULL,'2024-04-10 15:00:00',4,'Brasileirao2024'),(39,15,7,NULL,NULL,'2024-04-10 15:00:00',4,'Brasileirao2024'),(40,11,18,NULL,NULL,'2024-04-10 15:00:00',4,'Brasileirao2024'),(41,13,4,NULL,NULL,'2024-04-13 15:00:00',5,'Brasileirao2024'),(42,16,2,NULL,NULL,'2024-04-13 15:00:00',5,'Brasileirao2024'),(43,6,17,NULL,NULL,'2024-04-13 15:00:00',5,'Brasileirao2024'),(44,12,5,NULL,NULL,'2024-04-13 15:00:00',5,'Brasileirao2024'),(45,20,9,NULL,NULL,'2024-04-13 15:00:00',5,'Brasileirao2024'),(46,19,10,NULL,NULL,'2024-04-13 15:00:00',5,'Brasileirao2024'),(47,14,3,NULL,NULL,'2024-04-13 15:00:00',5,'Brasileirao2024'),(48,8,15,NULL,NULL,'2024-04-13 15:00:00',5,'Brasileirao2024'),(49,1,11,NULL,NULL,'2024-04-13 15:00:00',5,'Brasileirao2024'),(50,7,18,NULL,NULL,'2024-04-13 15:00:00',5,'Brasileirao2024'),(51,3,13,NULL,NULL,'2024-04-16 15:00:00',6,'Brasileirao2024'),(52,17,2,NULL,NULL,'2024-04-16 15:00:00',6,'Brasileirao2024'),(53,5,16,NULL,NULL,'2024-04-16 15:00:00',6,'Brasileirao2024'),(54,9,6,NULL,NULL,'2024-04-16 15:00:00',6,'Brasileirao2024'),(55,4,12,NULL,NULL,'2024-04-16 15:00:00',6,'Brasileirao2024'),(56,10,20,NULL,NULL,'2024-04-16 15:00:00',6,'Brasileirao2024'),(57,15,19,NULL,NULL,'2024-04-16 15:00:00',6,'Brasileirao2024'),(58,11,14,NULL,NULL,'2024-04-16 15:00:00',6,'Brasileirao2024'),(59,18,8,NULL,NULL,'2024-04-16 15:00:00',6,'Brasileirao2024'),(60,7,1,NULL,NULL,'2024-04-16 15:00:00',6,'Brasileirao2024'),(61,13,11,NULL,NULL,'2024-04-19 15:00:00',7,'Brasileirao2024'),(62,17,5,NULL,NULL,'2024-04-19 15:00:00',7,'Brasileirao2024'),(63,2,9,NULL,NULL,'2024-04-19 15:00:00',7,'Brasileirao2024'),(64,16,4,NULL,NULL,'2024-04-19 15:00:00',7,'Brasileirao2024'),(65,6,10,NULL,NULL,'2024-04-19 15:00:00',7,'Brasileirao2024'),(66,12,3,NULL,NULL,'2024-04-19 15:00:00',7,'Brasileirao2024'),(67,20,15,NULL,NULL,'2024-04-19 15:00:00',7,'Brasileirao2024'),(68,19,18,NULL,NULL,'2024-04-19 15:00:00',7,'Brasileirao2024'),(69,14,7,NULL,NULL,'2024-04-19 15:00:00',7,'Brasileirao2024'),(70,8,1,NULL,NULL,'2024-04-19 15:00:00',7,'Brasileirao2024'),(71,7,13,NULL,NULL,'2024-04-22 15:00:00',8,'Brasileirao2024'),(72,9,5,NULL,NULL,'2024-04-22 15:00:00',8,'Brasileirao2024'),(73,4,17,NULL,NULL,'2024-04-22 15:00:00',8,'Brasileirao2024'),(74,10,2,NULL,NULL,'2024-04-22 15:00:00',8,'Brasileirao2024'),(75,3,16,NULL,NULL,'2024-04-22 15:00:00',8,'Brasileirao2024'),(76,15,6,NULL,NULL,'2024-04-22 15:00:00',8,'Brasileirao2024'),(77,11,12,NULL,NULL,'2024-04-22 15:00:00',8,'Brasileirao2024'),(78,18,20,NULL,NULL,'2024-04-22 15:00:00',8,'Brasileirao2024'),(79,1,19,NULL,NULL,'2024-04-22 15:00:00',8,'Brasileirao2024'),(80,8,14,NULL,NULL,'2024-04-22 15:00:00',8,'Brasileirao2024'),(81,13,8,NULL,NULL,'2024-04-25 15:00:00',9,'Brasileirao2024'),(82,9,4,NULL,NULL,'2024-04-25 15:00:00',9,'Brasileirao2024'),(83,5,10,NULL,NULL,'2024-04-25 15:00:00',9,'Brasileirao2024'),(84,17,3,NULL,NULL,'2024-04-25 15:00:00',9,'Brasileirao2024'),(85,2,15,NULL,NULL,'2024-04-25 15:00:00',9,'Brasileirao2024'),(86,16,11,NULL,NULL,'2024-04-25 15:00:00',9,'Brasileirao2024'),(87,6,18,NULL,NULL,'2024-04-25 15:00:00',9,'Brasileirao2024'),(88,12,7,NULL,NULL,'2024-04-25 15:00:00',9,'Brasileirao2024'),(89,20,1,NULL,NULL,'2024-04-25 15:00:00',9,'Brasileirao2024'),(90,19,14,NULL,NULL,'2024-04-25 15:00:00',9,'Brasileirao2024'),(91,19,13,NULL,NULL,'2024-04-28 15:00:00',10,'Brasileirao2024'),(92,10,4,NULL,NULL,'2024-04-28 15:00:00',10,'Brasileirao2024'),(93,3,9,NULL,NULL,'2024-04-28 15:00:00',10,'Brasileirao2024'),(94,15,5,NULL,NULL,'2024-04-28 15:00:00',10,'Brasileirao2024'),(95,11,17,NULL,NULL,'2024-04-28 15:00:00',10,'Brasileirao2024'),(96,18,2,NULL,NULL,'2024-04-28 15:00:00',10,'Brasileirao2024'),(97,7,16,NULL,NULL,'2024-04-28 15:00:00',10,'Brasileirao2024'),(98,1,6,NULL,NULL,'2024-04-28 15:00:00',10,'Brasileirao2024'),(99,8,12,NULL,NULL,'2024-04-28 15:00:00',10,'Brasileirao2024'),(100,14,20,NULL,NULL,'2024-04-28 15:00:00',10,'Brasileirao2024'),(101,13,12,NULL,NULL,'2024-05-01 15:00:00',11,'Brasileirao2024'),(102,10,3,NULL,NULL,'2024-05-01 15:00:00',11,'Brasileirao2024'),(103,4,15,NULL,NULL,'2024-05-01 15:00:00',11,'Brasileirao2024'),(104,9,11,NULL,NULL,'2024-05-01 15:00:00',11,'Brasileirao2024'),(105,5,18,NULL,NULL,'2024-05-01 15:00:00',11,'Brasileirao2024'),(106,17,7,NULL,NULL,'2024-05-01 15:00:00',11,'Brasileirao2024'),(107,2,1,NULL,NULL,'2024-05-01 15:00:00',11,'Brasileirao2024'),(108,16,8,NULL,NULL,'2024-05-01 15:00:00',11,'Brasileirao2024'),(109,6,14,NULL,NULL,'2024-05-01 15:00:00',11,'Brasileirao2024'),(110,20,19,NULL,NULL,'2024-05-01 15:00:00',11,'Brasileirao2024'),(111,16,13,NULL,NULL,'2024-05-04 15:00:00',12,'Brasileirao2024'),(112,15,3,NULL,NULL,'2024-05-04 15:00:00',12,'Brasileirao2024'),(113,11,10,NULL,NULL,'2024-05-04 15:00:00',12,'Brasileirao2024'),(114,18,4,NULL,NULL,'2024-05-04 15:00:00',12,'Brasileirao2024'),(115,7,9,NULL,NULL,'2024-05-04 15:00:00',12,'Brasileirao2024'),(116,1,5,NULL,NULL,'2024-05-04 15:00:00',12,'Brasileirao2024'),(117,8,17,NULL,NULL,'2024-05-04 15:00:00',12,'Brasileirao2024'),(118,14,2,NULL,NULL,'2024-05-04 15:00:00',12,'Brasileirao2024'),(119,19,6,NULL,NULL,'2024-05-04 15:00:00',12,'Brasileirao2024'),(120,20,12,NULL,NULL,'2024-05-04 15:00:00',12,'Brasileirao2024'),(121,13,17,NULL,NULL,'2024-05-07 15:00:00',13,'Brasileirao2024'),(122,15,11,NULL,NULL,'2024-05-07 15:00:00',13,'Brasileirao2024'),(123,3,18,NULL,NULL,'2024-05-07 15:00:00',13,'Brasileirao2024'),(124,10,7,NULL,NULL,'2024-05-07 15:00:00',13,'Brasileirao2024'),(125,4,1,NULL,NULL,'2024-05-07 15:00:00',13,'Brasileirao2024'),(126,9,8,NULL,NULL,'2024-05-07 15:00:00',13,'Brasileirao2024'),(127,5,14,NULL,NULL,'2024-05-07 15:00:00',13,'Brasileirao2024'),(128,2,19,NULL,NULL,'2024-05-07 15:00:00',13,'Brasileirao2024'),(129,16,20,NULL,NULL,'2024-05-07 15:00:00',13,'Brasileirao2024'),(130,6,12,NULL,NULL,'2024-05-07 15:00:00',13,'Brasileirao2024'),(131,9,13,NULL,NULL,'2024-05-10 15:00:00',14,'Brasileirao2024'),(132,18,11,NULL,NULL,'2024-05-10 15:00:00',14,'Brasileirao2024'),(133,7,15,NULL,NULL,'2024-05-10 15:00:00',14,'Brasileirao2024'),(134,1,3,NULL,NULL,'2024-05-10 15:00:00',14,'Brasileirao2024'),(135,8,10,NULL,NULL,'2024-05-10 15:00:00',14,'Brasileirao2024'),(136,14,4,NULL,NULL,'2024-05-10 15:00:00',14,'Brasileirao2024'),(137,19,5,NULL,NULL,'2024-05-10 15:00:00',14,'Brasileirao2024'),(138,20,17,NULL,NULL,'2024-05-10 15:00:00',14,'Brasileirao2024'),(139,12,2,NULL,NULL,'2024-05-10 15:00:00',14,'Brasileirao2024'),(140,6,16,NULL,NULL,'2024-05-10 15:00:00',14,'Brasileirao2024'),(141,13,10,NULL,NULL,'2024-05-13 15:00:00',15,'Brasileirao2024'),(142,18,7,NULL,NULL,'2024-05-13 15:00:00',15,'Brasileirao2024'),(143,11,1,NULL,NULL,'2024-05-13 15:00:00',15,'Brasileirao2024'),(144,15,8,NULL,NULL,'2024-05-13 15:00:00',15,'Brasileirao2024'),(145,3,14,NULL,NULL,'2024-05-13 15:00:00',15,'Brasileirao2024'),(146,4,19,NULL,NULL,'2024-05-13 15:00:00',15,'Brasileirao2024'),(147,9,20,NULL,NULL,'2024-05-13 15:00:00',15,'Brasileirao2024'),(148,5,12,NULL,NULL,'2024-05-13 15:00:00',15,'Brasileirao2024'),(149,17,6,NULL,NULL,'2024-05-13 15:00:00',15,'Brasileirao2024'),(150,2,16,NULL,NULL,'2024-05-13 15:00:00',15,'Brasileirao2024'),(151,15,13,NULL,NULL,'2024-05-16 15:00:00',16,'Brasileirao2024'),(152,1,7,NULL,NULL,'2024-05-16 15:00:00',16,'Brasileirao2024'),(153,8,18,NULL,NULL,'2024-05-16 15:00:00',16,'Brasileirao2024'),(154,14,11,NULL,NULL,'2024-05-16 15:00:00',16,'Brasileirao2024'),(155,19,3,NULL,NULL,'2024-05-16 15:00:00',16,'Brasileirao2024'),(156,20,10,NULL,NULL,'2024-05-16 15:00:00',16,'Brasileirao2024'),(157,12,4,NULL,NULL,'2024-05-16 15:00:00',16,'Brasileirao2024'),(158,6,9,NULL,NULL,'2024-05-16 15:00:00',16,'Brasileirao2024'),(159,16,5,NULL,NULL,'2024-05-16 15:00:00',16,'Brasileirao2024'),(160,2,17,NULL,NULL,'2024-05-16 15:00:00',16,'Brasileirao2024'),(161,13,18,NULL,NULL,'2024-05-19 15:00:00',17,'Brasileirao2024'),(162,1,8,NULL,NULL,'2024-05-19 15:00:00',17,'Brasileirao2024'),(163,7,14,NULL,NULL,'2024-05-19 15:00:00',17,'Brasileirao2024'),(164,11,19,NULL,NULL,'2024-05-19 15:00:00',17,'Brasileirao2024'),(165,15,20,NULL,NULL,'2024-05-19 15:00:00',17,'Brasileirao2024'),(166,3,12,NULL,NULL,'2024-05-19 15:00:00',17,'Brasileirao2024'),(167,10,6,NULL,NULL,'2024-05-19 15:00:00',17,'Brasileirao2024'),(168,4,16,NULL,NULL,'2024-05-19 15:00:00',17,'Brasileirao2024'),(169,9,2,NULL,NULL,'2024-05-19 15:00:00',17,'Brasileirao2024'),(170,5,17,NULL,NULL,'2024-05-19 15:00:00',17,'Brasileirao2024'),(171,1,13,NULL,NULL,'2024-05-22 15:00:00',18,'Brasileirao2024'),(172,14,8,NULL,NULL,'2024-05-22 15:00:00',18,'Brasileirao2024'),(173,19,7,NULL,NULL,'2024-05-22 15:00:00',18,'Brasileirao2024'),(174,20,18,NULL,NULL,'2024-05-22 15:00:00',18,'Brasileirao2024'),(175,12,11,NULL,NULL,'2024-05-22 15:00:00',18,'Brasileirao2024'),(176,6,15,NULL,NULL,'2024-05-22 15:00:00',18,'Brasileirao2024'),(177,16,3,NULL,NULL,'2024-05-22 15:00:00',18,'Brasileirao2024'),(178,2,10,NULL,NULL,'2024-05-22 15:00:00',18,'Brasileirao2024'),(179,17,4,NULL,NULL,'2024-05-22 15:00:00',18,'Brasileirao2024'),(180,5,9,NULL,NULL,'2024-05-22 15:00:00',18,'Brasileirao2024'),(181,13,14,NULL,NULL,'2024-05-25 15:00:00',19,'Brasileirao2024'),(182,8,19,NULL,NULL,'2024-05-25 15:00:00',19,'Brasileirao2024'),(183,1,20,NULL,NULL,'2024-05-25 15:00:00',19,'Brasileirao2024'),(184,7,12,NULL,NULL,'2024-05-25 15:00:00',19,'Brasileirao2024'),(185,18,6,NULL,NULL,'2024-05-25 15:00:00',19,'Brasileirao2024'),(186,11,16,NULL,NULL,'2024-05-25 15:00:00',19,'Brasileirao2024'),(187,15,2,NULL,NULL,'2024-05-25 15:00:00',19,'Brasileirao2024'),(188,3,17,NULL,NULL,'2024-05-25 15:00:00',19,'Brasileirao2024'),(189,10,5,NULL,NULL,'2024-05-25 15:00:00',19,'Brasileirao2024'),(190,4,9,NULL,NULL,'2024-05-25 15:00:00',19,'Brasileirao2024'),(191,20,13,NULL,NULL,'2024-05-28 15:00:00',20,'Brasileirao2024'),(192,12,19,NULL,NULL,'2024-05-28 15:00:00',20,'Brasileirao2024'),(193,6,14,NULL,NULL,'2024-05-28 15:00:00',20,'Brasileirao2024'),(194,16,8,NULL,NULL,'2024-05-28 15:00:00',20,'Brasileirao2024'),(195,2,1,NULL,NULL,'2024-05-28 15:00:00',20,'Brasileirao2024'),(196,17,7,NULL,NULL,'2024-05-28 15:00:00',20,'Brasileirao2024'),(197,5,18,NULL,NULL,'2024-05-28 15:00:00',20,'Brasileirao2024'),(198,9,11,NULL,NULL,'2024-05-28 15:00:00',20,'Brasileirao2024'),(199,4,15,NULL,NULL,'2024-05-28 15:00:00',20,'Brasileirao2024'),(200,10,3,NULL,NULL,'2024-05-28 15:00:00',20,'Brasileirao2024'),(201,13,6,NULL,NULL,'2024-05-31 15:00:00',21,'Brasileirao2024'),(202,20,12,NULL,NULL,'2024-05-31 15:00:00',21,'Brasileirao2024'),(203,19,16,NULL,NULL,'2024-05-31 15:00:00',21,'Brasileirao2024'),(204,14,2,NULL,NULL,'2024-05-31 15:00:00',21,'Brasileirao2024'),(205,8,17,NULL,NULL,'2024-05-31 15:00:00',21,'Brasileirao2024'),(206,1,5,NULL,NULL,'2024-05-31 15:00:00',21,'Brasileirao2024'),(207,7,9,NULL,NULL,'2024-05-31 15:00:00',21,'Brasileirao2024'),(208,18,4,NULL,NULL,'2024-05-31 15:00:00',21,'Brasileirao2024'),(209,11,10,NULL,NULL,'2024-05-31 15:00:00',21,'Brasileirao2024'),(210,15,3,NULL,NULL,'2024-05-31 15:00:00',21,'Brasileirao2024'),(211,2,13,NULL,NULL,'2024-06-03 15:00:00',22,'Brasileirao2024'),(212,6,12,NULL,NULL,'2024-06-03 15:00:00',22,'Brasileirao2024'),(213,16,20,NULL,NULL,'2024-06-03 15:00:00',22,'Brasileirao2024'),(214,17,19,NULL,NULL,'2024-06-03 15:00:00',22,'Brasileirao2024'),(215,5,14,NULL,NULL,'2024-06-03 15:00:00',22,'Brasileirao2024'),(216,9,8,NULL,NULL,'2024-06-03 15:00:00',22,'Brasileirao2024'),(217,4,1,NULL,NULL,'2024-06-03 15:00:00',22,'Brasileirao2024'),(218,10,7,NULL,NULL,'2024-06-03 15:00:00',22,'Brasileirao2024'),(219,3,18,NULL,NULL,'2024-06-03 15:00:00',22,'Brasileirao2024'),(220,15,11,NULL,NULL,'2024-06-03 15:00:00',22,'Brasileirao2024'),(221,13,5,NULL,NULL,'2024-06-06 15:00:00',23,'Brasileirao2024'),(222,6,16,NULL,NULL,'2024-06-06 15:00:00',23,'Brasileirao2024'),(223,12,2,NULL,NULL,'2024-06-06 15:00:00',23,'Brasileirao2024'),(224,20,17,NULL,NULL,'2024-06-06 15:00:00',23,'Brasileirao2024'),(225,19,9,NULL,NULL,'2024-06-06 15:00:00',23,'Brasileirao2024'),(226,14,4,NULL,NULL,'2024-06-06 15:00:00',23,'Brasileirao2024'),(227,8,10,NULL,NULL,'2024-06-06 15:00:00',23,'Brasileirao2024'),(228,1,3,NULL,NULL,'2024-06-06 15:00:00',23,'Brasileirao2024'),(229,7,15,NULL,NULL,'2024-06-06 15:00:00',23,'Brasileirao2024'),(230,18,11,NULL,NULL,'2024-06-06 15:00:00',23,'Brasileirao2024'),(231,4,13,NULL,NULL,'2024-06-09 15:00:00',24,'Brasileirao2024'),(232,2,16,NULL,NULL,'2024-06-09 15:00:00',24,'Brasileirao2024'),(233,17,6,NULL,NULL,'2024-06-09 15:00:00',24,'Brasileirao2024'),(234,5,12,NULL,NULL,'2024-06-09 15:00:00',24,'Brasileirao2024'),(235,9,20,NULL,NULL,'2024-06-09 15:00:00',24,'Brasileirao2024'),(236,10,19,NULL,NULL,'2024-06-09 15:00:00',24,'Brasileirao2024'),(237,3,14,NULL,NULL,'2024-06-09 15:00:00',24,'Brasileirao2024'),(238,15,8,NULL,NULL,'2024-06-09 15:00:00',24,'Brasileirao2024'),(239,11,1,NULL,NULL,'2024-06-09 15:00:00',24,'Brasileirao2024'),(240,18,7,NULL,NULL,'2024-06-09 15:00:00',24,'Brasileirao2024'),(241,13,3,NULL,NULL,'2024-06-12 15:00:00',25,'Brasileirao2024'),(242,2,17,NULL,NULL,'2024-06-12 15:00:00',25,'Brasileirao2024'),(243,16,5,NULL,NULL,'2024-06-12 15:00:00',25,'Brasileirao2024'),(244,6,9,NULL,NULL,'2024-06-12 15:00:00',25,'Brasileirao2024'),(245,12,4,NULL,NULL,'2024-06-12 15:00:00',25,'Brasileirao2024'),(246,20,10,NULL,NULL,'2024-06-12 15:00:00',25,'Brasileirao2024'),(247,19,15,NULL,NULL,'2024-06-12 15:00:00',25,'Brasileirao2024'),(248,14,11,NULL,NULL,'2024-06-12 15:00:00',25,'Brasileirao2024'),(249,8,18,NULL,NULL,'2024-06-12 15:00:00',25,'Brasileirao2024'),(250,1,7,NULL,NULL,'2024-06-12 15:00:00',25,'Brasileirao2024'),(251,11,13,NULL,NULL,'2024-06-15 15:00:00',26,'Brasileirao2024'),(252,5,17,NULL,NULL,'2024-06-15 15:00:00',26,'Brasileirao2024'),(253,9,2,NULL,NULL,'2024-06-15 15:00:00',26,'Brasileirao2024'),(254,4,16,NULL,NULL,'2024-06-15 15:00:00',26,'Brasileirao2024'),(255,10,6,NULL,NULL,'2024-06-15 15:00:00',26,'Brasileirao2024'),(256,3,12,NULL,NULL,'2024-06-15 15:00:00',26,'Brasileirao2024'),(257,15,20,NULL,NULL,'2024-06-15 15:00:00',26,'Brasileirao2024'),(258,18,19,NULL,NULL,'2024-06-15 15:00:00',26,'Brasileirao2024'),(259,7,14,NULL,NULL,'2024-06-15 15:00:00',26,'Brasileirao2024'),(260,1,8,NULL,NULL,'2024-06-15 15:00:00',26,'Brasileirao2024'),(261,13,7,NULL,NULL,'2024-06-18 15:00:00',27,'Brasileirao2024'),(262,5,9,NULL,NULL,'2024-06-18 15:00:00',27,'Brasileirao2024'),(263,17,4,NULL,NULL,'2024-06-18 15:00:00',27,'Brasileirao2024'),(264,2,10,NULL,NULL,'2024-06-18 15:00:00',27,'Brasileirao2024'),(265,16,3,NULL,NULL,'2024-06-18 15:00:00',27,'Brasileirao2024'),(266,6,15,NULL,NULL,'2024-06-18 15:00:00',27,'Brasileirao2024'),(267,12,11,NULL,NULL,'2024-06-18 15:00:00',27,'Brasileirao2024'),(268,20,18,NULL,NULL,'2024-06-18 15:00:00',27,'Brasileirao2024'),(269,19,1,NULL,NULL,'2024-06-18 15:00:00',27,'Brasileirao2024'),(270,14,8,NULL,NULL,'2024-06-18 15:00:00',27,'Brasileirao2024'),(271,8,13,NULL,NULL,'2024-06-21 15:00:00',28,'Brasileirao2024'),(272,4,9,NULL,NULL,'2024-06-21 15:00:00',28,'Brasileirao2024'),(273,10,5,NULL,NULL,'2024-06-21 15:00:00',28,'Brasileirao2024'),(274,3,17,NULL,NULL,'2024-06-21 15:00:00',28,'Brasileirao2024'),(275,15,2,NULL,NULL,'2024-06-21 15:00:00',28,'Brasileirao2024'),(276,11,16,NULL,NULL,'2024-06-21 15:00:00',28,'Brasileirao2024'),(277,18,6,NULL,NULL,'2024-06-21 15:00:00',28,'Brasileirao2024'),(278,7,12,NULL,NULL,'2024-06-21 15:00:00',28,'Brasileirao2024'),(279,1,20,NULL,NULL,'2024-06-21 15:00:00',28,'Brasileirao2024'),(280,14,19,NULL,NULL,'2024-06-21 15:00:00',28,'Brasileirao2024'),(281,13,19,NULL,NULL,'2024-06-24 15:00:00',29,'Brasileirao2024'),(282,4,10,NULL,NULL,'2024-06-24 15:00:00',29,'Brasileirao2024'),(283,9,3,NULL,NULL,'2024-06-24 15:00:00',29,'Brasileirao2024'),(284,5,15,NULL,NULL,'2024-06-24 15:00:00',29,'Brasileirao2024'),(285,17,11,NULL,NULL,'2024-06-24 15:00:00',29,'Brasileirao2024'),(286,2,18,NULL,NULL,'2024-06-24 15:00:00',29,'Brasileirao2024'),(287,16,7,NULL,NULL,'2024-06-24 15:00:00',29,'Brasileirao2024'),(288,6,1,NULL,NULL,'2024-06-24 15:00:00',29,'Brasileirao2024'),(289,12,8,NULL,NULL,'2024-06-24 15:00:00',29,'Brasileirao2024'),(290,20,14,NULL,NULL,'2024-06-24 15:00:00',29,'Brasileirao2024'),(291,12,13,NULL,NULL,'2024-06-27 15:00:00',30,'Brasileirao2024'),(292,3,10,NULL,NULL,'2024-06-27 15:00:00',30,'Brasileirao2024'),(293,15,4,NULL,NULL,'2024-06-27 15:00:00',30,'Brasileirao2024'),(294,11,9,NULL,NULL,'2024-06-27 15:00:00',30,'Brasileirao2024'),(295,18,5,NULL,NULL,'2024-06-27 15:00:00',30,'Brasileirao2024'),(296,7,17,NULL,NULL,'2024-06-27 15:00:00',30,'Brasileirao2024'),(297,1,2,NULL,NULL,'2024-06-27 15:00:00',30,'Brasileirao2024'),(298,8,16,NULL,NULL,'2024-06-27 15:00:00',30,'Brasileirao2024'),(299,14,6,NULL,NULL,'2024-06-27 15:00:00',30,'Brasileirao2024'),(300,19,20,NULL,NULL,'2024-06-27 15:00:00',30,'Brasileirao2024'),(301,13,16,NULL,NULL,'2024-06-30 15:00:00',31,'Brasileirao2024'),(302,3,15,NULL,NULL,'2024-06-30 15:00:00',31,'Brasileirao2024'),(303,10,11,NULL,NULL,'2024-06-30 15:00:00',31,'Brasileirao2024'),(304,4,18,NULL,NULL,'2024-06-30 15:00:00',31,'Brasileirao2024'),(305,9,7,NULL,NULL,'2024-06-30 15:00:00',31,'Brasileirao2024'),(306,5,1,NULL,NULL,'2024-06-30 15:00:00',31,'Brasileirao2024'),(307,17,8,NULL,NULL,'2024-06-30 15:00:00',31,'Brasileirao2024'),(308,2,14,NULL,NULL,'2024-06-30 15:00:00',31,'Brasileirao2024'),(309,6,19,NULL,NULL,'2024-06-30 15:00:00',31,'Brasileirao2024'),(310,12,20,NULL,NULL,'2024-06-30 15:00:00',31,'Brasileirao2024'),(311,17,13,NULL,NULL,'2024-07-03 15:00:00',32,'Brasileirao2024'),(312,11,15,NULL,NULL,'2024-07-03 15:00:00',32,'Brasileirao2024'),(313,18,3,NULL,NULL,'2024-07-03 15:00:00',32,'Brasileirao2024'),(314,7,10,NULL,NULL,'2024-07-03 15:00:00',32,'Brasileirao2024'),(315,1,4,NULL,NULL,'2024-07-03 15:00:00',32,'Brasileirao2024'),(316,8,9,NULL,NULL,'2024-07-03 15:00:00',32,'Brasileirao2024'),(317,14,5,NULL,NULL,'2024-07-03 15:00:00',32,'Brasileirao2024'),(318,19,2,NULL,NULL,'2024-07-03 15:00:00',32,'Brasileirao2024'),(319,20,16,NULL,NULL,'2024-07-03 15:00:00',32,'Brasileirao2024'),(320,12,6,NULL,NULL,'2024-07-03 15:00:00',32,'Brasileirao2024'),(321,13,9,NULL,NULL,'2024-07-06 15:00:00',33,'Brasileirao2024'),(322,11,18,NULL,NULL,'2024-07-06 15:00:00',33,'Brasileirao2024'),(323,15,7,NULL,NULL,'2024-07-06 15:00:00',33,'Brasileirao2024'),(324,3,1,NULL,NULL,'2024-07-06 15:00:00',33,'Brasileirao2024'),(325,10,8,NULL,NULL,'2024-07-06 15:00:00',33,'Brasileirao2024'),(326,4,14,NULL,NULL,'2024-07-06 15:00:00',33,'Brasileirao2024'),(327,5,19,NULL,NULL,'2024-07-06 15:00:00',33,'Brasileirao2024'),(328,17,20,NULL,NULL,'2024-07-06 15:00:00',33,'Brasileirao2024'),(329,2,12,NULL,NULL,'2024-07-06 15:00:00',33,'Brasileirao2024'),(330,16,6,NULL,NULL,'2024-07-06 15:00:00',33,'Brasileirao2024'),(331,10,13,NULL,NULL,'2024-07-09 15:00:00',34,'Brasileirao2024'),(332,7,18,NULL,NULL,'2024-07-09 15:00:00',34,'Brasileirao2024'),(333,1,11,NULL,NULL,'2024-07-09 15:00:00',34,'Brasileirao2024'),(334,8,15,NULL,NULL,'2024-07-09 15:00:00',34,'Brasileirao2024'),(335,14,3,NULL,NULL,'2024-07-09 15:00:00',34,'Brasileirao2024'),(336,19,4,NULL,NULL,'2024-07-09 15:00:00',34,'Brasileirao2024'),(337,20,9,NULL,NULL,'2024-07-09 15:00:00',34,'Brasileirao2024'),(338,12,5,NULL,NULL,'2024-07-09 15:00:00',34,'Brasileirao2024'),(339,6,17,NULL,NULL,'2024-07-09 15:00:00',34,'Brasileirao2024'),(340,16,2,NULL,NULL,'2024-07-09 15:00:00',34,'Brasileirao2024'),(341,13,15,NULL,NULL,'2024-07-12 15:00:00',35,'Brasileirao2024'),(342,7,1,NULL,NULL,'2024-07-12 15:00:00',35,'Brasileirao2024'),(343,18,8,NULL,NULL,'2024-07-12 15:00:00',35,'Brasileirao2024'),(344,11,14,NULL,NULL,'2024-07-12 15:00:00',35,'Brasileirao2024'),(345,3,19,NULL,NULL,'2024-07-12 15:00:00',35,'Brasileirao2024'),(346,10,20,NULL,NULL,'2024-07-12 15:00:00',35,'Brasileirao2024'),(347,4,12,NULL,NULL,'2024-07-12 15:00:00',35,'Brasileirao2024'),(348,9,6,NULL,NULL,'2024-07-12 15:00:00',35,'Brasileirao2024'),(349,5,16,NULL,NULL,'2024-07-12 15:00:00',35,'Brasileirao2024'),(350,17,2,NULL,NULL,'2024-07-12 15:00:00',35,'Brasileirao2024'),(351,18,13,NULL,NULL,'2024-07-15 15:00:00',36,'Brasileirao2024'),(352,8,1,NULL,NULL,'2024-07-15 15:00:00',36,'Brasileirao2024'),(353,14,7,NULL,NULL,'2024-07-15 15:00:00',36,'Brasileirao2024'),(354,19,11,NULL,NULL,'2024-07-15 15:00:00',36,'Brasileirao2024'),(355,20,15,NULL,NULL,'2024-07-15 15:00:00',36,'Brasileirao2024'),(356,12,3,NULL,NULL,'2024-07-15 15:00:00',36,'Brasileirao2024'),(357,6,10,NULL,NULL,'2024-07-15 15:00:00',36,'Brasileirao2024'),(358,16,4,NULL,NULL,'2024-07-15 15:00:00',36,'Brasileirao2024'),(359,2,9,NULL,NULL,'2024-07-15 15:00:00',36,'Brasileirao2024'),(360,17,5,NULL,NULL,'2024-07-15 15:00:00',36,'Brasileirao2024'),(361,13,1,NULL,NULL,'2024-07-18 15:00:00',37,'Brasileirao2024'),(362,8,14,NULL,NULL,'2024-07-18 15:00:00',37,'Brasileirao2024'),(363,7,19,NULL,NULL,'2024-07-18 15:00:00',37,'Brasileirao2024'),(364,18,20,NULL,NULL,'2024-07-18 15:00:00',37,'Brasileirao2024'),(365,11,12,NULL,NULL,'2024-07-18 15:00:00',37,'Brasileirao2024'),(366,15,6,NULL,NULL,'2024-07-18 15:00:00',37,'Brasileirao2024'),(367,3,16,NULL,NULL,'2024-07-18 15:00:00',37,'Brasileirao2024'),(368,10,2,NULL,NULL,'2024-07-18 15:00:00',37,'Brasileirao2024'),(369,4,17,NULL,NULL,'2024-07-18 15:00:00',37,'Brasileirao2024'),(370,9,5,NULL,NULL,'2024-07-18 15:00:00',37,'Brasileirao2024'),(371,14,13,NULL,NULL,'2024-07-21 15:00:00',38,'Brasileirao2024'),(372,19,8,NULL,NULL,'2024-07-21 15:00:00',38,'Brasileirao2024'),(373,20,1,NULL,NULL,'2024-07-21 15:00:00',38,'Brasileirao2024'),(374,12,7,NULL,NULL,'2024-07-21 15:00:00',38,'Brasileirao2024'),(375,6,18,NULL,NULL,'2024-07-21 15:00:00',38,'Brasileirao2024'),(376,16,11,NULL,NULL,'2024-07-21 15:00:00',38,'Brasileirao2024'),(377,2,15,NULL,NULL,'2024-07-21 15:00:00',38,'Brasileirao2024'),(378,17,3,NULL,NULL,'2024-07-21 15:00:00',38,'Brasileirao2024'),(379,5,10,NULL,NULL,'2024-07-21 15:00:00',38,'Brasileirao2024'),(380,9,4,NULL,NULL,'2024-07-21 15:00:00',38,'Brasileirao2024');
/*!40000 ALTER TABLE `partidas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `times`
--

DROP TABLE IF EXISTS `times`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `times` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `sigla` varchar(10) NOT NULL,
  `cidade` varchar(100) DEFAULT NULL,
  `estado` varchar(50) DEFAULT NULL,
  `estadio` varchar(100) DEFAULT NULL,
  `fundacao` date DEFAULT NULL,
  `escudo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sigla` (`sigla`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `times`
--

LOCK TABLES `times` WRITE;
/*!40000 ALTER TABLE `times` DISABLE KEYS */;
INSERT INTO `times` VALUES (1,'Botafogo','BOT','Rio de Janeiro','RJ','Nilton Santos','1904-08-12','https://s.sde.globo.com/media/organizations/2019/02/04/botafogo-65.png'),(2,'Palmeiras','PAL','São Paulo','SP','Allianz Parque','1914-08-26','https://s.sde.globo.com/media/organizations/2014/04/14/palmeiras_60x60.png'),(3,'Flamengo','FLA','Rio de Janeiro','RJ','Maracanã','1895-11-17','https://s.sde.globo.com/media/organizations/2018/04/09/Flamengo-65.png'),(4,'Fortaleza','FOR','Fortaleza','CE','Castelão','1918-10-18','https://s.sde.globo.com/media/organizations/2021/09/19/65_0000_Fortaleza-2021.png'),(5,'Internacional','INT','Porto Alegre','RS','Beira-Rio','1909-04-04','https://s.sde.globo.com/media/organizations/2016/05/03/inter65.png'),(6,'São Paulo','SAO','São Paulo','SP','Morumbi','1930-01-25','https://s.sde.globo.com/media/organizations/2014/04/14/sao_paulo_60x60.png'),(7,'Corinthians','COR','São Paulo','SP','Neo Química Arena','1910-09-01','https://s.sde.globo.com/media/organizations/2024/10/09/Corinthians-2024-65_IYhgZ1u.png'),(8,'Bahia','BAH','Salvador','BA','Arena Fonte Nova','1931-01-01','https://s.sde.globo.com/media/organizations/2014/04/14/bahia_60x60.png'),(9,'Grêmio','GRE','Porto Alegre','RS','Arena do Grêmio','1903-09-15','https://s.sde.globo.com/media/organizations/2014/04/14/gremio_60x60.png'),(10,'Fluminense','FLU','Rio de Janeiro','RJ','Maracanã','1902-07-21','https://s.sde.globo.com/media/organizations/2014/04/14/fluminense_60x60.png'),(11,'Cruzeiro','CRU','Belo Horizonte','MG','Mineirão','1921-01-02','https://s.sde.globo.com/media/organizations/2021/02/13/65_cruzeiro-2021.png'),(12,'Vasco da Gama','VAS','Rio de Janeiro','RJ','São Januário','1898-08-21','https://s.sde.globo.com/media/organizations/2021/09/04/ESCUDO-VASCO-RGB_65px.png'),(13,'Athletico-PR','CAP','Curitiba','PR','Arena da Baixada','1924-03-26','https://s.sde.globo.com/media/organizations/2019/09/09/Athletico-PR-65x65.png'),(14,'Atlético-MG','CAM','Belo Horizonte','MG','Mineirão','1908-03-25','https://s.sde.globo.com/media/organizations/2017/11/23/Atletico-Mineiro-escudo65px.png'),(15,'Cuiabá','CUI','Cuiabá','MT','Arena Pantanal','2001-12-12','https://s.sde.globo.com/media/organizations/2014/04/16/cuiaba65.png'),(16,'Red Bull Bragantino','RBB','Bragança Paulista','SP','Nabi Abi Chedid','1928-01-08','https://s.sde.globo.com/media/organizations/2020/01/01/65.png'),(17,'Juventude','JUV','Caxias do Sul','RS','Alfredo Jaconi','1913-06-29','https://s.sde.globo.com/media/organizations/2021/04/29/juventude65.png'),(18,'Criciúma','CRI','Criciúma','SC','Heriberto Hülse','1947-05-13','https://s.sde.globo.com/media/organizations/2024/03/28/criciuma-65.png'),(19,'Atlético-GO','ACG','Goiânia','GO','Antônio Accioly','1937-04-02','https://s.sde.globo.com/media/organizations/2020/07/02/atletico-go-2020-65.png'),(20,'Vitória','VIT','Salvador','BA','Barradão','1899-05-13','https://s.sde.globo.com/media/organizations/2024/04/09/escudo-vitoria-65x65-69284.png');
/*!40000 ALTER TABLE `times` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `senha` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'CARLOS','carlos@teste','$2y$10$E9y.sK0oc8REiaKFDlGLc.HLPidY3hXJm3QRsnpiNxmUgZvMiaVwy'),(2,'carlos','carlos@refacty.com','$2y$10$x1vDOwTo3WZuoxQrDQvDS.sXDowQOhoDXY.Yxfpk22hxACAfgSzhK'),(3,'carlos@meucu.com','carlos@aaa.com','$2y$10$KIUAMNo.RDhkqK1kC6PEhu/rSG3fNeMhutEZQA9z4X5jymXmIqz.2'),(4,'teste','dadwn@teste.com','$2y$10$a2JAsZ0GM3/XRGKXwwYTQ.MHlk5FMu7N5Rrn8Vwy9dlz616NI5sKG');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'brasileirao'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-11 20:29:37
