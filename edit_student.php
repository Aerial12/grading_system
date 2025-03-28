<?php
include 'config.php';

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['update_student'])) {
    // Debugging lines
    echo "<pre>";
    print_r($_POST);
    echo "</pre>";

    // Update student data in the database
    $student_id = $_POST['id'];
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

    $sql = "UPDATE students SET lastname = ?, firstname = ?, middlename = ?, gender = ?, birthdate = ?, birthplace = ?, address = ?, father = ?, mother = ?, course = ? WHERE id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ssssssssssi", $lastname, $firstname, $middlename, $gender, $birthdate, $birthplace, $address, $father, $mother, $course, $student_id);

    if ($stmt->execute()) {
        echo "Student updated successfully.";
    } else {
        echo "Error updating student: " . $stmt->error;
    }

    $stmt->close();
    $conn->close();

    // Redirect back to the student list page
    header("Location: student_list.php");
    exit();
} else {
    echo "Invalid request.";
    exit();
}
?>
