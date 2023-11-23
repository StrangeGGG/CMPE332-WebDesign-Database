<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "restaurantDB";
$con = new mysqli($servername, $username, $password, $dbname);

if ($con->connect_error) {
    die("Connection failed: " . $con->connect_error);
}

$query = 'select * from chef union
			select * from delivery union
			select * from management union
			select * from servers as employee';
$result = $con->query($query);

echo "<form method='GET'>";
echo "<select name='ID'>";
while ($row = $result->fetch_assoc()) {
    echo "<option value='" . $row["ID"] . "'>" . $row["name"] . " " . $row["email"] . "</option>";
}
echo "</select>";
echo "<input type='submit' value='Show Schedule'>";
echo "</form>";

if (isset($_GET["ID"])) {
    $employeeID = $_GET["ID"];

    $sql = 'select listofdays, starttime, endtime, chefID as ID from chefschedule union
			select listofdays, starttime, endtime, deliveryID as ID from deliveryschedule union
			select listofdays, starttime, endtime, managementID as ID from managementschedule union
			select listofdays, starttime, endtime, serverID as ID from serverschedule as schedule
			where ID = $ID and listofdays in ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday') order by listofdays, StartTime';
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        echo "<table>";
        echo "<tr><th>Day</th><th>Start Time</th><th>End Time</th></tr>";
        while ($row = $result->fetch_assoc()) {
            echo "<tr><td>" . $row["listofdays"] . "</td><td>" . $row["starttime"] . "</td><td>" . $row["endtime"] . "</td></tr>";
        }
        echo "</table>";
    } else {
        echo "No schedule found for selected employee.";
    }
}

$con->close();
?>

<!DOCTYPE html>
<html>
<body>
</body>
</html>