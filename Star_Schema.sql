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
-- Table `mydb`.`Product_Dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Product_Dim` (
  `Product_SK` INT NOT NULL,
  `Product_ID` VARCHAR(45) NOT NULL,
  `Product_Name` VARCHAR(45) NOT NULL,
  `Product_Type` VARCHAR(45) NOT NULL,
  `Product_Description` VARCHAR(45) NOT NULL,
  `Product_Volume` VARCHAR(45) NOT NULL,
  `Product_Price` DECIMAL(2) NOT NULL,
  PRIMARY KEY (`Product_SK`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Time_Dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Time_Dim` (
  `Time_SK` INT NOT NULL,
  `Date` DATETIME NOT NULL,
  `Month` VARCHAR(45) NOT NULL,
  `Year` INT NOT NULL,
  `Fiscal_Year` VARCHAR(45) NOT NULL,
  `Day_of_Week` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Time_SK`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`User_Dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`User_Dim` (
  `User_PK` INT NOT NULL,
  `User_ID` VARCHAR(45) NOT NULL,
  `User_Name` VARCHAR(45) NOT NULL,
  `User_Wage` VARCHAR(45) NOT NULL,
  `Begin_employment` DATETIME NOT NULL,
  `Date_of_birth` DATETIME NOT NULL,
  PRIMARY KEY (`User_PK`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Store_Dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Store_Dim` (
  `Store_SK` INT NOT NULL,
  `Store_ID` VARCHAR(45) NOT NULL,
  `Store_Name` VARCHAR(45) NOT NULL,
  `Adress` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Store_SK`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Receipt_Dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Receipt_Dim` (
  `Receipt_SK` INT NOT NULL,
  `Receipt_ID` VARCHAR(45) NOT NULL,
  `Payment_Method` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Receipt_SK`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Region_Dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Region_Dim` (
  `Region_SK` INT NOT NULL,
  `Region_ID` VARCHAR(45) NOT NULL,
  `Zip_Code` INT NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `State` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Region_SK`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Fact_Product_Sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Fact_Product_Sales` (
  `Product_SK` INT NOT NULL,
  `Time_Dim_Time_SK` INT NOT NULL,
  `User_Dim_User_PK` INT NOT NULL,
  `Store_Dim_Store_SK` INT NOT NULL,
  `Receipt_Dim_Receipt_SK` INT NOT NULL,
  `Region_Dim_Region_SK` INT NOT NULL,
  `Product_Amount` INT NOT NULL,
  `Total_Price` DECIMAL(2) NOT NULL,
  PRIMARY KEY (`Product_SK`, `Time_Dim_Time_SK`, `User_Dim_User_PK`, `Store_Dim_Store_SK`, `Receipt_Dim_Receipt_SK`, `Region_Dim_Region_SK`),
  INDEX `fk_Fact_Product_Sales_Time_Dim1_idx` (`Time_Dim_Time_SK` ASC) VISIBLE,
  INDEX `fk_Fact_Product_Sales_User_Dim1_idx` (`User_Dim_User_PK` ASC) VISIBLE,
  INDEX `fk_Fact_Product_Sales_Store_Dim1_idx` (`Store_Dim_Store_SK` ASC) VISIBLE,
  INDEX `fk_Fact_Product_Sales_Receipt_Dim1_idx` (`Receipt_Dim_Receipt_SK` ASC) VISIBLE,
  INDEX `fk_Fact_Product_Sales_Region_Dim1_idx` (`Region_Dim_Region_SK` ASC) VISIBLE,
  CONSTRAINT `fk_Fact_Product_Sales_Product_Dim`
    FOREIGN KEY (`Product_SK`)
    REFERENCES `mydb`.`Product_Dim` (`Product_SK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fact_Product_Sales_Time_Dim1`
    FOREIGN KEY (`Time_Dim_Time_SK`)
    REFERENCES `mydb`.`Time_Dim` (`Time_SK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fact_Product_Sales_User_Dim1`
    FOREIGN KEY (`User_Dim_User_PK`)
    REFERENCES `mydb`.`User_Dim` (`User_PK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fact_Product_Sales_Store_Dim1`
    FOREIGN KEY (`Store_Dim_Store_SK`)
    REFERENCES `mydb`.`Store_Dim` (`Store_SK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fact_Product_Sales_Receipt_Dim1`
    FOREIGN KEY (`Receipt_Dim_Receipt_SK`)
    REFERENCES `mydb`.`Receipt_Dim` (`Receipt_SK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fact_Product_Sales_Region_Dim1`
    FOREIGN KEY (`Region_Dim_Region_SK`)
    REFERENCES `mydb`.`Region_Dim` (`Region_SK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
