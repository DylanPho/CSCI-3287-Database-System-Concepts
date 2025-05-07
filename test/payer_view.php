<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Payer View</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
        rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
        crossorigin="anonymous">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class='container mt-4'>

<?php 
require("db.php");
date_default_timezone_set('America/Denver');

$mysqli = new mysqli(SERVER, USER, PASSWORD, DB);
if ($mysqli->connect_error) {
  die("Error: Database connection failed! " . $mysqli->connect_error);
}

$sql = "SELECT * FROM payers ORDER BY NAME";
$result = $mysqli->query($sql);
?>

<h1>List of Payers</h1>

<table class='table table-striped'>
  <tr>
    <th>Name</th>
    <th>Address</th>
    <th>City</th>
    <th>State</th>
    <th>Zip</th>
    <th>Phone</th>
    <th>Action</th>
  </tr>

<?php foreach ($result as $row): ?>
  <tr>
    <td><?= $row['NAME'] ?></td>
    <td><?= $row['ADDRESS'] ?></td>
    <td><?= $row['CITY'] ?></td>
    <td><?= $row['STATE_HEADQUARTERED'] ?></td>
    <td><?= $row['ZIP'] ?></td>
    <td><?= $row['PHONE'] ?></td>
    <td>
      <button type='button' class='btn btn-primary btn-sm'
              data-id='<?= $row['Id'] ?>'
              data-name='<?= $row['NAME'] ?>'
              data-address='<?= $row['ADDRESS'] ?>'
              data-city='<?= $row['CITY'] ?>'
              data-state='<?= $row['STATE_HEADQUARTERED'] ?>'
              data-zip='<?= $row['ZIP'] ?>'
              data-phone='<?= $row['PHONE'] ?>'
              data-bs-toggle='modal'
              data-bs-target='#editModal'>
        Edit
      </button>

      <button type='button' class='btn btn-danger btn-sm'
              data-id='<?= $row['Id'] ?>'
              data-name='<?= $row['NAME'] ?>'
              data-bs-toggle='modal'
              data-bs-target='#deleteModal'>
        Delete
      </button>
    </td>
  </tr>
<?php endforeach; ?>
</table>

<!-- Edit Modal -->
<div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <form method="POST" action="payer_handler.php">
        <div class="modal-header">
          <h1 class="modal-title fs-3" id="editModalLabel">Edit Payer Information</h1>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="form-group mt-2">
            <label class="h5" for="payer_id">Id:</label>
            <input type="text" class="form-control-plaintext input-sm" id="payer_id" name="payer_id" readonly>
          </div>
          <div class="form-group mt-2">
            <label class="h5" for="payer_name">Name:</label>
            <input type="text" class="form-control input-sm" id="payer_name" name="payer_name">
          </div>
          <div class="form-group mt-2">
            <label class="h5" for="payer_address">Address:</label>
            <textarea class="form-control input-sm" id="payer_address" name="payer_address"></textarea>
          </div>
          <div class="form-group mt-2">
            <label class="h5" for="payer_city">City:</label>
            <input type="text" class="form-control input-sm" id="payer_city" name="payer_city">
          </div>
          <div class="form-group mt-2">
            <label class="h5" for="payer_state">State:</label>
            <input type="text" class="form-control input-sm" id="payer_state" name="payer_state">
          </div>
          <div class="form-group mt-2">
            <label class="h5" for="payer_zip">Zipcode:</label>
            <input type="text" class="form-control input-sm" id="payer_zip" name="payer_zip">
          </div>
          <div class="form-group mt-2">
            <label class="h5" for="payer_phone">Phone:</label>
            <input type="text" class="form-control input-sm" id="payer_phone" name="payer_phone">
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
          <button type="submit" class="btn btn-primary" name='update'>Submit</button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- DELETE Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <form method="POST" action="payer_handler.php">
        <div class="modal-header">
          <h1 class="modal-title fs-3" id="deleteModalLabel">Delete Payer</h1>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="form-group mt-2">
            <label class="h5" for="id">Id:</label>
            <input type="text" class="form-control-plaintext input-sm" id="id" name="id" readonly>
          </div>
          <div class="form-group mt-2">
            <label class="h5" for="name">Name:</label>
            <input type="text" class="form-control-plaintext input-sm" id="name" name="name" readonly>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
          <button type="submit" class="btn btn-danger" name='delete'>Delete</button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- Modal Scripts -->
<script>
$(document).ready(function() {
  // Handle Edit Modal
  $('#editModal').on('show.bs.modal', function(event) {
    var button = $(event.relatedTarget);
    $('#payer_id').val(button.data('id'));
    $('#payer_name').val(button.data('name'));
    $('#payer_address').val(button.data('address'));
    $('#payer_city').val(button.data('city'));
    $('#payer_state').val(button.data('state'));
    $('#payer_zip').val(button.data('zip'));
    $('#payer_phone').val(button.data('phone'));
  });

  // Handle DELETE Modal
  $('#deleteModal').on('show.bs.modal', function(event) {
    var button = $(event.relatedTarget);
    $('#id').val(button.data('id'));
    $('#name').val(button.data('name'));
  });
});
</script>

</div>
</body>
</html>
