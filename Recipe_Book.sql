-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: recipe_book
-- ------------------------------------------------------
-- Server version	8.0.30

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
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `comment_id` int NOT NULL AUTO_INCREMENT,
  `account_id` int NOT NULL,
  `comment` varchar(264) DEFAULT NULL,
  `recipe_id` varchar(45) NOT NULL,
  PRIMARY KEY (`comment_id`,`account_id`,`recipe_id`),
  UNIQUE KEY `comment_id_UNIQUE` (`comment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,1,'Great recipe','4'),(2,4,'Fantastic!','5'),(3,6,'Very tasty','10'),(4,10,'No complaints','7'),(5,4,'Added apples','1'),(6,7,'Could be better','8'),(7,9,'Great recipe','4'),(8,8,'Genius!','6'),(9,6,'Very tasty','8'),(10,10,'Super tasty','8'),(11,1,'This is good.','1'),(14,1,'Very lemony','9'),(17,1,'This is good','3');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorite`
--

DROP TABLE IF EXISTS `favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorite` (
  `account_id` int NOT NULL,
  `recipe_id` int NOT NULL,
  `comment` varchar(264) DEFAULT NULL,
  PRIMARY KEY (`account_id`,`recipe_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorite`
--

LOCK TABLES `favorite` WRITE;
/*!40000 ALTER TABLE `favorite` DISABLE KEYS */;
INSERT INTO `favorite` VALUES (1,2,''),(2,6,''),(5,7,'Yummy'),(6,8,''),(8,3,'The best ever!'),(8,8,'Tasty'),(9,1,''),(10,3,''),(10,5,'');
/*!40000 ALTER TABLE `favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grocery_item`
--

DROP TABLE IF EXISTS `grocery_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grocery_item` (
  `grocery_item` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `description` varchar(264) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`grocery_item`),
  UNIQUE KEY `grocery_item_UNIQUE` (`grocery_item`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grocery_item`
--

LOCK TABLES `grocery_item` WRITE;
/*!40000 ALTER TABLE `grocery_item` DISABLE KEYS */;
INSERT INTO `grocery_item` VALUES (1,'Ham','deli meat',2.50),(2,'Salami','deli meat',3.00),(3,'Sugar','',5.00),(4,'Lettuce','greens',3.50),(5,'Beets','greens',3.50),(6,'Pasta','',5.00),(7,'Marinara','',5.50),(8,'Chicken','',10.50),(9,'Lemon','',1.00),(10,'Apple','',1.20);
/*!40000 ALTER TABLE `grocery_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grocery_list`
--

DROP TABLE IF EXISTS `grocery_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grocery_list` (
  `grocery_list_id` int NOT NULL AUTO_INCREMENT,
  `account_id` int NOT NULL,
  `title` varchar(45) DEFAULT NULL,
  `description` varchar(264) DEFAULT NULL,
  PRIMARY KEY (`grocery_list_id`,`account_id`),
  UNIQUE KEY `grocery_list_id_UNIQUE` (`grocery_list_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grocery_list`
--

LOCK TABLES `grocery_list` WRITE;
/*!40000 ALTER TABLE `grocery_list` DISABLE KEYS */;
INSERT INTO `grocery_list` VALUES (1,4,'Sandwich Ingredients','sandwich ingredients'),(2,10,'Grocery stuff','Groceries'),(4,2,'Random','random stuff'),(5,5,'Beverages','Fruit Punch'),(6,7,'Personal','Equipment'),(7,9,'Get today','need to get all this today'),(8,8,'Veggies','stuff'),(9,5,'Fruits','stuff');
/*!40000 ALTER TABLE `grocery_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `post_id` int NOT NULL AUTO_INCREMENT,
  `account_id` varchar(45) NOT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`post_id`,`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,'3','2022-11-03 00:00:00'),(2,'1','2022-11-03 00:00:00'),(3,'9','2022-11-03 00:00:00'),(4,'8','2022-11-03 00:00:00'),(5,'3','2022-11-03 00:00:00'),(6,'4','2022-11-03 00:00:00'),(7,'8','2022-11-03 00:00:00'),(8,'7','2022-11-03 00:00:00'),(9,'5','2022-11-03 00:00:00'),(10,'2','2022-11-03 00:00:00');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rating`
--

DROP TABLE IF EXISTS `rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rating` (
  `rating_id` int NOT NULL AUTO_INCREMENT,
  `account_id` int NOT NULL,
  `recipe_id` varchar(45) NOT NULL,
  `rating` int DEFAULT NULL,
  PRIMARY KEY (`rating_id`,`account_id`,`recipe_id`),
  UNIQUE KEY `rating_id_UNIQUE` (`rating_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rating`
--

LOCK TABLES `rating` WRITE;
/*!40000 ALTER TABLE `rating` DISABLE KEYS */;
INSERT INTO `rating` VALUES (1,10,'5',10),(2,9,'4',9),(3,8,'3',9),(4,7,'2',10),(5,6,'1',7),(6,5,'6',9),(7,4,'7',8),(8,3,'8',6),(9,2,'9',1),(10,1,'10',2);
/*!40000 ALTER TABLE `rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe`
--

DROP TABLE IF EXISTS `recipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe` (
  `recipe_id` int NOT NULL AUTO_INCREMENT,
  `account_id` int NOT NULL,
  `title` varchar(45) DEFAULT NULL,
  `description` varchar(264) DEFAULT NULL,
  `prep_time` varchar(45) DEFAULT NULL,
  `cook_time` varchar(45) DEFAULT NULL,
  `image_url` longtext,
  `how_to` longtext,
  `private` int DEFAULT NULL,
  PRIMARY KEY (`recipe_id`,`account_id`),
  UNIQUE KEY `recipe_id_UNIQUE` (`recipe_id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe`
--

LOCK TABLES `recipe` WRITE;
/*!40000 ALTER TABLE `recipe` DISABLE KEYS */;
INSERT INTO `recipe` VALUES (1,4,'Ham Sandwich','Ham Sandwich','1 minute','0 minutes','HamSandwich.jpeg',NULL,0),(2,2,'Salami Sandwich','Salami Sandwich','1 minute','','SalamiSandwich.jpeg',NULL,0),(3,7,'Chicken Alfredo','Pasta dish with chicken and alfredo sauce.','10 minutes','10 minutes','ChickenAlfredo.jpeg',NULL,0),(4,3,'Chicken Parm','Breaded chicken with marinara sauce on top','10 minutes','30 minutes','ChickenParm.jpeg',NULL,0),(5,5,'Ceaser Salad','Salad with ceaser sauce','10 minutes','5 minutes','CeaserSalad.jpg',NULL,0),(6,10,'Beet Salad','Salad with beets','10 minutes','2 minutes','BeetSalad.jpeg',NULL,0),(7,9,'Chocolate Chip Cookie','Cookie','15 minutes','10 minutes','CCCookie.jpeg',NULL,0),(8,8,'Cake','Cake','15 minutes','30 minutes','',NULL,0),(9,2,'Lemonade','Juice made from lemons','5 minutes','','',NULL,0),(10,1,'Fruit Punch','Juice made from fruits','10 minutes','0 minutes','FruitPunch.jpeg',NULL,0),(11,1,'Special Sandwich &#129386;','Yummy sandwich','1 minute','1 minute','',NULL,0),(99,1,'Chug Jug','Gives you shield','10 seconds','2 hours','',NULL,0),(109,1,'Grilled Cheese','Cheesy Sandwich','2 minutes','10 minutes','',NULL,0);
/*!40000 ALTER TABLE `recipe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_ing`
--

DROP TABLE IF EXISTS `recipe_ing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe_ing` (
  `ingredient_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `description` varchar(264) DEFAULT NULL,
  `amount` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ingredient_id`),
  UNIQUE KEY `ingredient_id_UNIQUE` (`ingredient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_ing`
--

LOCK TABLES `recipe_ing` WRITE;
/*!40000 ALTER TABLE `recipe_ing` DISABLE KEYS */;
INSERT INTO `recipe_ing` VALUES (1,'Ham','Ham','1 lb'),(2,'Salami','Salami','1 l b'),(3,'Sugar','Suga','3 cups'),(4,'Lettuce','greens','5 oz'),(5,'Pasta','pasta','1 pack'),(6,'Marinara','sauce to go on pasta','1 bottle'),(7,'Chicken','chicken','1 lb'),(8,'Lemon','lemon','10'),(9,'Apple','apple','5'),(10,'Beets','beet','3');
/*!40000 ALTER TABLE `recipe_ing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_list`
--

DROP TABLE IF EXISTS `recipe_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe_list` (
  `recipe_list_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(45) DEFAULT NULL,
  `description` varchar(264) DEFAULT NULL,
  `account_id` int NOT NULL,
  PRIMARY KEY (`recipe_list_id`,`account_id`),
  UNIQUE KEY `recipe_list_id_UNIQUE` (`recipe_list_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_list`
--

LOCK TABLES `recipe_list` WRITE;
/*!40000 ALTER TABLE `recipe_list` DISABLE KEYS */;
INSERT INTO `recipe_list` VALUES (1,'Sandwiches','Sandwiches',1),(2,'Soups','List of soups',1),(3,'Pastas','List of pastas',2),(4,'Healthy','List of healthy recipes',3),(5,'Deserts','List of deserts',4),(6,'Unhealthy','List of unhealthy recipes',7),(7,'Greens','List of green recipes',10),(8,'Random','List of random recipes',5),(9,'Random','List of random recipes',5),(10,'Sandwiches','Sandwiches',10);
/*!40000 ALTER TABLE `recipe_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `account_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`account_id`),
  UNIQUE KEY `account_id_UNIQUE` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'adrian123','adrian123@gmail.com','12345'),(2,'kian123','kian123@gmail.com','12345'),(3,'bob456','bob456@gmail.com','45678'),(4,'ted123','ted123@gmail.com','H7WtcGuRvS'),(5,'karen987','karen987@gmail.com','i9cMCnYrfr'),(6,'jacob6783','jacob6783@gmail.com','CeW4hrIVbd'),(7,'elsa78','elsa78@gmail.com','0Fzge5DOWu'),(8,'barry432','barry432@gmail.com','ZVmaBaApjN'),(9,'pedro92','pedro92@gmaiil.com','s0QAQB1uHk'),(10,'lena56','lena56@gmail.com','Zl6emiZId4'),(11,'teddy123','teddy@gmail.com','12345'),(12,'Bobby123','Bobby@gmail.com','12345'),(15,NULL,NULL,NULL),(16,'test','test@gmail.com','12345'),(17,'test123','test123@gmail.com','123'),(18,'example123','joajsjlk','12345');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_settings`
--

DROP TABLE IF EXISTS `user_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_settings` (
  `account_id` int NOT NULL,
  `private` int DEFAULT NULL,
  `theme` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_settings`
--

LOCK TABLES `user_settings` WRITE;
/*!40000 ALTER TABLE `user_settings` DISABLE KEYS */;
INSERT INTO `user_settings` VALUES (1,0,'blue'),(2,0,'green'),(3,1,'green'),(4,0,'blue'),(5,1,'grey'),(6,0,'grey'),(7,0,'blue'),(8,0,'blue'),(9,0,'blue'),(10,0,'blue');
/*!40000 ALTER TABLE `user_settings` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-09 19:48:25
