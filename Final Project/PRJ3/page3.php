<?php
// Query 3: MO Codes Without Descriptions

$host = 'localhost';
$user = 'phouttdy';
$password = 'tHMrNAwgcvvj';
$dbname = 'phouttdy_PROJECT';

$conn = new mysqli($host, $user, $password, $dbname);
if ($conn->connect_error) {
    die('Connection failed: ' . $conn->connect_error);
}

$sql = <<<SQL
-- query3.sql: Set Theory - Find MO codes described in MOCODE_Description that are not used in any crimes.
SELECT md.Mocode, md.Mocode_Desc
FROM MOCODE_Description md
WHERE md.Mocode NOT IN (
    SELECT DISTINCT cm.Mocode FROM Crime_MOCodes cm
);
SQL;

$result = $conn->query($sql);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Query 3: MO Codes Without Descriptions</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>Query 3: MO Codes Without Descriptions</h1>
    <a href="index.php">← Back to Home</a>
    <table border="1">
        <?php if ($result && $result->num_rows > 0): ?>
            <tr>
<?php if ($result): ?>
    <?php
        $fields = $result->fetch_fields();
        foreach ($fields as $field):
            $label = [
                "Crm_Cd" => "Crime Code",
                "Crm_Cd_Desc" => "Crime Description",
                "Weapon_Desc" => "Weapon Used",
                "Area_Name" => "Area Name",
                "Premis_Desc" => "Premises Type",
                "Mo_Code" => "MO Code",
                "Mocode_Desc" => "Mocode Description",
                "Rpt_Dist_No" => "Reporting District",
                "Total_Crimes" => "Total Crimes",
                "Total_Incidents" => "Total Incidents",
                "Crime_Count" => "Crime Count",
            ][$field->name] ?? $field->name;
    ?>
        <th><?= htmlspecialchars($label) ?></th>
    <?php endforeach; ?>
<?php endif; ?>
</tr>

            <?php while ($row = $result->fetch_assoc()): ?>
                <tr>
                    <?php foreach ($row as $cell): ?>
                        <td><?= htmlspecialchars($cell) ?></td>
                    <?php endforeach; ?>
                </tr>
            <?php endwhile; ?>
        <?php else: ?>
            <tr><td>No data found or query failed.</td></tr>
        <?php endif; ?>
    </table>
</body>
</html>
<?php
$conn->close();
?>
