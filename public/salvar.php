<?php
require_once '../config.php';

try {
    $config = include('../config.php');
    $conn = new PDO(
        "mysql:host={$config['db']['host']};dbname={$config['db']['name']};charset=utf8",
        $config['db']['user'],
        $config['db']['pass']
    );
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $data = json_decode(file_get_contents("php://input"), true);
    
    $conn->beginTransaction();
    
    foreach ($data as $resultado) {
        $allowedFields = ['gols_casa', 'gols_fora'];
        $field = $resultado['time'] === 'casa' ? 'gols_casa' : 'gols_fora';
        
        if(!in_array($field, $allowedFields)) {
            throw new Exception("Campo inválido");
        }

        $stmt = $conn->prepare("UPDATE partidas SET $field = :gols WHERE id = :id");
        $gols = filter_var($resultado['gols'], FILTER_VALIDATE_INT, [
            'options' => ['min_range' => 0, 'max_range' => 20]
        ]);
        
        $stmt->execute([
            ':gols' => ($gols !== false) ? $gols : 0,
            ':id' => filter_var($resultado['id'], FILTER_VALIDATE_INT)
        ]);
    }
    
    $conn->commit();
    echo json_encode(['status' => 'success']);
    
} catch (Exception $e) {
    $conn->rollBack();
    http_response_code(500);
    echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
}