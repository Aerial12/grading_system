<?php
session_start();
include 'config.php'; // Ensure this file contains your database connection

// Pagination and search logic
$offset = isset($_GET['offset']) ? intval($_GET['offset']) : 0; // Get offset from URL parameter
$limit = 1; // Number of students per page
$search_query = isset($_GET['query']) ? $_GET['query'] : ''; // Get search query from URL parameter

// Fetch students with pagination and search
$sql_students = "SELECT * FROM students";
if ($search_query) {
    $sql_students .= " WHERE firstname LIKE '%" . $conn->real_escape_string($search_query) . "%' 
                    OR lastname LIKE '%" . $conn->real_escape_string($search_query) . "%' 
                    OR course LIKE '%" . $conn->real_escape_string($search_query) . "%'";
}
$sql_students .= " LIMIT $limit OFFSET $offset";
$result_students = $conn->query($sql_students);

if (!$result_students) {
    // Handle query error (example: print the error and stop execution)
    die("Error fetching students: " . $conn->error);
}

// Fetch total number of students for navigation
$sql_count = "SELECT COUNT(*) AS total FROM students";
if ($search_query) {
    $sql_count .= " WHERE firstname LIKE '%" . $conn->real_escape_string($search_query) . "%' 
                 OR lastname LIKE '%" . $conn->real_escape_string($search_query) . "%' 
                 OR course LIKE '%" . $conn->real_escape_string($search_query) . "%'";
}
$result_count = $conn->query($sql_count);
$total_students = $result_count->fetch_assoc()['total'];
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Academic</title>
    <link href="./fontstyle.css" rel="stylesheet" type="text/css">
    <style>
        body {
            background-color: #F5F5F5; /* Light gray background */
            color: #333333; /* Dark text for readability */
            font-family: Arial, sans-serif;
        }
        .header {
            background-color: #1F293A; /* Dark blue */
            color: #FFFFFF; /* White text */
            text-align: center;
            padding: 10px 0;
            position: relative;
        }
        .footer {
            background-color: #1F293A; /* Dark blue */
            color: #FFFFFF; /* White text */
            text-align: center;
            padding: 10px 0;
        }
        .sub-header {
            background-color: #1F293A; /* Light blue-gray */
            color: #FFFFFF; /* Dark text */
            text-align: center;
            padding: 5px 0;
            font-size: 1.2em;
        }
        .container {
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            background-color: #FFFFFF; /* White background for tables */
        }
        th, td {
            border: 1px solid #CCCCCC; /* Light gray borders */
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #EEEEEE; /* Light gray header background */
        }
        .pagination {
            display: flex;
            justify-content: center;
            list-style-type: none;
            padding: 0;
        }
        .pagination li {
            margin: 0 5px;
        }
        .pagination a {
            text-decoration: none;
            color: #333333; /* Dark text */
            padding: 5px 10px;
            border: 1px solid #CCCCCC; /* Light gray borders */
            border-radius: 5px;
        }
        .pagination a:hover {
            background-color: #47768F; /* Dark blue background on hover */
            color: #FFFFFF; /* White text on hover */
        }
        .search-bar {
            position: absolute;
            top: 50%;
            right: 20px;
            transform: translateY(-50%);
        }
        .search-bar input[type="text"] {
            padding: 5px;
            border: 1px solid #CCCCCC;
            border-radius: 5px;
        }
        .search-bar button {
            padding: 5px 10px;
            border: none;
            background-color: #1F293A; /* Dark blue */
            color: #FFFFFF; /* White text */
            border-radius: 5px;
            cursor: pointer;
        }
        .search-bar button:hover {
            background-color: #47768F; /* Darker blue */
        }
    </style>
</head>
<body>
    <header class="header">
        <strong>:::: SCHEDULE ::::</strong>
        <div class="search-bar">
            <form action="" method="GET">
                <input type="text" name="query" placeholder="Search student..." value="<?php echo htmlspecialchars($search_query); ?>">
                <button type="submit">Search</button>
            </form>
        </div>
    </header>

    <section class="sub-header">
        <strong>STUDENT LOAD &amp; SCHEDULE FOR 1st Sem, SCHOOL YEAR 2023-2024</strong>
    </section>

    <div class="container">
        <?php if ($result_students->num_rows > 0): ?>
            <?php while ($row_student = $result_students->fetch_assoc()) : ?>
            <!-- Student Information -->
            <table>
                <tr>
                    <th>Student ID</th>
                    <td><?php echo htmlspecialchars($row_student['id']); ?></td>
                </tr>
                <tr>
                    <th>Name</th>
                    <td><?php echo htmlspecialchars($row_student['firstname'] . ' ' . $row_student['lastname']); ?></td>
                </tr>
                <tr>
                    <th>Program</th>
                    <td><?php echo htmlspecialchars($row_student['course']); ?></td>
                </tr>
                <tr>
                    <th>Academic Year</th>
                    <td>2023</td> <!-- Replace with actual logic to determine academic year -->
                </tr>
            </table>

            <!-- Course Details -->
            <table>
                <thead>
                    <tr>
                        <th>SUBJECT CODE</th>
                        <th>SUBJECT NAME</th>
                        <th>SCHEDULE</th>
                        <th>SECTION &amp; ROOM #</th>
                        <th>LEC/LAB. UNITS</th>
                        <th>TOTAL UNITS</th>
                    </tr>
                </thead>
                <tbody>
                    
                </tbody>
            </table>

            <!-- Semester Summary -->
            <div class="summary">
                <strong>TOTAL LOAD UNITS:</strong> <!-- Replace with actual logic to calculate total load units -->
            </div>
            <hr>
            <?php endwhile; ?>
        <?php else: ?>
            <p>No students found.</p>
        <?php endif; ?>

        <!-- Pagination Buttons -->
        <nav aria-label="Pagination">
            <ul class="pagination">
                <?php if ($offset > 0) : ?>
                    <li>
                        <a href="?offset=<?php echo $offset - $limit; ?>&query=<?php echo urlencode($search_query); ?>" aria-label="Previous">
                            &laquo; Previous
                        </a>
                    </li>
                <?php endif; ?>

                <?php if ($offset + $limit < $total_students) : ?>
                    <li>
                        <a href="?offset=<?php echo $offset + $limit; ?>&query=<?php echo urlencode($search_query); ?>" aria-label="Next">
                            Next &raquo;
                        </a>
                    </li>
                <?php endif; ?>
            </ul>
        </nav>
        <div class="text-center">
            <a href="admin_dashboard.php" class="btn btn-secondary">Back to Dashboard</a>
        </div>
    </div>

    <footer class="footer">
        &copy; 2023 Academic Schedule
    </footer>
</body>
</html>
