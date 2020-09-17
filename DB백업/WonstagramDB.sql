CREATE DATABASE  IF NOT EXISTS `jspbeginner` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `jspbeginner`;
-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: jspbeginner
-- ------------------------------------------------------
-- Server version	5.6.45-log

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
-- Table structure for table `board`
--

DROP TABLE IF EXISTS `board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `board` (
  `num` int(11) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `passwd` varchar(20) DEFAULT NULL,
  `subject` varchar(50) DEFAULT NULL,
  `content` varchar(2000) DEFAULT NULL,
  `re_ref` int(11) DEFAULT NULL,
  `re_lev` int(11) DEFAULT NULL,
  `re_seq` int(11) DEFAULT NULL,
  `readcount` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `ip` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board`
--

LOCK TABLES `board` WRITE;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` VALUES (2,'admin','1234','글제목입니다.2','글내용입니다.2',2,0,0,1,'2020-06-10 14:05:32','127.0.0.1'),(3,'admin','1234','글제목입니다.3','글내용입니다.3',3,0,0,0,'2020-06-10 14:05:41','127.0.0.1'),(10,'admin','1234','답글제목','답글내용',9,1,2,0,'2020-06-12 11:22:00','127.0.0.1');
/*!40000 ALTER TABLE `board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carlist`
--

DROP TABLE IF EXISTS `carlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carlist` (
  `carno` int(11) NOT NULL,
  `carname` varchar(50) NOT NULL,
  `carcompany` varchar(50) NOT NULL,
  `carprice` int(11) NOT NULL,
  `carusepeople` int(11) NOT NULL,
  `carinfo` varchar(500) NOT NULL,
  `carimg` varchar(50) NOT NULL,
  `carcategory` varchar(10) NOT NULL,
  PRIMARY KEY (`carno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carlist`
--

LOCK TABLES `carlist` WRITE;
/*!40000 ALTER TABLE `carlist` DISABLE KEYS */;
INSERT INTO `carlist` VALUES (1,'아반테','현대',80000,4,'이차량은 소형차량으로 잘나갑니다.','avante.jpg','Small'),(2,'카렌스','현대',90000,4,'이차량은 소형차량으로 잘나갑니다.','carens.jpg','Small'),(3,'카니발','기아',100000,9,'이차량은 소형차량으로 잘나갑니다.','canival.jpg','Small'),(4,'코란도','쌍용',110000,4,'이차량은 소형차량으로 잘나갑니다.','co.jpg','Small'),(101,'에쿠스','현대',120000,5,'이차량은 중형차량으로 잘나갑니다.','equus.jpg','Mid'),(102,'그렌져','현대',130000,5,'이차량은 중형차량으로 잘나갑니다.','grandeur.jpg','Mid'),(103,'k3','기아',140000,4,'이차량은 중형차량으로 잘나갑니다.','k3.jpg','Mid'),(104,'k5','기아',150000,4,'이차량은 중형차량으로 잘나갑니다.','k5.jpg','Mid'),(201,'k7','기아',160000,4,'이차량은 대형차량으로 잘나갑니다.','k7.jpg','Big'),(202,'k9','기아',170000,4,'이차량은 대형차량으로 잘나갑니다.','k9.jpg','Big'),(203,'말리부','GM',180000,4,'이차량은 대형차량으로 잘나갑니다.','malibu.jpg','Big'),(204,'bmw528i','bmw',190000,5,'이차량은 대형차량으로 잘나갑니다.','bmw.jpg','Big');
/*!40000 ALTER TABLE `carlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carorder`
--

DROP TABLE IF EXISTS `carorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carorder` (
  `orderid` int(11) NOT NULL AUTO_INCREMENT,
  `carno` int(11) NOT NULL,
  `carqty` int(11) NOT NULL,
  `carreserveday` int(11) NOT NULL,
  `carbegindate` varchar(50) NOT NULL,
  `carins` int(11) NOT NULL,
  `carwifi` int(11) NOT NULL,
  `carnave` int(11) NOT NULL,
  `carbabyseat` int(11) NOT NULL,
  `memberphone` varchar(50) NOT NULL,
  `memberpass` varchar(50) NOT NULL,
  PRIMARY KEY (`orderid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carorder`
--

LOCK TABLES `carorder` WRITE;
/*!40000 ALTER TABLE `carorder` DISABLE KEYS */;
INSERT INTO `carorder` VALUES (2,2,1,1,'2020-07-30',1,0,1,1,'01044173371','1234');
/*!40000 ALTER TABLE `carorder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsp_ccboard`
--

DROP TABLE IF EXISTS `jsp_ccboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsp_ccboard` (
  `num` int(11) NOT NULL,
  `subject` varchar(50) DEFAULT NULL,
  `content` varchar(2000) DEFAULT NULL,
  `id` varchar(20) DEFAULT NULL,
  `pw` varchar(20) DEFAULT NULL,
  `readcount` int(11) DEFAULT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  `re_ref` int(11) DEFAULT NULL,
  `re_lev` int(11) DEFAULT NULL,
  `re_seq` int(11) DEFAULT NULL,
  `secret` int(2) DEFAULT '0',
  `main_id` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsp_ccboard`
--

LOCK TABLES `jsp_ccboard` WRITE;
/*!40000 ALTER TABLE `jsp_ccboard` DISABLE KEYS */;
INSERT INTO `jsp_ccboard` VALUES (1,'jyc94님의 문의사항','검색할수 있는거 만들어주세요~','jyc94','1234',13,'2020-07-15 20:40:10',1,0,0,0,'jyc94'),(2,'jyc94님의 문의사항 답글입니다.','문의사항 >> \r\n검색할수 있는거 만들어주세요~\r\n\r\n----------------------------------------------------------------------\r\n\r\n답글 내용입니다 >> \r\n내일 만들겠습니다~','admin','1234',7,'2020-07-15 20:40:34',1,1,1,0,'jyc94'),(3,'Mukbang님의 문의사항','안녕하세요~','Mukbang','1234',10,'2020-07-20 17:42:00',3,0,0,1,'Mukbang'),(4,'Mukbang님의 문의사항 답글입니다.','문의사항 >> \r\n안녕하세요~\r\n\r\n----------------------------------------------------------------------\r\n\r\n답글 내용입니다 >> \r\n네 안녕하세요.','admin','1234',5,'2020-07-28 09:30:21',3,1,1,1,'Mukbang'),(5,'Mukbang님의 문의사항','1234','Mukbang','1234',1,'2020-09-11 22:31:30',5,0,0,0,'Mukbang');
/*!40000 ALTER TABLE `jsp_ccboard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsp_comment`
--

DROP TABLE IF EXISTS `jsp_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsp_comment` (
  `feedNum` int(11) DEFAULT NULL,
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `id` varchar(20) DEFAULT NULL,
  `content` varchar(2000) DEFAULT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsp_comment`
--

LOCK TABLES `jsp_comment` WRITE;
/*!40000 ALTER TABLE `jsp_comment` DISABLE KEYS */;
INSERT INTO `jsp_comment` VALUES (16,26,'Mukbang','포항 가고싶넹 ㅎㅎ','2020-07-15 19:49:08'),(17,27,'ghwn5401','이런 날씨엔 칼국수가 딱 이죠','2020-07-15 19:51:44'),(18,28,'Mukbang','우리귀엽눙','2020-07-15 20:05:20'),(18,29,'ghwn5401','강아지가 너무 귀여워용 ','2020-07-15 20:13:55'),(19,30,'Mukbang','존맛탱 입니다~','2020-07-15 20:34:19'),(19,31,'ghwn5401','헐 너무 맜있겠다.. ','2020-07-15 21:41:32'),(27,34,'Mukbang','루이둥절~','2020-07-15 22:34:14'),(28,35,'Mukbang','펭하~~~','2020-07-15 22:34:23'),(29,36,'Mukbang','소주 캬~~~','2020-07-15 22:34:38'),(32,37,'zhyomi','앞에 분 이쁘네여','2020-07-15 22:58:35'),(17,38,'zhyomi','ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ맛있겠다 ㅠㅠ','2020-07-15 22:59:12'),(34,39,'zhyomi','뚱땡이','2020-07-16 22:43:55'),(36,40,'Mukbang','엇 저네욤 ㅎㅎ','2020-07-16 22:47:32'),(37,41,'Mukbang','이뻐요~~~','2020-07-16 22:48:37'),(38,42,'Mukbang','사이 좋습니다~~','2020-07-16 22:50:27'),(39,43,'Mukbang','저두 갈래요~','2020-07-16 22:53:10'),(40,44,'Mukbang','사..사..줄게..','2020-07-16 22:53:27'),(35,45,'ghwn5401','와 푸짐하게 많이나오네요','2020-07-16 22:54:32'),(34,46,'ghwn5401','비오는날에는 또 최고죠 ','2020-07-16 22:54:45'),(38,47,'ghwn5401','선팔합니당 너무 아름다운 커플이에요','2020-07-16 22:55:11'),(41,48,'Mukbang','돼지아닙니다..','2020-07-16 22:55:44'),(16,49,'zhyomi','저두 포항 가구시파여','2020-07-16 22:56:20'),(42,50,'Mukbang','자전거 타러 갑시다요 시험끝나고!','2020-07-16 22:56:41'),(43,51,'Mukbang','담이당~~','2020-07-16 22:58:58'),(42,52,'ghwn5401','자전거 가 너무 잘 빠졌어요 ','2020-07-16 22:59:29'),(44,53,'Mukbang','좋겟다 캠핑 ㅎ','2020-07-16 22:59:40'),(40,54,'ghwn5401','꽃이 어딨는지 모르겠어용 ','2020-07-16 22:59:43'),(36,55,'ghwn5401','머리가 태양보다 조금 더 큰거같아요!','2020-07-16 23:00:02'),(44,56,'zhyomi','우왕 사진이 너무 멋져요 아저씨 ~~~!','2020-07-16 23:01:14'),(46,57,'Mukbang','담이 장난감 슬리퍼','2020-07-16 23:03:40'),(46,58,'Mukbang','ㅎㅎㅎ화보','2020-07-16 23:03:46'),(47,59,'Mukbang','언제나 초심입니다~','2020-07-16 23:04:07'),(45,60,'ghwn5401','친구 대박 부러워요! 저는 다섯손가락 안으로 친구가 다 들어온답니다 ^^','2020-07-16 23:04:49'),(48,61,'Mukbang','개이쁨~~~','2020-07-16 23:06:14'),(43,62,'ghwn5401','에고 남사스러버라','2020-07-16 23:06:53'),(35,63,'zhyomi','돼지세요 ?','2020-07-16 23:07:35'),(47,64,'ghwn5401','너무나 싱그러운 커플이에요 아이셔~','2020-07-16 23:10:50'),(48,65,'ghwn5401','다 했다는 문장 의미가 달라졌나요~? 하하 넝담 ^~^','2020-07-16 23:11:12'),(54,66,'Mukbang','시원하겟너','2020-07-17 22:53:25'),(33,67,'alwls123','안녕하세영','2020-07-21 17:16:05'),(33,68,'alwls123','ㅎㅇㅎㅇ','2020-07-21 17:16:09'),(16,69,'Mukbang','호주 하이~','2020-09-11 22:32:33');
/*!40000 ALTER TABLE `jsp_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsp_feed`
--

DROP TABLE IF EXISTS `jsp_feed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsp_feed` (
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `id` varchar(20) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `imgLocation` varchar(200) DEFAULT NULL,
  `content` varchar(2000) DEFAULT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsp_feed`
--

LOCK TABLES `jsp_feed` WRITE;
/*!40000 ALTER TABLE `jsp_feed` DISABLE KEYS */;
INSERT INTO `jsp_feed` VALUES (16,'ghwn5401','경북 포항시 북구 두호동 694','원.jpg','#영일대','2020-07-15 19:47:14'),(17,'Mukbang','강원 강릉시 가작로 6','8D7A15B7-F9EF-4B0D-B119-76CF37D01A81.jpeg','강릉 #장칼국수','2020-07-15 19:50:32'),(18,'dudcjf3371','','KakaoTalk_20200715_152906590_04.jpg','#우리','2020-07-15 20:03:43'),(19,'wldudahs1','','042AE7FC-6043-45A4-93F5-F05DEF72B1B1.jpeg','맛있는 에그타르트','2020-07-15 20:33:10'),(24,'admin','부산 부산진구 동천로 109','고객센터1.png','Wonstagram! 고객센터 페이지 입니다.\r\n#JSP #JavaScript #개발자','2020-07-15 22:04:37'),(25,'admin','부산 부산진구 동천로 109','프로필페이지.png','Wonstagram! 프로필 페이지 입니다.\r\n#JSP #JavaScript','2020-07-15 22:07:10'),(27,'zhyomi','','5A360E00-FF56-4E9A-B274-4073B7727584.jpeg','따랑하는 우리집 기염둥이 ','2020-07-15 22:25:50'),(28,'zhyomi','','273C5B01-FBA5-4F9B-8877-5CC0D8C162CE.jpeg','강알리 ~~','2020-07-15 22:26:38'),(29,'zhyomi','','3AA2D183-5F53-486F-8A14-0FCF8AA8311A.jpeg','JMT ..','2020-07-15 22:28:38'),(32,'Mukbang','강원 강릉시 가작로 16-1','순두부짬뽕.jpg','강릉 교동 순두부짬뽕\r\n#JMT','2020-07-15 22:39:23'),(33,'admin','부산 부산진구 동천로 109','로그인페이지.png','로그인 페이지입니다.\r\n#JSP #JavaScript #개인프로젝트','2020-07-16 14:48:41'),(34,'Mukbang','부산 북구 덕천동 395-6','어제삼겹살.png','어제저녁 #삼겹살','2020-07-16 14:52:08'),(35,'Mukbang','부산 연제구 중앙대로 1196','B72C034E-93AE-48F9-A57A-5CF009322616.jpeg','교대역 서울왕돈까스\r\n#JMT','2020-07-16 17:30:11'),(36,'zhyomi','제주특별자치도 제주시 애월읍 가문동길 21','9FA6843B-587D-48AC-BE3B-932CFEF94FA4.jpeg','제주 노을 짱짱 ','2020-07-16 22:46:52'),(37,'zhyomi','제주특별자치도 제주시 애월읍 가문동길 2','4E21C98B-961D-40C4-ACA7-530E60F97C8E.jpeg','#제주도 예쁜 노을 + 예쁜 나 ^^','2020-07-16 22:47:51'),(38,'zhyomi','부산 금정구 금강로279번길 91','088546B2-8B09-49E1-94DB-033D3EF5B2005.jpeg','사이좋은 척 ㅎㅎ #귀여운나ㅅ','2020-07-16 22:49:47'),(39,'zhyomi','경북 경주시 서면 강변마을길 22-14','7B66D4B8-6027-4B4B-88B1-3F29E3CA6BC4.jpeg','여기 진짜 맛있음 아무도 안가르쳐줄거임 #JMT','2020-07-16 22:51:59'),(40,'zhyomi','','C722DA45-28EC-419B-BE47-16D56D4E0BBD.jpeg','나 귀욥징ㅋ 조수원이 사준 거 아님 #오빠꽃좀사줘 ..','2020-07-16 22:53:04'),(41,'zhyomi','부산 부산진구 시민공원로 73','FEBB681E-DE18-4A53-AEFF-7765DFB52647.jpeg','피크닉 가고싶당ㅋ #돼지랑 ~~','2020-07-16 22:54:58'),(42,'zhyomi','제주특별자치도 제주시 구좌읍 월정서로 64-42','80A960C8-2370-4EA9-8CED-C75795F6723C.jpeg','월정리 개간지녀 #제주 #자전거','2020-07-16 22:56:02'),(43,'zhyomi','제주특별자치도 제주시 구좌읍 월정서로 64-42','46B52BAD-7406-4977-9148-5913E7D46582.jpeg','제주도에 있는 우래기 #꼬추보여 ㅠㅠ','2020-07-16 22:58:30'),(44,'ghwn5401','경남 합천군 가야면 가야산로 998','KakaoTalk_20200716_225731136_02.jpg','친구들과 캠핑을 다녀왔어용 ','2020-07-16 22:58:40'),(45,'zhyomi','부산 동래구 구만덕로 287-34','B051ACF4-1A03-4E99-B7A3-6F69CFCE2EE0.jpeg','사진에서 술 냄새 난당 하악 하악  #동래술집 #술고래','2020-07-16 22:59:31'),(46,'zhyomi','제주특별자치도 제주시 구좌읍 만장굴길 182','120D2A28-817F-4E70-8B4F-B5887810CBC4.jpeg','저 때가 좋았지 .. 망할 현실 #제주 #제주도 #영처라비행기표좀끊어','2020-07-16 23:02:14'),(47,'zhyomi','제주특별자치도 서귀포시 가가로 14','AFCA6549-892B-4333-A142-2A5BF348BA3C.jpeg','우왕ㅋ 귀여웠다 우리 #500일전 .. #초심찾자영처라','2020-07-16 23:03:45'),(48,'zhyomi','제주특별자치도 제주시 애월읍 가문동길 2','BBECD677-508D-4DD5-B708-15CE68C6ED78.jpeg','배경말구 내가 다했다 ㅎㅎ #모델 #제주 #인어공주','2020-07-16 23:05:12'),(49,'ghwn5401','','커피먹는지영.jpg','대전에서 커피먹다가 한컷..★','2020-07-16 23:10:22'),(53,'dudcjf3371','','20200511_1755493.jpg','쇼핑했어요!!\r\n#상이네구매대행','2020-07-17 20:54:05'),(54,'qjatjr418','','10FE86F9-47DD-4422-9755-4C5C1BDA32B5.jpeg','','2020-07-17 22:47:32'),(56,'alwls123','','album41.jpg','ㅎㅇㅎㅇ','2020-07-21 17:15:22'),(57,'alwls123','서울 강남구 논현로189길 6','album2.jpg','1','2020-07-21 17:18:59');
/*!40000 ALTER TABLE `jsp_feed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsp_like`
--

DROP TABLE IF EXISTS `jsp_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsp_like` (
  `feedNum` int(11) DEFAULT NULL,
  `id` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsp_like`
--

LOCK TABLES `jsp_like` WRITE;
/*!40000 ALTER TABLE `jsp_like` DISABLE KEYS */;
INSERT INTO `jsp_like` VALUES (14,'whdudcjf3371'),(16,'Mukbang'),(17,'ghwn5401'),(16,'ghwn5401'),(17,'dudcjf3371'),(16,'dudcjf3371'),(18,'ghwn5401'),(19,'Mukbang'),(19,'ghwn5401'),(17,'admin'),(27,'zhyomi'),(29,'zhyomi'),(28,'zhyomi'),(27,'Mukbang'),(28,'Mukbang'),(29,'Mukbang'),(32,'zhyomi'),(17,'zhyomi'),(18,'Mukbang'),(32,'Mukbang'),(33,'Mukbang'),(34,'Mukbang'),(24,'Mukbang'),(25,'Mukbang'),(35,'zhyomi'),(34,'zhyomi'),(36,'Mukbang'),(37,'Mukbang'),(38,'zhyomi'),(38,'Mukbang'),(37,'zhyomi'),(36,'zhyomi'),(40,'Mukbang'),(35,'ghwn5401'),(34,'ghwn5401'),(38,'ghwn5401'),(41,'Mukbang'),(16,'zhyomi'),(42,'Mukbang'),(44,'ghwn5401'),(43,'Mukbang'),(42,'ghwn5401'),(44,'Mukbang'),(40,'ghwn5401'),(45,'zhyomi'),(43,'zhyomi'),(45,'Mukbang'),(36,'ghwn5401'),(42,'zhyomi'),(44,'zhyomi'),(46,'Mukbang'),(47,'Mukbang'),(47,'ghwn5401'),(46,'ghwn5401'),(45,'ghwn5401'),(48,'zhyomi'),(47,'zhyomi'),(46,'zhyomi'),(48,'Mukbang'),(41,'zhyomi'),(40,'zhyomi'),(39,'zhyomi'),(43,'ghwn5401'),(48,'ghwn5401'),(49,'Mukbang'),(49,'ghwn5401'),(53,'Mukbang'),(54,'Mukbang'),(33,'alwls123'),(56,'Mukbang'),(57,'Mukbang'),(17,'Mukbang'),(39,'Mukbang'),(35,'Mukbang');
/*!40000 ALTER TABLE `jsp_like` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsp_member`
--

DROP TABLE IF EXISTS `jsp_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsp_member` (
  `id` char(15) NOT NULL,
  `pw` char(15) NOT NULL,
  `name` char(15) DEFAULT NULL,
  `gender` char(10) DEFAULT NULL,
  `email` char(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsp_member`
--

LOCK TABLES `jsp_member` WRITE;
/*!40000 ALTER TABLE `jsp_member` DISABLE KEYS */;
INSERT INTO `jsp_member` VALUES ('admin','1234','관리자','woman','admin@google.com'),('adminstor','1234','관리자','man','adminstor@gmail.com'),('alwls123','alwls123','미진','woman','alwlsdndb@naver.com'),('bib1212','1234','조엉칠','man','josuwon3371@google.com'),('ddd159','dddd159','미미','woman','d@naver.com'),('dddf159','dddd159','미미','woman','d@naver.com'),('dudcjf3371','dudcjf12','감자ab','man','lws2269@naver.com'),('ghwn5401','gkdtkd12','장호주','man','mg223@naver.com'),('jyc94','1234','조수원','man','jyc9494@naver.com'),('Mukbang','Mukbang','조수원','man','jyc9494@naver.com'),('qjatjr418','akqmf159','김범석','man','qjatjr418@naver.com'),('test','1234','테스트','man','test1@naver.com'),('user1','1111','유저','man','user1@naver.com'),('whdudcjf3371','1234','조영철','man','vv_vv3371@naver.com'),('wldudahs1','dlsrks12','허지영','woman','wldudahs1@naver.com'),('zhyomi','dudcjf0616','박재영','woman','wodud6242@naver.com');
/*!40000 ALTER TABLE `jsp_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsp_relation`
--

DROP TABLE IF EXISTS `jsp_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsp_relation` (
  `id` varchar(20) DEFAULT NULL,
  `targetId` varchar(20) DEFAULT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsp_relation`
--

LOCK TABLES `jsp_relation` WRITE;
/*!40000 ALTER TABLE `jsp_relation` DISABLE KEYS */;
INSERT INTO `jsp_relation` VALUES ('admin','jyc94','2020-07-14 13:53:56'),('jyc94','admin','2020-07-14 15:01:40'),('whdudcjf3371','admin','2020-07-14 22:25:53'),('whdudcjf3371','jyc94','2020-07-14 22:25:57'),('whdudcjf3371','bib1212','2020-07-14 22:29:44'),('Mukbang','ghwn5401','2020-07-15 19:48:52'),('ghwn5401','Mukbang','2020-07-15 19:51:16'),('Mukbang','dudcjf3371','2020-07-15 20:05:11'),('dudcjf3371','Mukbang','2020-07-15 20:05:56'),('dudcjf3371','ghwn5401','2020-07-15 20:06:09'),('ghwn5401','dudcjf3371','2020-07-15 20:13:39'),('Mukbang','wldudahs1','2020-07-15 20:34:22'),('ghwn5401','wldudahs1','2020-07-15 21:41:06'),('Mukbang','zhyomi','2020-07-15 22:33:37'),('zhyomi','Mukbang','2020-07-15 22:58:24'),('bib1212','admin','2020-07-16 16:13:26'),('ghwn5401','zhyomi','2020-07-16 22:54:58'),('zhyomi','ghwn5401','2020-07-16 22:56:24'),('alwls123','admin','2020-07-21 17:15:59'),('alwls123','Mukbang','2020-07-21 17:16:27'),('Mukbang','alwls123','2020-07-22 11:08:58'),('Mukbang','admin','2020-07-22 14:02:14'),('Mukbang','qjatjr418','2020-07-28 10:58:46');
/*!40000 ALTER TABLE `jsp_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `id` varchar(12) NOT NULL,
  `passwd` varchar(12) NOT NULL,
  `name` varchar(20) NOT NULL,
  `reg_date` datetime NOT NULL,
  `age` int(11) DEFAULT NULL,
  `gender` varchar(5) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `tel` varchar(20) DEFAULT NULL,
  `mtel` varchar(20) DEFAULT NULL,
  `postcode` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES ('admin','admin','관리자','2020-06-09 15:45:16',27,'남자','vv_vv3371@naver.com','부산 북구 덕천동 395-6 303호','01044173371','01044173371','46569'),('jyc94','fkwpql1','조수원','2020-06-10 16:44:03',27,'남자','jyc9494@naver.com','부산 북구 만덕3로16번길 1 1','01044173371','01044173371','46570');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member2`
--

DROP TABLE IF EXISTS `member2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member2` (
  `id` varchar(12) NOT NULL,
  `pass` varchar(12) NOT NULL,
  `name` varchar(20) NOT NULL,
  `age` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `email` varchar(100) NOT NULL,
  `address` varchar(100) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `mobile` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member2`
--

LOCK TABLES `member2` WRITE;
/*!40000 ALTER TABLE `member2` DISABLE KEYS */;
INSERT INTO `member2` VALUES ('','','',0,'2020-07-23 17:40:43','','','','');
/*!40000 ALTER TABLE `member2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'jspbeginner'
--

--
-- Dumping routines for database 'jspbeginner'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-09-17 17:44:22
