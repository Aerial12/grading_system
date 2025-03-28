<?php
include 'config.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $student_id = $conn->real_escape_string($_POST['student_id']);
    $period = $conn->real_escape_string($_POST['period']);

    $sql = "UPDATE grades SET period = '$period' WHERE student_id = $student_id";

    if ($conn->query($sql) === TRUE) {
        header("Location: report.php?message=update_success");
    } else {
        echo "Error updating record: " . $conn->error;
    }
}

$conn->close();
?>
