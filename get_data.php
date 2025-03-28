<?php
include 'db_connection.php';

$id = $_GET['id'];

try {
    $stmt = $pdo->prepare("SELECT * FROM grades WHERE id = :id");
    $stmt->execute(['id' => $id]);
    $data = $stmt->fetch(PDO::FETCH_ASSOC);
    
    echo json_encode($data);
} catch(PDOException $e) {
    echo "Error: " . $e->getMessage();
}
?>
