<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Add Encounter</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet" integrity="sha384-
    QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
    crossorigin="anonymous">
</head>
<body>
<div class='container'>

<h1> Add New Encounter </h1>
<?php
require('db.php');
date_default_timezone_set('America/Denver');

// Connect to database
$mysqli = new mysqli(SERVER, USER, PASSWORD, DB);
if ($mysqli->connect_error) {
    echo "Error: Database connection failed - " . $mysqli->connect_error;
    exit(0);
}

// Get List of Patients
$sql_patient = "SELECT Id, Concat(FIRST, ' ', LAST) AS NAME FROM patients ORDER BY NAME";
$result_patient = $mysqli->query($sql_patient);

// Get List of Organizations
$sql_organization = "SELECT Id, NAME FROM organizations ORDER BY NAME";
$result_organization = $mysqli->query($sql_organization);

// Get List of Payers
$sql_payer = "SELECT Id, NAME FROM payers ORDER BY NAME";
$result_payer = $mysqli->query($sql_payer);

//Unique ID and Current DateTime
$encounter_id = uniqid();
$encounter_date = date('Y-m-d H:i:s');
?>

<form method="POST" action="add_encounter_handler.php">
    <table class='table'>
    <tr>
    <td>Encounter Id:</td>
    <td>
        <input type="text" name="encounter_id" value="<?php echo $encounter_id; ?>" readonly>
        </td>
    </tr>
    <tr>
    <td>Start Date & Time: </td>
    <td><input type="text" name="current_date_time" value="<?php echo $encounter_date; ?>" readonly>
    </td>
    </tr>

    <tr>
    <td>Patient:</td>
    <td>
            <select name="patient" id="patient">
            <option value=''>Select one option</option>
            <?php
            foreach ($result_patient as $row) {
                echo "<option value='" . $row['Id'] . "'>" . $row['NAME'] . "</option>";
            }
            ?>
        </select>
    </td>
    </tr>

    <tr>
    <td>Organization:</td>
    <td>
        <select name="organization" id="organization">
            <option value="">Select one option</option>
            <?php
            foreach ($result_organization as $row) {
                echo "<option value='" . $row['Id'] . "'>" . $row['NAME'] . "</option>";
            }
            ?>
        </select>
    </td>
    </tr>

    <tr>
    <td>Payer:</td>
    <td>
        <select name="payer" id="payer">
            <option value="">Select one option</option>
            <?php
            foreach ($result_payer as $row) {
                echo "<option value='" . $row['Id'] . "'>" . $row['NAME'] . "</option>";
            }
            ?>
        </select>
    </td>
    </tr>

    <tr>
    <td>Encounter Type:</td>
    <td>
        <select name="type_encounter" id="type_encounter">
            <option value=''>Select one option</option>
            <option value='ambulatory'>Ambulatory</option>
            <option value='emergency'>Emergency</option>
            <option value='inpatient'>Inpatient</option>
            <option value='outpatient'>Outpatient</option>
            <option value='urgentcare'>Urgentcare</option>
            <option value='wellness'>Wellness</option>
        </select>
    </td>
    </tr>

    <table>
    
    <div class='d-flex flex-row-reverse'>
        <input type="submit" value="Submit" class='btn btn-primary ms-1'>
        <input type="reset" value="Reset" class='btn btn-primary ms-1'>
    </div>

</form>

</div>
</body>
</html>