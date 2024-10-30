-- Step 1: Drop the foreign key constraint temporarily
ALTER TABLE orders DROP FOREIGN KEY Bookings_BookingID_FK;

-- Step 2: Modify BookingID in bookings to AUTO_INCREMENT
ALTER TABLE bookings MODIFY COLUMN BookingID INT NOT NULL AUTO_INCREMENT;

-- Step 3: Re-add the foreign key constraint
ALTER TABLE orders 
ADD CONSTRAINT Bookings_BookingID_FK 
FOREIGN KEY (BookingID) REFERENCES bookings(BookingID);

-- Step 4: Clear existing data in bookings and customerdetails to avoid duplicates

DELETE FROM bookings;
DELETE FROM customerdetails;

-- Insert necessary records into customerdetails

INSERT INTO customerdetails (CustomerID, FirstName, LastName, PhoneNumber, Email) VALUES
(1, 'Alice', 'Johnson', '1234567890', 'alice.johnson@example.com'),
(2, 'Bob', 'Smith', '0987654321', 'bob.smith@example.com'),
(3, 'Charlie', 'Brown', '1112223333', 'charlie.brown@example.com'),
(4, 'Daisy', 'Miller', '4445556666', 'daisy.miller@example.com');

-- Step 5: Populate bookings with initial records

INSERT INTO bookings (BookingDate, TableNumber, CustomerID) VALUES 
('2022-10-10', 5, 1),
('2022-11-12', 3, 3),
('2022-10-11', 2, 2),
('2022-10-13', 2, 4);

-- Verify the inserted records
SELECT * FROM customerdetails;
SELECT * FROM bookings;


-- Task 2: Stored Procedure to Check Booking Availability

-- Drop the procedure if it already exists
DROP PROCEDURE IF EXISTS CheckBooking;

DELIMITER //

CREATE PROCEDURE CheckBooking(IN booking_date DATE, IN table_number INT)
BEGIN
    DECLARE table_status INT;

    -- Check if the table is already booked for the given date
    SELECT COUNT(*) INTO table_status
    FROM bookings
    WHERE BookingDate = booking_date AND TableNumber = table_number;

    -- Output the status
    IF table_status > 0 THEN
        SELECT 'Table is already booked.' AS Status;
    ELSE
        SELECT 'Table is available.' AS Status;
    END IF;
END //

DELIMITER ;

-- Example call for testing availability
CALL CheckBooking('2022-10-10', 5);


-- Task 3: Stored Procedure and Transaction for Adding Valid Booking

-- Drop the procedure if it already exists
DROP PROCEDURE IF EXISTS AddValidBooking;

DELIMITER //

CREATE PROCEDURE AddValidBooking(IN booking_date DATE, IN table_number INT, IN customer_id INT)
BEGIN
    DECLARE table_status INT;

    -- Start the transaction
    START TRANSACTION;

    -- Check if the table is already booked on the given date
    SELECT COUNT(*) INTO table_status
    FROM bookings
    WHERE BookingDate = booking_date AND TableNumber = table_number;

    -- If the table is booked, rollback the transaction
    IF table_status > 0 THEN
        ROLLBACK;
        SELECT 'Booking cancelled: Table is already booked.' AS Status;
    ELSE
        -- If the table is available, insert the new booking and commit the transaction
        INSERT INTO bookings (BookingDate, TableNumber, CustomerID)
        VALUES (booking_date, table_number, customer_id);
        COMMIT;
        SELECT 'Booking confirmed.' AS Status;
    END IF;
END //

DELIMITER ;

-- Example calls to test adding valid bookings
CALL AddValidBooking('2022-10-10', 5, 2); -- Should be cancelled as the table is already booked
CALL AddValidBooking('2022-10-14', 1, 3); -- Should be confirmed as available







