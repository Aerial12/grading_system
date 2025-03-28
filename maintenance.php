<?php
session_start();
if (!isset($_SESSION['username']) || $_SESSION['role'] !== 'admin') {
    header("Location: login.php");
    exit();
}
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Maintenance</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/css/bootstrap.min.css"> <!-- Use Bootstrap for better styling -->
    <style>
		body {
			background-color:#E0F7FA;
			}
        .container {
            margin-top: 50px;
        }
        .card {
            margin-bottom: 20px;
        }
        .btn-custom {
            background-color: #47768F;
            color: #FFFFFF;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="text-center">Maintenance Page</h2>
        
        <div class="card">
            <div class="card-header">
                <h4>Database Backup</h4>
            </div>
            <div class="card-body">
                <p>Regular backups are crucial to prevent data loss.</p>
                <button class="btn btn-custom" onclick="backupDatabase()">Backup Now</button>
            </div>
        </div>

        <div class="card">
            <div class="card-header">
                <h4>Update System</h4>
            </div>
            <div class="card-body">
                <p>Ensure your system is up to date with the latest features and security patches.</p>
                <button class="btn btn-custom" onclick="updateSystem()">Update Now</button>
            </div>
        </div>

        <div class="card">
            <div class="card-header">
                <h4>User Management</h4>
            </div>
            <div class="card-body">
                <p>Manage user accounts and permissions.</p>
                <button class="btn btn-custom" onclick="location.href='users.php'">Manage Users</button>
            </div>
        </div>

        <div class="text-center">
            <a href="admin_dashboard.php" class="btn btn-secondary">Back to Dashboard</a>
        </div>
    </div>

    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/js/bootstrap.bundle.min.js"></script>
    <script>
        function backupDatabase() {
            // Placeholder function for backing up the database
            alert('Database backup initiated!');
            // Actual backup logic should be implemented here
        }

        function updateSystem() {
            // Placeholder function for updating the system
            alert('System update initiated!');
            // Actual update logic should be implemented here
        }
    </script>
</body>
</html>
