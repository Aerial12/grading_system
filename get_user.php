<?php
include 'config.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $user_id = $_POST['id'];

    $sql = "SELECT username, role FROM users WHERE id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $user_id);

    if ($stmt->execute()) {
        $result = $stmt->get_result();
        if ($row = $result->fetch_assoc()) {
            echo '<div class="form-group">
                    <label for="edit_username">Username:</label>
                    <input type="text" class="form-control" id="edit_username" name="edit_username" value="' . htmlspecialchars($row['username']) . '" readonly>
                  </div>
                  <div class="form-group">
                    <label for="edit_role">Role:</label>
                    <input type="text" class="form-control" id="edit_role" name="edit_role" value="' . htmlspecialchars($row['role']) . '" readonly>
                  </div>';
        }
    }

    $stmt->close();
    $conn->close();
}
?>
