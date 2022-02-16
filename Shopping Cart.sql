/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

USE classicmodels;

/*Table structure for table `orderdetails` */

DROP TABLE IF EXISTS `cartdetails`;

CREATE TABLE `cartdetails` (
  `cartNumber` int(11) NOT NULL,
  `productCode` varchar(15) NOT NULL,
  `quantityAdded` int(11) NOT NULL,
  `priceEach` decimal(10,2) NOT NULL,
  `cartLineNumber` smallint(6) NOT NULL,
  PRIMARY KEY (`cartNumber`,`productCode`),
  KEY `productCode` (`productCode`),
  CONSTRAINT `cartdetails_ibfk_1` FOREIGN KEY (`cartNumber`) REFERENCES `shoppingcart` (`cartNumber`),
  CONSTRAINT `cartdetails_ibfk_2` FOREIGN KEY (`productCode`) REFERENCES `products` (`productCode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `orders` */

DROP TABLE IF EXISTS `shoppingcart`;

CREATE TABLE `shoppingcart` (
  `cartNumber` int(11) NOT NULL,
  `cartDate` date NOT NULL,
  `status` varchar(15) NOT NULL,
  `customerNumber` int(11) NOT NULL,
  PRIMARY KEY (`cartNumber`),
  KEY `customerNumber` (`customerNumber`),
  CONSTRAINT `shoppingcart_ibfk_1` FOREIGN KEY (`customerNumber`) REFERENCES `customers` (`customerNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

insert  into `shoppingcart`(`cartNumber`,`cartDate`,`status`,`customerNumber`) values 
	(10100,'2003-01-06','Empty',363),
	(10101,'2003-01-09','Ordered',128),
	(10102,'2003-01-10','In Progress',181);


