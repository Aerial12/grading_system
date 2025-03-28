<?php
include 'config.php';

if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['id'])) {
    $grade_id = $_GET['id'];
    $sql = "SELECT * FROM grades WHERE id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $grade_id);
    $stmt->execute();
    $result = $stmt->get_result();
    $grade = $result->fetch_assoc();
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['update_score'])) {
    $grade_id = $_POST['id'];
    $quizzes = $_POST['quizzes'];
    $academic_projects = $_POST['academic_projects'];
    $recitation = $_POST['recitation'];
    $performance_task = $_POST['performance_task'];
    $activity_sheets = $_POST['activity_sheets'];
    $assignments = $_POST['assignments'];
    $prelim_exam = $_POST['prelim_exam'] ?? null;
    $midterm_exam = $_POST['midterm_exam'] ?? null;
    $semi_final_exam = $_POST['semi_final_exam'] ?? null;
    $final_exam = $_POST['final_exam'] ?? null;
    $period = $_POST['period'];
    $exam_score = null;

    switch ($period) {
        case 'PE':
            $exam_score = $prelim_exam;
            break;
        case 'ME':
            $exam_score = $midterm_exam;
            break;
        case 'SFE':
            $exam_score = $semi_final_exam;
            break;
        case 'FE':
            $exam_score = $final_exam;
            break;
    }

    $sql = "UPDATE grades SET quizzes = ?, academic_projects = ?, recitation = ?, performance_task = ?, activity_sheets = ?, assignments = ?, period = ?, prelim_exam = ?, midterm_exam = ?, semi_final_exam = ?, final_exam = ?, exam_score = ? WHERE id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ssssssssssssi", $quizzes, $academic_projects, $recitation, $performance_task, $activity_sheets, $assignments, $period, $prelim_exam, $midterm_exam, $semi_final_exam, $final_exam, $exam_score, $grade_id);

    if ($stmt->execute()) {
        header("Location: report.php?message=update_success");
    } else {
        echo "Error: " . $stmt->error;
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Score</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <script>
        function updateExamFields() {
            const period = document.getElementById('period').value;
            document.getElementById('prelim_exam_div').style.display = 'none';
            document.getElementById('midterm_exam_div').style.display = 'none';
            document.getElementById('semi_final_exam_div').style.display = 'none';
            document.getElementById('final_exam_div').style.display = 'none';

            if (period === 'PE') {
                document.getElementById('prelim_exam_div').style.display = 'block';
            } else if (period === 'ME') {
                document.getElementById('midterm_exam_div').style.display = 'block';
            } else if (period === 'SFE') {
                document.getElementById('semi_final_exam_div').style.display = 'block';
            } else if (period === 'FE') {
                document.getElementById('final_exam_div').style.display = 'block';
            }
        }

        document.addEventListener('DOMContentLoaded', function() {
            updateExamFields();
        });
    </script>
</head>
<body>
    <div class="container">
        <h1>Edit Score</h1>
        <form method="POST" action="edit_score.php">
            <input type="hidden" name="id" value="<?php echo $grade['id']; ?>">
            <div class="form-group">
                <label>Quizzes</label>
                <input type="number" name="quizzes" class="form-control" value="<?php echo $grade['quizzes']; ?>" required>
            </div>
            <div class="form-group">
                <label>Academic Projects</label>
                <input type="number" name="academic_projects" class="form-control" value="<?php echo $grade['academic_projects']; ?>" required>
            </div>
            <div class="form-group">
                <label>Recitation</label>
                <input type="number" name="recitation" class="form-control" value="<?php echo $grade['recitation']; ?>" required>
            </div>
            <div class="form-group">
                <label>Performance Task</label>
                <input type="number" name="performance_task" class="form-control" value="<?php echo $grade['performance_task']; ?>" required>
            </div>
            <div class="form-group">
                <label>Activity Sheets</label>
                <input type="number" name="activity_sheets" class="form-control" value="<?php echo $grade['activity_sheets']; ?>" required>
            </div>
            <div class="form-group">
                <label>Assignments</label>
                <input type="number" name="assignments" class="form-control" value="<?php echo $grade['assignments']; ?>" required>
            </div>
            <div class="form-group">
			<?php if (!empty($grades) && isset($grades['period']) && $grades['period'] == 'PE') echo 'selected'; ?>

                <label>Period</label>
                <select name="period" id="period" class="form-control" onchange="updateExamFields()">
                    <option value="PE" <?php if ($grades['period'] == 'PE') echo 'selected'; ?>>Preliminary Exam</option>
                    <option value="ME" <?php if ($grades['period'] == 'ME') echo 'selected'; ?>>Midterm Exam</option>
                    <option value="SFE" <?php if ($grades['period'] == 'SFE') echo 'selected'; ?>>Semi-Final Exam</option>
                    <option value="FE" <?php if ($grades['period'] == 'FE') echo 'selected'; ?>>Final Exam</option>
                </select>
            </div>
            <div class="form-group" id="prelim_exam_div" style="display: none;">
                <label for="prelim_exam">Preliminary Exam Score</label>
                <input type="number" step="0.01" name="prelim_exam" class="form-control" id="prelim_exam" value="<?php echo $grade['prelim_exam']; ?>">
            </div>
            <div class="form-group" id="midterm_exam_div" style="display: none;">
                <label for="midterm_exam">Midterm Exam Score</label>
                <input type="number" step="0.01" name="midterm_exam" class="form-control" id="midterm_exam" value="<?php echo $grade['midterm_exam']; ?>">
            </div>
            <div class="form-group" id="semi_final_exam_div" style="display: none;">
                <label for="semi_final_exam">Semi-Final Exam Score</label>
                <input type="number" step="0.01" name="semi_final_exam" class="form-control" id="semi_final_exam" value="<?php echo $grade['semi_final_exam']; ?>">
            </div>
            <div class="form-group" id="final_exam_div" style="display: none;">
                <label for="final_exam">Final Exam Score</label>
                <input type="number" step="0.01" name="final_exam" class="form-control" id="final_exam" value="<?php echo $grade['final_exam']; ?>">
            </div>
            <button type="submit" name="update_score" class="btn btn-primary">Update Score</button>
            <a href="report.php" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
</body>
</html>
