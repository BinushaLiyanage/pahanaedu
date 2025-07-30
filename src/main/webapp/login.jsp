<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - Pahana Edu</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #f3f4f6, #cbd5e1);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-container {
            background: #fff;
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            width: 350px;
        }

        .login-container h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #1f2937;
        }

        label {
            font-weight: 500;
            color: #374151;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px 12px;
            margin: 8px 0 15px 0;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            background: #f9fafb;
            transition: 0.3s;
        }

        input[type="text"]:focus, input[type="password"]:focus {
            border-color: #3b82f6;
            outline: none;
            background: #fff;
        }

        .toggle-password {
            float: right;
            margin-top: -40px;
            margin-right: 10px;
            cursor: pointer;
            color: #6b7280;
        }

        input[type="submit"] {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 8px;
            background-color: #2563eb;
            color: white;
            font-weight: bold;
            font-size: 15px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #1d4ed8;
        }

        .footer {
            margin-top: 20px;
            text-align: center;
            font-size: 13px;
            color: #6b7280;
        }
    </style>
</head>
<body>

<div class="login-container">
    <h2>Login to Pahana Edu</h2>
    <form action="LoginServlet" method="post">
        <label>Username:</label>
        <input type="text" name="username" required>

        <label>Password:</label>
        <input type="password" name="password" id="password" required>
        <span class="toggle-password" onclick="togglePassword()">👁</span>

        <input type="submit" value="Login">
    </form>

    <div class="footer">
        © 2025 PahanaEdu Bookshop System
    </div>
</div>

<script>
    function togglePassword() {
        const pwd = document.getElementById("password");
        pwd.type = pwd.type === "password" ? "text" : "password";
    }
</script>

</body>
</html>
