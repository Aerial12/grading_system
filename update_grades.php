<?php
include 'config.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $student_id = $_POST['student_id'];
    $period = $_POST['period'];
    $quizzes = $_POST['quizzes'];
    $academic_projects = $_POST['academic_projects'];
    $recitation = $_POST['recitation'];
    $performance_task = $_POST['performance_task'];
    $activity_sheets = $_POST['activity_sheets'];
    $assignments = $_POST['assignments'];

    // Update the grades in the database
    $sql = "UPDATE grades SET 
            quizzes = ?, 
            academic_projects = ?, 
            recitation = ?, 
            performance_task = ?, 
            activity_sheets = ?, 
            assignments = ?
            WHERE student_id = ? AND period = ?";
            
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("iiiiiiis", $quizzes, $academic_projects, $recitation, $performance_task, $activity_sheets, $assignments, $student_id, $period);

    if ($stmt->execute()) {
        header("Location: report.php?message=update_success");
    } else {
        header("Location: report.php?message=update_failure");
    }
    $stmt->close();
}
$conn->close();
?>
