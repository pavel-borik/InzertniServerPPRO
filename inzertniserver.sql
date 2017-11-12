/* ---------------------------------------------------- */
/*  Generated by Enterprise Architect Version 13.0 		*/
/*  Created On : 12-11-2017 13:20:10 				*/
/*  DBMS       : MySql 						*/
/* ---------------------------------------------------- */

SET FOREIGN_KEY_CHECKS=0 
;

/* Drop Tables */

DROP TABLE IF EXISTS `Adverts` CASCADE
;

DROP TABLE IF EXISTS `Categories` CASCADE
;

DROP TABLE IF EXISTS `Comments` CASCADE
;

DROP TABLE IF EXISTS `Ratings` CASCADE
;

DROP TABLE IF EXISTS `Users` CASCADE
;

/* Create Tables */

CREATE TABLE `Adverts`
(
	`ID` INT NOT NULL,
	`Name` VARCHAR(50) NOT NULL,
	`CategoryID` INT NOT NULL,
	`UserID` INT NOT NULL,
	`Image` BLOB NULL,
	`Description` TEXT NOT NULL,
	`Timestamp` DATETIME NOT NULL,
	`Location` VARCHAR(50) NOT NULL,
	CONSTRAINT `PK_Adverts` PRIMARY KEY (`ID` ASC)
)

;

CREATE TABLE `Categories`
(
	`ID` INT NOT NULL,
	`Name` VARCHAR(50) NOT NULL,
	CONSTRAINT `PK_Categories` PRIMARY KEY (`ID` ASC)
)

;

CREATE TABLE `Comments`
(
	`ID` INT NOT NULL,
	`Comment` TEXT NOT NULL,
	`AuthorID` INT NOT NULL,
	`AdvertID` INT NOT NULL,
	`PostDate` DATETIME NOT NULL,
	`CommentedUserID` INT NOT NULL,
	CONSTRAINT `PK_Comments` PRIMARY KEY (`ID` ASC)
)

;

CREATE TABLE `Ratings`
(
	`ID` INT NOT NULL,
	`AuthorID` INT NOT NULL,
	`RatedUserID` INT NOT NULL,
	`Rating` TEXT NOT NULL,
	`PostDate` DATETIME NOT NULL,
	CONSTRAINT `PK_Ratings` PRIMARY KEY (`ID` ASC)
)

;

CREATE TABLE `Users`
(
	`ID` INT NOT NULL,
	`Username` VARCHAR(50) NOT NULL,
	`Password` VARCHAR(50) NOT NULL,
	`Email` VARCHAR(50) NULL,
	`Phone` VARCHAR(50) NULL,
	`CreationTime` DATETIME NOT NULL,
	CONSTRAINT `PK_Users` PRIMARY KEY (`ID` ASC)
)

;

/* Create Primary Keys, Indexes, Uniques, Checks */

ALTER TABLE `Adverts` 
 ADD INDEX `IXFK_Adverts_Categories` (`CategoryID` ASC)
;

ALTER TABLE `Adverts` 
 ADD INDEX `IXFK_Adverts_Users` (`UserID` ASC)
;

ALTER TABLE `Comments` 
 ADD INDEX `IXFK_Comments_Adverts` (`AdvertID` ASC)
;

ALTER TABLE `Comments` 
 ADD INDEX `IXFK_Comments_Author` (`AuthorID` ASC)
;

ALTER TABLE `Comments` 
 ADD INDEX `IXFK_Comments_CommentedUser` (`CommentedUserID` ASC)
;

ALTER TABLE `Ratings` 
 ADD INDEX `IXFK_Ratings_Author` (`AuthorID` ASC)
;

ALTER TABLE `Ratings` 
 ADD INDEX `IXFK_Ratings_RatedUser` (`RatedUserID` ASC)
;

/* Create Foreign Key Constraints */

ALTER TABLE `Adverts` 
 ADD CONSTRAINT `FK_Adverts_Categories`
	FOREIGN KEY (`CategoryID`) REFERENCES `Categories` (`ID`) ON DELETE Restrict ON UPDATE Restrict
;

ALTER TABLE `Adverts` 
 ADD CONSTRAINT `FK_Adverts_Users`
	FOREIGN KEY (`UserID`) REFERENCES `Users` (`ID`) ON DELETE Restrict ON UPDATE Restrict
;

ALTER TABLE `Comments` 
 ADD CONSTRAINT `FK_Comments_Adverts`
	FOREIGN KEY (`AdvertID`) REFERENCES `Adverts` (`ID`) ON DELETE Restrict ON UPDATE Restrict
;

ALTER TABLE `Comments` 
 ADD CONSTRAINT `FK_Comments_Author`
	FOREIGN KEY (`AuthorID`) REFERENCES `Users` (`ID`) ON DELETE Restrict ON UPDATE Restrict
;

ALTER TABLE `Comments` 
 ADD CONSTRAINT `FK_Comments_CommentedUser`
	FOREIGN KEY (`CommentedUserID`) REFERENCES `Users` (`ID`) ON DELETE Restrict ON UPDATE Restrict
;

ALTER TABLE `Ratings` 
 ADD CONSTRAINT `FK_Ratings_Author`
	FOREIGN KEY (`AuthorID`) REFERENCES `Users` (`ID`) ON DELETE Restrict ON UPDATE Restrict
;

ALTER TABLE `Ratings` 
 ADD CONSTRAINT `FK_Ratings_RatedUser`
	FOREIGN KEY (`RatedUserID`) REFERENCES `Users` (`ID`) ON DELETE Restrict ON UPDATE Restrict
;

SET FOREIGN_KEY_CHECKS=1 
;
