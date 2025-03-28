<?php
// Refactored Grade Computation Functions
if (!function_exists('compute_grade')) {
    function compute_grade($student_id, $periods) {
        global $conn;
        $placeholders = implode(',', array_fill(0, count($periods), '?'));
        $types = str_repeat('s', count($periods));
        $sql = "SELECT * FROM grades WHERE student_id=? AND period IN ($placeholders)";
        $stmt = $conn->prepare($sql);
        
        $params = array_merge([$student_id], $periods);
        $stmt->bind_param("i" . $types, ...$params);
        
        $stmt->execute();
        $result = $stmt->get_result();

        $total_score = array_fill_keys($periods, 0);
        $CS = 0;

        while ($row = $result->fetch_assoc()) {
            $period = $row['period'];
            $score = $row['quizzes'] + $row['academic_projects'] + $row['recitation'] + $row['performance_task'] + $row['activity_sheets'] + $row['assignments'];
            $total_score[$period] = $score;
            $CS += $score;
        }

        $stmt->close();
        return array_merge($total_score, ['CS' => $CS]);
    }
}

if (!function_exists('compute_midterm_grade')) {
    function compute_midterm_grade($student_id) {
        $scores = compute_grade($student_id, ['PE', 'ME']);
        return ($scores['PE'] + 4 * $scores['CS'] + 2 * $scores['ME']) / 7;
    }
}

if (!function_exists('compute_final_grade')) {
    function compute_final_grade($student_id) {
        $scores = compute_grade($student_id, ['SFE', 'FE']);
        return ($scores['SFE'] + 4 * $scores['CS'] + 2 * $scores['FE']) / 7;
    }
}

if (!function_exists('compute_final_grade_average')) {
    function compute_final_grade_average($student_id) {
        $MG = compute_midterm_grade($student_id);
        $TFG = compute_final_grade($student_id);
        return ($MG + 2 * $TFG) / 3;
    }
}

?>