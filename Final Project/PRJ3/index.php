<?php
// index.php - Landing page for PRJ2
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Crime Report Queries</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 2rem;
        }
        h1 {
            color: #333;
            text-align: center;
        }
        ul {
            max-width: 600px;
            margin: 2rem auto;
            padding: 0;
            list-style-type: none;
        }
        li {
            margin: 0.75rem 0;
        }
        a {
            display: block;
            padding: 1rem;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            text-align: center;
            transition: background-color 0.3s ease;
        }
        a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <h1>Welcome to the Crime Reports Dashboard</h1>
    <ul>
        <li><a href="page1.php">Query 1: Join - Total incidents per area</a></li>
        <li><a href="page2.php">Query 2: Outer Join - Crimes and weapons used (some crimes may not have a weapon)</a></li>
        <li><a href="page3.php">Query 3: Set Theory - Find MO codes that are not used in any crimes</a></li>
        <li><a href="page4.php">Query 4: Aggregation - Crimes per premises type</a></li>
        <li><a href="page5.php">Query 5: Top 5 Most Frequent Crime Types</a></li>
        <li><a href="page6.php">Query 6: Crime Count by Reporting District</a></li>
    </ul>
</body>
</html>
