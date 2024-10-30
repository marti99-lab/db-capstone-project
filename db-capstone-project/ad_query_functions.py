import mysql.connector as connector  # import connector module with an alias

try:
    # Establish a connection to the database
    connection = connector.connect(
        user="marti99",  
        password="fcfcfc",  
        db="littlelemondb"  
    )

    # Instantiate a cursor to interact with the database
    cursor = connection.cursor()
    print("Connection to the database was successful.\n")

    # Task 2: Show All Tables in the Database
    show_tables_query = "SHOW tables"
    cursor.execute(show_tables_query)
    results = cursor.fetchall()
    
    print("Tables in the database:")
    for table in results:
        print(table[0])
    print("\n")  # Line break for readability

    # Task 3: Query with Table JOIN
    promotional_query = """
    SELECT customerdetails.FirstName, customerdetails.LastName, customerdetails.PhoneNumber, customerdetails.Email, orders.TotalCost
    FROM customerdetails
    JOIN orders ON customerdetails.CustomerID = orders.BookingID
    WHERE orders.TotalCost > 60;
    """
    
    cursor.execute(promotional_query)
    promotional_results = cursor.fetchall()
    
    # Check if there are any results
    if promotional_results:
        print("Customers with orders over $60:")
        for row in promotional_results:
            print(f"Name: {row[0]} {row[1]}, Phone: {row[2]}, Email: {row[3]}, Bill: ${row[4]}")
    else:
        print("No customer spent over $60!")

except connector.Error as err:
    print(f"Error: {err}")
finally:
    # Close cursor and connection
    if 'cursor' in locals():
        cursor.close()
    if 'connection' in locals() and connection.is_connected():
        connection.close()
    print("\nDatabase connection closed.")
