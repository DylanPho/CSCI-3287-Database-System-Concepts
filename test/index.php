<!DOCTYPE html> 
<html lang="en"> 
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap demo</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body> 
<div class='container'> 
<?php 
require("db.php"); 
$mysqli = new mysqli(SERVER, USER, PASSWORD, DB);
echo "Result:" . $mysqli->host_info;
$sql = "SELECT * FROM patients";
$result = $mysqli->query($sql);
$num_rows = $result->num_rows;
echo " Number of rows = $num_rows";
echo "<h1>List of Patients</h1>";
echo "<table class='table table-striped'>
<tr>
<th>First Name</th>
<th>Last Name</th>
<th>Birthdate</th>
</tr>";

foreach ($result as $row) {
    echo "<tr>
    <td>".$row["FIRST"]."</td>
    <td>".$row["LAST"]."</td>
    <td>".$row["BIRTHDATE"]."</td>
    </tr>";
}
echo "</table>";
?> 
<div class="container"> 
<body> 
<html>