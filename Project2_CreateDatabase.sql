-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema assignment3
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema assignment3
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `assignment3` DEFAULT CHARACTER SET utf8mb3 ;
USE `assignment3` ;

-- -----------------------------------------------------
-- Table `assignment3`.`item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `assignment3`.`item` (
  `ItemDescription` VARCHAR(45) NOT NULL,
  `Category` VARCHAR(45) NOT NULL,
  `ItemID` INT NOT NULL,
  PRIMARY KEY (`ItemID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `assignment3`.`ownerinfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `assignment3`.`ownerinfo` (
  `OwnerID` VARCHAR(50) NOT NULL,
  `Phone` VARCHAR(45) NOT NULL,
  `OwnerFname` VARCHAR(45) NOT NULL,
  `OwnerLname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`OwnerID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `assignment3`.`projectowner`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `assignment3`.`projectowner` (
  `ProjectName` VARCHAR(45) NOT NULL,
  `ProjectID` VARCHAR(45) NOT NULL,
  `OwnerInfo_OwnerID` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`ProjectID`),
  INDEX `fk_ProjectOwner_OwnerInfo1_idx` (`OwnerInfo_OwnerID` ASC) VISIBLE,
  CONSTRAINT `fk_ProjectOwner_OwnerInfo1`
    FOREIGN KEY (`OwnerInfo_OwnerID`)
    REFERENCES `assignment3`.`ownerinfo` (`OwnerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `assignment3`.`supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `assignment3`.`supplier` (
  `SupplierID` INT NOT NULL,
  `Discount` DOUBLE NOT NULL,
  `PhoneNumber` VARCHAR(45) NOT NULL,
  `Supplier` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`SupplierID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `assignment3`.`project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `assignment3`.`project` (
  `Quantity` INT NOT NULL,
  `UnitPrice` DOUBLE NOT NULL,
  `ExtendedPrice` DOUBLE NOT NULL,
  `ProjectID` VARCHAR(45) NOT NULL,
  `Item_ItemID` INT NOT NULL,
  `Supplier_SupplierID` INT NOT NULL,
  `ProjectOwner_ProjectID` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ProjectID`, `Item_ItemID`, `Supplier_SupplierID`, `ProjectOwner_ProjectID`),
  INDEX `fk_Project_Item_idx` (`Item_ItemID` ASC) VISIBLE,
  INDEX `fk_Project_Supplier1_idx` (`Supplier_SupplierID` ASC) VISIBLE,
  INDEX `fk_Project_ProjectOwner1_idx` (`ProjectOwner_ProjectID` ASC) VISIBLE,
  CONSTRAINT `fk_Project_Item`
    FOREIGN KEY (`Item_ItemID`)
    REFERENCES `assignment3`.`item` (`ItemID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Project_ProjectOwner1`
    FOREIGN KEY (`ProjectOwner_ProjectID`)
    REFERENCES `assignment3`.`projectowner` (`ProjectID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Project_Supplier1`
    FOREIGN KEY (`Supplier_SupplierID`)
    REFERENCES `assignment3`.`supplier` (`SupplierID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
