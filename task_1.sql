DROP FUNCTION IF EXISTS CALC_SECONDS;
DELIMITER $$
CREATE FUNCTION CALC_SECONDS (sec INT) RETURNS VARCHAR(50) DETERMINISTIC
BEGIN
  DECLARE	cur INT DEFAULT 0;
	DECLARE temp VARCHAR(50) DEFAULT ' ';
  DECLARE res VARCHAR(50) DEFAULT ' ';
	SET @s_day = 86400;
	SET @s_hour = 3600;
  SET @s_minute = 60;

	SET cur = sec DIV @s_day;
  IF cur > 0 THEN
    	SET res = CONCAT(cur,' days ');
    	SET cur = sec MOD @s_day;
      SET sec = cur;
	END IF;    	
  
  SET cur := sec DIV @s_hour;
	IF cur > 0 THEN
    	SET temp := CONCAT(res, cur,' hours ');
        SET res := temp;
    	SET cur := sec MOD @s_hour;
        SET sec := cur;
  END IF;    	

  SET cur = sec DIV @s_minute;
	IF cur > 0 THEN
    	SET temp = CONCAT(res, cur,' minutes ');
        SET res = temp;
    	SET cur = sec MOD @s_minute;
        SET sec := cur;
  END IF;    	
    
	IF sec > 0 THEN
    	SET temp = CONCAT(res, sec,' seconds ');
        SET res = temp;
  END IF;    	

	RETURN res;
END
$$
DELIMITER ;

SELECT CALC_SECONDS(123456);
