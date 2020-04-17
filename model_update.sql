DROP TABLE IF EXISTS `level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `level` (
  `level_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `level` int(10) NOT NULL,
  PRIMARY KEY (`level_id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `level`
--

LOCK TABLES `level` WRITE;

/*!40000 ALTER TABLE `level` DISABLE KEYS */;
/*!40000 ALTER TABLE `level` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(30) NOT NULL,
  `lastname` varchar(30) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(200) DEFAULT NULL,
  `birthday` datetime NOT NULL,
  `email` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `avatar` varchar(255) NOT NULL DEFAULT 'avatar/default.png',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `product_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(30) NOT NULL,
  `description` varchar(200),
  `price` int(10) NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `slug` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  FOREIGN KEY (`user_id`)
    REFERENCES `user`(`user_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;


LOCK TABLES `product` WRITE;
ALTER TABLE `product` DISABLE KEYS;
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `picture_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `picture_product` (
  `picture_product_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `name` varchar(200),
  `url` varchar(200) NOT NULL,
  `created_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`picture_product_id`),
  FOREIGN KEY (`product_id`)
    REFERENCES `product`(`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;


LOCK TABLES `picture_product` WRITE;
/*!40000 ALTER TABLE `picture_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `picture_product` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `category_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(30) NOT NULL,
  `description` varchar(200),
  `slug` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag` (
  `tag_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `owner_id`int(10) unsigned DEFAULT NULL,
  `title` varchar(30) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  FOREIGN KEY (`owner_id`)
    REFERENCES `user`(`user_id`),
  PRIMARY KEY (`tag_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--


DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order` (
  `order_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`order_id`),
  FOREIGN KEY (`user_id`)
    REFERENCES `user`(`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `order` WRITE;


/*!40000 ALTER TABLE `order` DISABLE KEYS */;
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_line` (
  `order_line_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `quantity` int(10) NOT NULL,
  `price` int(10) NOT NULL,
  `total_price` int(10) NOT NULL,
  PRIMARY KEY (`order_line_id`),
  FOREIGN KEY (`product_id`)
    REFERENCES `product`(`product_id`),
  FOREIGN KEY (`order_id`)
    REFERENCES `order`(`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `order_line` WRITE;


/*!40000 ALTER TABLE `order_line` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_line` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `productsUsers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productsUsers` (
  `user` int(10) unsigned NOT NULL,
  `product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user`,`product`),
  KEY `Constr_productsUsers_product_fk` (`product`),
  CONSTRAINT `Constr_productsUsers_product_fk` FOREIGN KEY (`product`) REFERENCES `product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Constr_productsUsers_user_fk` FOREIGN KEY (`user`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `productsUsers` WRITE;
/*!40000 ALTER TABLE `productsUsers` DISABLE KEYS */;
/*!40000 ALTER TABLE `productsUsers` ENABLE KEYS */;
UNLOCK TABLES;



DROP TABLE IF EXISTS `productsCategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productsCategories` (
  `category` int(10) unsigned NOT NULL,
  `product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`category`,`product`),
  KEY `Constr_productsCategories_category_fk` (`category`),
  CONSTRAINT `Constr_productsCategories_produit_fk` FOREIGN KEY (`product`) REFERENCES `product` (`product_id`) ON UPDATE CASCADE,
  CONSTRAINT `Constr_productsCategories_category_fk` FOREIGN KEY (`category`) REFERENCES `category` (`category_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `productsCategories` WRITE;
/*!40000 ALTER TABLE `productsCategories` DISABLE KEYS */;
/*!40000 ALTER TABLE `productsCategories` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `productsTags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productsTags` (
  `tag` int(10) unsigned NOT NULL,
  `product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`tag`,`product`),
  KEY `Constr_productsTags_tag_fk` (`tag`),
  CONSTRAINT `Constr_productsTags_produit_fk` FOREIGN KEY (`product`) REFERENCES `product` (`product_id`) ON UPDATE CASCADE,
  CONSTRAINT `Constr_productsTags_tag_fk` FOREIGN KEY (`tag`) REFERENCES `tag` (`tag_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `productsTags` WRITE;
/*!40000 ALTER TABLE `productsTags` DISABLE KEYS */;
/*!40000 ALTER TABLE `productsTags` ENABLE KEYS */;
UNLOCK TABLES;
