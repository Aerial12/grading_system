<?php
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);

if (isset($_SESSION['message'])) {
    $message = $_SESSION['message'];
    unset($_SESSION['message']); // Clear the message after displaying it
}
if (!isset($_SESSION['username']) || $_SESSION['role'] !== 'admin') {
    header("Location: login.php");
    exit();
}
include 'config.php';

function validate_grade($grade) {
    return min(100, max(0, $grade)); // Ensure grade is between 0 and 100
}

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
        $course = $_POST['course'];

        $stmt = $conn->prepare("INSERT INTO students (lastname, firstname, middlename, gender, birthdate, birthplace, address, father, mother, course) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        if (!$stmt) {
            echo "Error preparing statement: " . $conn->error;
        } else {
            $stmt->bind_param("ssssssssss", $lastname, $firstname, $middlename, $gender, $birthdate, $birthplace, $address, $father, $mother, $course);

            if ($stmt->execute() === TRUE) {
                echo "New student added successfully";
            } else {
                echo "Error: " . $stmt->error;
            }

            $stmt->close();
        }
    }

    if (isset($_POST['add_grade'])) {
        $student_id = $_POST['student_id'];
        $period = $_POST['period'];
        $quizzes = $_POST['quizzes'];
        $academic_projects = $_POST['academic_projects'];
        $recitation = $_POST['recitation'];
        $performance_task = $_POST['performance_task'];
        $activity_sheets = $_POST['activity_sheets'];
        $assignments = $_POST['assignments'];

        // Default exam values
        $prelim_exam = NULL;
        $midterm_exam = NULL;
        $semi_final_exam = NULL;
        $final_exam = NULL;

        if ($period == 'PE') {
            $prelim_exam = $_POST['prelim_exam'];
        } elseif ($period == 'ME') {
            $midterm_exam = $_POST['midterm_exam'];
        } elseif ($period == 'SFE') {
            $semi_final_exam = $_POST['semi_final_exam'];
        } elseif ($period == 'FE') {
            $final_exam = $_POST['final_exam'];
        }

        $stmt = $conn->prepare("INSERT INTO grades (student_id, period, quizzes, academic_projects, recitation, performance_task, activity_sheets, assignments, prelim_exam, midterm_exam, semi_final_exam, final_exam) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        if (!$stmt) {
            echo "Error preparing statement: " . $conn->error;
        } else {
            $stmt->bind_param("isssssssssss", $student_id, $period, $quizzes, $academic_projects, $recitation, $performance_task, $activity_sheets, $assignments, $prelim_exam, $midterm_exam, $semi_final_exam, $final_exam);

            if ($stmt->execute()) {
                echo "New grade added successfully";
            } else {
                echo "Error: " . $stmt->error;
            }

            $stmt->close();
        }
    }
}

$students_sql = "SELECT id, CONCAT(lastname, ', ', firstname, ' ', middlename) as name FROM students";
$students_result = $conn->query($students_sql);

function compute_class_standing($student_id) {
    global $conn;
    $sql = "SELECT * FROM grades WHERE student_id=$student_id";
    $result = $conn->query($sql);
    
    $CS = 0;

    while ($row = $result->fetch_assoc()) {
        $CS += $row['quizzes'] * 0.05 +
               $row['academic_projects'] * 0.10 +
               $row['recitation'] * 0.10 +
               $row['performance_task'] * 0.20 +
               $row['activity_sheets'] * 0.20 +
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
    if ($row = $result->fetch_assoc()) {
        $ME = $row['midterm_exam'];
    }

    return ($ME + 4 * $CS) / 5;
}

function compute_tentative_final_grade($student_id) {
    global $conn;
    $CS = compute_class_standing($student_id);
    $sql = "SELECT * FROM grades WHERE student_id=$student_id AND period='SFE'";
    $result = $conn->query($sql);

    $SFE = 0;
    if ($row = $result->fetch_assoc()) {
        $SFE = $row['semi_final_exam'];
    }

    return ($SFE + 4 * $CS) / 5;
}

function compute_final_grade($student_id) {
    global $conn;
    $TFG = compute_tentative_final_grade($student_id);
    $sql = "SELECT * FROM grades WHERE student_id=$student_id AND period='FE'";
    $result = $conn->query($sql);

    $FE = 0;
    if ($row = $result->fetch_assoc()) {
        $FE = $row['final_exam'];
    }

    return ($TFG + $FE) / 2;
}

function compute_final_grade_average($student_id) {
    $MG = compute_midterm_grade($student_id);
    $FG = compute_final_grade($student_id);

    return ($MG + 2 * $FG) / 3;
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
	<script src="assets/js/sweetalert2@11.js"></script>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <style>
        body {
            background-image:url("bg.jpg");
            background-size:cover;
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
           background-color:white;
            padding: 20px;
            border: 1px solid black;
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
        .center-text {
            text-align: center;
            margin-top: 20px;
            font-size: 3rem; 
            font-weight: bold; 
        }
        .add{
            text-align: Left;
            margin-top: 20px;
            font-size: 2rem; 
           
        }
        #addstu{
            background-color:#E0F7FA;
            border: 1px solid black;
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
					<script>
        Swal.fire({
            title: 'Welcome!',
            text: '<?php echo $message; ?>',
            icon: 'info',
            confirmButtonText: 'OK'
        });
		</script>
                    <ul class="nav flex-column">
                        <li class="nav-item"><a class="nav-link" href="report.php">Student Reports</a></li>
                        <li class="nav-item"><a class="nav-link" href="student_list.php">Student List</a></li>
                        <li class="nav-item"><a class="nav-link" href="academic.php">Academic Records</a></li>
                        <li class="nav-item"><a class="nav-link" href="maintenance.php">Maintenance</a></li>
						<a href="#" onclick="showHelp()">Help</a>
                        <li class="nav-item"><a class="nav-link" href="users.php">Users</a></li>
                        <li class="nav-item"><a class="nav-link" href="logout.php" class="btn btn-danger">Logout</a></li>
                    </ul>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-md-10">
                <div class="main-content">
                    <h2 class="center-text">Welcome, <?php echo $_SESSION['username']; ?>! (Admin)</h2>
    </br>
  
  
    <!-- Add Student Form -->
    <div class="row mb-3">
        <div class="col-md-12">
            <div class="card">
                <div class="card-body" id="addstu">
                    <h3 class="add">Add Student</h3>
                    <form id="addStudentForm" method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>" onsubmit="return confirm('Are you sure you want to add this student?');">
                        <input type="hidden" name="add_student" value="1">
                        <input type="text" name="lastname" class="form-control mb-2" placeholder="Last Name" required aria-label="Last Name">
                        <input type="text" name="firstname" class="form-control mb-2" placeholder="First Name" required aria-label="First Name">
                        <input type="text" name="middlename" class="form-control mb-2" placeholder="Middle Name" required aria-label="Middle Name">
                        <select name="gender" class="form-control mb-2" required aria-label="Gender">
                            <option value="">Select Gender</option>
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                        </select>
                        <input type="date" name="birthdate" class="form-control mb-2" required aria-label="Birthdate">
                        <input type="text" name="birthplace" class="form-control mb-2" placeholder="Birthplace" required aria-label="Birthplace">
                        <textarea name="address" class="form-control mb-2" placeholder="Address" required aria-label="Address"></textarea>
                        <input type="text" name="father" class="form-control mb-2" placeholder="Father's Name" required aria-label="Father's Name">
                        <input type="text" name="mother" class="form-control mb-2" placeholder="Mother's Name" required aria-label="Mother's Name">
                        <select name="course" class="form-control mb-2" required aria-label="Course">
                            <option value="">Select Course</option>
                            <option value="BSIT">BSIT</option>
                            <option value="BSCS">BSCS</option>
                        </select>
                        <input type="submit" value="Add Student" class="btn btn-primary btn-block">
                        <button type="button" class="btn btn-secondary btn-block" onclick="resetForm('addStudentForm')">Reset</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
	
    <!-- Help Modal -->
<div class="modal fade" id="helpModal" tabindex="-1" role="dialog" aria-labelledby="helpModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="helpModalLabel">Help</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p><strong>Add Student:</strong></p>
                <ul>
                    <li>Click on "Add Student" tab.</li>
                    <li>Fill out the student information form and click "Add Student".</li>
                </ul>
                <p><strong>Add Grade:</strong></p>
                <ul>
                    <li>Click on "Add Grade" tab.</li>
                    <li>Select a student and fill out the grade information form.</li>
                    <li>Click "Add Grade" to submit the form.</li>
                </ul>
                <p><strong>View Students:</strong></p>
                <ul>
                    <li>Click on "View Students" tab to see a list of students and their grades.</li>
                </ul>
                <p>If you have any further questions, please contact the system administrator.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

    <!-- Add Grade Form -->
    <div class="row mb-3">
        <div class="col-md-12">
            <div class="card">
                <div class="card-body" id="addstu">
                    <h3 class="add">Add Grade</h3>
                    <form id="addGradeForm" method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>" onsubmit="return confirm('Are you sure you want to add this grade?');">
                        <input type="hidden" name="add_grade" value="1">
                        <select name="student_id" class="form-control mb-2" required aria-label="Student">
                            <option value="">Select Student</option>
                            <?php
                            while ($row = $students_result->fetch_assoc()) {
                                echo "<option value='" . $row['id'] . "'>" . $row['name'] . "</option>";
                            }
                            ?>
                        </select>
                        <select name="period" id="period" class="form-control mb-2" required aria-label="Period" onchange="toggleExamFields()">
                            <option value="">Select Period</option>
                            <option value="PE">PE (Preliminary Examination)</option>
                            <option value="ME">ME (Midterm Examination)</option>
                            <option value="SFE">SFE (Semi-Final Examination)</option>
                            <option value="FE">FE (Final Examination)</option>
                        </select>
                        <div class="form-group">
                            <label for="quizzes">Quizzes</label>
                            <input type="number" step="0.01" name="quizzes" class="form-control mb-2" id="quizzes" required aria-label="Quizzes">
                        </div>
                        <div class="form-group">
                            <label for="academic_projects">Academic Projects</label>
                            <input type="number" step="0.01" name="academic_projects" class="form-control mb-2" id="academic_projects" required aria-label="Academic Projects">
                        </div>
                        <div class="form-group">
                            <label for="recitation">Recitation</label>
                            <input type="number" step="0.01" name="recitation" class="form-control mb-2" id="recitation" required aria-label="Recitation">
                        </div>
                        <div class="form-group">
                            <label for="performance_task">Performance Task</label>
                            <input type="number" step="0.01" name="performance_task" class="form-control mb-2" id="performance_task" required aria-label="Performance Task">
                        </div>
                        <div class="form-group">
                            <label for="activity_sheets">Activity Sheets</label>
                            <input type="number" step="0.01" name="activity_sheets" class="form-control mb-2" id="activity_sheets" required aria-label="Activity Sheets">
                        </div>
                        <div class="form-group">
                            <label for="assignments">Assignments</label>
                            <input type="number" step="0.01" name="assignments" class="form-control mb-2" id="assignments" required aria-label="Assignments">
                        </div>
                        <div class="form-group" id="prelim_exam_div" style="display: none;">
                            <label for="prelim_exam">Preliminary Exam</label>
                            <input type="number" step="0.01" name="prelim_exam" class="form-control mb-2" id="prelim_exam" aria-label="Preliminary Exam">
                        </div>
                        <div class="form-group" id="midterm_exam_div" style="display: none;">
                            <label for="midterm_exam">Midterm Exam</label>
                            <input type="number" step="0.01" name="midterm_exam" class="form-control mb-2" id="midterm_exam" aria-label="Midterm Exam">
                        </div>
                        <div class="form-group" id="semi_final_exam_div" style="display: none;">
                            <label for="semi_final_exam">Semi-Final Exam</label>
                            <input type="number" step="0.01" name="semi_final_exam" class="form-control mb-2" id="semi_final_exam" aria-label="Semi-Final Exam">
                        </div>
                        <div class="form-group" id="final_exam_div" style="display: none;">
                            <label for="final_exam">Final Exam</label>
                            <input type="number" step="0.01" name="final_exam" class="form-control mb-2" id="final_exam" aria-label="Final Exam">
                        </div>
                        <input type="submit" value="Add Grade" class="btn btn-primary btn-block">
                        <button type="button" class="btn btn-secondary btn-block" onclick="resetForm('addGradeForm')">Reset</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Compute Grades -->
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-body" id="addstu">
                    <h3 class="add">Compute Grades</h3>
                    <form method="get" action="<?php echo $_SERVER['PHP_SELF']; ?>">
                        <select name="compute_student_id" class="form-control mb-2" aria-label="Compute Student">
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


<script src="assets/js/bootstrap.bundle.min.js"></script>
   <script src="assets/js/jquery-3.5.1.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
	<script>
	function showHelp() {
    $('#helpModal').modal('show');
}
</script>
    <script>
        function toggleExamFields() {
            var period = document.getElementById("period").value;
            document.getElementById("prelim_exam_div").style.display = (period === 'PE') ? 'block' : 'none';
            document.getElementById("midterm_exam_div").style.display = (period === 'ME') ? 'block' : 'none';
            document.getElementById("semi_final_exam_div").style.display = (period === 'SFE') ? 'block' : 'none';
            document.getElementById("final_exam_div").style.display = (period === 'FE') ? 'block' : 'none';
        }

        function resetForm(formId) {
            document.getElementById(formId).reset();
            toggleExamFields(); // Ensure all exam fields are hidden after reset
        }
    </script>

</body>
</html>
