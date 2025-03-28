<?php
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);

if (!isset($_SESSION['username']) || $_SESSION['role'] !== 'admin') {
    header("Location: login.php");
    exit();
}
include 'config.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (isset($_POST['add_student'])) {
        $lastname = $_POST['lastname'];
        $firstname = $_POST['firstname'];
        $middlename = $_POST['middlename'];
        $gender = $_POST['gender'];
        $birthdate = $_POST['birthdate'];
        $birthplace = $_POST['birthplace'];
        $address = $_POST['address'];
        $father = $_POST['father'];
        $mother = $_POST['mother'];
        $course_id = $_POST['course']; // Capture course ID

        $stmt = $conn->prepare("INSERT INTO students (lastname, firstname, middlename, gender, birthdate, birthplace, address, father, mother, course_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("sssssssssi", $lastname, $firstname, $middlename, $gender, $birthdate, $birthplace, $address, $father, $mother, $course_id);

        if ($stmt->execute() === TRUE) {
            echo "New student added successfully";
        } else {
            echo "Error: " . $stmt->error;
        }

        $stmt->close();
    }

    if (isset($_POST['add_grade'])) {
        $student_id = $_POST['student_id'];
        $course_id = $_POST['course_id']; // Capture course ID
        $period = $_POST['period'];
        $quizzes = $_POST['quizzes'];
        $academic_projects = $_POST['academic_projects'];
        $recitation = $_POST['recitation'];
        $performance_task = $_POST['performance_task'];
        $activity_sheets = $_POST['activity_sheets'];
        $assignments = $_POST['assignments'];
        $prelim_exam = $_POST['prelim_exam'];
        $midterm_exam = $_POST['midterm_exam'];
        $semi_final_exam = $_POST['semi_final_exam'];
        $final_exam = $_POST['final_exam'];

        $stmt = $conn->prepare("INSERT INTO grades (student_id, course_id, period, quizzes, academic_projects, recitation, performance_task, activity_sheets, assignments, prelim_exam, midterm_exam, semi_final_exam, final_exam) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("iisssssssssss", $student_id, $course_id, $period, $quizzes, $academic_projects, $recitation, $performance_task, $activity_sheets, $assignments, $prelim_exam, $midterm_exam, $semi_final_exam, $final_exam);

        if ($stmt->execute()) {
            echo "New grade added successfully";
        } else {
            echo "Error: " . $stmt->error;
        }

        $stmt->close();
    }
}

function compute_class_standing($student_id) {
    global $conn;
    $sql = "SELECT * FROM grades WHERE student_id=$student_id";
    $result = $conn->query($sql);

    $CS = 0;

    while($row = $result->fetch_assoc()) {
        $CS += $row['quizzes'] * 0.05 +
               $row['academic_projects'] * 0.10 +
               $row['recitation'] * 0.10 +
               $row['performance_task'] * 0.20 +
               $row['activity_sheets'] * 0.10 +
               $row['assignments'] * 0.10;
    }

    return $CS;
}

function compute_midterm_grade($student_id) {
    global $conn;
    $CS = compute_class_standing($student_id);
    $sql = "SELECT * FROM grades WHERE student_id=$student_id AND period='ME'";
    $result = $conn->query($sql);

    $ME = 0;
    if($row = $result->fetch_assoc()) {
        $ME = $row['quizzes'] + $row['academic_projects'] + $row['recitation'] + $row['performance_task'] + $row['activity_sheets'] + $row['assignments'];
    }

    return ($ME + 4 * $CS) / 5;
}

function compute_final_grade($student_id) {
    global $conn;
    $CS = compute_class_standing($student_id);
    $sql = "SELECT * FROM grades WHERE student_id=$student_id AND period IN ('SFE', 'FE')";
    $result = $conn->query($sql);

    $SFE = 0;
    $FE = 0;
    while($row = $result->fetch_assoc()) {
        if ($row['period'] == 'SFE') {
            $SFE = $row['quizzes'] + $row['academic_projects'] + $row['recitation'] + $row['performance_task'] + $row['activity_sheets'] + $row['assignments'];
        }
        if ($row['period'] == 'FE') {
            $FE = $row['quizzes'] + $row['academic_projects'] + $row['recitation'] + $row['performance_task'] + $row['activity_sheets'] + $row['assignments'];
        }
    }

    return ($SFE + 4 * $CS + 2 * $FE) / 7;
}

function compute_final_grade_average($student_id) {
    $MG = compute_midterm_grade($student_id);
    $TFG = compute_final_grade($student_id);

    return ($MG + 2 * $TFG) / 3;
}

$students_sql = "SELECT id, CONCAT(lastname, ', ', firstname, ' ', middlename) as name FROM students";
$students_result = $conn->query($students_sql);
$courses_sql = "SELECT id, course_name FROM courses"; // Fetching courses
$courses_result = $conn->query($courses_sql);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <style>
        body {
            background-color:#E0F7FA;
            font-family: Arial, sans-serif;
            line-height: 1.6;
        }
        .sidebar {
            height: 100%;
            width: 250px;
            position: fixed;
            z-index: 1;
            top: 0;
            left: 0;
            background-color: #343a40;
            overflow-x: hidden;
            padding-top: 20px;
            transition: 0.3s;
            color: #fff;
        }
        .sidebar h2 {
            text-align: center;
            margin-bottom: 30px;
        }
        .sidebar a {
            padding: 10px 15px;
            text-decoration: none;
            font-size: 18px;
            color: #fff;
            display: block;
            transition: 0.3s;
        }
        .sidebar a:hover {
            background-color: #495057;
        }
        .main-content {
            margin-left: 250px;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            margin-top: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .form-control {
            margin-bottom: 15px;
        }
        .btn-primary, .btn-danger, .btn-success, .btn-reset {
            margin-top: 10px;
        }
        .btn-primary:hover, .btn-danger:hover, .btn-success:hover, .btn-reset:hover {
            opacity: 0.8;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-2">
                <div class="sidebar">
                    <h2>Admin Panel</h2>
                    <ul class="nav flex-column">
                        <li class="nav-item"><a class="nav-link" href="report.php">Reports</a></li>
                        <li class="nav-item"><a class="nav-link" href="student_list.php">Student List</a></li>
                        <li class="nav-item"><a class="nav-link" href="academic.php">Academic Records</a></li>
                        <li class="nav-item"><a class="nav-link" href="maintenance.php">Maintenance</a></li>
                        <li class="nav-item"><a class="nav-link" href="users.php">Users</a></li>
                        <li class="nav-item"><a class="nav-link" href="logout.php" class="btn btn-danger">Logout</a></li>
                    </ul>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-md-10">
                <div class="main-content">
                    <h2>Welcome, <?php echo $_SESSION['username']; ?> (Admin)</h2>

                    <div class="row mt-3">
                        <div class="col-md-4">
                            <h3>Add Student</h3>
                            <form id="addStudentForm" method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>" onsubmit="return confirm('Are you sure you want to add this student?');">
                                <input type="hidden" name="add_student" value="1">
                                <input type="text" name="lastname" class="form-control" placeholder="Last Name" required aria-label="Last Name">
                                <input type="text" name="firstname" class="form-control" placeholder="First Name" required aria-label="First Name">
                                <input type="text" name="middlename" class="form-control" placeholder="Middle Name" required aria-label="Middle Name">
                                <select name="gender" class="form-control" required aria-label="Gender">
                                    <option value="">Select Gender</option>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                </select>
                                <input type="date" name="birthdate" class="form-control" required aria-label="Birthdate">
                                <input type="text" name="birthplace" class="form-control" placeholder="Birthplace" required aria-label="Birthplace">
                                <textarea name="address" class="form-control" placeholder="Address" required aria-label="Address"></textarea>
                                <input type="text" name="father" class="form-control" placeholder="Father's Name" required aria-label="Father's Name">
                                <input type="text" name="mother" class="form-control" placeholder="Mother's Name" required aria-label="Mother's Name">
                                <select name="course" class="form-control" required aria-label="Course">
                                    <option value="">Select Course</option>
                                    <?php
                                    while ($row = $courses_result->fetch_assoc()) {
                                        echo "<option value='" . $row['id'] . "'>" . $row['course_name'] . "</option>";
                                    }
                                    ?>
                                </select>
                                <input type="submit" value="Add Student" class="btn btn-primary btn-block">
                                <button type="button" class="btn btn-reset btn-block" onclick="resetForm('addStudentForm')">Reset</button>
                            </form>
                        </div>

                        <div class="col-md-4">
                            <h3>Add Grade</h3>
                            <form id="addGradeForm" method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>" onsubmit="return confirm('Are you sure you want to add this grade?');">
                                <input type="hidden" name="add_grade" value="1">
                                <select name="student_id" class="form-control" required aria-label="Student">
                                    <option value="">Select Student</option>
                                    <?php
                                    while ($row = $students_result->fetch_assoc()) {
                                        echo "<option value='" . $row['id'] . "'>" . $row['name'] . "</option>";
                                    }
                                    ?>
                                </select>
                                <select name="course_id" class="form-control" required aria-label="Course">
                                    <option value="">Select Course</option>
                                    <?php
                                    $courses_result->data_seek(0); // Reset result pointer
                                    while ($row = $courses_result->fetch_assoc()) {
                                        echo "<option value='" . $row['id'] . "'>" . $row['course_name'] . "</option>";
                                    }
                                    ?>
                                </select>
                                <select name="period" class="form-control" required aria-label="Period" id="period" onchange="showExamFields()">
                                    <option value="">Select Period</option>
                                    <option value="PE">PE (Preliminary Examination)</option>
                                    <option value="ME">ME (Midterm Examination)</option>
                                    <option value="SFE">SFE (Semi-Final Examination)</option>
                                    <option value="FE">FE (Final Examination)</option>
                                </select>
                                <div class="form-group">
                                    <label for="quizzes">Quizzes</label>
                                    <input type="number" step="0.01" name="quizzes" class="form-control" id="quizzes" required aria-label="Quizzes">
                                </div>
                                <div class="form-group">
                                    <label for="academic_projects">Academic Projects</label>
                                    <input type="number" step="0.01" name="academic_projects" class="form-control" id="academic_projects" required aria-label="Academic Projects">
                                </div>
                                <div class="form-group">
                                    <label for="recitation">Recitation</label>
                                    <input type="number" step="0.01" name="recitation" class="form-control" id="recitation" required aria-label="Recitation">
                                </div>
                                <div class="form-group">
                                    <label for="performance_task">Performance Task</label>
                                    <input type="number" step="0.01" name="performance_task" class="form-control" id="performance_task" required aria-label="Performance Task">
                                </div>
                                <div class="form-group">
                                    <label for="activity_sheets">Activity Sheets</label>
                                    <input type="number" step="0.01" name="activity_sheets" class="form-control" id="activity_sheets" required aria-label="Activity Sheets">
                                </div>
                                <div class="form-group">
                                    <label for="assignments">Assignments</label>
                                    <input type="number" step="0.01" name="assignments" class="form-control" id="assignments" required aria-label="Assignments">
                                </div>
                                <div id="examFields"></div>
                                <input type="submit" value="Add Grade" class="btn btn-primary btn-block">
                                <button type="button" class="btn btn-reset btn-block" onclick="resetForm('addGradeForm')">Reset</button>
                            </form>
                        </div>

                        <div class="col-md-4">
                            <h3>Compute Grades</h3>
                            <form method="get" action="<?php echo $_SERVER['PHP_SELF']; ?>">
                                <select name="compute_student_id" class="form-control" aria-label="Compute Student">
                                    <option value="">Select Student</option>
                                    <?php
                                    $students_result->data_seek(0); // Reset result pointer

                                    while ($row = $students_result->fetch_assoc()) {
                                        echo "<option value='" . $row['id'] . "'>" . $row['name'] . "</option>";
                                    }
                                    ?>
                                </select>
                                <input type="submit" value="Compute" class="btn btn-success btn-block mt-3">
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
            </div>
        </div>
    </div>

    <script src="assets/js/jquery-3.5.1.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script>
        function resetForm(formId) {
            document.getElementById(formId).reset();
        }
    </script>
</body>
</html>
