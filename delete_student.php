<?php
include 'config.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $student_id = $_POST['id'];
    // Delete the student from the database using $student_id
    $sql = "DELETE FROM students WHERE id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $student_id);
    
    if ($stmt->execute()) {
        echo "Student deleted successfully.";
    } else {
        echo "Error deleting student: " . $conn->error;
    }

    $stmt->close();
    $conn->close();

    // Redirect back to the student list page
    header("Location: student_list.php");
    exit();
}
?>
