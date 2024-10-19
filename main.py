import mysql.connector
from mysql.connector import Error
import uuid
from faker import Faker
import random
import os
from dotenv import load_dotenv

load_dotenv()

HOST = 'localhost'
USER = 'root'
PASSWORD = 'Aa123456@'
DATABASE = 'ASSIGNMENT3'

fake = Faker()

def create_connection():
    try:
        connection = mysql.connector.connect(
            host=HOST,
            user=USER,
            password=PASSWORD,
            database=DATABASE
        )
        if connection.is_connected():
            print("Successful connection to MySQL")
        return connection
    except Error as e:
        print(f"The '{e}' error occurred")
        return None

def execute_many_queries(connection, query, data, table_name):
    cursor = connection.cursor()
    try:
        print(f"Inserting in the table {table_name}...")
        cursor.executemany(query, data)
        connection.commit()
        print(f"Data inserted in the table {table_name}.")
    except Error as e:
        print(f"The '{e}' error is occurred")

def insert_data():
    connection = create_connection()

    if connection is None:
        return

    tours_insert_query = """
    INSERT INTO TOURS (ID, NAME, START_DATE, FINISH_DATE, PRICE, AVAILABILITY, DESCRIPTION, MAX_PARTICIPANTS, MIN_PARTICIPANTS)
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
    """
    tours_data = [
        (str(uuid.uuid4()), fake.word(), fake.date_this_year(), fake.future_date(), round(random.uniform(100, 5000), 2),
         random.choice(['available', 'not available']), fake.text(max_nb_chars=200), random.randint(5, 50), random.randint(1, 5))
        for _ in range(10000)
    ]
    execute_many_queries(connection, tours_insert_query, tours_data, "TOURS")

    clients_insert_query = """
    INSERT INTO CLIENTS (ID, NAME, SURNAME, EMAIL, PHONE)
    VALUES (%s, %s, %s, %s, %s)
    """
    clients_data = [
        (str(uuid.uuid4()), fake.first_name(), fake.last_name(), fake.email(), fake.phone_number())
        for _ in range(400000)
    ]
    execute_many_queries(connection, clients_insert_query, clients_data, "CLIENTS")

    orders_insert_query = """
    INSERT INTO ORDERS (ID, TOUR_ID, CLIENT_ID, ORDER_DATE, TOTAL_PRICE)
    VALUES (%s, %s, %s, %s, %s)
    """
    orders_data = [
        (str(uuid.uuid4()), random.choice(tours_data)[0], random.choice(clients_data)[0], fake.date_this_year(), round(random.uniform(100, 5000), 2))
        for _ in range(500000)
    ]
    execute_many_queries(connection, orders_insert_query, orders_data, "ORDERS")

    hotels_insert_query = """
    INSERT INTO HOTELS (ID, NAME, COUNTRY, ADDRESS, RATING)
    VALUES (%s, %s, %s, %s, %s)
    """
    hotels_data = [
        (str(uuid.uuid4()), fake.company(), fake.country(), fake.address(), round(random.uniform(3, 5), 1))
        for _ in range(15000)
    ]
    execute_many_queries(connection, hotels_insert_query, hotels_data, "HOTELS")

    guides_insert_query = """
    INSERT INTO GUIDES (ID, NAME, SURNAME, PHONE, EMAIL)
    VALUES (%s, %s, %s, %s, %s)
    """
    guides_data = [
        (str(uuid.uuid4()), fake.first_name(), fake.last_name(), fake.phone_number(), fake.email())
        for _ in range(20000)
    ]
    execute_many_queries(connection, guides_insert_query, guides_data, "GUIDES")

    tour_hotels_insert_query = """
    INSERT INTO TOUR_HOTELS (TOUR_ID, HOTEL_ID)
    VALUES (%s, %s)
    """
    tour_hotels_data = [
        (random.choice(tours_data)[0], random.choice(hotels_data)[0])
        for _ in range(20000)
    ]
    execute_many_queries(connection, tour_hotels_insert_query, tour_hotels_data, "TOUR_HOTELS")

    tour_guides_insert_query = """
    INSERT INTO TOUR_GUIDES (TOUR_ID, GUIDE_ID)
    VALUES (%s, %s)
    """
    tour_guides_data = [
        (random.choice(tours_data)[0], random.choice(guides_data)[0])
        for _ in range(20000)
    ]
    execute_many_queries(connection, tour_guides_insert_query, tour_guides_data, "TOUR_GUIDES")

    client_details_insert_query = """
    INSERT INTO CLIENT_DETAILS (CLIENT_ID, ADDITIONAL_INFO)
    VALUES (%s, %s)
    """
    client_details_data = [
        (client[0], fake.text(max_nb_chars=200))
        for client in clients_data
    ]
    execute_many_queries(connection, client_details_insert_query, client_details_data, "CLIENT_DETAILS")

insert_data()
