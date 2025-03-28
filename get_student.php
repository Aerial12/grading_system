<?php
include 'config.php';

if (isset($_GET['id'])) {
    $student_id = $_GET['id'];

    $sql = "SELECT * FROM students WHERE id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $student_id);
    $stmt->execute();
    $result = $stmt->get_result();
    $student = $result->fetch_assoc();
    $stmt->close();

    echo json_encode($student);
} else {
    echo json_encode(['error' => 'Invalid request.']);
}
?>
