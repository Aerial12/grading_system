<?php
include 'config.php';

// Fetch users
$users_sql = "SELECT id, username, role FROM users";
$users_result = $conn->query($users_sql);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Management</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <style>
        body {
            background-color: #F5F5F5;
            color: #333333;
            font-family: Arial, sans-serif;
        }
        .container {
            margin-top: 20px;
        }
        .card {
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        .btn-primary, .btn-danger {
            background-color: #47768F;
            border-color: #47768F;
        }
        .btn-primary:hover, .btn-danger:hover {
            background-color: #365a6c;
        }
        .table th {
            background-color: white;
        }
        .frm-new {
            background-color: #FFFFFF;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        body {
            background-color: lightcyan;
            background-size: cover;
            font-family: Arial, sans-serif;
            line-height: 1.6;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Edit User Modal -->
    <div class="modal fade" id="edit_user" role="dialog" aria-labelledby="editUserLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
                    <h4 class="modal-title" id="editUserLabel">Edit User</h4>
                </div>
                <div class="modal-body">
                    <form id="editUserForm" method="post" action="edit_user.php">
                        <div id="e_user">
                            <!-- User details will be loaded via AJAX here -->
                        </div>
                        <input type="hidden" id="edit_user_id" name="edit_user_id">
                        <div class="form-group">
                            <label for="edit_password">Password:</label>
                            <input type="password" class="form-control" id="edit_password" name="edit_password" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- User List Card -->
    <div class="card">
        <div class="card-header">
            <h3 class="card-title">List of Users</h3>
        </div>
        <div class="card-body">
            <table id="students" class="table table-hover table-bordered">
                <thead>
                    <tr>
                        <th style="width:20%">Username</th>
                        <th style="width:10%">Role</th>
                        <th style="width:10%"></th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    while($row = mysqli_fetch_assoc($users_result)) {
                    ?>
                    <tr>
                        <td><?php echo htmlspecialchars($row['username']); ?></td>
                        <td><?php echo htmlspecialchars($row['role']); ?></td>
                        <td class="action-buttons">
                            <button type="button" class="btn btn-primary btn-edit" data-id="<?php echo $row['id']; ?>" data-toggle="modal" data-target="#edit_user">Edit</button>
                            <form action="delete_user.php" method="POST" onsubmit="return confirm('Are you sure you want to delete this User?');" style="display:inline;">
                                <input type="hidden" name="id" value="<?php echo $row['id']; ?>">
                                <button type="submit" class="btn btn-danger">Delete</button>
                            </form>
                        </td>
                    </tr>
                    <?php
                    }
                    mysqli_close($conn);
                    ?>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Add New User Card -->
    <div class="card">
        <div class="card-body">
            <h3 class="card-title">Add New User</h3>
            <form method="post" action="add_user.php">
                <div class="form-group">
                    <label for="user">Create User:</label>
                    <input type="text" class="form-control" id="user" name="user" placeholder="Enter Username" required>
                </div>
                <div class="form-group">
                    <label for="pwd">Password:</label>
                    <input type="password" class="form-control" id="pwd" name="pwd" placeholder="Enter Password" required>
                </div>
                <div class="form-group">
                    <label for="type">User Type:</label>
                    <select class="form-control" name="type" id="type" required>
                        <option value="admin">Admin</option>
                        <option value="professor">Professor</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">Add User</button>
            </form>
        </div>
    </div>
    
    <div class="text-center">
        <a href="admin_dashboard.php" class="btn btn-secondary">Back to Dashboard</a>
    </div>
</div>

<script src="assets/js/jquery-3.5.1.min.js"></script>
<script src="assets/js/bootstrap.min.js"></script>
<script>
$(document).on('click', '.btn-edit', function() {
    var user_id = $(this).data('id');
    $.ajax({
        url: 'get_user.php',
        type: 'POST',
        data: {id: user_id},
        success: function(response) {
            $('#e_user').html(response);
            $('#edit_user_id').val(user_id);
        }
    });
});
</script>
</body>
</html>
