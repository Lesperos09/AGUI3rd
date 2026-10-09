CREATE DATABASE IF NOT EXISTS tasks_today
  CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE tasks_today;

DROP TABLE IF EXISTS tasks;
DROP TABLE IF EXISTS users;

CREATE TABLE tasks (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(150) NOT NULL,
  status VARCHAR(20) NOT NULL DEFAULT 'pending',
  task_date DATE NOT NULL,
  created_at DATETIME NOT NULL
);

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL UNIQUE,
  full_name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  created_at DATETIME NOT NULL
);

-- Dates are relative to CURDATE() so "today" always has records
INSERT INTO tasks (title, status, task_date, created_at) VALUES
('Review database schema',        'done',    CURDATE() - INTERVAL 2 DAY, NOW()),
('Submit lab report',             'done',    CURDATE() - INTERVAL 2 DAY, NOW()),
('Read PHP PDO documentation',    'done',    CURDATE() - INTERVAL 1 DAY, NOW()),
('Buy printer ink',               'pending', CURDATE() - INTERVAL 1 DAY, NOW()),
('Build TaskModel and UserModel', 'pending', CURDATE(),                  NOW()),
('Style the Welcome page',        'pending', CURDATE(),                  NOW()),
('Test all four routes',          'pending', CURDATE(),                  NOW()),
('Prepare project demo',          'pending', CURDATE() + INTERVAL 1 DAY, NOW()),
('Submit final project',          'pending', CURDATE() + INTERVAL 3 DAY, NOW());

INSERT INTO users (username, full_name, email, created_at) VALUES
('demo_user', 'Demo User', 'demo.user@example.com', NOW());