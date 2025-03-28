<?php
include 'db_connection.php';

$id = $_POST['id'];
$quizzes = $_POST['quizzes'];
$academic_projects = $_POST['academic_projects'];
$recitation = $_POST['recitation'];
$performance_task = $_POST['performance_task'];
$activity_sheets = $_POST['activity_sheets'];
$assignments = $_POST['assignments'];
$prelim_exam = $_POST['preliminary_exam'];
$midterm_exam = $_POST['midterm_exam'];
$semi_final_exam = $_POST['semifinal_exam'];
$final_exam = $_POST['final_exam'];
$exam_score = $_POST['exam_score'];
$remarks = $_POST['remarks'];

try {
    $stmt = $pdo->prepare("UPDATE grades SET quizzes = :quizzes, academic_projects = :academic_projects, recitation = :recitation, performance_task = :performance_task, activity_sheets = :activity_sheets, assignments = :assignments, prelim_exam = :prelim_exam, midterm_exam = :midterm_exam, semi_final_exam = :semi_final_exam, final_exam = :final_exam, exam_score = :exam_score, remarks = :remarks WHERE id = :id");
    $stmt->execute([
        'quizzes' => $quizzes,
        'academic_projects' => $academic_projects,
        'recitation' => $recitation,
        'performance_task' => $performance_task,
        'activity_sheets' => $activity_sheets,
        'assignments' => $assignments,
        'prelim_exam' => $prelim_exam,
        'midterm_exam' => $midterm_exam,
        'semi_final_exam' => $semi_final_exam,
        'final_exam' => $final_exam,
        'exam_score' => $exam_score,
        'remarks' => $remarks,
        'id' => $id
    ]);
    echo "Record updated successfully";
} catch(PDOException $e) {
    echo "Error: " . $e->getMessage();
}
?>
