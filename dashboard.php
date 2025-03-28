<?php
include 'config.php';



if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (isset($_POST['add_student'])) {
        $name = $_POST['name'];
        $sql = "INSERT INTO students (name) VALUES ('$name')";
        $conn->query($sql);
    } elseif (isset($_POST['add_grade'])) {
        $student_id = $_POST['student_id'];
        $period = $_POST['period'];
        $quizzes = $_POST['quizzes'];
        $academic_projects = $_POST['academic_projects'];
        $recitation = $_POST['recitation'];
        $performance_task = $_POST['performance_task'];
        $activity_sheets = $_POST['activity_sheets'];
        $assignments = $_POST['assignments'];

        $sql = "INSERT INTO grades (student_id, period, quizzes, academic_projects, recitation, performance_task, activity_sheets, assignments)
                VALUES ('$student_id', '$period', '$quizzes', '$academic_projects', '$recitation', '$performance_task', '$activity_sheets', '$assignments')";
        $conn->query($sql);
    }
}

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

$students_sql = "SELECT id, name FROM students";
$students_result = $conn->query($students_sql);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2>Welcome, <?php echo $_SESSION['username']; ?>!</h2>
        <a href="logout.php" class="btn btn-danger">Logout</a>

        <div class="row">
            <div class="col-md-4">
                <h3>Add Student</h3>
                <form method="post" action="<?php echo $_SERVER['PHP_SELF'];?>">
                    <input type="hidden" name="add_student" value="1">
                    Name: <input type="text" name="name" class="form-control" required><br>
                    <input type="submit" value="Add Student" class="btn btn-primary">
                </form>
            </div>

            <div class="col-md-4">
                <h3>Add Grade</h3>
                <form method="post" action="<?php echo $_SERVER['PHP_SELF'];?>">
                    <input type="hidden" name="add_grade" value="1">
                    Student: 
                    <select name="student_id" class="form-control">
                        <?php
                        while($row = $students_result->fetch_assoc()) {
                            echo "<option value='".$row['id']."'>".$row['name']."</option>";
                        }
                        ?>
                    </select><br>
                    Period: 
                    <select name="period" class="form-control">
                        <option value="PE">PE</option>
                        <option value="ME">ME</option>
                        <option value="SFE">SFE</option>
                        <option value="FE">FE</option>
                    </select><br>
                    Quizzes: <input type="text" name="quizzes" class="form-control"><br>
                    Academic Projects: <input type="text" name="academic_projects" class="form-control"><br>
                    Recitation: <input type="text" name="recitation" class="form-control"><br>
                    Performance Task: <input type="text" name="performance_task" class="form-control"><br>
                    Activity Sheets: <input type="text" name="activity_sheets" class="form-control"><br>
                    Assignments: <input type="text" name="assignments" class="form-control"><br>
                    <input type="submit" value="Add Grade" class="btn btn-primary">
                </form>
            </div>

            <div class="col-md-4">
                <h3>Compute Grades</h3>
                <form method="get" action="<?php echo $_SERVER['PHP_SELF'];?>">
                    Student: 
                    <select name="compute_student_id" class="form-control">
                        <?php
                        $students_result = $conn->query($students_sql);
                        while($row = $students_result->fetch_assoc()) {
                            echo "<option value='".$row['id']."'>".$row['name']."</option>";
                        }
                        ?>
                    </select><br>
                    <input type="submit" value="Compute" class="btn btn-success">
                </form>

                <?php
                if (isset($_GET['compute_student_id'])) {
                    $student_id = $_GET['compute_student_id'];
                    echo "<h4>Grades for student ID: $student_id</h4>";
                    echo "Midterm Grade: " . compute_midterm_grade($student_id) . "<br>";
                    echo "Final Grade: " . compute_final_grade($student_id) . "<br>";
                    echo "Final Grade Average: " . compute_final_grade_average($student_id) . "<br>";
                }
                ?>
            </div>
        </div>
    </div>

    <script src="assets/js/jquery-3.5.1.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/scripts.js"></script>
</body>
</html>
