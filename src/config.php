<?php
$host = "db"; 
$port = "5432"; // Container එක ඇතුළේ තියෙන්නේ default port එකමයි
$db   = "fuel_tracker_db";
$user = "fuel_user";
$pass = "fuel_password";

try {
    $dsn = "pgsql:host=$host;port=$port;dbname=$db;";
    $pdo = new PDO($dsn, $user, $pass, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
    ]);
} catch (PDOException $e) {
    header('Content-Type: application/json');
    echo json_encode(["error" => "Database connection failed: " . $e->getMessage()]);
    exit;
}
