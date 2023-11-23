<?php
// Connect to database
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "restaurantdb";
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Retrieve employee list
$sql = "select * from employee";
$result = $conn->query($sql);

// Display employee list as dropdown menu
echo "<form method='GET'>";
echo "<select name='employeeID'>";
while ($row = $result->fetch_assoc()) {
    echo "<option value='" . $row["ID"] . "'>" . $row["name"] . " " . $row["email"] . "</option>";
}
echo "</select>";
echo "<input type='submit' value='Show Schedule'>";
echo "</form>";

// Display schedule if employee is selected
if (isset($_GET["eID"])) {
    $employeeID = $_GET["eID"];

    // Retrieve schedule for Monday to Friday
    $sql = "SELECT * FROM Schedule WHERE EmployeeID = $employeeID AND DayOfWeek IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday') ORDER BY DayOfWeek, StartTime";
    $result = $conn->query($sql);

    // Display schedule in table
    if ($result->num_rows > 0) {
        echo "<table>";
        echo "<tr><th>Day</th><th>Start Time</th><th>End Time</th></tr>";
        while ($row = $result->fetch_assoc()) {
            echo "<tr><td>" . $row["DayOfWeek"] . "</td><td>" . $row["StartTime"] . "</td><td>" . $row["EndTime"] . "</td></tr>";
        }
        echo "</table>";
    } else {
        echo "No schedule found for selected employee.";
    }
}

// Close connection
$conn->close();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Employee Schedule</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" type="text/css" href="stylemain.css">

</head>
<body>
</body>
</html>
