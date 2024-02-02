-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Sat_User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Sat_User` (
  `Sat_User_SK` INT NOT NULL,
  `Sat_User_ID` VARCHAR(45) NOT NULL,
  `Load_Date` DATETIME NOT NULL,
  `Load_End_Date` DATETIME NOT NULL,
  `Record_Source` VARCHAR(45) NOT NULL,
  `User_Name` VARCHAR(45) NOT NULL,
  `User_Wage` VARCHAR(45) NOT NULL,
  `Begin_Employment` DATETIME NOT NULL,
  `Date_of_Birth` DATETIME NOT NULL,
  PRIMARY KEY (`Sat_User_SK`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Hub_User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Hub_User` (
  `Hub_User_SK` INT NOT NULL,
  `Sat_User_Sat_User_SK` INT NOT NULL,
  `Load_Date` DATETIME NOT NULL,
  `Record_Source` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Hub_User_SK`, `Sat_User_Sat_User_SK`),
  INDEX `fk_Hub_User_Sat_User1_idx` (`Sat_User_Sat_User_SK` ASC) VISIBLE,
  CONSTRAINT `fk_Hub_User_Sat_User1`
    FOREIGN KEY (`Sat_User_Sat_User_SK`)
    REFERENCES `mydb`.`Sat_User` (`Sat_User_SK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sat_Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Sat_Product` (
  `Sat_Product_SK` INT NOT NULL,
  `Sat_Product_ID` VARCHAR(45) NOT NULL,
  `Load_Date` DATETIME NOT NULL,
  `Load_End_Date` DATETIME NOT NULL,
  `Record_Source` VARCHAR(45) NOT NULL,
  `Product_Name` VARCHAR(45) NOT NULL,
  `Product_Type` VARCHAR(45) NOT NULL,
  `Product_Description` VARCHAR(45) NOT NULL,
  `Product_Price` VARCHAR(45) NOT NULL,
  `Product_Volume` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Sat_Product_SK`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Hub_Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Hub_Product` (
  `Hub_Product_SK` INT NOT NULL,
  `Hub_Product_ID` VARCHAR(45) NOT NULL,
  `Sat_Product_Sat_Product_SK` INT NOT NULL,
  `Load_Date` DATETIME NOT NULL,
  `Record_Source` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Hub_Product_SK`, `Sat_Product_Sat_Product_SK`),
  INDEX `fk_Hub_Product_Sat_Product1_idx` (`Sat_Product_Sat_Product_SK` ASC) VISIBLE,
  CONSTRAINT `fk_Hub_Product_Sat_Product1`
    FOREIGN KEY (`Sat_Product_Sat_Product_SK`)
    REFERENCES `mydb`.`Sat_Product` (`Sat_Product_SK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sat_Store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Sat_Store` (
  `Sat_Store_SK` INT NOT NULL,
  `Sat_Store_ID` VARCHAR(45) NOT NULL,
  `Load_Date` DATETIME NOT NULL,
  `Load_End_Date` DATETIME NOT NULL,
  `Record_Source` VARCHAR(45) NOT NULL,
  `Store_Name` VARCHAR(45) NOT NULL,
  `Adress` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Sat_Store_SK`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Hub_Store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Hub_Store` (
  `Hub_Store_SK` INT NOT NULL,
  `Store_ID` VARCHAR(45) NOT NULL,
  `Sat_Store_Sat_Store_SK` INT NOT NULL,
  `Load_Date` VARCHAR(45) NOT NULL,
  `Record_Source` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Hub_Store_SK`, `Sat_Store_Sat_Store_SK`),
  INDEX `fk_Hub_Store_Sat_Store1_idx` (`Sat_Store_Sat_Store_SK` ASC) VISIBLE,
  CONSTRAINT `fk_Hub_Store_Sat_Store1`
    FOREIGN KEY (`Sat_Store_Sat_Store_SK`)
    REFERENCES `mydb`.`Sat_Store` (`Sat_Store_SK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sat_Receipt`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Sat_Receipt` (
  `Sat_Receipt_SK` INT NOT NULL,
  `Sat_Receipt_ID` VARCHAR(45) NOT NULL,
  `Load_Date` DATETIME NOT NULL,
  `Load_End_Date` DATETIME NOT NULL,
  `Total_Price` DECIMAL(2) NOT NULL,
  `Record-Source` VARCHAR(45) NOT NULL,
  `Amount_Product` INT NOT NULL,
  `Payment_Method` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Sat_Receipt_SK`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Hub_Receipt`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Hub_Receipt` (
  `Hub_Receipt_SK` INT NOT NULL,
  `Receipt_ID` VARCHAR(45) NOT NULL,
  `Load_Date` DATETIME NOT NULL,
  `Record_Source` VARCHAR(45) NOT NULL,
  `Sat_Receipt_Sat_Receipt_SK` INT NOT NULL,
  PRIMARY KEY (`Hub_Receipt_SK`, `Sat_Receipt_Sat_Receipt_SK`),
  INDEX `fk_Hub_Receipt_Sat_Receipt1_idx` (`Sat_Receipt_Sat_Receipt_SK` ASC) VISIBLE,
  CONSTRAINT `fk_Hub_Receipt_Sat_Receipt1`
    FOREIGN KEY (`Sat_Receipt_Sat_Receipt_SK`)
    REFERENCES `mydb`.`Sat_Receipt` (`Sat_Receipt_SK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Link_Receipt_Store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Link_Receipt_Store` (
  `Link_Receipt_Store_SK` INT NOT NULL,
  `Hub_Receipt_Hub_Receipt_SK` INT NOT NULL,
  `Hub_Store_Hub_Store_SK` INT NOT NULL,
  `Load_Date` DATETIME NOT NULL,
  `Record_Source` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Link_Receipt_Store_SK`, `Hub_Receipt_Hub_Receipt_SK`, `Hub_Store_Hub_Store_SK`),
  INDEX `fk_Link_Receipt_Store_Hub_Receipt_idx` (`Hub_Receipt_Hub_Receipt_SK` ASC) VISIBLE,
  INDEX `fk_Link_Receipt_Store_Hub_Store1_idx` (`Hub_Store_Hub_Store_SK` ASC) VISIBLE,
  CONSTRAINT `fk_Link_Receipt_Store_Hub_Receipt`
    FOREIGN KEY (`Hub_Receipt_Hub_Receipt_SK`)
    REFERENCES `mydb`.`Hub_Receipt` (`Hub_Receipt_SK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Link_Receipt_Store_Hub_Store1`
    FOREIGN KEY (`Hub_Store_Hub_Store_SK`)
    REFERENCES `mydb`.`Hub_Store` (`Hub_Store_SK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Link_Receipt_User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Link_Receipt_User` (
  `Link_Receipt_User_SK` INT NOT NULL,
  `Hub_User_Hub_User_SK` INT NOT NULL,
  `Hub_Receipt_Hub_Receipt_SK` INT NOT NULL,
  `Load_Date` DATETIME NOT NULL,
  `Record_Source` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Link_Receipt_User_SK`, `Hub_User_Hub_User_SK`, `Hub_Receipt_Hub_Receipt_SK`),
  INDEX `fk_Link_Receipt_User_Hub_User1_idx` (`Hub_User_Hub_User_SK` ASC) VISIBLE,
  INDEX `fk_Link_Receipt_User_Hub_Receipt1_idx` (`Hub_Receipt_Hub_Receipt_SK` ASC) VISIBLE,
  CONSTRAINT `fk_Link_Receipt_User_Hub_User1`
    FOREIGN KEY (`Hub_User_Hub_User_SK`)
    REFERENCES `mydb`.`Hub_User` (`Hub_User_SK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Link_Receipt_User_Hub_Receipt1`
    FOREIGN KEY (`Hub_Receipt_Hub_Receipt_SK`)
    REFERENCES `mydb`.`Hub_Receipt` (`Hub_Receipt_SK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Link_Receipt_Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Link_Receipt_Product` (
  `Link_Receipt_Product_SK` INT NOT NULL,
  `Hub_Receipt_Hub_Receipt_SK` INT NOT NULL,
  `Hub_Product_Hub_Product_SK` INT NOT NULL,
  `Load_Date` DATETIME NOT NULL,
  `Record_Source` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Link_Receipt_Product_SK`, `Hub_Receipt_Hub_Receipt_SK`, `Hub_Product_Hub_Product_SK`),
  INDEX `fk_Link_Receipt_Product_Hub_Receipt1_idx` (`Hub_Receipt_Hub_Receipt_SK` ASC) VISIBLE,
  INDEX `fk_Link_Receipt_Product_Hub_Product1_idx` (`Hub_Product_Hub_Product_SK` ASC) VISIBLE,
  CONSTRAINT `fk_Link_Receipt_Product_Hub_Receipt1`
    FOREIGN KEY (`Hub_Receipt_Hub_Receipt_SK`)
    REFERENCES `mydb`.`Hub_Receipt` (`Hub_Receipt_SK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Link_Receipt_Product_Hub_Product1`
    FOREIGN KEY (`Hub_Product_Hub_Product_SK`)
    REFERENCES `mydb`.`Hub_Product` (`Hub_Product_SK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sat_Region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Sat_Region` (
  `Sat_Region_SK` INT NOT NULL,
  `Sat_Region_ID` VARCHAR(45) NOT NULL,
  `Load_Date` DATETIME NOT NULL,
  `Load_End_Date` DATETIME NOT NULL,
  `Record_Source` VARCHAR(45) NOT NULL,
  `Zip_Code` VARCHAR(45) NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `State` VARCHAR(45) NOT NULL,
  `Country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Sat_Region_SK`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Hub_Region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Hub_Region` (
  `Hub_Region_SK` INT NOT NULL,
  `Hub_Region_ID` VARCHAR(45) NOT NULL,
  `Sat_Region_Sat_Region_SK` INT NOT NULL,
  `Load_Date` DATETIME NOT NULL,
  `Record_Source` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Hub_Region_SK`, `Sat_Region_Sat_Region_SK`),
  INDEX `fk_Hub_Adress_Sat_Adress1_idx` (`Sat_Region_Sat_Region_SK` ASC) VISIBLE,
  CONSTRAINT `fk_Hub_Adress_Sat_Adress1`
    FOREIGN KEY (`Sat_Region_Sat_Region_SK`)
    REFERENCES `mydb`.`Sat_Region` (`Sat_Region_SK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Link_Store_Region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Link_Store_Region` (
  `Link_Store_Region_SK` INT NOT NULL,
  `Hub_Store_Sat_Store_Sat_Store_SK` INT NOT NULL,
  `Hub_Region_Hub_Region_SK` INT NOT NULL,
  `Load_Date` DATETIME NOT NULL,
  `Record_Source` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Link_Store_Region_SK`, `Hub_Store_Sat_Store_Sat_Store_SK`, `Hub_Region_Hub_Region_SK`),
  INDEX `fk_Link_Store_Adress_Hub_Store1_idx` (`Hub_Store_Sat_Store_Sat_Store_SK` ASC) VISIBLE,
  INDEX `fk_Link_Store_Adress_Hub_Adress1_idx` (`Hub_Region_Hub_Region_SK` ASC) VISIBLE,
  CONSTRAINT `fk_Link_Store_Adress_Hub_Store1`
    FOREIGN KEY (`Hub_Store_Sat_Store_Sat_Store_SK`)
    REFERENCES `mydb`.`Hub_Store` (`Sat_Store_Sat_Store_SK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Link_Store_Adress_Hub_Adress1`
    FOREIGN KEY (`Hub_Region_Hub_Region_SK`)
    REFERENCES `mydb`.`Hub_Region` (`Hub_Region_SK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sat_Time`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Sat_Time` (
  `Sat_Time_SK` INT NOT NULL,
  `Sat_Time_ID` VARCHAR(45) NOT NULL,
  `Load_Date` DATETIME NOT NULL,
  `Load_End_Date` DATETIME NOT NULL,
  `Record_Source` VARCHAR(45) NOT NULL,
  `Receipt_Date` DATETIME NOT NULL,
  `Month` VARCHAR(45) NOT NULL,
  `Year` INT NOT NULL,
  `Fiscal_Yeal` VARCHAR(45) NOT NULL,
  `Day_of_Week` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Sat_Time_SK`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Hub_Time`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Hub_Time` (
  `Hub_Time_SK` INT NOT NULL,
  `Hub_Time_ID` VARCHAR(45) NOT NULL,
  `Load_Date` DATETIME NOT NULL,
  `Record_Source` VARCHAR(45) NOT NULL,
  `Sat_Time_Sat_Time_SK` INT NOT NULL,
  PRIMARY KEY (`Hub_Time_SK`, `Sat_Time_Sat_Time_SK`),
  INDEX `fk_Hub_Time_Sat_Time1_idx` (`Sat_Time_Sat_Time_SK` ASC) VISIBLE,
  CONSTRAINT `fk_Hub_Time_Sat_Time1`
    FOREIGN KEY (`Sat_Time_Sat_Time_SK`)
    REFERENCES `mydb`.`Sat_Time` (`Sat_Time_SK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Link_Receipt_Time`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Link_Receipt_Time` (
  `Link_Receipt_Time_SK` INT NOT NULL,
  `Load_Date` DATETIME NOT NULL,
  `Record_Source` VARCHAR(45) NOT NULL,
  `Hub_Receipt_Hub_Receipt_SK` INT NOT NULL,
  `Hub_Time_Hub_Time_SK` INT NOT NULL,
  PRIMARY KEY (`Link_Receipt_Time_SK`, `Hub_Receipt_Hub_Receipt_SK`, `Hub_Time_Hub_Time_SK`),
  INDEX `fk_Link_Receipt_Time_Hub_Receipt1_idx` (`Hub_Receipt_Hub_Receipt_SK` ASC) VISIBLE,
  INDEX `fk_Link_Receipt_Time_Hub_Time1_idx` (`Hub_Time_Hub_Time_SK` ASC) VISIBLE,
  CONSTRAINT `fk_Link_Receipt_Time_Hub_Receipt1`
    FOREIGN KEY (`Hub_Receipt_Hub_Receipt_SK`)
    REFERENCES `mydb`.`Hub_Receipt` (`Hub_Receipt_SK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Link_Receipt_Time_Hub_Time1`
    FOREIGN KEY (`Hub_Time_Hub_Time_SK`)
    REFERENCES `mydb`.`Hub_Time` (`Hub_Time_SK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
