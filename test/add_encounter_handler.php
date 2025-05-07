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
    <pre><?php print_r($_POST); ?></pre>

<?php
    $encounter_id = $_POST['encounter_id'];
    $current_date_time = $_POST['current_date_time'];
    $patient_id = $_POST['patient'];
    $organization_id = $_POST['organization'];
    $payer_id = $_POST['payer'];
    $type_encounter = $_POST['type_encounter'];
    require("db.php");
    $mysqli = new mysqli(SERVER, USER, PASSWORD, DB);
    if(!$mysqli->host_info){
    echo "Error: Database connection failed!:";
    exit(0);
    }

// Insert Encounter
$sql_insert_encounter = "INSERT INTO encounters (Id, START, PATIENT, ORGANIZATION, PAYER,
ENCOUNTERCLASS)
VALUES ('$encounter_id', '$current_date_time', '$patient_id', '$organization_id',
'$payer_id', '$type_encounter')";

// Execute Query
$result_insert = $mysqli->query($sql_insert_encounter);

// Check query result
if(!$result_insert) {
echo "<div class='alert alert-warning'>Error: $mysqli->error</div>";
} else {
echo "<div class='alert alert-success'>Successfull Insert!</div>";
}
?>

</div>
</body>
</html>