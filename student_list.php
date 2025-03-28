<?php
include 'config.php';

// Pagination logic
$offset = isset($_GET['offset']) ? intval($_GET['offset']) : 0; // Get offset from URL parameter
$limit = 20; // Number of students per page

// Fetch student list from the database with pagination
$sql = "SELECT * FROM students LIMIT $limit OFFSET $offset";
$result = $conn->query($sql);

// Fetch distinct subjects (subject_name) from the courses table for the filter dropdown
$query = "SELECT DISTINCT course FROM students WHERE course IN ('BSIT', 'BSCS')";
$courses_result = $conn->query($query);

// Fetch total number of students for navigation
$sql_count = "SELECT COUNT(*) AS total FROM students";
$result_count = $conn->query($sql_count);
$total_students = $result_count->fetch_assoc()['total'];

// Debugging: print the variables
// echo "Offset: $offset, Limit: $limit, Total Students: $total_students";
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student List</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <script src="assets/js/jquery-3.5.1.slim.min.js"></script>
    <script src="assets/js/popper.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
        }
        .container {
            display: inline-block;
            text-align: left;
            padding: 20px;
            border: 1px solid #ccc;
            margin: 20px;
        }
        .student-list {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
            text-align: center;
            border: 2px solid #ccc; /* Bolder border for student list */
        }
        .student-list th, .student-list td {
            border: 1px solid #ccc; /* Normal border for table cells */
            padding: 8px;
            text-align: center;
        }
        .print-button, .filter-sort {
            margin-top: 20px;
        }
        .action-buttons form {
            display: inline-block;
        }
        .action-buttons button {
            margin-right: 5px;
        }
        @media print {
            .print-button, .action-buttons, .filter-sort, .search-bar {
                display: none;
            }
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
            max-height: 100px;
            border-radius: 50%;
            padding: 5px;
            width: 100px;
            margin: 0 20px; /* Spacing around images */
        }
        .instructor-info {
            text-align: left;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            padding: 10px;
        }
    </style>
</head>
<body>

<div class="header">
    <div>
        <img src="image/ccs.jpg" alt="Left Image">
    </div>
    <div>
        <h1>UNIVERSITY OF LUZON</h1>
        <h2>College of Computer Studies</h2>
    </div>
    <div>
        <img src="image/cs.jpg" alt="Right Image">
    </div>
</div>

<div class="instructor-info">
    <p>Instructor Name:</p>
    <p>Section:</p>
</div>

<div>
    <select id="subjectDropdown" class="form-control" aria-label="Select subject">
    <option value="">Select Subject</option>
	<option value="Computer Science Subject 1">DESIGN AND IMPLEMENTATION OF PROGRAMMING LANGUAGES</option>
        <option value="Computer Science Subject 2">	ELECTIVE 2 - INTELLIGENT SYSTEMS</option>
        <option value="Computer Science Subject 3">	LANGUAGE THEORY AND AUTOMATA</option>
        <option value="Computer Science Subject 4">	THESIS A</option>
        <option value="Information Technology Subject 1">CAD APPLICATION</option>
        <option value="Information Technology Subject 2">ELECTIVE 3 - SAP ADMINISTRATION</option>
        <option value="Information Technology Subject 3">ELECTIVE 1 - DATA ANALYTICS</option>
        <option value="Information Technology Subject 4">WEB SYSTEM AND TECHNOLOGIES</option>
</select>

</div>

<div class="search-bar">
    <input type="text" id="search" class="form-control" placeholder="Search students..." aria-label="Search students" oninput="filterTable()">
</div>

<div class="filter-sort">
    <select id="filterCourse" class="form-control" aria-label="Filter by course" onchange="filterTable()">
        <option value="">All Courses</option>
        <?php while($course = $courses_result->fetch_assoc()): ?>
            <option value="<?php echo $course['course']; ?>"><?php echo $course['course']; ?></option>
        <?php endwhile; ?>
    </select>

    <select id="sortField" class="form-control" aria-label="Sort by field" onchange="sortTable()">
        <option value="id">Student ID</option>
        <option value="lastname">Last Name</option>
        <option value="firstname">First Name</option>
        <option value="middlename">Middle Name</option>
        <option value="course">Course</option>
    </select>
</div>

<h2>Student List</h2>
<table class="student-list" id="studentTable">
    <thead>
        <tr>
            <th>STUDENT ID</th>
            <th>LAST NAME</th>
            <th>FIRST NAME</th>
            <th>MIDDLE NAME</th>
            <th>COURSE CODE</th>
            <th class="action-buttons">ACTIONS</th>
        </tr>
    </thead>
    <tbody>
        <?php while($row = $result->fetch_assoc()): ?>
        <tr>
            <td><?php echo $row['id']; ?></td>
            <td><?php echo $row['lastname']; ?></td>
            <td><?php echo $row['firstname']; ?></td>
            <td><?php echo $row['middlename']; ?></td>
            <td><?php echo $row['course']; ?></td>
            <td class="action-buttons">
                <button type="button" class="btn btn-primary btn-edit" data-id="<?php echo $row['id']; ?>">Edit</button>
                <form action="delete_student.php" method="POST" onsubmit="return confirm('Are you sure you want to delete this student?');">
                    <input type="hidden" name="id" value="<?php echo $row['id']; ?>">
                    <button type="submit" class="btn btn-danger">Delete</button>
                </form>
            </td>
        </tr>
        <?php endwhile; ?>
    </tbody>
</table>
<div class="text-center">
<button class="print-button btn btn-secondary" onclick="window.print()">Print</button>
</div>
<div class="text-center">
    <a href="admin_dashboard.php" class="btn btn-secondary">Back to Dashboard</a>
</div>

<div class="row">
    <div class="col-md-12">
        <nav aria-label="Pagination">
            <ul class="pagination justify-content-center">
                <?php if ($offset > 0) : ?>
                    <li class="page-item">
                        <a class="page-link" href="?offset=<?php echo $offset - $limit; ?>" aria-label="Previous">
                            <span aria-hidden="true">&laquo; Previous</span>
                        </a>
                    </li>
                <?php endif; ?>

                <?php if ($offset + $limit < $total_students) : ?>
                    <li class="page-item">
                        <a class="page-link" href="?offset=<?php echo $offset + $limit; ?>" aria-label="Next">
                            <span aria-hidden="true">Next &raquo;</span>
                        </a>
                    </li>
                <?php endif; ?>
            </ul>
        </nav>
    </div>
</div>

    <!-- Edit Student Modal -->
    <div class="modal fade" id="editStudentModal" tabindex="-1" aria-labelledby="editStudentModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editStudentModalLabel">Edit Student</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="editStudentForm" method="post" action="edit_student.php">
                        <input type="hidden" name="update_student" value="1">
                        <input type="hidden" name="id" id="student-id">
                        <div class="form-group">
                            <label for="student-lastname">Last Name</label>
                            <input type="text" name="lastname" id="student-lastname" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="student-firstname">First Name</label>
                            <input type="text" name="firstname" id="student-firstname" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="student-middlename">Middle Name</label>
                            <input type="text" name="middlename" id="student-middlename" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="student-gender">Gender</label>
                            <select name="gender" id="student-gender" class="form-control" required>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="student-birthdate">Birthdate</label>
                            <input type="date" name="birthdate" id="student-birthdate" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="student-birthplace">Birthplace</label>
                            <input type="text" name="birthplace" id="student-birthplace" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="student-address">Address</label>
                            <input type="text" name="address" id="student-address" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="student-father">Father's Name</label>
                            <input type="text" name="father" id="student-father" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="student-mother">Mother's Name</label>
                            <input type="text" name="mother" id="student-mother" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="student-course">Course</label>
                            <select name="course" id="student-course" class="form-control" required>
                                <option value="BSIT">BSIT (Bachelor of Science in Information Technology)</option>
                                <option value="BSCS">BSCS (Bachelor of Science in Computer Science)</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary">Update Student</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    </form>
					
                </div>
				
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var editButtons = document.querySelectorAll('.btn-edit');
            editButtons.forEach(function (button) {
                button.addEventListener('click', function () {
                    var studentId = this.getAttribute('data-id');

                    // Fetch student data using AJAX
                    fetch('get_student.php?id=' + studentId)
                        .then(response => response.json())
                        .then(data => {
                            document.getElementById('student-id').value = data.id;
                            document.getElementById('student-lastname').value = data.lastname;
                            document.getElementById('student-firstname').value = data.firstname;
                            document.getElementById('student-middlename').value = data.middlename;
                            document.getElementById('student-gender').value = data.gender;
                            document.getElementById('student-birthdate').value = data.birthdate;
                            document.getElementById('student-birthplace').value = data.birthplace;
                            document.getElementById('student-address').value = data.address;
                            document.getElementById('student-father').value = data.father;
                            document.getElementById('student-mother').value = data.mother;
                            document.getElementById('student-course').value = data.course;

                            // Show the modal
                            $('#editStudentModal').modal('show');
                        })
                        .catch(error => console.error('Error:', error));
                });
            });
        });

        function filterTable() {
            var searchInput = document.getElementById('search').value.toLowerCase();
            var filterCourse = document.getElementById('filterCourse').value.toLowerCase();
            var table = document.getElementById('studentTable');
            var tr = table.getElementsByTagName('tr');

            for (var i = 1; i < tr.length; i++) {
                var tdName = tr[i].getElementsByTagName('td');
                var txtValue = (tdName[1].textContent || tdName[1].innerText) + ' ' +
                               (tdName[2].textContent || tdName[2].innerText) + ' ' +
                               (tdName[3].textContent || tdName[3].innerText);
                var courseValue = tdName[4].textContent || tdName[4].innerText;

                if ((txtValue.toLowerCase().indexOf(searchInput) > -1) && (filterCourse === "" || courseValue.toLowerCase().indexOf(filterCourse) > -1)) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                }
            }
        }

        function sortTable() {
            var table = document.getElementById('studentTable');
            var rows = table.rows;
            var switching = true;
            var sortField = document.getElementById('sortField').value;
            var shouldSwitch, i;
            var dir = "asc"; 
            var switchCount = 0;

            while (switching) {
                switching = false;
                var rowsArray = Array.from(rows).slice(1);

                for (i = 0; i < (rowsArray.length - 1); i++) {
                    shouldSwitch = false;
                    var x = rowsArray[i].getElementsByTagName("TD")[sortFieldMap[sortField]];
                    var y = rowsArray[i + 1].getElementsByTagName("TD")[sortFieldMap[sortField]];

                    if (dir == "asc") {
                        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                            shouldSwitch = true;
                            break;
                        }
                    } else if (dir == "desc") {
                        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                            shouldSwitch = true;
                            break;
                        }
                    }
                }

                if (shouldSwitch) {
                    rowsArray[i].parentNode.insertBefore(rowsArray[i + 1], rowsArray[i]);
                    switching = true;
                    switchCount++;
                } else {
                    if (switchCount == 0 && dir == "asc") {
                        dir = "desc";
                        switching = true;
                    }
                }
            }
        }

        var sortFieldMap = {
            "id": 0,
            "lastname": 1,
            "firstname": 2,
            "middlename": 3,
            "course": 4
        };
    </script>
</body>
</html>
