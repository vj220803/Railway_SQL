
DROP DATABASE RAILWAY;
CREATE DATABASE RAILWAY;
USE RAILWAY;

-- Creating the train table
CREATE TABLE train (
    train_no INT AUTO_INCREMENT,
    train_name VARCHAR(20),
    src_station VARCHAR(20),
    dest_station VARCHAR(20),
    depart_time TIME,
    arrival_time TIME,
    num_of_bogies INT,
    bogie_capacity INT,
    PRIMARY KEY (train_no)
);

-- Inserting new values into the train table
INSERT INTO train (train_name, src_station, dest_station, depart_time, arrival_time, num_of_bogies, bogie_capacity) VALUES
('Metro Express', 'Station X', 'Station Y', '09:30:00', '11:30:00', 8, 60),
('City Liner', 'Station X', 'Station Z', '10:45:00', '12:15:00', 10, 50),
('Night Rider', 'Station Y', 'Station W', '14:00:00', '16:30:00', 12, 70),
('Rapid Transit', 'Station Z', 'Station W', '15:00:00', '17:00:00', 10, 65),
('Blue Arrow', 'Station X', 'Station W', '18:00:00', '20:00:00', 6, 75);
SELECT * FROM train;

-- Creating the passenger table
CREATE TABLE passenger (
    passenger_id INT AUTO_INCREMENT,
    passenger_name VARCHAR(20),
    address VARCHAR(50),
    age INT,
    gender CHAR(1),
    PRIMARY KEY (passenger_id)
);

-- Inserting new values into the passenger table
INSERT INTO passenger (passenger_name, address, age, gender) VALUES
('Amit', 'New York', 22, 'M'),
('Neha', 'Mumbai', 25, 'F'),
('Raj', 'Delhi', 24, 'M'),
('Priya', 'London', 26, 'F'),
('Ravi', 'Paris', 27, 'M'),
('Simran', 'Tokyo', 21, 'F'),
('Vikram', 'Berlin', 28, 'M'),
('Kiran', 'Dubai', 23, 'F'),
('John', 'Sydney', 29, 'M'),
('Alice', 'Toronto', 30, 'F');
SELECT * FROM passenger;

-- Creating the train_passenger relationship table
CREATE TABLE train_passenger (
    train_no INT,
    passenger_id INT,
    PRIMARY KEY (train_no, passenger_id),
    journey_date DATE,
    seat_no INT,
    fare DECIMAL(6,2),
    FOREIGN KEY (train_no) REFERENCES train(train_no),
    FOREIGN KEY (passenger_id) REFERENCES passenger(passenger_id)
);

-- Inserting values into train_passenger table with new data
INSERT INTO train_passenger (train_no, passenger_id, fare, journey_date) VALUES
(1, 1, 300, '2023-09-01'), (1, 2, 250,'2023-09-02'), (2, 3, 270,'2023-09-03'), (3, 6, 285,'2023-09-04'), (4, 7, 300,'2023-09-05'), (4, 8, 310,'2023-09-06'), (5, 9, 260,'2023-09-07'), (5, 10, 250,'2023-09-08');
SELECT * FROM train_passenger;

-- Altering the train_passenger table to add the 'status' column
ALTER TABLE train_passenger
ADD status ENUM('Confirmed', 'Not Confirmed', 'Waiting') DEFAULT 'Not Confirmed';

-- Updating status for some passengers
UPDATE train_passenger SET status = 'Confirmed' WHERE train_no = 1 AND passenger_id IN (1, 2);
UPDATE train_passenger SET status = 'Waiting' WHERE train_no = 2 AND passenger_id IN (3, 4);
UPDATE train_passenger SET status = 'Not Confirmed' WHERE train_no = 3 AND passenger_id IN (5, 6);
SELECT p.passenger_name, t.train_name, tp.status 
FROM train_passenger tp
JOIN passenger p ON tp.passenger_id = p.passenger_id
JOIN train t ON tp.train_no = t.train_no;

-- Inserting new entries with status
INSERT INTO train_passenger (train_no, passenger_id, status) VALUES
(1, 3, 'Confirmed'),
(2, 4, 'Waiting'),
(3, 5, 'Not Confirmed');

-- Q1: Select distinct passengers with 'Confirmed' status
SELECT DISTINCT p.passenger_name 
FROM train_passenger tp
JOIN passenger p ON tp.passenger_id = p.passenger_id
JOIN train t ON tp.train_no = t.train_no
WHERE tp.status = 'Confirmed';


-- Q2: Select distinct passengers with 'Waiting' status
SELECT DISTINCT p.passenger_name 
FROM train_passenger tp
JOIN passenger p ON tp.passenger_id = p.passenger_id
JOIN train t ON tp.train_no = t.train_no
WHERE tp.status = 'Waiting';


-- Q3: Delete train where num_of_bogies = 10 and src_station = 'Station Y'
DELETE FROM train 
WHERE num_of_bogies = 10 AND src_station = 'City liner';

-- Q4: Confirm passengers with names starting with 'S' who are currently 'Waiting'
UPDATE train_passenger tp
JOIN passenger p ON tp.passenger_id = p.passenger_id
SET tp.status = 'Confirmed'
WHERE tp.status = 'Waiting' AND p.passenger_name LIKE 'S%';

-- Final output for train_passenger table
SELECT * FROM train_passenger;


# Q5. List all passengers and their ticket details
SELECT p.passenger_name, t.train_no, t.journey_date, t.seat_no, t.fare
FROM passenger p
JOIN train_passenger t ON p.passenger_id = t.passenger_id;

# Q6. List all trains and how many tickets have been booked per train
# SELECT tr.train_name, COUNT(tp.ticket_no) AS tickets_booked
# FROM train tr
# LEFT JOIN train_passenger tp ON tr.train_id = tp.train_id
# GROUP BY tr.train_id;


# Q7. Total fare collected per train
SELECT tr.train_name, SUM(t.fare) AS total_fare
FROM train tr
JOIN train_passenger t ON tr.train_no = t.train_no
GROUP BY tr.train_no;

# Q8. Passengers who paid more than 250
SELECT p.passenger_name, tp.fare, tr.train_name
FROM train_passenger tp
JOIN passenger p ON tp.passenger_id = p.passenger_id
JOIN train tr ON tp.train_no = tr.train_no
WHERE tp.fare > 250;


# Q9. Passengers who paid the highest fare
SELECT p.passenger_name, tp.fare
FROM train_passenger tp
JOIN passenger p ON tp.passenger_id = p.passenger_id
ORDER BY tp.fare DESC
LIMIT 1;


# Q10. Count number of passengers per gender
SELECT gender, COUNT(*) AS count
FROM passenger
GROUP BY gender;


# Q11. Average fare per train
SELECT tr.train_name, AVG(tp.fare) AS average_fare
FROM train tr
JOIN train_passenger tp ON tr.train_no = tp.train_no
GROUP BY tr.train_no;


# Q12. List all passengers who traveled on '2023-09-01'
SELECT p.passenger_name, tr.train_name, tp.seat_no
FROM train_passenger tp
JOIN passenger p ON tp.passenger_id = p.passenger_id
JOIN train tr ON tp.train_no = tr.train_no
WHERE tp.journey_date = '2023-09-01';


# Q13. Trains that have never been booked
SELECT tr.train_name
FROM train tr
LEFT JOIN train_passenger tp ON tr.train_no = tp.train_no
WHERE tp.train_no IS NULL;


# Q14. List all passengers and the train they booked
SELECT p.passenger_name, tr.train_name
FROM train_passenger tp
JOIN passenger p ON tp.passenger_id = p.passenger_id
JOIN train tr ON tp.train_no = tr.train_no;

# Q15. List number of passengers booked on each journey date
SELECT journey_date, COUNT(DISTINCT passenger_id) AS total_passengers
FROM train_passenger 
GROUP BY journey_date;




