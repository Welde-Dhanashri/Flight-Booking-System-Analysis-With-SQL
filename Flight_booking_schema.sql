create database flightbookingsystem ;

use flightbookingsystem ;

CREATE TABLE bookings (
    Booking_ID INTEGER PRIMARY KEY,
    Passenger_ID INTEGER,
    Flight_ID INTEGER,
    Booking_Date DATETIME,
    Payment_Status TEXT CHECK (Payment_Status IN ('Paid', 'Pending')),
    FOREIGN KEY (Passenger_ID) REFERENCES passengers(Passenger_ID),
    FOREIGN KEY (Flight_ID) REFERENCES flights(Flight_ID)
);


CREATE TABLE flights (
    Flight_ID INTEGER PRIMARY KEY,
    Airline_Name TEXT,
    Source_Airport TEXT,
    Destination_Airport TEXT,
    Departure_Time DATETIME,
    Arrival_Time DATETIME,
    Ticket_Price DECIMAL(10,2),
    Available_Seats INTEGER
);


CREATE TABLE passengers (
    Passenger_ID INTEGER PRIMARY KEY,
    Name TEXT,
    Gender TEXT CHECK (Gender IN ('Male', 'Female', 'Other'))
);
