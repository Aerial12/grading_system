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
$sql = "SELECT students.id as student_id, 
               CONCAT(students.lastname, ', ', students.firstname, ' ', students.middlename) as student_name, 
               grades.id as grade_id, grades.period, grades.quizzes, grades.academic_projects, grades.recitation, 
               grades.performance_task, grades.activity_sheets, grades.assignments, grades.prelim_exam, grades.midterm_exam, 
               grades.semi_final_exam, grades.final_exam, grades.remarks, students.status
        FROM students
        LEFT JOIN grades ON students.id = grades.student_id
        WHERE (students.lastname LIKE '%$search_query%' OR students.firstname LIKE '%$search_query%' OR students.middlename LIKE '%$search_query%')";

if (isset($_GET['period']) && !empty($_GET['period'])) {
    $period_query = $conn->real_escape_string($_GET['period']);
    $sql .= " AND grades.period = '$period_query'";
}

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
                border-bottom
				            : 1px solid #ddd;
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
        </form>
        <div class="container">
            <form method="GET" action="" class="form-inline mb-3">
                <label for="period" class="mr-2">Select Period:</label>
                <select name="period" id="period" class="form-control" onchange="this.form.submit()">
                    <option value="">All Periods</option>
                    <option value="PE" <?php if (isset($_GET['period']) && $_GET['period'] == 'PE') echo 'selected'; ?>>Preliminary Exam</option>
                    <option value="ME" <?php if (isset($_GET['period']) && $_GET['period'] == 'ME') echo 'selected'; ?>>Midterm Exam</option>
                    <option value="SFE" <?php if (isset($_GET['period']) && $_GET['period'] == 'SFE') echo 'selected'; ?>>Semi-Final Exam</option>
                    <option value="FE" <?php if (isset($_GET['period']) && $_GET['period'] == 'FE') echo 'selected'; ?>>Final Exam</option>
                </select>
            </form>
            <a href="#" onclick="window.print();" class="print-icon"><i class="fas fa-print"></i> Print Report</a>

            <?php
            // Check if a period is selected
            $selected_period = isset($_GET['period']) ? $_GET['period'] : '';

            // Create the SQL query
            $sql = "SELECT students.id as student_id, students.lastname, students.firstname, students.middlename,
                           CONCAT(students.lastname, ', ', students.firstname, ' ', students.middlename) as student_name, 
                           grades.id as grade_id, grades.period, grades.quizzes, grades.academic_projects, grades.recitation, 
                           grades.performance_task, grades.activity_sheets, grades.assignments, grades.prelim_exam, grades.midterm_exam, 
                           grades.semi_final_exam, grades.final_exam, grades.remarks, students.status
                    FROM students
                    LEFT JOIN grades ON students.id = grades.student_id";

            if (!empty($selected_period)) {
                $sql .= " WHERE grades.period = '$selected_period'";
            }

            $result = $conn->query($sql);

            if ($result->num_rows > 0) {
                echo '<table class="table table-bordered">';
                echo '<thead><tr><th>Student ID</th><th>Student Name</th><th>Period</th><th>Prelim Exam</th><th>Midterm Exam</th><th>Semi-Final Exam</th><th>Final Exam</th></tr></thead>';
                echo '<tbody>';
                while ($row = $result->fetch_assoc()) {
                    echo '<tr>';
                    echo '<td>' . $row['student_id'] . '</td>';
                    echo '<td>' . $row['student_name'] . '</td>';
                    echo '<td>' . $row['period'] . '</td>';
                    echo '<td>' . ($row['prelim_exam'] ?? 'N/A') . '</td>';
                    echo '<td>' . ($row['midterm_exam'] ?? 'N/A') . '</td>';
                    echo '<td>' . ($row['semi_final_exam'] ?? 'N/A') . '</td>';
                    echo '<td>' . ($row['final_exam'] ?? 'N/A') . '</td>';
                    echo '</tr>';
                }
                echo '</tbody>';
                echo '</table>';
            } else {
                echo '<p>No records found for the selected period.</p>';
            }

            $conn->close();
            ?>
        </div>
        <div class="text-center">
            <a href="admin_dashboard.php" class="btn btn-secondary" id="dashboard">Back to Dashboard</a>
        </div>
    </div>
</body>
</html>
