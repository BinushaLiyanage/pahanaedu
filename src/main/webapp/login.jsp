<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Pahana Edu</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #1e3a8a 0%, #1e40af 50%, #3b82f6 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            position: relative;
        }


        .bg-animation {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: -1;
        }

        .floating-shapes {
            position: absolute;
            background: rgba(255, 255, 255, 0.08);
            border-radius: 50%;
            animation: float 8s ease-in-out infinite;
        }

        .shape1 {
            width: 120px;
            height: 120px;
            top: 15%;
            left: 10%;
            animation-delay: 0s;
        }
        .shape2 {
            width: 180px;
            height: 180px;
            top: 25%;
            right: 15%;
            animation-delay: 3s;
        }
        .shape3 {
            width: 100px;
            height: 100px;
            bottom: 20%;
            left: 20%;
            animation-delay: 6s;
        }
        .shape4 {
            width: 150px;
            height: 150px;
            bottom: 15%;
            right: 25%;
            animation-delay: 2s;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); opacity: 0.6; }
            50% { transform: translateY(-30px) rotate(180deg); opacity: 1; }
        }


        .back-nav {
            position: absolute;
            top: 20px;
            left: 20px;
            z-index: 1000;
        }

        .back-btn {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: white;
            padding: 12px 20px;
            border-radius: 50px;
            text-decoration: none;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 500;
        }

        .back-btn:hover {
            background: rgba(255, 255, 255, 0.25);
            transform: translateX(-5px);
            color: white;
            text-decoration: none;
            box-shadow: 0 5px 20px rgba(255, 255, 255, 0.2);
        }


        .main-container {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            box-shadow: 0 30px 80px rgba(0, 0, 0, 0.3);
            width: 420px;
            max-width: 90vw;
            overflow: hidden;
            position: relative;
            animation: slideUp 1s ease-out;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(50px) scale(0.95);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }


        .login-header {
            background: linear-gradient(135deg, #1e3a8a, #1e40af);
            color: white;
            padding: 30px 40px 25px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .login-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 20"><defs><pattern id="grid" width="10" height="10" patternUnits="userSpaceOnUse"><path d="M 10 0 L 0 0 0 10" fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="0.5"/></pattern></defs><rect width="100" height="20" fill="url(%23grid)"/></svg>');
            opacity: 0.3;
        }

        .login-icon {
            font-size: 48px;
            margin-bottom: 15px;
            opacity: 0.9;
            position: relative;
            z-index: 1;
        }

        .form-title {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 8px;
            position: relative;
            z-index: 1;
        }

        .form-subtitle {
            font-size: 14px;
            opacity: 0.9;
            position: relative;
            z-index: 1;
        }


        .form-container {
            padding: 40px;
            position: relative;
        }


        .message {
            padding: 12px 15px;
            border-radius: 10px;
            margin-bottom: 25px;
            font-size: 14px;
            font-weight: 500;
        }

        .message.error {
            background: linear-gradient(135deg, #fee2e2, #fecaca);
            color: #dc2626;
            border: 1px solid #f87171;
        }


        .input-group {
            position: relative;
            margin-bottom: 25px;
        }

        .input-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #1e3a8a;
            font-size: 14px;
        }

        .input-wrapper {
            position: relative;
        }

        .form-input {
            width: 100%;
            padding: 16px 50px 16px 50px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: #f8fafc;
            color: #1e3a8a;
        }

        .form-input:focus {
            outline: none;
            border-color: #1e40af;
            background: white;
            box-shadow: 0 0 0 3px rgba(30, 64, 175, 0.1);
            transform: translateY(-1px);
        }

        .input-icon {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: #64748b;
            font-size: 18px;
            transition: color 0.3s ease;
        }

        .form-input:focus + .input-icon {
            color: #1e40af;
        }

        .toggle-password {
            position: absolute;
            right: 18px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #64748b;
            font-size: 18px;
            transition: color 0.3s ease;
        }

        .toggle-password:hover {
            color: #1e40af;
        }

        /* Submit Button */
        .submit-btn {
            width: 100%;
            padding: 16px;
            background: linear-gradient(135deg, #1e3a8a, #1e40af);
            border: none;
            border-radius: 12px;
            color: white;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            margin-top: 10px;
        }

        .submit-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.6s;
        }

        .submit-btn:hover::before {
            left: 100%;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(30, 58, 138, 0.4);
            background: linear-gradient(135deg, #1e40af, #3b82f6);
        }

        .submit-btn:active {
            transform: translateY(0);
        }

        /* Form Options */
        .form-options {
            margin-top: 25px;
            text-align: center;
        }

        .form-link {
            color: #1e40af;
            text-decoration: none;
            font-weight: 500;
            font-size: 14px;
            transition: color 0.3s ease;
        }

        .form-link:hover {
            color: #1e3a8a;
            text-decoration: underline;
        }


        .footer {
            text-align: center;
            padding: 20px;
            background: linear-gradient(135deg, #f8fafc, #e2e8f0);
            color: #64748b;
            font-size: 13px;
            border-top: 1px solid rgba(30, 58, 138, 0.1);
        }


        .loading {
            display: none;
            text-align: center;
            margin-top: 15px;
        }

        .spinner {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            border-top-color: white;
            animation: spin 1s ease-in-out infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }


        @media (max-width: 768px) {
            .main-container {
                width: 95vw;
                margin: 20px;
            }

            .form-container {
                padding: 30px 25px;
            }

            .login-header {
                padding: 25px 30px 20px;
            }

            .back-nav {
                top: 10px;
                left: 10px;
            }

            .form-title {
                font-size: 24px;
            }

            .login-icon {
                font-size: 40px;
            }
        }


        .form-input:focus,
        .submit-btn:focus,
        .back-btn:focus,
        .form-link:focus {
            outline: 2px solid #1e40af;
            outline-offset: 2px;
        }
    </style>
</head>
<body>

<div class="bg-animation">
    <div class="floating-shapes shape1"></div>
    <div class="floating-shapes shape2"></div>
    <div class="floating-shapes shape3"></div>
    <div class="floating-shapes shape4"></div>
</div>


<div class="back-nav">
    <a href="index.jsp" class="back-btn">
        <i class="fas fa-arrow-left"></i>
        <span>Back to Home</span>
    </a>
</div>


<div class="main-container">

    <div class="login-header">
        <div class="login-icon">
            <i class="fas fa-shield-alt"></i>
        </div>
        <h2 class="form-title">Management System</h2>
        <p class="form-subtitle">Please sign in to access your account</p>
    </div>


    <div class="form-container">

        <div class="message error" id="loginError" style="display: <%= request.getAttribute("loginError") != null ? "block" : "none" %>;">
            <i class="fas fa-exclamation-circle me-2"></i>
            <%= request.getAttribute("loginError") != null ? request.getAttribute("loginError") : "" %>
        </div>



        <form action="LoginServlet" method="post" id="loginForm">
            <div class="input-group">
                <label for="loginUsername">Username</label>
                <div class="input-wrapper">
                    <input type="text" name="username" id="loginUsername" class="form-input" required
                           placeholder="Enter your username">
                    <i class="fas fa-user input-icon"></i>
                </div>
            </div>

            <div class="input-group">
                <label for="loginPassword">Password</label>
                <div class="input-wrapper">
                    <input type="password" name="password" id="loginPassword" class="form-input" required
                           placeholder="Enter your password">
                    <i class="fas fa-lock input-icon"></i>
                    <i class="fas fa-eye toggle-password" onclick="togglePassword('loginPassword')"></i>
                </div>
            </div>

            <button type="submit" class="submit-btn">
                <i class="fas fa-sign-in-alt me-2"></i>
                Sign In
            </button>

            <div class="loading" id="loginLoading">
                <div class="spinner"></div>
                <span class="ms-2">Signing in...</span>
            </div>
        </form>

        <!-- Form Options -->
        <div class="form-options">
            <a href="#" class="form-link" onclick="showForgotPassword()">
                <i class="fas fa-question-circle me-1"></i>Forgot Password?
            </a>
        </div>
    </div>


    <div class="footer">
        <i class="fas fa-shield-alt me-1"></i>
        © 2025 PahanaEdu Bookshop System - Secure & Reliable
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>

    function togglePassword(inputId) {
        const passwordInput = document.getElementById(inputId);
        const toggleIcon = passwordInput.parentElement.querySelector('.toggle-password');

        if (passwordInput.type === 'password') {
            passwordInput.type = 'text';
            toggleIcon.classList.remove('fa-eye');
            toggleIcon.classList.add('fa-eye-slash');
        } else {
            passwordInput.type = 'password';
            toggleIcon.classList.remove('fa-eye-slash');
            toggleIcon.classList.add('fa-eye');
        }
    }


    document.getElementById('loginForm').addEventListener('submit', function() {
        document.getElementById('loginLoading').style.display = 'block';
    });


    function showForgotPassword() {
        alert('Please contact the system administrator to reset your password.\nEmail: admin@pahanaedu.lk\nPhone: +94 11 234 5678');
    }


    setTimeout(() => {
        const messages = document.querySelectorAll('.message');
        messages.forEach(msg => {
            if (msg.style.display !== 'none') {
                msg.style.display = 'none';
            }
        });
    }, 5000);


    document.querySelectorAll('.form-input').forEach(input => {
        input.addEventListener('focus', function() {
            this.parentElement.style.transform = 'scale(1.01)';
            this.parentElement.style.transition = 'transform 0.3s ease';
        });

        input.addEventListener('blur', function() {
            this.parentElement.style.transform = 'scale(1)';
        });
    });


    window.addEventListener('load', function() {
        document.querySelector('.main-container').style.opacity = '0';
        setTimeout(() => {
            document.querySelector('.main-container').style.opacity = '1';
        }, 200);
    });


    document.addEventListener('keydown', function(e) {
        if (e.key === 'Enter' && e.target.tagName !== 'BUTTON' && e.target.type !== 'submit') {
            e.preventDefault();
            document.querySelector('.submit-btn').click();
        }
    });
</script>
</body>
</html>