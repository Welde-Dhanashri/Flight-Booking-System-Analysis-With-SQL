use flightbookingsystem ;

-- 1. How many total bookings have been made?
SELECT COUNT(*) AS total_bookings FROM bookings;

-- 2. What is the total revenue generated from ticket sales?
SELECT SUM(f.Ticket_Price) AS total_revenue
FROM bookings b
JOIN flights f ON b.Flight_ID = f.Flight_ID
WHERE b.Payment_Status = 'Paid';

-- 3. Which airline has the highest number of bookings?
SELECT f.Airline_Name, COUNT(*) AS total_bookings
FROM bookings b
JOIN flights f ON b.Flight_ID = f.Flight_ID
GROUP BY f.Airline_Name
ORDER BY total_bookings DESC
LIMIT 1;

-- 4. What is the most popular destination?
SELECT f.Destination_Airport, COUNT(*) AS total_flights
FROM bookings b
JOIN flights f ON b.Flight_ID = f.Flight_ID
GROUP BY f.Destination_Airport
ORDER BY total_flights DESC
LIMIT 1;

-- 5. What is the distribution of passengers by gender?
SELECT p.Gender, COUNT(*) AS total_passengers
FROM passengers p
GROUP BY p.Gender;

-- 6. What is the average ticket price per airline?
SELECT f.Airline_Name, AVG(f.Ticket_Price) AS avg_price
FROM flights f
GROUP BY f.Airline_Name;

-- 7. What are the top 5 most expensive flights?
SELECT * FROM flights
ORDER BY Ticket_Price DESC
LIMIT 5;

-- 8. How many bookings are unpaid?
SELECT COUNT(*) AS unpaid_bookings
FROM bookings
WHERE Payment_Status = 'Pending';

-- 9. Which passenger has made the highest number of bookings?
SELECT p.Name, COUNT(*) AS booking_count
FROM bookings b
JOIN passengers p ON b.Passenger_ID = p.Passenger_ID
GROUP BY p.Name
ORDER BY booking_count DESC
LIMIT 1;

-- 10. Which flight has the most available seats?
SELECT Flight_ID, Airline_Name, Available_Seats
FROM flights
ORDER BY Available_Seats DESC
LIMIT 1;

-- 11. What are the monthly revenue trends?
SELECT strftime('%Y-%m', b.Booking_Date) AS month, SUM(f.Ticket_Price) AS revenue
FROM bookings b
JOIN flights f ON b.Flight_ID = f.Flight_ID
WHERE b.Payment_Status = 'Paid'
GROUP BY month
ORDER BY month;

-- 12. What are the peak travel periods based on the number of bookings?
SELECT strftime('%Y-%m', b.Booking_Date) AS month, COUNT(*) AS total_bookings
FROM bookings b
GROUP BY month
ORDER BY total_bookings DESC
LIMIT 5;

-- 13. What are the most frequently used source and destination airports?
SELECT f.Source_Airport, f.Destination_Airport, COUNT(*) AS flight_count
FROM bookings b
JOIN flights f ON b.Flight_ID = f.Flight_ID
GROUP BY f.Source_Airport, f.Destination_Airport
ORDER BY flight_count DESC
LIMIT 10;

-- 14. What is the flight occupancy rate (percentage of seats booked per flight)?
SELECT f.Flight_ID, f.Airline_Name, 
       (COUNT(b.Booking_ID) * 100.0 / (COUNT(b.Booking_ID) + f.Available_Seats)) AS occupancy_rate
FROM flights f
LEFT JOIN bookings b ON f.Flight_ID = b.Flight_ID
GROUP BY f.Flight_ID, f.Airline_Name
ORDER BY occupancy_rate DESC;

-- 15. What is the payment pattern analysis (percentage of paid vs pending bookings)?
SELECT Payment_Status, COUNT(*) * 100.0 / (SELECT COUNT(*) FROM bookings) AS percentage
FROM bookings
GROUP BY Payment_Status;
