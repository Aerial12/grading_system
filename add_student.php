<?php
include 'config.php';
$data = json_decode(file_get_contents("php://input"), true);
$student_id = $data['student_id'];
$subject = $data['subject'];

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $name = $_POST['name'];

    $sql = "INSERT INTO students (name) VALUES ('$name')";
    if ($conn->query($sql) === TRUE) {
        echo "New student added successfully";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
	
	
	$sql = "INSERT INTO student_subjects (student_id, subject) VALUES ($student_id, '$subject')";
if ($conn->query($sql) === TRUE) {
    echo json_encode(['success' => true]);
} else {
    echo json_encode(['success' => false, 'error' => $conn->error]);
}

}
?>
<!DOCTYPE html>
<html>
<body>
<h2>Add Student</h2>
<form method="post" action="<?php echo $_SERVER['PHP_SELF'];?>">
  Name: <input type="text" name="name">
  <input type="submit" value="Add Student">
</form>
</body>
</html>