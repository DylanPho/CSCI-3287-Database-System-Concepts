<pre>
<?php
print_r($_POST);
?>
</pre>

<?php
$start = $_POST['startTemp'];
$end = $_POST['endTemp'];

if ($start > $end) {
    header('Refresh: 2; URL=temp2.php');
    echo "<h1>Error. Please enter a valid start and end temps<h1>";
    exit;
}
?>

<table border="1">
<tr>
    <th>Farenheit</th>
    <th>Celsius</th>
</tr>
    
<?php
for ($i = $start; $i <= $end; $i++) {
    $calc = ($i - 32) * 5 / 9;
?>
<tr>
    <td><?php echo $i; ?></td>
    <td><?php echo round($calc, 1); ?> </td>
</tr>
<?php
}
?>
</table>