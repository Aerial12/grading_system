<?php
include 'config.php';

$password_admin = password_hash("Seyfert", PASSWORD_BCRYPT);
$password_professor = password_hash("aerial", PASSWORD_BCRYPT);

$sql_admin = "INSERT INTO users (username, password, role) VALUES ('admin', '$password_admin', 'admin')";
$sql_professor = "INSERT INTO users (username, password, role) VALUES ('professor', '$password_professor', 'professor')";

if ($conn->query($sql_admin) === TRUE && $conn->query($sql_professor) === TRUE) {
    echo "Admin and Professor users created successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}
?>
