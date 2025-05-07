<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Payer View</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class='container'>

<?php
require("db.php");
date_default_timezone_set('America/Denver');

$mysqli = new mysqli(SERVER, USER, PASSWORD, DB);
if ($mysqli->connect_error) {
    die("Error: Database connection failed! " . $mysqli->connect_error);
}

// Handle Update
if (isset($_POST['update'])) {
    $payer_id = $_POST['payer_id'];
    $payer_name = $_POST['payer_name'];
    $payer_address = $_POST['payer_address'];
    $payer_city = $_POST['payer_city'];
    $payer_state = $_POST['payer_state'];
    $payer_zip = $_POST['payer_zip'];
    $payer_phone = $_POST['payer_phone'];

    $sql = "
        UPDATE payers
        SET NAME = '$payer_name',
        ADDRESS = '$payer_address',
        CITY = '$payer_city',
        STATE_HEADQUARTERED = '$payer_state',
        ZIP = '$payer_zip',
        PHONE = '$payer_phone'
        WHERE Id = '$payer_id'
    ";

    $result = $mysqli->query($sql);

    // Check query result
    if (!$result) {
        echo "<div class='alert alert-warning'>Error: $mysqli->error</div>";
    } else {
        echo "<div class='alert alert-success'>Successful Update!</div>";
        header('Location: payer_view.php');
        exit();
    }
}

// Handle Delete
elseif (isset($_POST['delete'])) {
    $payer_id = $_POST['id'];

    $sql = "
    DELETE FROM payers 
    WHERE Id = '$payer_id'
    ";

    $result = $mysqli->query($sql);

    // Check query result
    if (!$result) {
        echo "<div class='alert alert-warning'>Error: $mysqli->error</div>";
    } else {
        echo "<div class='alert alert-success'>Successful Delete!</div>";
        header('Location: payer_view.php');
        exit();
    }
}
?>
</div>
</body>
</html>