<?php
include 'config.php';

$search_query = '';
$remarks_query = '';

if (isset($_GET['search'])) {
    $search_query = $conn->real_escape_string($_GET['search']);
}

if (isset($_GET['remarks']) && !empty($_GET['remarks'])) {
    $remarks_query = $conn->real_escape_string($_GET['remarks']);
}

// Fetch student information along with their grades from the database
$sql = "SELECT students.id as student_id, students.lastname, students.firstname, students.middlename, 
        grades.id as grade_id, grades.period, grades.quizzes, grades.academic_projects, grades.recitation, 
        grades.performance_task, grades.activity_sheets, grades.assignments, grades.prelim_exam, grades.midterm_exam, grades.semi_final_exam, grades.final_exam, grades.remarks, students.status
        FROM students
        LEFT JOIN grades ON students.id = grades.student_id
        WHERE (students.lastname LIKE '%$search_query%' OR students.firstname LIKE '%$search_query%' OR students.middlename LIKE '%$search_query%')";

if (!empty($remarks_query)) {
    $sql .= " AND grades.remarks = '$remarks_query'";
}

$result = $conn->query($sql);

if (!$result) {
    die("Query failed: " . $conn->error);
}


if (isset($_POST['add_grade'])) {
    // Capture form data
    $student_id = $_POST['student_id'];
    $course_id = $_POST['course_id'];
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
    
    // Default to 'enrolled' if 'status' is not set
    $status = isset($_POST['status']) ? $_POST['status'] : 'enrolled';

    // Calculate average grade
    $total_score = $quizzes + $academic_projects + $recitation + $performance_task + $activity_sheets + $assignments + $prelim_exam + $midterm_exam + $semi_final_exam + $final_exam;
    $average_grade = $total_score / 10; // Assuming equal weight for each component

    // Determine remarks based on average grade and status
    if ($status == 'dropped') {
        $remarks = 'Dropped';
    } else {
        if ($average_grade < 75) {
            $remarks = 'Failed';
        } else {
            $remarks = 'Passed';
        }
    }

    // Insert into database
    $stmt = $conn->prepare("INSERT INTO grades (student_id, course_id, period, quizzes, academic_projects, recitation, performance_task, activity_sheets, assignments, prelim_exam, midterm_exam, semi_final_exam, final_exam, remarks, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("iisssssssssssss", $student_id, $course_id, $period, $quizzes, $academic_projects, $recitation, $performance_task, $activity_sheets, $assignments, $prelim_exam, $midterm_exam, $semi_final_exam, $final_exam, $remarks, $status);
    $stmt->execute();
    $stmt->close();
}

    


$students_sql = "SELECT id, CONCAT(lastname, ', ', firstname, ' ', middlename) as name FROM students";
$students_result = $conn->query($students_sql);

function compute_class_standing($student_id) {
    global $conn;
    $sql = "SELECT * FROM grades WHERE student_id=$student_id";
    $result = $conn->query($sql);
    
    $CS = 0;

    while ($row = $result->fetch_assoc()) {
        $CS += min($row['quizzes'], 99) * 0.05 +
               min($row['academic_projects'], 99) * 0.10 +
               min($row['recitation'], 99) * 0.10 +
               min($row['performance_task'], 99) * 0.20 +
               min($row['activity_sheets'], 99) * 0.20 +
               min($row['assignments'], 99) * 0.10;
    }

    return min($CS, 99);
}

function compute_midterm_grade($student_id) {
    global $conn;
    $CS = compute_class_standing($student_id);
    $sql = "SELECT * FROM grades WHERE student_id=$student_id AND period='ME'";
    $result = $conn->query($sql);

    $ME = 0;
    if ($row = $result->fetch_assoc()) {
        $ME = min($row['midterm_exam'], 99);
    }

    return min(($ME + 4 * $CS) / 5, 99);
}

function compute_tentative_final_grade($student_id) {
    global $conn;
    $CS = compute_class_standing($student_id);
    $sql = "SELECT * FROM grades WHERE student_id=$student_id AND period='SFE'";
    $result = $conn->query($sql);

    $SFE = 0;
    if ($row = $result->fetch_assoc()) {
        $SFE = min($row['semi_final_exam'], 99);
    }

    return min(($SFE + 4 * $CS) / 5, 99);
}

function compute_final_grade($student_id) {
    global $conn;
    $TFG = compute_tentative_final_grade($student_id);
    $sql = "SELECT * FROM grades WHERE student_id=$student_id AND period='FE'";
    $result = $conn->query($sql);

    $FE = 0;
    if ($row = $result->fetch_assoc()) {
        $FE = min($row['final_exam'], 99);
    }

    return min(($TFG + $FE) / 2, 99);
}

function compute_final_grade_average($student_id) {
    $MG = compute_midterm_grade($student_id);
    $FG = compute_final_grade($student_id);

    return min(($MG + 2 * $FG) / 3, 99);
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
        }

        .container {
            max-width: 100%;
            padding: 10px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 5rem;
            font-weight: bold;
            text-shadow: 2px 2px #D8E2E7;
        }

        .table-responsive {
            margin-top: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            table-layout: auto;
        }

        th {
            background-color: #1F293A;
            font-weight: bold;
            border-color: 2px solid #4F5152;
            color: white;
        }

        th, td {
            padding: 12px;
            border: 2px solid #ddd;
            text-align: center;
            word-wrap: break-word;
        }

        tr:nth-child(odd) {
            background-color: #EFF9FA;
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

        @media screen and (max-width: 767px) {
            table, thead, tbody, th, td, tr {
                display: block;
            }
            
            th {
                position: absolute;
                top: -9999px;
                left: -9999px;
            }
            
            tr {
                margin: 0 0 1rem 0;
            }
            
            td {
                border: none;
                border-bottom: 1px solid #ddd;
                position: relative;
                padding-left: 50%;
            }
            
            td:before {
                position: absolute;
                top: 6px;
                left: 6px;
                width: 45%;
                padding-right: 10px;
                white-space: nowrap;
                content: attr(data-label);
            }
        }

        @media print {
            .container {
                box-shadow: none;
            }

            .print-icon {
                display: none;
            }

            .btn-action {
                display: none;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                table-layout: auto;
            }

            th, td {
                padding: 10px;
                text-align: center;
            }

            th {
                background-color: #1F293A;
                font-weight: bold;
                border-bottom: 2px solid #4F5152;
            }

            td {
                border: none;
                border-bottom: 2px solid #ddd;
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

            .print-button, .action-buttons, #search, #dashboard, .actionsT {
                display: none;
            }

            @page {
                size: landscape;
                margin: 20mm 10mm 10mm 10mm;
            }
        }

        .action-buttons form {
            display: inline-block;
        }

        .action-buttons button {
            margin-right: 5px;
        }
		.header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
            background-color: #ffffff; /* White background */
            color: #000000; /* Black text */
            margin-bottom: 20px;
            font-family: Algerian, sans-serif; /* Algerian font */
        }
		 .header img {
            max-height: 1000px;
            border-radius: 50%;
            padding: 5px;
            width: 100px;
            margin: 0 200px; /* Spacing around images */
        }
    </style>
</head>
<body>
<div class="header">
    <div>
        <img src="image/ccs.jpg" alt="Left Image">
    </div>
    <div>
        <h3>UNIVERSITY OF LUZON</h3>
        <h4>College of Computer Studies</h4>
    </div>
    <div>
        <img src="image/cs.jpg" alt="Right Image">
    </div>
</div>
    <div class="container">
	
        <h1>Student Reports</h1>
        <form method="GET" action="" id="search">
            <div class="input-group mb-3">
                <input type="text" class="form-control" name="search" placeholder="Search by name" value="<?php echo htmlspecialchars($search_query); ?>">
                <div class="input-group-append">
                    <button class="btn btn-primary" type="submit">Search</button>
                </div>
            </div>
            
            <div class="input-group mb-3">
                <select class="form-control" name="remarks">
                    <option value="">Filter by Remarks</option>
                    <option value="Passed"<?php if (isset($_GET['remarks']) && $_GET['remarks'] == 'Passed') echo ' selected'; ?>>Passed</option>
                    <option value="Failed"<?php if (isset($_GET['remarks']) && $_GET['remarks'] == 'Failed') echo ' selected'; ?>>Failed</option>
                    <option value="Dropped"<?php if (isset($_GET['status']) && $_GET['status'] == 'Dropped') echo ' selected'; ?>>Dropped</option>
                </select>
                <div class="input-group-append">
                    <button class="btn btn-primary" type="submit">Filter</button>
                </div>
            </div>
        </form>

        <?php if (isset($_GET['message']) && $_GET['message'] == 'update_success'): ?>
            <div class="alert alert-success">updated successfully!</div>
        <?php endif; ?>
        <?php if (isset($_GET['message']) && $_GET['message'] == 'delete_success'): ?>
            <div class="alert alert-success"> deleted successfully!</div>
        <?php endif; ?>
        <a href="#" onclick="window.print();" class="print-icon"><i class="fas fa-print"></i> Print Report</a>
        <div class="table-responsive">
            <table class="table">
                <thead>
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
                        <th>Preliminary Exam</th>
                        <th>Midterm Exam</th>
                        <th>Semi-final Exam</th>
                        <th>Final Exam</th>
                        <th>Midterm Grade</th>
                        <th>Tentative Final Grade</th>
                        <th>Final Grade Average</th>
                        <th>Remarks</th>
						<th>Status</th>
						
                        <th class="actionsT">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <?php while ($row = $result->fetch_assoc()): ?>
                        <?php
                        $student_id = $row['student_id'];
                        $midterm_grade = compute_midterm_grade($student_id);
                        $tentative_final_grade = compute_final_grade($student_id);
                        $final_grade_average = compute_final_grade_average($student_id);
                        ?>
                        <tr>
                            <td><?php echo htmlspecialchars($row['student_id']); ?></td>
                            <td><?php echo htmlspecialchars($row['lastname']); ?></td>
                            <td><?php echo htmlspecialchars($row['firstname']); ?></td>
                            <td><?php echo htmlspecialchars($row['middlename']); ?></td>
                            <td data-label="Period">
    <form method="POST" action="update_status.php" style="display:inline;">
    <input type="hidden" name="student_id" value="<?php echo $student_id; ?>">
    <select name="Period" class="form-control periodDropdown" onchange="updatePeriodDropdown(this)">
        <option value="PE" <?php if ($row['period'] == 'PE') echo 'selected'; ?>>PE</option>
        <option value="ME" <?php if ($row['period'] == 'ME') echo 'selected'; ?>>ME</option>
        <option value="SFE" <?php if ($row['period'] == 'SFE') echo 'selected'; ?>>SFE</option>
        <option value="FE" <?php if ($row['period'] == 'FE') echo 'selected'; ?>>FE</option>
    </select>
</form>

                            <td><?php echo htmlspecialchars($row['quizzes']); ?></td>
                            <td><?php echo htmlspecialchars($row['academic_projects']); ?></td>
                            <td><?php echo htmlspecialchars($row['recitation']); ?></td>
                            <td><?php echo htmlspecialchars($row['performance_task']); ?></td>
                            <td><?php echo htmlspecialchars($row['activity_sheets']); ?></td>
                            <td><?php echo htmlspecialchars($row['assignments']); ?></td>
                            <td><?php echo htmlspecialchars($row['prelim_exam']); ?></td>
                            <td><?php echo htmlspecialchars($row['midterm_exam']); ?></td>
                            <td><?php echo htmlspecialchars($row['semi_final_exam']); ?></td>
                            <td><?php echo htmlspecialchars($row['final_exam']); ?></td>
                            <td><?php echo htmlspecialchars(number_format($midterm_grade, 2)); ?></td>
                            <td><?php echo htmlspecialchars(number_format($tentative_final_grade, 2)); ?></td>
                            <td><?php echo htmlspecialchars(number_format($final_grade_average, 2)); ?></td>
                            <td class="remarks"><?php echo htmlspecialchars($row['remarks']); ?></td>
							<td data-label="Status">
    <form method="POST" action="update_status.php" style="display:inline;">
        <input type="hidden" name="student_id" value="<?php echo $student_id; ?>">
        <select name="status" class="form-control" onchange="this.form.submit()">
            <option value="enrolled" <?php if ($row['status'] == 'enrolled') echo 'selected'; ?>>Enrolled</option>
            <option value="dropped" <?php if ($row['status'] == 'dropped') echo 'selected'; ?>>Dropped</option>
            <option value="incomplete" <?php if ($row['status'] == 'incomplete') echo 'selected'; ?>>Incomplete</option>
        </select>
    </form>
</td>


								</td>
                            <td class="action-buttons">
                                <a href="edit_score.php?student_id=<?php echo $student_id; ?>" class="btn btn-secondary">Edit</a>
</td>
                        </tr>
                    <?php endwhile; ?>
                </tbody>
            </table>
        </div>
		

        <div class="text-center">
            <a href="admin_dashboard.php" class="btn btn-secondary" id="dashboard">Back to Dashboard</a>
        </div>
    </div>
<!-- edit Modal -->
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
                    <form id="updateForm">
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
                        <div class="form-group">
                            <label for="prelim_exam">Prelim Exam</label>
                            <input type="number" name="prelim_exam" id="prelim_exam" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="midterm_exam">Midterm Exam</label>
                            <input type="number" name="midterm_exam" id="midterm_exam" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="semi_final_exam">Semi-final Exam</label>
                            <input type="number" name="semi_final_exam" id="semi_final_exam" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="final_exam">Final Exam</label>
                            <input type="number" name="final_exam" id="final_exam" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="remarks">Remarks</label>
                            <select name="remarks" id="remarks" class="form-control">
                                <option value="Passed">Passed</option>
                                <option value="Failed">Failed</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="status">Status:</label>
                            <select name="status" id="status" class="form-control">
                                <option value="enrolled">Enrolled</option>
                                <option value="dropped">Dropped</option>
                                <option value="incomplete">Incomplete</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-primary">Save changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

	<script src="assets/js/jquery-3.5.1.min.js"></script>
    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/js/bootstrap.bundle.min.js"></script>
    <script>
        $('#editModal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget);
            var studentId = button.data('student-id');

            var modal = $(this);
            modal.find('#editStudentId').val(studentId);

            // Fetch the student's existing data and populate the modal fields (AJAX call to fetch data can be added here)
            $.ajax({
                url: 'fetch_student_data.php', // PHP script to fetch the student's data
                type: 'GET',
                data: { student_id: studentId },
                success: function(data) {
                    var student = JSON.parse(data);
                    modal.find('#period').val(student.period);
                    modal.find('#quizzes').val(student.quizzes);
                    modal.find('#academic_projects').val(student.academic_projects);
                    modal.find('#recitation').val(student.recitation);
                    modal.find('#performance_task').val(student.performance_task);
                    modal.find('#activity_sheets').val(student.activity_sheets);
                    modal.find('#assignments').val(student.assignments);
                    modal.find('#prelim_exam').val(student.prelim_exam);
                    modal.find('#midterm_exam').val(student.midterm_exam);
                    modal.find('#semi_final_exam').val(student.semi_final_exam);
                    modal.find('#final_exam').val(student.final_exam);
                    modal.find('#remarks').val(student.remarks);
					modal.find('#status').val(student.final_exam);
                }
            });
        });
	   $('#updateForm').on('submit', function(event) {
            event.preventDefault();
            $.ajax({
                url: 'update_data.php',
                type: 'POST',
                data: $(this).serialize(),
                success: function(data) {
                    alert(data);
                    $('#editModal').modal('hide');
                }
            });
        });
	
     
    document.querySelectorAll('.period-container').forEach(function(container) {
        container.addEventListener('click', function() {
            var span = this.querySelector('.current-period');
            var select = this.querySelector('.periodDropdown');
            
            span.style.display = 'none';
            select.style.display = 'block';
            select.focus();
        });
    });

    function updatePeriodDropdown(selectElement) {
        // Get the selected value
        var selectedValue = selectElement.value;

        // Clear all options
        selectElement.innerHTML = '';

        // Add the selected option only
        var option = document.createElement('option');
        option.value = selectedValue;
        option.text = selectedValue;
        option.selected = true;
        selectElement.appendChild(option);

        // Submit the form
        selectElement.form.submit();
    }

    </script>
</body>
</html>
