<?php
// jwt_helper.php

use Firebase\JWT\JWT;
use Firebase\JWT\Key;

require_once __DIR__ . '/vendor/autoload.php';
require_once 'config.php';

function generate_jwt($payload) {
    return JWT::encode($payload, JWT_SECRET_KEY, 'HS256');
}

function validate_jwt($token) {
    return JWT::decode($token, new Key(JWT_SECRET_KEY, 'HS256'));
}
?>
