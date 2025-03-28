<?php
include 'config.php';

// update_status.php
include 'config.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $student_id = $_POST['student_id'];
    $status = $_POST['status'];

    $stmt = $conn->prepare("UPDATE students SET status = ? WHERE id = ?");
    $stmt->bind_param("si", $status, $student_id);
    $stmt->execute();
    $stmt->close();

    header("Location: report.php?message=update_success");
    exit();
}

?>
