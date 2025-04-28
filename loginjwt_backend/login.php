<?php
// login.php

// --- 🔥 CORS: permitir peticiones de cualquier origen ---
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: POST, OPTIONS");

// Si es una solicitud OPTIONS, respondemos vacía (sin 401)
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(200);
    exit();
}
// ---------------------------------------------------------

require_once 'jwt_helper.php';

// Usuarios ficticios
$usuarios = [
    'prueba@correo.com' => '123456',
];

// Obtener datos del cuerpo
$input = json_decode(file_get_contents('php://input'), true);
$email = $input['email'] ?? '';
$password = $input['password'] ?? '';

if (isset($usuarios[$email]) && $usuarios[$email] === $password) {
    $payload = [
        'email' => $email,
        'exp' => time() + (60 * 60), // 1 hora
    ];

    $jwt = generate_jwt($payload);

    echo json_encode(['token' => $jwt]);
} else {
    http_response_code(401);
    echo json_encode(['error' => 'Credenciales inválidas']);
}
?>
