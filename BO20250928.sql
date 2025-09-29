CREATE DATABASE  IF NOT EXISTS `DB_Backoffice` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `DB_Backoffice`;
-- MySQL dump 10.13  Distrib 8.0.41, for macos15 (x86_64)
--
-- Host: cdb-global-backoffice-test.cbyco0wyw688.us-east-1.rds.amazonaws.com    Database: DB_Backoffice
-- ------------------------------------------------------
-- Server version	8.0.39

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `mdl01_authenticator`
--

DROP TABLE IF EXISTS `mdl01_authenticator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl01_authenticator` (
  `authenticator_id` int NOT NULL AUTO_INCREMENT,
  `auth_name` varchar(30) NOT NULL COMMENT 'Nombre de autenticador',
  `auth_code` varchar(30) NOT NULL COMMENT 'codigo del autenticador',
  `status` bit(1) NOT NULL DEFAULT b'1' COMMENT 'estado del autenticador',
  PRIMARY KEY (`authenticator_id`),
  UNIQUE KEY `uk_mdl01_authenticator_auth_code` (`auth_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena el tipo de autenticador de un cliente (token, preguntas de seguridad, etc)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl01_client`
--

DROP TABLE IF EXISTS `mdl01_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl01_client` (
  `client_id` int NOT NULL AUTO_INCREMENT COMMENT 'Id de la tabla',
  `client_role_id` int NOT NULL,
  `authenticator_id` int NOT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1' COMMENT 'estado del cliente',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'fecha de creación',
  `approved_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'fecha de aprobación',
  `created_by` int NOT NULL COMMENT 'ID de quien creo',
  `approved_by` int NOT NULL COMMENT 'ID de quien aprobo',
  PRIMARY KEY (`client_id`),
  KEY `fk_mdl01_client_mdl02_employee` (`created_by`),
  KEY `fk_mdl01_client_mdl02_employee_2` (`approved_by`),
  KEY `fk_mdl01_client_mdl01_authenticator` (`authenticator_id`),
  KEY `fk_mdl01_client_mdl01_client_role` (`client_role_id`),
  CONSTRAINT `fk_mdl01_client_mdl01_authenticator` FOREIGN KEY (`authenticator_id`) REFERENCES `mdl01_authenticator` (`authenticator_id`),
  CONSTRAINT `fk_mdl01_client_mdl01_client_role` FOREIGN KEY (`client_role_id`) REFERENCES `mdl01_client_role` (`client_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena la informacion de los clientes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl01_client_activity_log`
--

DROP TABLE IF EXISTS `mdl01_client_activity_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl01_client_activity_log` (
  `client_activity_log_id` int NOT NULL AUTO_INCREMENT,
  `client_id` int NOT NULL COMMENT 'FK id de la tabla mdl01_client',
  `date_activity` date NOT NULL COMMENT 'Fecha de la actividad',
  `ip_device` varchar(50) NOT NULL COMMENT 'IP del dispositivo',
  `op_system` varchar(50) NOT NULL COMMENT 'Sistema operativo',
  `browser` varchar(50) NOT NULL COMMENT 'Navegador',
  PRIMARY KEY (`client_activity_log_id`),
  KEY `fk_mdl01_client_activity_log_mdl01_client` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena la actividad de los clientes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl01_client_channel`
--

DROP TABLE IF EXISTS `mdl01_client_channel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl01_client_channel` (
  `client_channel_id` int NOT NULL AUTO_INCREMENT,
  `channel_id` int NOT NULL,
  `client_id` int NOT NULL COMMENT 'FK id de la tabla mdl01_client',
  `status` bit(1) NOT NULL DEFAULT b'1' COMMENT 'Estado del canal del cliente',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'fecha de creación',
  `approved_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'fecha de aprobación',
  `created_by` int NOT NULL COMMENT 'ID de quien creo',
  `approved_by` int NOT NULL COMMENT 'ID de quien aprobo',
  PRIMARY KEY (`client_channel_id`),
  UNIQUE KEY `uk_mdl01_client_channel_id_client_id_channel` (`channel_id`,`client_id`),
  KEY `fk_mdl01_client_channel_mdl04_mdl01_client` (`client_id`),
  KEY `fk_mdl01_client_channel_mdl02_employee` (`created_by`),
  KEY `fk_mdl01_client_channel_mdl02_employee_2` (`approved_by`),
  CONSTRAINT `fk_mdl01_client_channel_mdl04_channel` FOREIGN KEY (`channel_id`) REFERENCES `mdl04_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los canales de los clientes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl01_client_channel_mirror`
--

DROP TABLE IF EXISTS `mdl01_client_channel_mirror`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl01_client_channel_mirror` (
  `client_channel_mirror_id` int NOT NULL AUTO_INCREMENT,
  `client_channel_id` int DEFAULT NULL,
  `client_mirror_id` int NOT NULL,
  `channel_id` int DEFAULT NULL,
  `client_id` int DEFAULT NULL COMMENT 'FK id de la tabla mdl01_client',
  `status` bit(1) DEFAULT NULL COMMENT 'estado de canal del cliente',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'fecha de creación',
  `approved_date` datetime DEFAULT NULL COMMENT 'fecha de aprobación',
  `created_by` int NOT NULL COMMENT 'ID de quien creo',
  `approved_by` int DEFAULT NULL COMMENT 'ID de quien aprobo',
  PRIMARY KEY (`client_channel_mirror_id`),
  KEY `fk_mdl01_client_channel_mirror_mdl02_employee` (`created_by`),
  KEY `fk_mdl01_client_channel_mirror_mdl02_employee_2` (`approved_by`),
  KEY `fk_mdl01_client_channel_mirror_mdl01_client_mirror` (`client_mirror_id`),
  CONSTRAINT `fk_mdl01_client_channel_mirror_mdl01_client_mirror` FOREIGN KEY (`client_mirror_id`) REFERENCES `mdl01_client_mirror` (`client_mirror_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla espejo de mdl01_client_channel';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl01_client_mirror`
--

DROP TABLE IF EXISTS `mdl01_client_mirror`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl01_client_mirror` (
  `client_mirror_id` int NOT NULL AUTO_INCREMENT,
  `client_id` int NOT NULL COMMENT 'id de la tabla mdl01_client',
  `client_role_id` int DEFAULT NULL,
  `authenticator_id` int DEFAULT NULL,
  `dni` varchar(20) DEFAULT NULL COMMENT 'Documento Nacional de Identidad',
  `name` varchar(50) DEFAULT NULL COMMENT 'Nombre del cliente',
  `lastname` varchar(50) DEFAULT NULL COMMENT 'Apellido del cliente',
  `user_alias` varchar(50) DEFAULT NULL COMMENT 'Usuario cliente',
  `phone` varchar(30) DEFAULT NULL COMMENT 'Numero del cliente',
  `email` varchar(30) DEFAULT NULL COMMENT 'Email del cliente',
  `status` bit(1) DEFAULT NULL COMMENT 'estado del cliente',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'fecha de creación',
  `approved_date` datetime DEFAULT NULL COMMENT 'fecha de aprobación',
  `created_by` int NOT NULL COMMENT 'ID de quien creo',
  `approved_by` int DEFAULT NULL COMMENT 'ID de quien aprobo',
  PRIMARY KEY (`client_mirror_id`),
  KEY `fk_mdl01_client_mirror_mdl02_employee` (`created_by`),
  KEY `fk_mdl01_client_mirror_empl_employee_2` (`approved_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que espejo de mdl01_client';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl01_client_movement`
--

DROP TABLE IF EXISTS `mdl01_client_movement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl01_client_movement` (
  `client_movement_id` int NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL COMMENT 'fecha del movimiento',
  `details` varchar(50) NOT NULL COMMENT 'datalle del movimiento',
  `id_operation` int NOT NULL COMMENT 'ID de la operacion',
  `ip_user` varchar(50) NOT NULL COMMENT 'Ip del usuario',
  `client_id` int NOT NULL COMMENT 'FK id de la tabla mdl01_client',
  `subproduct_id` int NOT NULL COMMENT 'FK id de la tabla mdl03_subproduct',
  PRIMARY KEY (`client_movement_id`),
  KEY `fk_mdl01_client_movement_mdl01_client` (`client_id`),
  KEY `fk_mdl01_client_movement_mdl03_subproduct` (`subproduct_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los movimientos de los clientes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl01_client_permission`
--

DROP TABLE IF EXISTS `mdl01_client_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl01_client_permission` (
  `client_permission_id` int NOT NULL AUTO_INCREMENT,
  `permission_name` varchar(50) NOT NULL COMMENT 'Nombre del permiso',
  `permission_level` int NOT NULL COMMENT 'Nivel del permiso',
  `permission_group_id` int NOT NULL,
  `permission_code` int NOT NULL COMMENT 'Codigo del permiso',
  `status` bit(1) NOT NULL DEFAULT b'1' COMMENT 'estado del permiso',
  PRIMARY KEY (`client_permission_id`),
  UNIQUE KEY `uk_mdl01_client_permission_code` (`permission_code`),
  KEY `fk_mdl01_client_permission_mdl01_permission_group` (`permission_group_id`),
  CONSTRAINT `fk_mdl01_client_permission_mdl01_permission_group` FOREIGN KEY (`permission_group_id`) REFERENCES `mdl01_permission_group` (`permission_group_id`),
  CONSTRAINT `ck_mdl01_client_permission_level` CHECK ((`permission_level` in (1,2,3)))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los permisos de los clientes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl01_client_role`
--

DROP TABLE IF EXISTS `mdl01_client_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl01_client_role` (
  `client_role_id` int NOT NULL AUTO_INCREMENT,
  `rol` varchar(50) NOT NULL,
  `role_level` int NOT NULL COMMENT 'Nivel del rol',
  `status` bit(1) NOT NULL DEFAULT b'1' COMMENT 'estado del rol del cliente',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'fecha de creación',
  `approved_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'fecha de aprobación',
  `created_by` int NOT NULL COMMENT 'ID de quien creo',
  `approved_by` int NOT NULL COMMENT 'ID de quien aprobo',
  PRIMARY KEY (`client_role_id`),
  KEY `fk_mdl01_client_role_mdl02_employee` (`created_by`),
  KEY `fk_mdl01_client_role_mdl02_employee_2` (`approved_by`),
  CONSTRAINT `ck_mdl01_client_role_level` CHECK ((`role_level` in (1,2,3)))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los roles de los clientes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl01_client_role_mirror`
--

DROP TABLE IF EXISTS `mdl01_client_role_mirror`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl01_client_role_mirror` (
  `client_role_mirror_id` int NOT NULL AUTO_INCREMENT,
  `client_role_id` int DEFAULT NULL,
  `role_level` int DEFAULT NULL COMMENT 'Nivel del rol',
  `status` bit(1) DEFAULT NULL COMMENT 'estado de canal del cliente',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'fecha de creación',
  `approved_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'fecha de aprobación',
  `created_by` int NOT NULL COMMENT 'ID de quien creo',
  `approved_by` int DEFAULT NULL COMMENT 'ID de quien aprobo',
  PRIMARY KEY (`client_role_mirror_id`),
  KEY `fk_mdl01_client_role_mirror_mdl02_employee` (`created_by`),
  KEY `fk_mdl01_client_role_mirror_mdl02_employee_2` (`approved_by`),
  CONSTRAINT `ck_mdl01_client_role_mirror_role_level` CHECK ((`role_level` in (1,2,3)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla espejo de mdl01_client_role';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl01_client_role_permission`
--

DROP TABLE IF EXISTS `mdl01_client_role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl01_client_role_permission` (
  `client_role_permission_id` int NOT NULL AUTO_INCREMENT,
  `client_role_id` int NOT NULL,
  `client_permission_id` int NOT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1' COMMENT 'estado del rol',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'fecha de creación',
  `approved_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'fecha de aprobación',
  `created_by` int NOT NULL COMMENT 'ID de quien creo',
  `approved_by` int NOT NULL COMMENT 'ID de quien aprobo',
  PRIMARY KEY (`client_role_permission_id`),
  UNIQUE KEY `uk_mdl01_client_role_permission` (`client_role_id`,`client_permission_id`),
  KEY `fk_mdl01_client_role_permission_mdl02_employee` (`created_by`),
  KEY `fk_mdl01_client_role_permission_mdl02_employee_2` (`approved_by`),
  KEY `fk_mdl01_client_role_perm_mdl01_client_permission` (`client_permission_id`),
  CONSTRAINT `fk_mdl01_client_role_perm_mdl01_client_permission` FOREIGN KEY (`client_permission_id`) REFERENCES `mdl01_client_permission` (`client_permission_id`),
  CONSTRAINT `fk_mdl01_client_role_permission_mdl01_client_role` FOREIGN KEY (`client_role_id`) REFERENCES `mdl01_client_role` (`client_role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los roles de persmisos de clientes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl01_client_role_permission_mirror`
--

DROP TABLE IF EXISTS `mdl01_client_role_permission_mirror`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl01_client_role_permission_mirror` (
  `client_role_permission_mirror_id` int NOT NULL AUTO_INCREMENT,
  `client_role_permission_id` int DEFAULT NULL,
  `client_role_id` int DEFAULT NULL,
  `client_role_mirror_id` int DEFAULT NULL,
  `client_permission_id` int DEFAULT NULL,
  `status` bit(1) DEFAULT NULL COMMENT 'estado del rol',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'fecha de creación',
  `approved_date` datetime DEFAULT NULL COMMENT 'fecha de aprobación',
  `created_by` int NOT NULL COMMENT 'ID de quien creo',
  `approved_by` int DEFAULT NULL COMMENT 'ID de quien aprobo',
  PRIMARY KEY (`client_role_permission_mirror_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla espejo de mdl01_client_role_permission';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl01_client_subproduct`
--

DROP TABLE IF EXISTS `mdl01_client_subproduct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl01_client_subproduct` (
  `client_subproduct_id` int NOT NULL AUTO_INCREMENT,
  `client_id` int NOT NULL COMMENT 'FK id de la tabla mdl01_client',
  `subproduct_id` int NOT NULL COMMENT 'FK id de la tabla mdl03_subproduct',
  `inquiry` bit(1) NOT NULL COMMENT 'Consulta del subproducto',
  `debit` bit(1) NOT NULL COMMENT 'subproducto debito',
  `credit` bit(1) NOT NULL COMMENT 'subproducto credito',
  `is_visible` bit(1) NOT NULL COMMENT 'subproducto visible',
  `status` bit(1) NOT NULL DEFAULT b'1' COMMENT 'estado del subproducto',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'fecha de creación',
  `approved_date` datetime NOT NULL COMMENT 'fecha de aprobación',
  `created_by` int NOT NULL COMMENT 'ID de quien creo',
  `approved_by` int NOT NULL COMMENT 'ID de quien aprobo',
  PRIMARY KEY (`client_subproduct_id`),
  KEY `fk_mdl01_client_subproduct_mdl01_client` (`client_id`),
  KEY `fk_mdl01_client_subproduct_mdl03_subproduct` (`subproduct_id`),
  KEY `fk_mdl01_client_subproduct_mdl02_employee` (`created_by`),
  KEY `fk_mdl01_client_subproduct_mdl02_employee_2` (`approved_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los subproductos de los clientes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl01_client_subproduct_mirror`
--

DROP TABLE IF EXISTS `mdl01_client_subproduct_mirror`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl01_client_subproduct_mirror` (
  `client_subproduct_mirror_id` int NOT NULL AUTO_INCREMENT,
  `client_subproduct_id` int DEFAULT NULL,
  `client_mirror_id` int NOT NULL,
  `client_id` int DEFAULT NULL COMMENT 'FK id de la tabla mdl01_client',
  `subproduct_id` int DEFAULT NULL COMMENT 'FK id de la tabla mdl03_subproduct',
  `inquiry` bit(1) DEFAULT NULL COMMENT 'Consulta del subproducto',
  `debit` bit(1) DEFAULT NULL COMMENT 'subproducto debito',
  `credit` bit(1) DEFAULT NULL COMMENT 'subproducto credito',
  `is_visible` bit(1) DEFAULT NULL COMMENT 'subproducto visible',
  `status` bit(1) DEFAULT NULL COMMENT 'estado del subproducto',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'fecha de creación',
  `approved_date` datetime DEFAULT NULL COMMENT 'fecha de aprobación',
  `created_by` int NOT NULL COMMENT 'ID de quien creo',
  `approved_by` int DEFAULT NULL COMMENT 'ID de quien aprobo',
  PRIMARY KEY (`client_subproduct_mirror_id`),
  KEY `fk_mdl01_client_subp_mr_mdl02_employee` (`created_by`),
  KEY `fk_mdl01_client_subp_mr_mdl02_employee_2` (`approved_by`),
  KEY `fk_mdl01_client_subp_mr_mdl01_client_mirror` (`client_mirror_id`),
  CONSTRAINT `fk_mdl01_client_subp_mr_mdl01_client_mirror` FOREIGN KEY (`client_mirror_id`) REFERENCES `mdl01_client_mirror` (`client_mirror_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los subproductos de los clientes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl01_permission_group`
--

DROP TABLE IF EXISTS `mdl01_permission_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl01_permission_group` (
  `permission_group_id` int NOT NULL AUTO_INCREMENT,
  `group_name` varchar(50) NOT NULL COMMENT 'Nombre del grupo',
  `status` bit(1) NOT NULL DEFAULT b'1' COMMENT 'Estado del grupo',
  PRIMARY KEY (`permission_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los permisos de los grupos de los clientes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl02_employee`
--

DROP TABLE IF EXISTS `mdl02_employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl02_employee` (
  `employee_id` int NOT NULL AUTO_INCREMENT COMMENT 'Id de la tabla',
  `branch_id` int NOT NULL,
  `role_id` int NOT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1' COMMENT 'Estado de la tabala empleado. 0: inactivo, 1: activo',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creación',
  `approved_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de aprovación',
  `created_by` int NOT NULL COMMENT 'Creador',
  `approved_by` int NOT NULL COMMENT 'Aprobador',
  PRIMARY KEY (`employee_id`),
  KEY `fK_mdl02_employee_mdl02_employee` (`created_by`),
  KEY `fK_mdl02_employee_mdl02_employee_2` (`approved_by`),
  KEY `fK_mdl02_employee_mdl02_employee_role` (`role_id`),
  KEY `fK_mdl02_employee_mdl05_branch` (`branch_id`),
  CONSTRAINT `fK_mdl02_employee_mdl02_employee_role` FOREIGN KEY (`role_id`) REFERENCES `mdl02_employee_role` (`role_id`),
  CONSTRAINT `fK_mdl02_employee_mdl05_branch` FOREIGN KEY (`branch_id`) REFERENCES `mdl05_branch` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena a los colaboradores';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl02_employee_activity_log`
--

DROP TABLE IF EXISTS `mdl02_employee_activity_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl02_employee_activity_log` (
  `activity_log_id` int NOT NULL AUTO_INCREMENT,
  `activity_log_date` datetime NOT NULL COMMENT 'fecha y hora de la actividad del empleado',
  `activity_log_description` varchar(50) NOT NULL COMMENT 'descripción de la actividad ejecutada por el empleado',
  `device_ip` varchar(50) NOT NULL COMMENT 'ip desde donde se reaizo la actividad',
  `op_system` varchar(50) NOT NULL COMMENT 'sistema operativo desde donde se hizo la actividad',
  `browser` varchar(50) NOT NULL COMMENT 'tipo de navegador desde donde se hizo la actividad',
  `employee_id` int NOT NULL COMMENT 'Numero del empleado',
  PRIMARY KEY (`activity_log_id`),
  KEY `fk_mdl02_employee_activity_log_mdl02_employee` (`employee_id`),
  KEY `idx_mdl02_employee_activity_log_date` (`activity_log_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena la actividad de los empleados';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl02_employee_mirror`
--

DROP TABLE IF EXISTS `mdl02_employee_mirror`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl02_employee_mirror` (
  `employee_mirror_id` int NOT NULL AUTO_INCREMENT,
  `employee_id` int NOT NULL COMMENT 'Numero del empleado',
  `employee_mirror_name` varchar(50) DEFAULT NULL COMMENT 'Nombre del empleado',
  `employee_mirror_lastname` varchar(50) DEFAULT NULL COMMENT 'Apellido del empleado',
  `branch_id` int DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  `status` bit(1) DEFAULT NULL COMMENT 'Estado de la tabala empleado mirror. 0: inactivo, 1: activo',
  `created_date` datetime NOT NULL COMMENT 'Fecha de creación',
  `approved_date` datetime DEFAULT NULL COMMENT 'Fecha de aprovación',
  `created_by` int NOT NULL COMMENT 'Creador',
  `approved_by` int DEFAULT NULL COMMENT 'Aprobador',
  PRIMARY KEY (`employee_mirror_id`),
  KEY `fk_mdl02_employee_mirror_mdl02_employee` (`created_by`),
  KEY `fk_mdl02_employee_mirror_mdl02_employee_2` (`approved_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla espejo que almacena a los empleados';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl02_employee_permission`
--

DROP TABLE IF EXISTS `mdl02_employee_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl02_employee_permission` (
  `employee_permission_id` int NOT NULL AUTO_INCREMENT,
  `employee_permission_name` varchar(50) NOT NULL COMMENT 'Nombre del permiso del empleado',
  `employee_permission_code` binary(16) NOT NULL COMMENT 'Codigo del permiso',
  `employee_permission_group_id` int NOT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1' COMMENT 'Estado de los permisos del empleado. 0: inactivo, 1: activo',
  PRIMARY KEY (`employee_permission_id`),
  UNIQUE KEY `uk_mdl02_employee_permission_code` (`employee_permission_code`),
  KEY `idx_mdl02_empl_perm_group_id_empl_perm_name` (`employee_permission_group_id`,`employee_permission_name`),
  CONSTRAINT `fk_mdl02_empl_perm_mdl02_empl_perm_group` FOREIGN KEY (`employee_permission_group_id`) REFERENCES `mdl02_employee_permission_group` (`employee_permission_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los permisos de los empelados';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl02_employee_permission_group`
--

DROP TABLE IF EXISTS `mdl02_employee_permission_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl02_employee_permission_group` (
  `employee_permission_group_id` int NOT NULL AUTO_INCREMENT,
  `employee_permission_group_name` varchar(50) NOT NULL COMMENT 'nombre del grupo',
  `status` bit(1) NOT NULL DEFAULT b'1' COMMENT 'Estado del grupo de permiso. 0: inactivo, 1: activo',
  PRIMARY KEY (`employee_permission_group_id`),
  KEY `idx_mdl02_employee_permission_group_name` (`employee_permission_group_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena el grupo al que pertenecen los permisos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl02_employee_role`
--

DROP TABLE IF EXISTS `mdl02_employee_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl02_employee_role` (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) NOT NULL COMMENT 'Nombre del rol',
  `status` bit(1) NOT NULL DEFAULT b'1' COMMENT 'Estado del rol del empleado. 0: inactivo, 1: activo',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creación',
  `approved_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de aprovación',
  `created_by` int NOT NULL COMMENT 'Creador',
  `approved_by` int NOT NULL COMMENT 'Aprobador',
  PRIMARY KEY (`role_id`),
  KEY `fk_mdl02_employee_role_mdl02_employee` (`created_by`),
  KEY `fk_mdl02_employee_role_mdl02_employee_2` (`approved_by`),
  KEY `idx_mdl02_employee_role_name` (`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=30956 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena el rol de los colaboradores';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl02_employee_role_mirror`
--

DROP TABLE IF EXISTS `mdl02_employee_role_mirror`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl02_employee_role_mirror` (
  `employee_role_mirror_id` int NOT NULL AUTO_INCREMENT,
  `role_id` int DEFAULT NULL,
  `role_name` varchar(50) DEFAULT NULL COMMENT 'Nombre del rol',
  `status` bit(1) DEFAULT NULL COMMENT 'Estado del rol del empleado. 0: inactivo, 1: activo',
  `created_date` datetime NOT NULL COMMENT 'Fecha de creación',
  `approved_date` datetime DEFAULT NULL COMMENT 'Fecha de aprovación',
  `created_by` int NOT NULL COMMENT 'Creador',
  `approved_by` int DEFAULT NULL COMMENT 'Aprobador',
  PRIMARY KEY (`employee_role_mirror_id`),
  KEY `fk_mdl02_employee_role_mirror_mdl02_employee` (`created_by`),
  KEY `fk_mdl02_employee_role_mirror_mdl02_employee_2` (`approved_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla espejo que almacena roles del empleado';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl02_employee_role_permission`
--

DROP TABLE IF EXISTS `mdl02_employee_role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl02_employee_role_permission` (
  `employee_role_permission_id` int NOT NULL AUTO_INCREMENT,
  `role_id` int NOT NULL,
  `employee_permission_id` int NOT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1' COMMENT 'Estado de los permisos para el rol del empleado. 0: inactivo, 1: activo',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creación',
  `approved_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de aprovación',
  `created_by` int NOT NULL COMMENT 'Creador',
  `approved_by` int NOT NULL COMMENT 'Aprobador',
  PRIMARY KEY (`employee_role_permission_id`),
  UNIQUE KEY `uk_mdl02_employee_role_permission` (`role_id`,`employee_permission_id`),
  KEY `fk_mdl02_employee_role_permission_mdl02_employee` (`created_by`),
  KEY `fk_mdl02_employee_role_permission_mdl02_employee_2` (`approved_by`),
  KEY `idx_mdl02_empl_role_perm_role_id_empl_perm_id` (`role_id`,`employee_permission_id`),
  KEY `fk_mdl02_employee_role_permission_mdl02_permission` (`employee_permission_id`),
  CONSTRAINT `fk_mdl02_employee_role_perm_mdl02_employee_role` FOREIGN KEY (`role_id`) REFERENCES `mdl02_employee_role` (`role_id`),
  CONSTRAINT `fk_mdl02_employee_role_permission_mdl02_permission` FOREIGN KEY (`employee_permission_id`) REFERENCES `mdl02_employee_permission` (`employee_permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los permisos de cada rol';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl02_employee_role_permission_mirror`
--

DROP TABLE IF EXISTS `mdl02_employee_role_permission_mirror`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl02_employee_role_permission_mirror` (
  `employee_role_permission_mirror_id` int NOT NULL AUTO_INCREMENT,
  `employee_role_mirror_id` int NOT NULL,
  `role_id` int DEFAULT NULL,
  `employee_role_permission_id` int DEFAULT NULL,
  `employee_permission_id` int DEFAULT NULL,
  `status` bit(1) DEFAULT NULL COMMENT 'Estado de los permisos para el rol del empleado. 0: inactivo, 1: activo',
  `created_date` datetime NOT NULL COMMENT 'Fecha de creación',
  `approved_date` datetime DEFAULT NULL COMMENT 'Fecha de aprovación',
  `created_by` int NOT NULL COMMENT 'Creador',
  `approved_by` int DEFAULT NULL COMMENT 'Aprobador',
  PRIMARY KEY (`employee_role_permission_mirror_id`),
  KEY `fk_mdl02_employee_role_perm_mr_mdl02_employee` (`created_by`),
  KEY `fk_mdl02_employee_role_perm_mr_mdl02_employee_2` (`approved_by`),
  KEY `fk_mdl02_empl_role_perm_mir__mdl02_empl_role_mir` (`employee_role_mirror_id`),
  CONSTRAINT `fk_mdl02_empl_role_perm_mir__mdl02_empl_role_mir` FOREIGN KEY (`employee_role_mirror_id`) REFERENCES `mdl02_employee_role_mirror` (`employee_role_mirror_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla espejo que almacena los permisos de los roles de los empleados';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl03_characteristic`
--

DROP TABLE IF EXISTS `mdl03_characteristic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl03_characteristic` (
  `characteristic_id` int NOT NULL AUTO_INCREMENT,
  `characteristic_name` varchar(50) NOT NULL COMMENT 'Nombre de caracteristicas',
  `status` bit(1) NOT NULL DEFAULT b'1' COMMENT 'Estado de la caracteristica',
  PRIMARY KEY (`characteristic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena caracteristicas';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl03_product`
--

DROP TABLE IF EXISTS `mdl03_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl03_product` (
  `product_id` int NOT NULL AUTO_INCREMENT COMMENT 'Id de la tabla',
  `product_name` varchar(50) NOT NULL COMMENT 'Nombre de producto',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT 'estado del producto',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'fecha de creación',
  `created_by` int NOT NULL COMMENT 'ID de quien creo',
  `approved_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'fecha de aprovación',
  `approved_by` int NOT NULL COMMENT 'ID de quien aprovo',
  PRIMARY KEY (`product_id`),
  KEY `fk_mdl03_product_mdl02_employee` (`created_by`),
  KEY `fk_mdl03_product_mdl02_employee_2` (`approved_by`),
  CONSTRAINT `ck_mdl03_product_status` CHECK (((`status` >= 0) and (`status` <= 5)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena información de productos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl03_product_mirror`
--

DROP TABLE IF EXISTS `mdl03_product_mirror`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl03_product_mirror` (
  `product_mirror_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL COMMENT 'FK Id de la tabla producto',
  `product_alias` varchar(50) DEFAULT NULL COMMENT 'Alias del producto',
  `status` tinyint DEFAULT NULL COMMENT 'estado del producto',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'fecha de creación',
  `created_by` int NOT NULL COMMENT 'Id de quien creó',
  `approved_date` datetime DEFAULT NULL COMMENT 'fecha de aprovación',
  `approved_by` int DEFAULT NULL COMMENT 'Id de quien aprovó',
  `status_mirror` bit(1) NOT NULL DEFAULT b'1' COMMENT 'estado del registro en mirror',
  PRIMARY KEY (`product_mirror_id`),
  KEY `fk_mdl03_product_mirror_mdl02_employee` (`created_by`),
  KEY `fk_mdl03_product_mirror_mdl02_employee_2` (`approved_by`),
  CONSTRAINT `ck_mdl03_product_mirror_status` CHECK (((`status` >= 0) and (`status` <= 5)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla espejo de mdl03_product_mirror';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl03_subproduct`
--

DROP TABLE IF EXISTS `mdl03_subproduct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl03_subproduct` (
  `subproduct_id` int NOT NULL AUTO_INCREMENT COMMENT 'Id de la tabla',
  `product_id` int NOT NULL COMMENT 'Id de tabla de productos',
  `subproduct_name` varchar(50) NOT NULL COMMENT 'Nombre de subproducto',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT 'Estado de subproducto',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creación',
  `created_by` int NOT NULL COMMENT 'Id de quien creo',
  `approved_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de aprovación',
  `approved_by` int NOT NULL COMMENT 'Id de quien aprovó',
  PRIMARY KEY (`subproduct_id`),
  KEY `fk_mdl03_subproduct_mdl02_employee` (`created_by`),
  KEY `fk_mdl03_subproduct_mdl02_employee_2` (`approved_by`),
  KEY `idx_mdl03_subproduct_product_id_subproduct_id` (`product_id`,`subproduct_id`),
  CONSTRAINT `ck_mdl03_subproduct_status` CHECK (((`status` >= 0) and (`status` <= 5)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena subproducto';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl03_subproduct_characteristic`
--

DROP TABLE IF EXISTS `mdl03_subproduct_characteristic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl03_subproduct_characteristic` (
  `subproduct_characteristic_id` int NOT NULL AUTO_INCREMENT,
  `subproduct_id` int NOT NULL COMMENT 'FK id de tabla mdl03_subproduct',
  `characteristic_id` int NOT NULL,
  `inquiry` bit(1) NOT NULL COMMENT 'Si es consulta',
  `debit` bit(1) NOT NULL COMMENT 'Si es debito',
  `credit` bit(1) NOT NULL COMMENT 'Si es credito',
  `status` bit(1) NOT NULL DEFAULT b'1' COMMENT 'Estado de la caracteristica',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creación',
  `created_by` int NOT NULL COMMENT 'id de quien creó',
  `approved_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de aprovación',
  `approved_by` int NOT NULL COMMENT 'id de quien aprovó',
  PRIMARY KEY (`subproduct_characteristic_id`),
  UNIQUE KEY `uk_mdl03_subprod_subprod_id_charac_charac_id` (`subproduct_id`,`characteristic_id`),
  KEY `fk_mdl03_subprod_charac_mdl02_employee` (`created_by`),
  KEY `fk_mdl03_subprod_charac_mdl02_employee_2` (`approved_by`),
  KEY `idx_mdl03_subprod_charac_subprod_id_sharac_id` (`subproduct_id`,`characteristic_id`),
  KEY `fk_mdl03_subprod_charac_mdl03_charact` (`characteristic_id`),
  CONSTRAINT `fk_mdl03_subprod_charac_mdl03_charact` FOREIGN KEY (`characteristic_id`) REFERENCES `mdl03_characteristic` (`characteristic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena caracteristicas de subproducto';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl03_subproduct_characteristic_mirror`
--

DROP TABLE IF EXISTS `mdl03_subproduct_characteristic_mirror`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl03_subproduct_characteristic_mirror` (
  `subproduct_characteristic_mirror_id` int NOT NULL AUTO_INCREMENT,
  `subproduct_mirror_id` int NOT NULL,
  `subproduct_characteristic_id` int DEFAULT NULL,
  `subproduct_id` int DEFAULT NULL COMMENT 'FK id de la tabla mdl03_subproduct',
  `characteristic_id` int DEFAULT NULL,
  `inquiry` bit(1) DEFAULT NULL COMMENT 'Si es consulta',
  `debit` bit(1) DEFAULT NULL COMMENT 'Si es debito',
  `credit` bit(1) DEFAULT NULL COMMENT 'Si es credito',
  `status` bit(1) DEFAULT NULL COMMENT 'Estado de la caracteristica',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creación',
  `created_by` int NOT NULL COMMENT 'Id quien creó',
  `approved_date` datetime DEFAULT NULL COMMENT 'Fecha de aprovación',
  `approved_by` int DEFAULT NULL COMMENT 'Id quien aprovó',
  `status_mirror` bit(1) NOT NULL DEFAULT b'1' COMMENT 'estado del registro en mirror',
  PRIMARY KEY (`subproduct_characteristic_mirror_id`),
  KEY `fk_mdl03_subprod_charac_mirror_mdl02_employee` (`created_by`),
  KEY `fk_mdl03_subprod_charac_mirror_mdl02_employee_2` (`approved_by`),
  KEY `fk_mdl03_subprod_charac_mirror_subprod_mirror` (`subproduct_mirror_id`),
  CONSTRAINT `fk_mdl03_subprod_charac_mirror_subprod_mirror` FOREIGN KEY (`subproduct_mirror_id`) REFERENCES `mdl03_subproduct_mirror` (`subproduct_mirror_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla espejo de mdl03_subproduct_characteristic';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl03_subproduct_mirror`
--

DROP TABLE IF EXISTS `mdl03_subproduct_mirror`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl03_subproduct_mirror` (
  `subproduct_mirror_id` int NOT NULL AUTO_INCREMENT,
  `product_mirror_id` int NOT NULL,
  `subproduct_id` int NOT NULL COMMENT 'FK id de tabla subproducto',
  `product_id` int DEFAULT NULL COMMENT 'FK id de la tabla producto',
  `subproduct_name` varchar(50) NOT NULL COMMENT 'Nombre de subproducto',
  `status` tinyint DEFAULT '1' COMMENT 'Estado de subproducto',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creación',
  `created_by` int NOT NULL COMMENT 'Id de quien creó',
  `approved_date` datetime DEFAULT NULL COMMENT 'Fecha de aprovación',
  `approved_by` int DEFAULT NULL COMMENT 'Id de quien aprovó',
  `status_mirror` bit(1) NOT NULL DEFAULT b'1' COMMENT 'estado del registro en mirror',
  PRIMARY KEY (`subproduct_mirror_id`),
  KEY `fk_mdl03_subproduct_mirror_mdl02_employee` (`created_by`),
  KEY `fk_mdl03_subproduct_mirror_mdl02_employee_2` (`approved_by`),
  KEY `fk_mdl03_subproduct_mirror_mdl03_product_mirror` (`product_mirror_id`),
  CONSTRAINT `fk_mdl03_subproduct_mirror_mdl03_product_mirror` FOREIGN KEY (`product_mirror_id`) REFERENCES `mdl03_product_mirror` (`product_mirror_id`),
  CONSTRAINT `ck_mdl03_subproduct_mirror_status` CHECK (((`status` >= 0) and (`status` <= 5)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla espejo de mdl03-subproduct';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl04_catalog`
--

DROP TABLE IF EXISTS `mdl04_catalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl04_catalog` (
  `catalog_id` int NOT NULL AUTO_INCREMENT,
  `catalog_name` varchar(50) NOT NULL COMMENT 'Nombre del catalogo',
  `catalog_code` varchar(50) NOT NULL COMMENT 'Codigo del catalogo',
  `created_by` int NOT NULL COMMENT 'Id del creador',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creacion',
  `approved_by` int NOT NULL COMMENT 'Id del aprobador',
  `approved_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de aprobacion',
  PRIMARY KEY (`catalog_id`),
  UNIQUE KEY `uk_mdl04_catalog_code` (`catalog_code`),
  KEY `idx_mdl04_catalog_catalog_name` (`catalog_name`),
  KEY `fk_mdl04_catalog_mdl02_employee` (`created_by`),
  KEY `fk_mdl04_catalog_mdl02_employee_2` (`approved_by`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los catalogos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl04_catalog_mirror`
--

DROP TABLE IF EXISTS `mdl04_catalog_mirror`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl04_catalog_mirror` (
  `catalog_mirror_id` int NOT NULL AUTO_INCREMENT,
  `catalog_id` int DEFAULT NULL,
  `catalog_name` varchar(50) DEFAULT NULL COMMENT 'Nombre del catalogo',
  `catalog_code` varchar(50) DEFAULT NULL COMMENT 'Codigo del catalogo',
  `created_by` int NOT NULL COMMENT 'Id del creador',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creacion',
  `approved_by` int DEFAULT NULL COMMENT 'Id del aprobador',
  `approved_date` datetime DEFAULT NULL COMMENT 'Fecha de aprobacion',
  `request_id` int NOT NULL COMMENT 'FK de la tabla mdl06_request',
  PRIMARY KEY (`catalog_mirror_id`),
  KEY `fk_mdl04_catalog_mirror_mdl02_employee` (`created_by`),
  KEY `fk_mdl04_catalog_mirror_mdl02_employee_2` (`approved_by`),
  KEY `FKrequest` (`request_id`),
  CONSTRAINT `FKrequest` FOREIGN KEY (`request_id`) REFERENCES `mdl06_request` (`request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=901 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los cambios de la tabla de catalogos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl04_channel`
--

DROP TABLE IF EXISTS `mdl04_channel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl04_channel` (
  `channel_id` int NOT NULL AUTO_INCREMENT,
  `channel_code` varchar(10) NOT NULL COMMENT 'Codigo del canal',
  `status` bit(1) NOT NULL DEFAULT b'1' COMMENT 'Estado del canal. 0: inactivo, 1: activo',
  PRIMARY KEY (`channel_id`),
  UNIQUE KEY `uk_mdl04_channel_code` (`channel_code`),
  KEY `idx_mdl04_channel_code` (`channel_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los canales de los clientes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl04_code_mirror`
--

DROP TABLE IF EXISTS `mdl04_code_mirror`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl04_code_mirror` (
  `code_mirror_id` int NOT NULL AUTO_INCREMENT,
  `element_mirror_id` int NOT NULL,
  `status` bit(1) DEFAULT NULL,
  `code_id` int DEFAULT NULL,
  `element_id` int DEFAULT NULL,
  `origin_id` int NOT NULL,
  `code` varchar(10) DEFAULT NULL COMMENT 'Codigo del elemento',
  `created_by` int NOT NULL COMMENT 'Id del creador',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creacion',
  `approved_by` int DEFAULT NULL COMMENT 'Id del aprobador',
  `approved_date` datetime DEFAULT NULL COMMENT 'Fecha de aprobacion',
  PRIMARY KEY (`code_mirror_id`),
  KEY `idx_mdl04_code_mirror_element_mirror_id` (`element_mirror_id`),
  KEY `fk_mdl04_code_mirror_mdl02_employee` (`created_by`),
  KEY `fk_mdl04_code_mirror_mdl02_employee_2` (`approved_by`),
  KEY `fk_mdl04_code_mirror_mdl04_origin` (`origin_id`),
  CONSTRAINT `fk_mdl04_code_mirror_mdl04_element_mirror` FOREIGN KEY (`element_mirror_id`) REFERENCES `mdl04_element_mirror` (`element_mirror_id`),
  CONSTRAINT `fk_mdl04_code_mirror_mdl04_origin` FOREIGN KEY (`origin_id`) REFERENCES `mdl04_origin` (`origin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=905 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los cambios de los codigos de los elementos por origen';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl04_description`
--

DROP TABLE IF EXISTS `mdl04_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl04_description` (
  `description_id` int NOT NULL AUTO_INCREMENT,
  `element_id` int NOT NULL,
  `language` varchar(2) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_by` int NOT NULL COMMENT 'Id del creador',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creacion',
  `approved_by` int NOT NULL COMMENT 'Id del aprobador',
  `approved_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de aprobacion',
  PRIMARY KEY (`description_id`),
  UNIQUE KEY `uk_mdl04_description_element_id_language_id` (`element_id`,`language`),
  KEY `idx_mdl04_description_language_id_element_id` (`element_id`,`language`),
  KEY `fk_mdl04_description_mdl02_employee` (`created_by`),
  KEY `fk_mdl04_description_mdl02_employee_2` (`approved_by`),
  KEY `fk_mdl04_description_mdl04_language` (`language`),
  CONSTRAINT `fk_mdl04_description_mdl04_element` FOREIGN KEY (`element_id`) REFERENCES `mdl04_element` (`element_id`),
  CONSTRAINT `chk_language` CHECK ((`language` in (_utf8mb4'ES',_utf8mb4'EN')))
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena la descripcion de los elementos por lenguaje';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl04_description_mirror`
--

DROP TABLE IF EXISTS `mdl04_description_mirror`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl04_description_mirror` (
  `description_mirror_id` int NOT NULL AUTO_INCREMENT,
  `element_mirror_id` int NOT NULL,
  `description_id` int DEFAULT NULL,
  `element_id` int DEFAULT NULL,
  `language` varchar(2) NOT NULL,
  `description` varchar(250) DEFAULT NULL COMMENT 'Descripcion del elemento',
  `created_by` int NOT NULL COMMENT 'Id del creador',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creacion',
  `approved_by` int DEFAULT NULL COMMENT 'Id del aprobador',
  `approved_date` datetime DEFAULT NULL COMMENT 'Fecha de aprobacion',
  `status` bit(1) DEFAULT NULL,
  PRIMARY KEY (`description_mirror_id`),
  KEY `idx_mdl04_description_mirror_element_mirror_id` (`element_mirror_id`),
  KEY `fk_mdl04_description_mirror_mdl02_employee` (`created_by`),
  KEY `fk_mdl04_description_mirror_mdl02_employee_2` (`approved_by`),
  CONSTRAINT `fk_mdl04_description_mirror_mdl04_element_mirror` FOREIGN KEY (`element_mirror_id`) REFERENCES `mdl04_element_mirror` (`element_mirror_id`)
) ENGINE=InnoDB AUTO_INCREMENT=904 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los cambios de la descripcion de los elementos por lenguaje';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl04_element`
--

DROP TABLE IF EXISTS `mdl04_element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl04_element` (
  `element_id` int NOT NULL AUTO_INCREMENT,
  `catalog_id` int NOT NULL,
  `element_name` varchar(50) NOT NULL COMMENT 'Nombre del elemento del catalogo',
  `status` bit(1) NOT NULL DEFAULT b'1' COMMENT 'Estado del elemento. 0: inactivo, 1: activo',
  `created_by` int NOT NULL COMMENT 'Id del creador',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creacion',
  `approved_by` int NOT NULL COMMENT 'Id del aprobador',
  `approved_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de aprobacion',
  PRIMARY KEY (`element_id`),
  KEY `idx_mdl04_element_catalog_id_element_name` (`catalog_id`,`element_name`),
  KEY `fk_mdl04_element_mdl02_employee` (`created_by`),
  KEY `fk_mdl04_element_mdl02_employee_2` (`approved_by`),
  CONSTRAINT `fk_mdl04_element_mdl04_catalog` FOREIGN KEY (`catalog_id`) REFERENCES `mdl04_catalog` (`catalog_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los elementos de los catalogos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl04_element_mirror`
--

DROP TABLE IF EXISTS `mdl04_element_mirror`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl04_element_mirror` (
  `element_mirror_id` int NOT NULL AUTO_INCREMENT,
  `catalog_mirror_id` int NOT NULL,
  `element_id` int DEFAULT NULL,
  `catalog_id` int DEFAULT NULL,
  `element_name` varchar(50) DEFAULT NULL COMMENT 'Nombre del elemento del catalogo',
  `status` bit(1) DEFAULT NULL COMMENT 'Estado del elemento. 0: inactivo, 1: activo',
  `created_by` int NOT NULL COMMENT 'Id del creador',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creacion',
  `approved_by` int DEFAULT NULL COMMENT 'Id del aprobador',
  `approved_date` datetime DEFAULT NULL COMMENT 'Fecha de aprobacion',
  `request_id` int NOT NULL,
  PRIMARY KEY (`element_mirror_id`),
  KEY `fk_mdl04_element_mirror_mdl02_employee` (`created_by`),
  KEY `fk_mdl04_element_mirror_mdl02_employee_2` (`approved_by`),
  KEY `fk_mdl04_element_mirror_mdl06_request` (`request_id`),
  KEY `fk_mdl04_element_mirror_mdl04_catalog_mirror_idx` (`element_id`),
  CONSTRAINT `fk_mdl04_element_mirror_mdl04_catalog_mirror` FOREIGN KEY (`element_id`) REFERENCES `mdl04_element` (`element_id`),
  CONSTRAINT `fk_mdl04_element_mirror_mdl06_request` FOREIGN KEY (`request_id`) REFERENCES `mdl06_request` (`request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=902 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los cambios de los elementos de los catalogos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl04_element_origin`
--

DROP TABLE IF EXISTS `mdl04_element_origin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl04_element_origin` (
  `origin_code_id` int NOT NULL AUTO_INCREMENT,
  `element_id` int NOT NULL,
  `origin_id` int NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `created_by` int NOT NULL COMMENT 'Id del creador',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creacion',
  `approved_by` int NOT NULL COMMENT 'Id del aprobador',
  `approved_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de aprobacion',
  PRIMARY KEY (`origin_code_id`),
  UNIQUE KEY `uk_mdl04_code_element_id_origin_id` (`element_id`,`code`),
  KEY `fk_mdl04_code_mdl02_employee` (`created_by`),
  KEY `fk_mdl04_code_mdl02_employee_2` (`approved_by`),
  KEY `idx_mdl04_code_element_id_origin_id_code` (`element_id`,`code`),
  KEY `fk_mdl04_code_mdl04_origin_idx` (`origin_id`),
  CONSTRAINT `fk_mdl04_code_mdl04_element` FOREIGN KEY (`element_id`) REFERENCES `mdl04_element` (`element_id`),
  CONSTRAINT `fk_mdl04_code_mdl04_origin` FOREIGN KEY (`origin_id`) REFERENCES `mdl04_origin` (`origin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1004 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los codigos de los elementos por origen';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl04_element_origin_mirror`
--

DROP TABLE IF EXISTS `mdl04_element_origin_mirror`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl04_element_origin_mirror` (
  `origin_code_id` int NOT NULL AUTO_INCREMENT,
  `element_id` int NOT NULL,
  `origin_id` int NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `created_by` int NOT NULL COMMENT 'Id del creador',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creacion',
  `approved_by` int NOT NULL COMMENT 'Id del aprobador',
  `approved_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de aprobacion',
  PRIMARY KEY (`origin_code_id`),
  UNIQUE KEY `uk_mdl04_code_element_id_origin_id` (`element_id`,`code`),
  KEY `fk_mdl04_code_mdl02_employee` (`created_by`),
  KEY `fk_mdl04_code_mdl02_employee_2` (`approved_by`),
  KEY `idx_mdl04_code_element_id_origin_id_code` (`element_id`,`code`),
  KEY `fk_mdl04_code_mdl04_origin_idx` (`origin_id`),
  CONSTRAINT `fk_mdl04_code_mdl04_element_mirror` FOREIGN KEY (`element_id`) REFERENCES `mdl04_element_mirror` (`element_id`),
  CONSTRAINT `fk_mdl04_code_mdl04_origin_mirror` FOREIGN KEY (`origin_id`) REFERENCES `mdl04_origin` (`origin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1004 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla mirror que almacena los codigos de los elementos por origen';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl04_origin`
--

DROP TABLE IF EXISTS `mdl04_origin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl04_origin` (
  `origin_id` int NOT NULL AUTO_INCREMENT,
  `origin_code` varchar(10) NOT NULL COMMENT 'Codigo del origen',
  `status` bit(1) NOT NULL DEFAULT b'1' COMMENT 'Estado del origen. 0: inactivo, 1: activo',
  PRIMARY KEY (`origin_id`),
  UNIQUE KEY `uk_mdl04_origin_code` (`origin_code`),
  KEY `idx_mdl04_origin_code` (`origin_code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los origenes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl04_subcatalog`
--

DROP TABLE IF EXISTS `mdl04_subcatalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl04_subcatalog` (
  `subcatalog_id` int NOT NULL AUTO_INCREMENT,
  `subcatalog_name` varchar(50) NOT NULL COMMENT 'Nombre del subcatalogo',
  `subcatalog_code` varchar(50) NOT NULL COMMENT 'Codigo del subcatalogo',
  `status` bit(1) NOT NULL DEFAULT b'1' COMMENT 'Estado del catalogo. 0: inactivo, 1: activo',
  `created_by` int NOT NULL COMMENT 'Id del creador',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creacion',
  `approved_by` int NOT NULL COMMENT 'Id del aprobador',
  `approved_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de aprobacion',
  PRIMARY KEY (`subcatalog_id`),
  UNIQUE KEY `uk_mdl04_subcatalog_code` (`subcatalog_code`),
  KEY `idx_mdl04_subcatalog_name` (`subcatalog_name`),
  KEY `fk_mdl04_subcatalog_mdl02_employee` (`created_by`),
  KEY `fk_mdl04_subcatalog_mdl02_employee_2` (`approved_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los subcatalogos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl04_subcatalog_element`
--

DROP TABLE IF EXISTS `mdl04_subcatalog_element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl04_subcatalog_element` (
  `subcatalog_element_id` int NOT NULL AUTO_INCREMENT,
  `subcatalog_id` int NOT NULL,
  `element_id` int NOT NULL,
  `created_by` int NOT NULL COMMENT 'Id del creador',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creacion',
  `approved_by` int NOT NULL COMMENT 'Id del aprobador',
  `approved_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de aprobacion',
  PRIMARY KEY (`subcatalog_element_id`),
  UNIQUE KEY `uk_mdl04_subcatalog_element_subcat_id_elem_id` (`subcatalog_id`,`element_id`),
  KEY `idx_mdl04_subcatalog_element_subcat_id_elem_id` (`subcatalog_id`,`element_id`),
  KEY `fk_mdl04_subcatalog_element_mdl02_employee` (`created_by`),
  KEY `fk_mdl04_subcatalog_element_mdl02_employee_2` (`approved_by`),
  KEY `fk_mdl04_subcatalog_element_mdl04_element` (`element_id`),
  CONSTRAINT `fk_mdl04_subcatalog_element_mdl04_element` FOREIGN KEY (`element_id`) REFERENCES `mdl04_element` (`element_id`),
  CONSTRAINT `fk_mdl04_subcatalog_element_mdl04_subcatalog` FOREIGN KEY (`subcatalog_id`) REFERENCES `mdl04_subcatalog` (`subcatalog_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los elementos de los subcatalogos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl04_subcatalog_element_mirror`
--

DROP TABLE IF EXISTS `mdl04_subcatalog_element_mirror`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl04_subcatalog_element_mirror` (
  `subcatalog_element_mirror_id` int NOT NULL AUTO_INCREMENT,
  `subcatalog_mirror_id` int NOT NULL,
  `request_id` int NOT NULL,
  `subcatalog_element_id` int DEFAULT NULL,
  `subcatalog_id` int DEFAULT NULL,
  `element_id` int DEFAULT NULL,
  `created_by` int NOT NULL COMMENT 'Id del creador',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creacion',
  `approved_by` int DEFAULT NULL COMMENT 'Id del aprobador',
  `approved_date` datetime DEFAULT NULL COMMENT 'Fecha de aprobacion',
  PRIMARY KEY (`subcatalog_element_mirror_id`),
  KEY `idx_mdl04_subcat_elem_mirror_subcat_mirror_id` (`subcatalog_mirror_id`),
  KEY `fk_mdl04_subcat_elem_mirror_mdl02_employee` (`created_by`),
  KEY `fk_mdl04_subcat_elem_mirror_mdl02_employee_2` (`approved_by`),
  KEY `fk_mdl04_subcatalog_element_mirror_mdl06_request` (`request_id`),
  CONSTRAINT `fk_mdl04_subcat_elem_mirror_mdl04_subcat_mirror` FOREIGN KEY (`subcatalog_mirror_id`) REFERENCES `mdl04_subcatalog_mirror` (`subcatalog_mirror_id`),
  CONSTRAINT `fk_mdl04_subcatalog_element_mirror_mdl06_request` FOREIGN KEY (`request_id`) REFERENCES `mdl06_request` (`request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los cambios de los elementos de los subcatalogos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl04_subcatalog_mirror`
--

DROP TABLE IF EXISTS `mdl04_subcatalog_mirror`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl04_subcatalog_mirror` (
  `subcatalog_mirror_id` int NOT NULL AUTO_INCREMENT,
  `request_id` int NOT NULL,
  `subcatalog_id` int DEFAULT NULL,
  `subcatalog_name` varchar(50) DEFAULT NULL COMMENT 'Nombre del subcatalogo',
  `subcatalog_code` varchar(50) DEFAULT NULL COMMENT 'Codigo del subcatalogo',
  `status` bit(1) DEFAULT NULL COMMENT 'Estado del catalogo. 0: inactivo, 1: activo',
  `created_by` int NOT NULL COMMENT 'Id del creador',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creacion',
  `approved_by` int DEFAULT NULL COMMENT 'Id del aprobador',
  `approved_date` datetime DEFAULT NULL COMMENT 'Fecha de aprobacion',
  PRIMARY KEY (`subcatalog_mirror_id`),
  KEY `fk_mdl04_subcatalog_mirror_mdl02_employee` (`created_by`),
  KEY `fk_mdl04_subcatalog_mirror_mdl02_employee_2` (`approved_by`),
  KEY `fk_mdl04_subcatalog_mirror_mdl06_request` (`request_id`),
  CONSTRAINT `fk_mdl04_subcatalog_mirror_mdl06_request` FOREIGN KEY (`request_id`) REFERENCES `mdl06_request` (`request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los cambios de los subcatalogos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl05_branch`
--

DROP TABLE IF EXISTS `mdl05_branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl05_branch` (
  `branch_id` int NOT NULL AUTO_INCREMENT,
  `branch_name` varchar(50) NOT NULL COMMENT 'Nombre de sucursal',
  `status` bit(1) NOT NULL DEFAULT b'1' COMMENT 'Estado de la sucursal. 0: inactivo, 1: activo',
  PRIMARY KEY (`branch_id`),
  KEY `idx_mdl05_branch_name` (`branch_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena las sucursales bancarias';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdl06_request`
--

DROP TABLE IF EXISTS `mdl06_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mdl06_request` (
  `request_id` int NOT NULL AUTO_INCREMENT,
  `request_detail` varchar(50) NOT NULL COMMENT 'Detalle de la solicitud',
  `request_type` int NOT NULL COMMENT 'Tipo de solicitud: 1: creación, 2: actualización, 3: eliminación, 4: desactivación',
  `impacted_table` int NOT NULL COMMENT 'Tabla que impacta: 1: mdl04_catalog, 2: mdl04_element',
  `status` int NOT NULL COMMENT 'Estado de la solicitud: 0: rechazado, 1: pendiente de aprobación, 2: aprobado',
  `created_by` int NOT NULL COMMENT 'Id del creador',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creación',
  `approved_by` int DEFAULT NULL COMMENT 'Id del aprobador',
  `approved_date` datetime DEFAULT NULL COMMENT 'Fecha de aprobación',
  PRIMARY KEY (`request_id`),
  CONSTRAINT `check_impacted_table` CHECK ((`impacted_table` in (1,2))),
  CONSTRAINT `check_request_type` CHECK ((`request_type` in (1,2,3,4))),
  CONSTRAINT `check_status` CHECK ((`status` in (0,1,2)))
) ENGINE=InnoDB AUTO_INCREMENT=504 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena las solicitudes para adminstrar los insert a los mirror';
/*!40101 SET character_set_client = @saved_cs_client */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-28 23:28:32
