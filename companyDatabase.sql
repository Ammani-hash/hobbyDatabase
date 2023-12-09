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
-- Table `mydb`.`inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`inventory` (
  `productid` INT NOT NULL,
  `productname` VARCHAR(45) NULL,
  `priceunit` DECIMAL NULL,
  `quantity` INT NULL,
  PRIMARY KEY (`productid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sales` (
  `salesid` INT NULL AUTO_INCREMENT,
  `customerid` INT NULL,
  `employeeid` INT NULL,
  `transactiondate` DATE NULL,
  `totalamount` DECIMAL NULL,
  `inventory_productid` INT NOT NULL,
  PRIMARY KEY (`salesid`),
  INDEX `fk_sales_inventory1_idx` (`inventory_productid` ASC) VISIBLE,
  CONSTRAINT `fk_sales_inventory1`
    FOREIGN KEY (`inventory_productid`)
    REFERENCES `mydb`.`inventory` (`productid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`customerphone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`customerphone` (
  `phoneid` INT NOT NULL,
  `customerid` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`phoneid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`customers` (
  `customerid` INT NOT NULL,
  `firstname` VARCHAR(45) NULL,
  `lastname` VARCHAR(45) NULL,
  `sales_salesid` INT NOT NULL,
  `customerphone_phoneid` INT NOT NULL,
  PRIMARY KEY (`customerid`),
  INDEX `fk_customers_sales_idx` (`sales_salesid` ASC) VISIBLE,
  INDEX `fk_customers_customerphone1_idx` (`customerphone_phoneid` ASC) VISIBLE,
  CONSTRAINT `fk_customers_sales`
    FOREIGN KEY (`sales_salesid`)
    REFERENCES `mydb`.`sales` (`salesid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customers_customerphone1`
    FOREIGN KEY (`customerphone_phoneid`)
    REFERENCES `mydb`.`customerphone` (`phoneid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`purchase`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`purchase` (
  `purchaseid` INT NOT NULL,
  `vendorid` INT NULL,
  `employeeid` INT NULL,
  `date` DATE NULL,
  `amount` DECIMAL NULL,
  `inventory_productid` INT NOT NULL,
  PRIMARY KEY (`purchaseid`),
  INDEX `fk_purchase_inventory1_idx` (`inventory_productid` ASC) VISIBLE,
  CONSTRAINT `fk_purchase_inventory1`
    FOREIGN KEY (`inventory_productid`)
    REFERENCES `mydb`.`inventory` (`productid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`vendoremail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`vendoremail` (
  `emailid` INT NOT NULL,
  `vendorid` VARCHAR(45) NOT NULL,
  `attodot` VARCHAR(45) NULL,
  `domain` VARCHAR(45) NULL,
  PRIMARY KEY (`emailid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`vendorphone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`vendorphone` (
  `phoneid` INT NOT NULL,
  `vendorid` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`phoneid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`vendors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`vendors` (
  `vendorid` INT NOT NULL,
  `vendorname` VARCHAR(45) NULL,
  `vendorcontact` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `purchase_purchaseid` INT NOT NULL,
  `vendoremail_emailid` INT NOT NULL,
  `vendorphone_phoneid` INT NOT NULL,
  PRIMARY KEY (`vendorid`),
  INDEX `fk_vendors_purchase1_idx` (`purchase_purchaseid` ASC) VISIBLE,
  INDEX `fk_vendors_vendoremail1_idx` (`vendoremail_emailid` ASC) VISIBLE,
  INDEX `fk_vendors_vendorphone1_idx` (`vendorphone_phoneid` ASC) VISIBLE,
  CONSTRAINT `fk_vendors_purchase1`
    FOREIGN KEY (`purchase_purchaseid`)
    REFERENCES `mydb`.`purchase` (`purchaseid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vendors_vendoremail1`
    FOREIGN KEY (`vendoremail_emailid`)
    REFERENCES `mydb`.`vendoremail` (`emailid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vendors_vendorphone1`
    FOREIGN KEY (`vendorphone_phoneid`)
    REFERENCES `mydb`.`vendorphone` (`phoneid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`employees` (
  `employeeid` INT NOT NULL,
  `firstname` VARCHAR(45) NULL,
  `lastname` VARCHAR(45) NULL,
  `position` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `address` VARCHAR(45) NULL,
  `purchase_purchaseid` INT NOT NULL,
  `sales_salesid` INT NOT NULL,
  PRIMARY KEY (`employeeid`),
  INDEX `fk_employees_purchase1_idx` (`purchase_purchaseid` ASC) VISIBLE,
  INDEX `fk_employees_sales1_idx` (`sales_salesid` ASC) VISIBLE,
  CONSTRAINT `fk_employees_purchase1`
    FOREIGN KEY (`purchase_purchaseid`)
    REFERENCES `mydb`.`purchase` (`purchaseid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employees_sales1`
    FOREIGN KEY (`sales_salesid`)
    REFERENCES `mydb`.`sales` (`salesid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`customeraddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`customeraddress` (
  `addressid` INT NOT NULL,
  `customerstreet` VARCHAR(45) NOT NULL,
  `customerstate` VARCHAR(45) NULL,
  `customers_customerid` INT NOT NULL,
  PRIMARY KEY (`addressid`, `customers_customerid`),
  INDEX `fk_customeraddress_customers1_idx` (`customers_customerid` ASC) VISIBLE,
  CONSTRAINT `fk_customeraddress_customers1`
    FOREIGN KEY (`customers_customerid`)
    REFERENCES `mydb`.`customers` (`customerid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`customeremail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`customeremail` (
  `emailid` INT NOT NULL,
  `customerid` VARCHAR(45) NOT NULL,
  `attodot` VARCHAR(45) NULL,
  `domain` VARCHAR(45) NULL,
  `customers_customerid` INT NOT NULL,
  PRIMARY KEY (`emailid`),
  INDEX `fk_customeremail_customers1_idx` (`customers_customerid` ASC) VISIBLE,
  CONSTRAINT `fk_customeremail_customers1`
    FOREIGN KEY (`customers_customerid`)
    REFERENCES `mydb`.`customers` (`customerid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`employeephone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`employeephone` (
  `phoneid` INT NOT NULL,
  `employeeid` VARCHAR(45) NOT NULL,
  `employees_employeeid` INT NOT NULL,
  PRIMARY KEY (`phoneid`),
  INDEX `fk_employeephone_employees1_idx` (`employees_employeeid` ASC) VISIBLE,
  CONSTRAINT `fk_employeephone_employees1`
    FOREIGN KEY (`employees_employeeid`)
    REFERENCES `mydb`.`employees` (`employeeid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`employeeemail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`employeeemail` (
  `emailid` INT NOT NULL,
  `employeeid` VARCHAR(45) NOT NULL,
  `attodot` VARCHAR(45) NULL,
  `domain` VARCHAR(45) NULL,
  `employees_employeeid` INT NOT NULL,
  PRIMARY KEY (`emailid`),
  INDEX `fk_employeeemail_employees1_idx` (`employees_employeeid` ASC) VISIBLE,
  CONSTRAINT `fk_employeeemail_employees1`
    FOREIGN KEY (`employees_employeeid`)
    REFERENCES `mydb`.`employees` (`employeeid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`employeeaddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`employeeaddress` (
  `addressid` INT NOT NULL,
  `customerstreet` VARCHAR(45) NOT NULL,
  `customerstate` VARCHAR(45) NULL,
  `employees_employeeid` INT NOT NULL,
  PRIMARY KEY (`addressid`),
  INDEX `fk_employeeaddress_employees1_idx` (`employees_employeeid` ASC) VISIBLE,
  CONSTRAINT `fk_employeeaddress_employees1`
    FOREIGN KEY (`employees_employeeid`)
    REFERENCES `mydb`.`employees` (`employeeid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
