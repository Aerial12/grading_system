<?php
include 'config.php';

$data = json_decode(file_get_contents("php://input"), true);
$student_id = $data['student_id'];
$subject = $data['subject'];

$sql = "INSERT INTO student_subjects (student_id, subject) VALUES ($student_id, '$subject')";
if ($conn->query($sql) === TRUE) {
    echo json_encode(['success' => true]);
} else {
    echo json_encode(['success' => false, 'error' => $conn->error]);
}
?>
