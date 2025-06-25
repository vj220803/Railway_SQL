#  Railway Management System (SQL Project)

## Project Overview

This project demonstrates a simplified **Railway Booking System** built using SQL. It models trains, passengers, and ticket bookings via a `train_passenger` table (serving as a transactional table). The schema is minimal but accurately simulates real-world operations like ticket reservations, journey records, and fare tracking.

---

## Technologies Used

* **Database**: MySQL
* **Language**: SQL (DDL, DML, JOINs, Aggregations)

---

## Database Schema

### 1. `train`

| Column      | Type        | Description       |
| ----------- | ----------- | ----------------- |
| train\_id   | INT (PK)    | Unique Train ID   |
| train\_name | VARCHAR(30) | Name of the Train |

### 2. `passenger`

| Column          | Type        | Description         |
| --------------- | ----------- | ------------------- |
| passenger\_id   | INT (PK)    | Unique Passenger ID |
| passenger\_name | VARCHAR(30) | Name of Passenger   |
| gender          | CHAR(1)     | Gender (M/F)        |
| phone\_no       | VARCHAR(10) | Contact Number      |

### 3. `train_passenger`

| Column        | Type         | Description          |
| ------------- | ------------ | -------------------- |
| train\_id     | INT (FK)     | Train booked         |
| passenger\_id | INT (FK)     | Passenger who booked |
| journey\_date | DATE         | Date of travel       |
| seat\_no      | INT          | Seat number          |
| fare          | DECIMAL(6,2) | Fare paid            |

---

## Relationships

```
[train] 1 ───< train_passenger >─── 1 [passenger]
```

* One train can be booked by **many passengers**
* One passenger can book **many trains**
* `train_passenger` serves as a **junction table** for M\:N relationship with additional attributes like date, seat, and fare

---

## ER Diagram


## Query List (Expanded)

| No  | Query Description                                          |
| --- | ---------------------------------------------------------- |
| Q1  | List all train bookings with passenger and journey details |
| Q2  | Number of bookings per train                               |
| Q3  | Total fare collected per train                             |
| Q4  | Passengers who paid more than ₹1000                        |
| Q5  | Passenger who paid highest fare                            |
| Q6  | Count of male and female passengers                        |
| Q7  | Average fare per train                                     |
| Q8  | List all journeys on a specific date                       |
| Q9  | Trains not booked by any passengers                        |
| Q10 | All trains a passenger has booked                          |
| Q11 | Passengers who booked more than once                       |
| Q12 | Total passengers booked per journey date                   |
| Q13 | Train with highest revenue                                 |
| Q14 | Bookings with fare between ₹500–₹1000                      |
| Q15 | Seat distribution across trains                            |

---

## ER Diagram (Text Overview)

```
[train]         [passenger]
   │                 │
   │                 │
    └────< train_passenger >────┘
            (M:N relationship)
```

### Cardinality:

* **train 1 : N train\_passenger**
* **passenger 1 : N train\_passenger**

---

## Author

**Vijayan Naidu**
M.Sc. Data Science @ Fergusson College

---


