-- Task 1: Create the AddBooking Stored Procedure (BookingID auto-assigned)

-- Drop the procedure if it already exists
DROP PROCEDURE IF EXISTS AddBooking;

DELIMITER //

CREATE PROCEDURE AddBooking(
    IN customer_id INT,
    IN booking_date DATE,
    IN table_number INT
)
BEGIN
    INSERT INTO bookings (CustomerID, BookingDate, TableNumber)
    VALUES (customer_id, booking_date, table_number);
    
    SELECT 'Booking added successfully.' AS Status;
END //

DELIMITER ;


-- Task 2: Create the UpdateBooking Stored Procedure

-- Drop the procedure if it already exists
DROP PROCEDURE IF EXISTS UpdateBooking;

DELIMITER //

CREATE PROCEDURE UpdateBooking(
    IN booking_id INT,
    IN booking_date DATE
)
BEGIN
    UPDATE bookings
    SET BookingDate = booking_date
    WHERE BookingID = booking_id;

    SELECT 'Booking updated successfully.' AS Status;
END //

DELIMITER ;


-- Task 3: Create the CancelBooking Stored Procedure

-- Drop the procedure if it already exists
DROP PROCEDURE IF EXISTS CancelBooking;

DELIMITER //

CREATE PROCEDURE CancelBooking(
    IN booking_id INT
)
BEGIN
    DELETE FROM bookings
    WHERE BookingID = booking_id;

    SELECT 'Booking cancelled successfully.' AS Status;
END //

DELIMITER ;


-- Example Calls to Test Procedures

-- Example call to add a booking (BookingID is now auto-assigned)
CALL AddBooking(1, '2023-11-01', 2);

-- Example call to update a booking (use a valid BookingID from your table)
CALL UpdateBooking(1, '2023-12-01');

-- Example call to cancel a booking (use a valid BookingID from your table)
CALL CancelBooking(1);

