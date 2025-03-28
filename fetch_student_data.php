<?php
include 'config.php';

if (isset($_GET['student_id'])) {
    $student_id = $conn->real_escape_string($_GET['student_id']);

    $sql = "SELECT * FROM grades WHERE student_id = $student_id";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $data = $result->fetch_assoc();
        echo json_encode($data);
    } else {
        echo json_encode([]);
    }
}
?>
