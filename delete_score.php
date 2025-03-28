<?php
include 'config.php';

if (isset($_GET['id'])) {
    $grade_id = $_GET['id'];

    $sql = "DELETE FROM grades WHERE id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $grade_id);

    if ($stmt->execute()) {
        header("Location: student_reports.php?message=delete_success");
    } else {
        echo "Error: " . $stmt->error;
    }
}
?>
