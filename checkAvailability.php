<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "hoteldb";

// Handle AJAX request
if ($_SERVER["REQUEST_METHOD"] == "GET") {
    // Get the room type from the GET data
    $roomType = $_GET['roomType'];

    $conn = new mysqli($servername, $username, $password, $dbname);

    // Checking connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

} else {
    echo "Invalid request.";
}


$stmt = $conn->prepare("SELECT COUNT(*) FROM bookings WHERE RoomTypeID = ?");
$stmt->bind_param("i", $roomType);
$stmt->execute();

// Bind the result variable
$stmt->bind_result($bookingsCount);

// Fetch the result
$stmt->fetch();

// Close the statement
$stmt->close();

// Adjusting the maximum logic according to assignment specification
$maxRoomCount = 2;

if ($bookingsCount < $maxRoomCount) {
    echo "The room is available! Please proceed with \"Book Now\" button";
} else {
    echo "Sorry the room is booked. Please try another room.";
}

// Closing the database connection
$conn->close();
?>

