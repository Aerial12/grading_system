<?php
include 'config.php';

if (isset($_GET['student_id'])) {
    $student_id = $_GET['student_id'];
    $sql = "UPDATE grades SET quizzes=0, academic_projects=0, recitation=0, performance_task=0, activity_sheets=0, assignments=0 WHERE student_id='$student_id'";
    
    if ($conn->query($sql) === TRUE) {
        header("Location: student_reports.php?message=delete_success");
    } else {
        echo "Error resetting grades: " . $conn->error;
    }
}
?>
