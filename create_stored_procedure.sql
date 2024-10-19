USE ASSIGNMENT3;

CREATE PROCEDURE ADDCLIENT(
    IN P_ID VARCHAR(36),
    IN P_NAME VARCHAR(200),
    IN P_SURNAME VARCHAR(200),
    IN P_EMAIL VARCHAR(200),
    IN P_PHONE VARCHAR(50)
)
BEGIN
    INSERT INTO CLIENTS (ID, NAME, SURNAME, EMAIL, PHONE)
    VALUES (P_ID, P_NAME, P_SURNAME, P_EMAIL, P_PHONE);
END;

CALL ADDCLIENT('F4A8C0D3-6F1A-4B8E-8E7C-19C78D9A1C5D', 'JOHN', 'DOE', 'JOHN.DOE@EXAMPLE.COM', '+123456789');
