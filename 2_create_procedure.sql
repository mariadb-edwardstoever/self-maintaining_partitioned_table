-- Script by Edward Stoever for Mariadb Support

DROP PROCEDURE IF EXISTS P_MAINTAIN_ACTIVITY_LOG;
delimiter //
CREATE PROCEDURE  P_MAINTAIN_ACTIVITY_LOG()
COMMENT 'Created By Edward Stoever for Mariadb Support.'
BEGIN

declare vSQL1, vSQL2 varchar(1000);
declare COMPLETED varchar(20); 
DECLARE cur_add_partitions CURSOR FOR  
select concat('alter table pt_example.activity_log add partition if not exists (P',UNIX_TIMESTAMP(cast(date_format(now() + interval seq hour,'%Y-%m-%d %H:00:00') as datetime)),' values less than (',UNIX_TIMESTAMP(cast(date_format(now() + interval seq hour,'%Y-%m-%d %H:00:00') as datetime)),'))') 
from seq_1_to_24;

DECLARE cur_drop_partitions CURSOR FOR  
select concat('alter table pt_example.activity_log drop partition ',PARTITION_NAME ) 
from information_schema.PARTITIONS 
where TABLE_SCHEMA='pt_example' 
and TABLE_NAME='activity_log' 
and cast(PARTITION_DESCRIPTION as INTEGER) < UNIX_TIMESTAMP(cast(date_format(now() - interval 48 hour,'%Y-%m-%d %H:00:00') as datetime));

DECLARE CONTINUE HANDLER FOR NOT FOUND 
  BEGIN
    SET COMPLETED = TRUE;
  END;

-- RESET COMPLETED
SET COMPLETED = NULL;
  
 OPEN cur_add_partitions;
  add_partitions_loop: LOOP
    FETCH cur_add_partitions INTO vSQL1;
    IF COMPLETED THEN
      LEAVE add_partitions_loop;
    END IF;
  PREPARE STMT1 FROM vSQL1;
  EXECUTE STMT1;
  DEALLOCATE PREPARE STMT1;
  END LOOP;
  CLOSE cur_add_partitions; 

-- RESET COMPLETED
SET COMPLETED = NULL;


 OPEN cur_drop_partitions;
  add_partitions_loop: LOOP
    FETCH cur_drop_partitions INTO vSQL2;
    IF COMPLETED THEN
      LEAVE add_partitions_loop;
    END IF;
  PREPARE STMT2 FROM vSQL2;
  EXECUTE STMT2;
  DEALLOCATE PREPARE STMT2;
  END LOOP;
  CLOSE cur_drop_partitions; 
  
END;
//
delimiter ;

