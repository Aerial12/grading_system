<?php
include 'config.php';

function compute_class_standing($quizzes, $academic_projects, $recitation, $performance_task, $activity_sheets, $assignments) {
    // Calculation for class standing
    $total = $quizzes + $academic_projects + $recitation + $performance_task + $activity_sheets + $assignments;
    $max_total = 355; // The maximum possible score
    $class_standing = ($total / $max_total) * 60 + 40;
    return round($class_standing, 2);
}

function compute_midterm_grade($pe, $cs, $me) {
    // Calculation for midterm grade
    return ($pe + 4 * $cs + 2 * $me) / 7;
}

function compute_final_grade($sfe, $cs, $fe) {
    // Calculation for final grade
    return ($sfe + 4 * $cs + 2 * $fe) / 7;
}

function compute_final_grade_average($mg, $tfg) {
    // Calculation for final grade average
    return ($mg + 2 * $tfg) / 3;
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $student_id = $_POST['student_id'];
    $period = $_POST['period'];
    $quizzes = $_POST['quizzes'];
    $academic_projects = $_POST['academic_projects'];
    $recitation = $_POST['recitation'];
    $performance_task = $_POST['performance_task'];
    $activity_sheets = $_POST['activity_sheets'];
    $assignments = $_POST['assignments'];

    // Compute class standing
    $class_standing = compute_class_standing($quizzes, $academic_projects, $recitation, $performance_task, $activity_sheets, $assignments);

    // Prepare and bind
    $stmt = $conn->prepare("INSERT INTO grades (student_id, period, quizzes, academic_projects, recitation, performance_task, activity_sheets, assignments, class_standing) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("issssssss", $student_id, $period, $quizzes, $academic_projects, $recitation, $performance_task, $activity_sheets, $assignments, $class_standing);

    if ($stmt->execute()) {
        echo "New grade added successfully with class standing of $class_standing.";
    } else {
        echo "Error: " . $stmt->error;
    }

    $stmt->close();
}

$students_sql = "SELECT id, CONCAT(lastname, ', ', firstname, ' ', middlename) as name FROM students";
$students_result = $conn->query($students_sql);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Grade</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <h2 class="mt-4">Add Grade</h2>
    <form method="post" action="<?php echo htmlspecialchars($_SERVER['PHP_SELF']);?>">
        <div class="form-group">
            <label for="student_id">Student</label>
            <select name="student_id" class="form-control" id="student_id" required>
                <option value="">Select Student</option>
                <?php
                while($row = $students_result->fetch_assoc()) {
                    echo "<option value='".$row['id']."'>".$row['name']."</option>";
                }
                ?>
            </select>
        </div>
        <div class="form-group">
            <label for="period">Period</label>
            <select name="period" class="form-control" id="period" required>
                <option value="PE">PE (Preliminary Examination)</option>
                <option value="ME">ME (Midterm Examination)</option>
                <option value="SFE">SFE (Semi-Final Examination)</option>
                <option value="FE">FE (Final Examination)</option>
            </select>
        </div>
        <div class="form-group">
            <label for="quizzes">Quizzes</label>
            <input type="number" step="0.01" name="quizzes" class="form-control" id="quizzes" required>
        </div>
        <div class="form-group">
            <label for="academic_projects">Academic Projects</label>
            <input type="number" step="0.01" name="academic_projects" class="form-control" id="academic_projects" required>
        </div>
        <div class="form-group">
            <label for="recitation">Recitation</label>
            <input type="number" step="0.01" name="recitation" class="form-control" id="recitation" required>
        </div>
        <div class="form-group">
            <label for="performance_task">Performance Task</label>
            <input type="number" step="0.01" name="performance_task" class="form-control" id="performance_task" required>
        </div>
        <div class="form-group">
            <label for="activity_sheets">Activity Sheets</label>
            <input type="number" step="0.01" name="activity_sheets" class="form-control" id="activity_sheets" required>
        </div>
        <div class="form-group">
            <label for="assignments">Assignments</label>
            <input type="number" step="0.01" name="assignments" class="form-control" id="assignments" required>
        </div>
        <button type="submit" class="btn btn-primary">Add Grade</button>
    </form>
</div>
</body>
</html>
