-- Script by Edward Stoever for Mariadb Support

delimiter //
CREATE EVENT `EV_MAINTAIN_ACTIVITY_LOG`
    ON SCHEDULE
        EVERY 1 HOUR STARTS cast(date_format(now()+interval 1 hour,'%Y-%m-%d %H:00:00') as datetime)
    ON COMPLETION PRESERVE
    ENABLE
    COMMENT 'Created By Edward Stoever for Mariadb Support. Requires global variable event_scheduler=ON'
    DO BEGIN
  CALL P_MAINTAIN_ACTIVITY_LOG();
END;
//
delimiter ;

