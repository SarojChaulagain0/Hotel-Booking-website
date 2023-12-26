<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "hoteldb";

$conn = new mysqli($servername, $username, $password, $dbname);

// Checking connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Handle form submission
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Retrieve form data from the input field
    $customerName = $_POST["customerName"];
    $email = $_POST["email"];
    $phone = $_POST["phone"];
    $checkInDate = $_POST["checkInDate"];
    $roomType = $_POST["roomType"];
    $numOfPersons = $_POST["numOfPersons"];

    // Insert customer information into Customers table
    $insertCustomerQuery = "INSERT INTO Customers (FullName, Email, Phone) VALUES ('$customerName', '$email', '$phone')";
    $conn->query($insertCustomerQuery);

    // Get the CustomerID of the inserted customer
    $customerID = $conn->insert_id;

    try {
        // Insert booking information into Bookings table
        $insertBookingQuery = "INSERT INTO Bookings (CustomerID, RoomTypeID, CheckInDate, NumOfPersons) VALUES ($customerID, $roomType, '$checkInDate', $numOfPersons)";
        $result = $conn->query($insertBookingQuery);

        if ($result) {
            // Booking successful
            // Display success message
            echo "The below booking has been successful!<br>";
            echo "Customer Name: $customerName<br>";
            echo "Email: $email<br>";
            echo "Phone: $phone<br>";
            echo "Check-in Date: $checkInDate<br>";
            echo "Room Type: $roomType<br>";
            echo "Number of Persons: $numOfPersons<br>";
        } else {
            // Booking failed
            // Display error message
            echo "Error: Unable to book the room. Please try again later.";
        }
    } catch (mysqli_sql_exception $e) {
        // Catch the specific exception thrown by the trigger
        if ($e->getCode() == 1644) {
            // Error code 1644 corresponds to the error thrown by the trigger
            echo "Error: Exceeded maximum limit of 2 bookings for this Room TYPE. Please try booking another room.";
        } else {
            // Handle other exceptions
            echo "Error: " . $e->getMessage();
        }
    }
} else {
    // Display error message if form not submitted
    echo "Error: Form not submitted!";
}

// Close the database connection
$conn->close();
?>

