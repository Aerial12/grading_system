<?php
include 'config.php';

function compute_midterm_grade($student_id) {
    global $conn;
    $sql = "SELECT * FROM grades WHERE student_id=$student_id AND period IN ('PE', 'ME')";
    $result = $conn->query($sql);
    
    $PE = 0;
    $ME = 0;
    $CS = 0;

    while($row = $result->fetch_assoc()) {
        if ($row['period'] == 'PE') {
            $PE = $row['quizzes'] + $row['academic_projects'] + $row['recitation'] + $row['performance_task'] + $row['activity_sheets'] + $row['assignments'];
        }
        if ($row['period'] == 'ME') {
            $ME = $row['quizzes'] + $row['academic_projects'] + $row['recitation'] + $row['performance_task'] + $row['activity_sheets'] + $row['assignments'];
        }
        $CS += $row['quizzes'] + $row['academic_projects'] + $row['recitation'] + $row['performance_task'] + $row['activity_sheets'] + $row['assignments'];
    }

    return ($PE + 4 * $CS + 2 * $ME) / 7;
}

function compute_final_grade($student_id) {
    global $conn;
    $sql = "SELECT * FROM grades WHERE student_id=$student_id AND period IN ('SFE', 'FE')";
    $result = $conn->query($sql);

    $SFE = 0;
    $FE = 0;
    $CS = 0;

    while($row = $result->fetch_assoc()) {
        if ($row['period'] == 'SFE') {
            $SFE = $row['quizzes'] + $row['academic_projects'] + $row['recitation'] + $row['performance_task'] + $row['activity_sheets'] + $row['assignments'];
        }
        if ($row['period'] == 'FE') {
            $FE = $row['quizzes'] + $row['academic_projects'] + $row['recitation'] + $row['performance_task'] + $row['activity_sheets'] + $row['assignments'];
        }
        $CS += $row['quizzes'] + $row['academic_projects'] + $row['recitation'] + $row['performance_task'] + $row['activity_sheets'] + $row['assignments'];
    }

    return ($SFE + 4 * $CS + 2 * $FE) / 7;
}

function compute_final_grade_average($student_id) {
    $MG = compute_midterm_grade($student_id);
    $TFG = compute_final_grade($student_id);
    
    return ($MG + 2 * $TFG) / 3;
}

// Example usage
$student_id = 1; // Assuming we want to compute grades for student with ID 1
echo "Midterm Grade: " . compute_midterm_grade($student_id) . "<br>";
echo "Final Grade: " . compute_final_grade($student_id) . "<br>";
echo "Final Grade Average: " . compute_final_grade_average($student_id) . "<br>";
?>
