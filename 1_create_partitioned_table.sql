-- Script by Edward Stoever for Mariadb Support
drop schema if exists pt_example; 
create schema pt_example; 
use pt_example;

drop table if exists activity_log;
CREATE TABLE `activity_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uxts` bigint(20) NOT NULL,
  `log_entry` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`id`,`uxts`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
 PARTITION BY RANGE (`uxts`)
(PARTITION `p0` VALUES LESS THAN (1000) ENGINE = InnoDB);


alter table activity_log add partition (partition P1 values less than (1000000));
alter table activity_log add partition (partition P2  values less than (2000000));

