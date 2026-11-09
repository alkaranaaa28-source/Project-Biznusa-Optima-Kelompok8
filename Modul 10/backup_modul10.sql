-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: db_biznusa
-- ------------------------------------------------------
-- Server version	8.4.3

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
-- Table structure for table `absensi`
--

DROP TABLE IF EXISTS `absensi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `absensi` (
  `id_absensi` varchar(10) NOT NULL,
  `tanggal` date NOT NULL,
  `id_staf` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id_absensi`),
  KEY `id_staf` (`id_staf`),
  CONSTRAINT `absensi_ibfk_1` FOREIGN KEY (`id_staf`) REFERENCES `staf_umkm` (`id_staf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `absensi`
--

LOCK TABLES `absensi` WRITE;
/*!40000 ALTER TABLE `absensi` DISABLE KEYS */;
INSERT INTO `absensi` VALUES ('AB001','2026-10-27','ST001'),('AB002','2026-10-27','ST002'),('AB003','2026-10-28','ST003');
/*!40000 ALTER TABLE `absensi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aduan_pelanggan`
--

DROP TABLE IF EXISTS `aduan_pelanggan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aduan_pelanggan` (
  `id_aduan` varchar(10) NOT NULL,
  `status_aduan` varchar(50) NOT NULL,
  `id_absensi` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id_aduan`),
  KEY `id_absensi` (`id_absensi`),
  CONSTRAINT `aduan_pelanggan_ibfk_1` FOREIGN KEY (`id_absensi`) REFERENCES `absensi` (`id_absensi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aduan_pelanggan`
--

LOCK TABLES `aduan_pelanggan` WRITE;
/*!40000 ALTER TABLE `aduan_pelanggan` DISABLE KEYS */;
INSERT INTO `aduan_pelanggan` VALUES ('AD001','Menunggu Diproses','AB001'),('AD002','Sedang Ditangani','AB002'),('AD003','Selesai','AB003');
/*!40000 ALTER TABLE `aduan_pelanggan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `owner_umkm`
--

DROP TABLE IF EXISTS `owner_umkm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `owner_umkm` (
  `id_owner` varchar(10) NOT NULL,
  `nama_owner` varchar(100) NOT NULL,
  PRIMARY KEY (`id_owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `owner_umkm`
--

LOCK TABLES `owner_umkm` WRITE;
/*!40000 ALTER TABLE `owner_umkm` DISABLE KEYS */;
INSERT INTO `owner_umkm` VALUES ('OW001','Bu Yuyun Winarti');
/*!40000 ALTER TABLE `owner_umkm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pembayaran`
--

DROP TABLE IF EXISTS `pembayaran`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pembayaran` (
  `id_pembayaran` varchar(10) NOT NULL,
  `status_pembayaran` varchar(50) NOT NULL,
  `id_transaksi` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id_pembayaran`),
  KEY `idx_pembayaran_id_transaksi` (`id_transaksi`),
  CONSTRAINT `pembayaran_ibfk_1` FOREIGN KEY (`id_transaksi`) REFERENCES `transaksi` (`id_transaksi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pembayaran`
--

LOCK TABLES `pembayaran` WRITE;
/*!40000 ALTER TABLE `pembayaran` DISABLE KEYS */;
INSERT INTO `pembayaran` VALUES ('PB001','Lunas','TR001'),('PB002','Belum Lunas','TR002'),('PB003','Lunas','TR003');
/*!40000 ALTER TABLE `pembayaran` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staf_umkm`
--

DROP TABLE IF EXISTS `staf_umkm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staf_umkm` (
  `id_staf` varchar(10) NOT NULL,
  `nama_staf` varchar(100) NOT NULL,
  `id_owner` varchar(10) DEFAULT NULL,
  `total_transaksi` decimal(15,2) DEFAULT '0.00',
  PRIMARY KEY (`id_staf`),
  KEY `id_owner` (`id_owner`),
  CONSTRAINT `staf_umkm_ibfk_1` FOREIGN KEY (`id_owner`) REFERENCES `owner_umkm` (`id_owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staf_umkm`
--

LOCK TABLES `staf_umkm` WRITE;
/*!40000 ALTER TABLE `staf_umkm` DISABLE KEYS */;
INSERT INTO `staf_umkm` VALUES ('ST001','Andi Pratama','OW001',150000.00),('ST002','Siti Aminah','OW001',250000.00),('ST003','Budi Santoso','OW001',175000.00),('ST005','Rina Amelia','OW001',0.00);
/*!40000 ALTER TABLE `staf_umkm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stok_gudang`
--

DROP TABLE IF EXISTS `stok_gudang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stok_gudang` (
  `id_stok` varchar(10) NOT NULL,
  `jumlah_stok` int NOT NULL,
  `id_owner` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id_stok`),
  KEY `id_owner` (`id_owner`),
  CONSTRAINT `stok_gudang_ibfk_1` FOREIGN KEY (`id_owner`) REFERENCES `owner_umkm` (`id_owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stok_gudang`
--

LOCK TABLES `stok_gudang` WRITE;
/*!40000 ALTER TABLE `stok_gudang` DISABLE KEYS */;
INSERT INTO `stok_gudang` VALUES ('SK001',100,'OW001'),('SK002',75,'OW001'),('SK003',150,'OW001');
/*!40000 ALTER TABLE `stok_gudang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaksi`
--

DROP TABLE IF EXISTS `transaksi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaksi` (
  `id_transaksi` varchar(10) NOT NULL,
  `total_transaksi` decimal(15,2) NOT NULL,
  `id_staf` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id_transaksi`),
  KEY `id_staf` (`id_staf`),
  CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`id_staf`) REFERENCES `staf_umkm` (`id_staf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaksi`
--

LOCK TABLES `transaksi` WRITE;
/*!40000 ALTER TABLE `transaksi` DISABLE KEYS */;
INSERT INTO `transaksi` VALUES ('TR001',150000.00,'ST001'),('TR002',250000.00,'ST002'),('TR003',175000.00,'ST003');
/*!40000 ALTER TABLE `transaksi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'db_biznusa'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-06 15:58:38
