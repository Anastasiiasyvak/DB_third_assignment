USE ASSIGNMENT3;

SELECT
    T.NAME AS TOUR_NAME,
    T.START_DATE,
    T.FINISH_DATE,
    T.PRICE,
    H.NAME AS HOTEL_NAME,
    H.RATING AS HOTEL_RATING
FROM
    TOURS T
JOIN
    TOUR_HOTELS TH ON T.ID = TH.TOUR_ID
JOIN
    HOTELS H ON TH.HOTEL_ID = H.ID
WHERE
    T.PRICE BETWEEN 5000 AND 8000
    AND T.START_DATE = '2024-07-10'
    AND T.AVAILABILITY = 'available'
    AND H.RATING > 4;


--> Nested loop inner join (cost=0.788 rows=0.0557) (actual time=0.0247..0.0247 rows=0 loops=1)
---> Nested loop inner join (cost=0.749 rows=0.111) (actual time=0.0236..0.0236 rows=0 loops=1)
---> Filter: ((T.AVAILABILITY = 'available') and (T.START_DATE = DATE'2024-07-10')) (cost=0.71 rows=0.05) (actual time=0.0221..0.0221 rows=0 loops=1)
---> Index range scan on T using INDEX_TOURS_PRICE over (5000.00 <= PRICE <= 8000.00), with index condition: (T.PRICE between 5000 and 8000) (cost=0.71 rows=1) (actual time=0.0213..0.0213 rows=0 loops=1)
---> Filter: (TH.HOTEL_ID is not null) (cost=5.01 rows=2.23) (never executed)
---> Index lookup on TH using TOUR_ID (TOUR_ID=T.ID) (cost=5.01 rows=2.23) (never executed)
---> Filter: (H.RATING > 4.0) (cost=0.699 rows=0.5) (never executed)
---> Single-row index lookup on H using PRIMARY (ID=TH.HOTEL_ID) (cost=0.699 rows=1) (never executed)
