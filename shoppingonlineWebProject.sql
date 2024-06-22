-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: weblproject
-- ------------------------------------------------------
-- Server version	8.0.37

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
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES ('admin','1');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client` (
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES ('dinh','123','1424143111'),('test','2','948205746'),('test2','2','0948205746');
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `orderid` int NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `timeordered` timestamp NULL DEFAULT NULL,
  `orderstatus` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`orderid`),
  KEY `username` (`username`),
  CONSTRAINT `order_ibfk_1` FOREIGN KEY (`username`) REFERENCES `client` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,'test','2024-06-21 08:59:51','Delivering'),(2,'test','2024-06-21 08:59:51','Delivering'),(3,'test','2024-06-21 13:25:40','Delivering');
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderlist`
--

DROP TABLE IF EXISTS `orderlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderlist` (
  `orderid` int DEFAULT NULL,
  `itemName` varchar(2550) DEFAULT NULL,
  `address` varchar(1000) DEFAULT NULL,
  `mail` varchar(150) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `price` int DEFAULT NULL,
  KEY `orderid` (`orderid`),
  CONSTRAINT `orderlist_ibfk_1` FOREIGN KEY (`orderid`) REFERENCES `order` (`orderid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderlist`
--

LOCK TABLES `orderlist` WRITE;
/*!40000 ALTER TABLE `orderlist` DISABLE KEYS */;
INSERT INTO `orderlist` VALUES (1,'Red T-Shirt:1;Patterned Polo:4','27/36/45 bui tu toan','lengochuy6829@gmail.com',14,480),(2,'Red T-Shirt:1;Patterned Polo:4','27/36/45 bui tu toan','lengochuy6829@gmail.com',14,480),(3,'Brown Pants:5;Red T-Shirt:5','27/36/45 Bui Tu Toan, An Lac ward, Binh Tan district','lengochuy6829@gmail.com',55,550);
/*!40000 ALTER TABLE `orderlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `img` varchar(1000) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` int NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `remainingquantity` int NOT NULL,
  `soldquantity` int NOT NULL,
  `typeproduct` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'https://m.media-amazon.com/images/I/41eDckDOhpL._AC_UY1000_.jpg','Formal Shirt',140,'2024-06-20 19:13:58',30,1,'shirt'),(2,'https://tshirtssouthafrica.com/wp-content/uploads/Royal.jpg','Blue T-Shirt',50,'2024-06-20 19:13:58',20,2,'t-shirt'),(3,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpD-ye0lQOBMB4xzlTrkW5zSaqsgZxW7J6mw&s','Red T-Shirt',40,'2024-06-20 19:13:58',40,1,'t-shirt'),(4,'https://i5.walmartimages.com/seo/Men-s-Heavyweight-Casual-Pullover-Hoodie-Sweatshirt-with-Front-Pocket-Kelly-Green-3XL_408920dc-f5b4-4a4c-bfa4-2328454153b7.03a04a0910d26652b85514cdcfe95b1d.jpeg','Green Hoodie',30,'2024-06-20 19:13:58',50,1,'hoodie'),(5,'https://img.kwcdn.com/product/Fancyalgo/VirtualModelMatting/8e52d025480db319df36790d379292b4.jpg','Black Hoodie',20,'2024-06-20 19:13:58',60,3,'hoodie'),(6,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgccs4Lr6qSfn3LoxavEIaiKXjOxPb27fT3A&s','Gray Pants',10,'2024-06-20 19:13:58',25,2,'pants'),(7,'https://image.uniqlo.com/UQ/ST3/AsianCommon/imagesgoods/443113/item/goods_38_443113.jpg?width=494','Brown Pants',70,'2024-06-20 19:13:58',26,1,'pants'),(8,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_nmHDvlg-Hcr1gkOn0BzTBb4sT4fNV5jLbw&s','Blue Shorts',80,'2024-06-20 19:13:58',27,2,'shorts'),(9,'https://i5.walmartimages.com/seo/White-Shorts-Plain-Color-Smooth-Board-Sports-Pants-Men-S-Fitness-Pants-Summer-Thin-Loose-Quick-Drying-Running-Training-Pants_549e1897-a043-4aba-9faa-d969b0992448.51c0f4b59b90bbb51d59a1dcb29ff777.jpeg?odnHeight=768&odnWidth=768&odnBg=FFFFFF','White Shorts',90,'2024-06-20 19:13:58',28,5,'shorts'),(10,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgEu4R17dhop6H6mDzoTLluUivB3u5IvahEA&s','Striped Polo',100,'2024-06-20 19:13:58',60,6,'polo'),(11,'https://cdn.vuahanghieu.com/unsafe/0x900/left/top/smart/filters:quality(90)/https://admin.vuahanghieu.com/upload/product/2022/06/ao-polo-lacoste-men-s-made-in-france-regular-fit-jacquard-patterned-pique-polo-shirt-mau-xanh-den-size-s-62b579d1f3857-24062022154609.jpg','Patterned Polo',110,'2024-06-20 19:13:58',40,5,'polo');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-22 13:18:11
