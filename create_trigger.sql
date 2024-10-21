USE ASSIGNMENT3;

CREATE TRIGGER UPDATE_TOUR_AVAILABILITY
AFTER INSERT ON ORDERS
FOR EACH ROW
BEGIN
    IF (SELECT COUNT(*) FROM ORDERS WHERE TOUR_ID = NEW.TOUR_ID) >= 10 THEN
        UPDATE TOURS
        SET AVAILABILITY = 'NOT AVAILABLE'
        WHERE ID = NEW.TOUR_ID;
    END IF;
END;
