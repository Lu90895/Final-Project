CREATE DATABASE restaurant_reservations;
CREATE TABLE customers (
    customerId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customerName VARCHAR(45) NOT NULL,
    contactInfo VARCHAR(200)
);
use restaurant_reservations;
CREATE TABLE customers (
    customerId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customerName VARCHAR(45) NOT NULL,
    contactInfo VARCHAR(200)
);
CREATE TABLE reservations (
    reservationId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customerId INT NOT NULL,
    reservationTime DATETIME NOT NULL,
    numberOfGuests INT NOT NULL,
    specialRequests VARCHAR(200),
    FOREIGN KEY (customerId) REFERENCES customers(customerId)
);
CREATE TABLE dining_preferences (
    preferenceId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customerId INT NOT NULL,
    favoriteTable VARCHAR(45),
    dietaryRestrictions VARCHAR(200),
    FOREIGN KEY (customerId) REFERENCES customers(customerId)
);
INSERT INTO customers (customerName, contactInfo) VALUES
('Johnny Water', 'johnny.water@gmail.com'),
('Mary Smith', 'mary.smith@gmail.com'),
('Amy Brown', 'amy.brown@gmail.com');

INSERT INTO reservations (customerId, reservationTime, numberOfGuests, specialRequests) VALUES
(1, '2024-12-15 19:00:00', 4, 'Window seat preferred'),
(2, '2024-12-16 18:30:00', 2, 'Allergy to nuts, please avoid dishes with nuts'),
(3, '2024-12-17 20:00:00', 3, 'Vegan meal for one guest');

INSERT INTO dining_preferences (customerId, favoriteTable, dietaryRestrictions) VALUES
(1, 'Table 5', 'Gluten-free'),
(2, 'Table 10', 'Peanut allergy'),
(3, 'Table 2', 'Vegetarian');

SELECT * FROM customers;
SELECT * FROM reservations;
SELECT * FROM dining_preferences;

DELIMITER $$

CREATE PROCEDURE findReservations(IN customerId INT)
BEGIN
    SELECT * 
    FROM reservations 
    WHERE customerId = customerId;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE addSpecialRequest(IN reservationId INT, IN requests VARCHAR(200))
BEGIN
    UPDATE reservations
    SET specialRequests = requests
    WHERE reservationId = reservationId;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE addReservation(
    IN customerName VARCHAR(45),
    IN contactInfo VARCHAR(200),
    IN reservationTime DATETIME,
    IN numberOfGuests INT,
    IN specialRequests VARCHAR(200)
)
BEGIN
    -- Check if the customer already exists
    DECLARE existingCustomerId INT;

    -- Find the customer by name
    SELECT customerId INTO existingCustomerId
    FROM customers
    WHERE customerName = customerName;

    -- If the customer doesn't exist, insert a new customer
    IF existingCustomerId IS NULL THEN
        INSERT INTO customers (customerName, contactInfo)
        VALUES (customerName, contactInfo);
        -- Get the new customerId
        SELECT LAST_INSERT_ID() INTO existingCustomerId;
    END IF;

    -- Now add the reservation for the customer
    INSERT INTO reservations (customerId, reservationTime, numberOfGuests, specialRequests)
    VALUES (existingCustomerId, reservationTime, numberOfGuests, specialRequests);
END $$

DELIMITER ;

SHOW PROCEDURE STATUS WHERE Db = 'restaurant_reservations';








