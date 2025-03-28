<?php
include 'config.php';

// Fetch student information along with their grades from the database
$sql = "SELECT students.id as student_id, students.lastname, students.firstname, students.middlename, 
        grades.id as grade_id, grades.period, grades.quizzes, grades.academic_projects, grades.recitation, 
        grades.performance_task, grades.activity_sheets, grades.assignments
        FROM students
        LEFT JOIN grades ON students.id = grades.student_id";
$result = $conn->query($sql);

if (!$result) {
    die("Query failed: " . $conn->error);
}

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
    <title>Student Reports</title>
    <link rel="stylesheet" href="assets/css/all.min.css">
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <style>
        body {
            background-color: #E0F7FA;
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
        }
        .container {
            max-width: 100%;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            table-layout: fixed;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
            word-wrap: break-word;
        }
        th {
            background-color: #f2f2f2;
            font-weight: bold;
        }
        .print-icon {
            display: block;
            width: fit-content;
            margin: 20px auto;
            text-decoration: none;
            color: #333;
        }
        .print-icon i {
            margin-right: 5px;
        }
        .btn-action {
            margin: 5px 0;
        }
        .alert {
            margin-top: 20px;
        }
        @media print {
            .container {
                box-shadow: none; /* Remove box shadow on print */
            }
            .print-icon {
                display: none; /* Hide print icon on print */
            }
            .btn-action {
                display: none; /* Hide action buttons on print */
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                table-layout: auto; /* Adjust table layout for print */
            }
            th, td {
                padding: 10px;
                text-align: center;
            }
            th {
                background-color: #f2f2f2;
                font-weight: bold;
            }
            td {
                border: none;
                border-bottom: 1px solid #ddd;
                position: relative;
                padding-left: 50%;
                word-wrap: break-word;
            }
            td:before {
                position: absolute;
                top: 10px;
                left: 10px;
                width: 45%;
                padding-right: 10px;
                white-space: nowrap;
                content: attr(data-label);
            }
        }
        @page {
            size: landscape;
            margin: 20mm 10mm 10mm 10mm;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Student Reports</h1>
        <?php if (isset($_GET['message']) && $_GET['message'] == 'update_success'): ?>
            <div class="alert alert-success">Score updated successfully!</div>
        <?php endif; ?>
        <?php if (isset($_GET['message']) && $_GET['message'] == 'delete_success'): ?>
            <div class="alert alert-success">Score deleted successfully!</div>
        <?php endif; ?>
        <a href="#" onclick="window.print();" class="print-icon"><i class="fas fa-print"></i> Print Report</a>
        <div class="table-responsive">
            <table class="table table-bordered table-striped">
                <thead class="thead-dark">
                    <tr>
                        <th>Student ID</th>
                        <th>Last Name</th>
                        <th>First Name</th>
                        <th>Middle Name</th>
                        <th>Period</th>
                        <th>Quizzes</th>
                        <th>Academic Projects</th>
                        <th>Recitation</th>
                        <th>Performance Task</th>
                        <th>Activity Sheets</th>
                        <th>Assignments</th>
                        <th>Midterm Grade</th>
                        <th>Tentative Final Grade</th>
                        <th>Final Grade Average</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <?php while ($row = $result->fetch_assoc()): ?>
                        <?php
                        $student_id = $row['student_id'];
                        $midterm_grade = compute_midterm_grade($student_id, $conn);
                        $tentative_final_grade = compute_final_grade($student_id, $conn);
                        $final_grade_average = compute_final_grade_average($student_id, $conn);
                        ?>
                        <tr>
                            <td><?php echo htmlspecialchars($row['student_id']); ?></td>
                            <td><?php echo htmlspecialchars($row['lastname']); ?></td>
                            <td><?php echo htmlspecialchars($row['firstname']); ?></td>
                            <td><?php echo htmlspecialchars($row['middlename']); ?></td>
                            <td><?php echo htmlspecialchars($row['period']); ?></td>
                            <td><?php echo htmlspecialchars($row['quizzes']); ?></td>
                            <td><?php echo htmlspecialchars($row['academic_projects']); ?></td>
                            <td><?php echo htmlspecialchars($row['recitation']); ?></td>
                            <td><?php echo htmlspecialchars($row['performance_task']); ?></td>
                            <td><?php echo htmlspecialchars($row['activity_sheets']); ?></td>
                            <td><?php echo htmlspecialchars($row['assignments']); ?></td>
                            <td><?php echo htmlspecialchars(number_format($midterm_grade, 2)); ?></td>
                            <td><?php echo htmlspecialchars(number_format($tentative_final_grade, 2)); ?></td>
                            <td><?php echo htmlspecialchars(number_format($final_grade_average, 2)); ?></td>
                            <td>
                                <button class="btn btn-primary btn-action" data-toggle="modal" data-target="#editModal" data-student-id="<?php echo $student_id; ?>">Edit</button>
                                <a href="reset_student.php?student_id=<?php echo $student_id; ?>" class="btn btn-danger btn-action" onclick="return confirm('Are you sure you want to reset this student\'s grades?');">Reset</a>
                            </td>
                        </tr>
                    <?php endwhile; ?>
                </tbody>
            </table>
        </div>
        <div class="text-center">
            <a href="admin_dashboard.php" class="btn btn-secondary">Back to Dashboard</a>
        </div>
    </div>

    <!-- Edit Modal -->
    <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editModalLabel">Edit Grades</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form action="update_grades.php" method="POST">
                        <input type="hidden" name="student_id" id="editStudentId">
                        <div class="form-group">
                            <label for="period">Period</label>
                            <select name="period" id="period" class="form-control" required>
                                <option value="Prelim">Prelim</option>
                                <option value="Midterm">Midterm</option>
                                <option value="Semi Final">Semi Final</option>
                                <option value="Final">Final</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="quizzes">Quizzes</label>
                            <input type="number" name="quizzes" id="quizzes" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="academic_projects">Academic Projects</label>
                            <input type="number" name="academic_projects" id="academic_projects" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="recitation">Recitation</label>
                            <input type="number" name="recitation" id="recitation" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="performance_task">Performance Task</label>
                            <input type="number" name="performance_task" id="performance_task" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="activity_sheets">Activity Sheets</label>
                            <input type="number" name="activity_sheets" id="activity_sheets" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="assignments">Assignments</label>
                            <input type="number" name="assignments" id="assignments" class="form-control" required>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Save changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/js/bootstrap.bundle.min.js"></script>
    <script>
        $('#editModal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget);
            var studentId = button.data('student-id');
            var modal = $(this);
            modal.find('#editStudentId').val(studentId);
        });
    </script>
</body>
</html>
