<?php
require_once __DIR__ . '/models/TaskModel.php';
require_once __DIR__ . '/models/UserModel.php';

// Works whether the app sits at /tasks-today/ (XAMPP) or at a domain root
$base = rtrim(str_replace('\\', '/', dirname($_SERVER['SCRIPT_NAME'])), '/');
$path = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$path = substr($path, strlen($base));
$path = '/' . trim($path, '/');
if ($path === '/index.php') {
    $path = '/';
}

function e($v): string
{
    return htmlspecialchars((string)$v, ENT_QUOTES, 'UTF-8');
}

function render(string $view, array $data = []): void
{
    global $base, $path;
    extract($data);
    require __DIR__ . '/views/header.php';
    require __DIR__ . "/views/$view.php";
    require __DIR__ . '/views/footer.php';
}

try {
    switch ($path) {
        case '/':
            render('welcome', [
                'title' => 'Welcome',
                'tasks' => (new TaskModel())->getToday(),
            ]);
            break;
        case '/tasks':
            render('tasks', [
                'title' => 'Task List',
                'tasks' => (new TaskModel())->getAll(),
            ]);
            break;
        case '/profile':
            render('profile', [
                'title' => 'Profile',
                'user'  => (new UserModel())->getDemoUser(),
            ]);
            break;
        case '/about':
            render('about', ['title' => 'About']);
            break;
        default:
            http_response_code(404);
            render('404', ['title' => 'Not Found']);
    }
} catch (PDOException $ex) {
    http_response_code(500);
    echo '<h1>Database error</h1><p>' . e($ex->getMessage()) . '</p>';
}