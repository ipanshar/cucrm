<?php
/**
 * Router script for PHP built-in web server
 * This handles routing for static files and PHP requests
 */

$uri = urldecode(parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH));

// Serve static files from client directory
if (preg_match('/^\/client\//', $uri)) {
    $file = __DIR__ . $uri;
    if (file_exists($file) && is_file($file)) {
        return false; // Serve the file as-is
    }
}

// Serve static files from html directory
if (preg_match('/^\/html\//', $uri)) {
    $file = __DIR__ . $uri;
    if (file_exists($file) && is_file($file)) {
        return false; // Serve the file as-is
    }
}

// Serve static files from public directory (install assets, etc)
if (preg_match('/^\/install\/(css|js|img)\//', $uri)) {
    $file = __DIR__ . '/public' . $uri;
    if (file_exists($file) && is_file($file)) {
        return false; // Serve the file as-is
    }
}

// Handle install requests - route to public/install/index.php
if (preg_match('/^\/install/', $uri)) {
    $_SERVER['SCRIPT_NAME'] = '/install/index.php';
    $_SERVER['SCRIPT_FILENAME'] = __DIR__ . '/public/install/index.php';
    chdir(__DIR__ . '/public/install');
    require __DIR__ . '/public/install/index.php';
    return;
}

// Handle API requests - route to public/api/v1/index.php
if (preg_match('/^\/api\/v1\//', $uri)) {
    $_SERVER['SCRIPT_NAME'] = '/api/v1/index.php';
    $_SERVER['SCRIPT_FILENAME'] = __DIR__ . '/public/api/v1/index.php';
    chdir(__DIR__ . '/public/api/v1');
    require __DIR__ . '/public/api/v1/index.php';
    return;
}

// Route everything else to public/index.php
$_SERVER['SCRIPT_NAME'] = '/index.php';
$_SERVER['SCRIPT_FILENAME'] = __DIR__ . '/public/index.php';
chdir(__DIR__ . '/public');
require __DIR__ . '/public/index.php';
