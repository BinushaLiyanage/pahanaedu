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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
            width: 100px;
            height: 100px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            animation: float 6s ease-in-out infinite;
        }

        .shape1 { top: 10%; left: 10%; animation-delay: 0s; }
        .shape2 { top: 20%; right: 10%; animation-delay: 2s; width: 150px; height: 150px; }
        .shape3 { bottom: 10%; left: 15%; animation-delay: 4s; width: 80px; height: 80px; }
        .shape4 { bottom: 20%; right: 20%; animation-delay: 1s; width: 120px; height: 120px; }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }


        .back-nav {
            position: absolute;
            top: 20px;
            left: 20px;
            z-index: 1000;
        }

        .back-btn {
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: white;
            padding: 12px 20px;
            border-radius: 50px;
            text-decoration: none;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .back-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateX(-5px);
            color: white;
            text-decoration: none;
        }


        .main-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 25px;
            box-shadow: 0 25px 60px rgba(0, 0, 0, 0.2);
            width: 450px;
            max-width: 90vw;
            overflow: hidden;
            position: relative;
            animation: slideUp 1s ease-out;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(50px) scale(0.9);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }


        .tab-container {
            display: flex;
            background: rgba(102, 126, 234, 0.1);
            margin: 0;
        }

        .tab-btn {
            flex: 1;
            padding: 20px;
            background: transparent;
            border: none;
            font-size: 16px;
            font-weight: 600;
            color: #666;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
        }

        .tab-btn.active {
            color: #667eea;
            background: rgba(102, 126, 234, 0.1);
        }

        .tab-btn::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 0;
            height: 3px;
            background: linear-gradient(45deg, #667eea, #764ba2);
            transition: width 0.3s ease;
        }

        .tab-btn.active::after {
            width: 100%;
        }


        .form-container {
            padding: 40px;
            position: relative;
        }

        .form-tab {
            display: none;
            animation: fadeIn 0.5s ease-in;
        }

        .form-tab.active {
            display: block;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateX(20px); }
            to { opacity: 1; transform: translateX(0); }
        }

        .form-title {
            text-align: center;
            margin-bottom: 30px;
            color: #333;
            font-size: 28px;
            font-weight: 700;
        }

        .form-subtitle {
            text-align: center;
            margin-bottom: 30px;
            color: #666;
            font-size: 14px;
        }


        .input-group {
            position: relative;
            margin-bottom: 25px;
        }

        .input-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #555;
            font-size: 14px;
        }

        .input-wrapper {
            position: relative;
        }

        .form-input {
            width: 100%;
            padding: 15px 50px 15px 45px;
            border: 2px solid #e1e5e9;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        .form-input:focus {
            outline: none;
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
            font-size: 18px;
        }

        .toggle-password {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #999;
            font-size: 18px;
            transition: color 0.3s ease;
        }

        .toggle-password:hover {
            color: #667eea;
        }


        .submit-btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(45deg, #667eea, #764ba2);
            border: none;
            border-radius: 12px;
            color: white;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .submit-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s;
        }

        .submit-btn:hover::before {
            left: 100%;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
        }


        .form-options {
            margin-top: 20px;
            text-align: center;
        }

        .form-link {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .form-link:hover {
            color: #764ba2;
            text-decoration: underline;
        }

        .divider {
            margin: 25px 0;
            text-align: center;
            position: relative;
            color: #999;
        }

        .divider::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 0;
            right: 0;
            height: 1px;
            background: #e1e5e9;
        }

        .divider span {
            background: white;
            padding: 0 15px;
        }


        .footer {
            text-align: center;
            padding: 20px;
            background: rgba(102, 126, 234, 0.05);
            color: #666;
            font-size: 13px;
        }


        .message {
            padding: 12px 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .message.error {
            background: #fee2e2;
            color: #dc2626;
            border: 1px solid #fecaca;
        }

        .message.success {
            background: #dcfce7;
            color: #16a34a;
            border: 1px solid #bbf7d0;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .main-container {
                width: 95vw;
                margin: 20px;
            }

            .form-container {
                padding: 30px 25px;
            }

            .back-nav {
                top: 10px;
                left: 10px;
            }
        }


        .loading {
            display: none;
            text-align: center;
            margin-top: 10px;
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


    <div class="tab-container">
        <button class="tab-btn active" onclick="switchTab('login')">
            <i class="fas fa-sign-in-alt me-2"></i>Login
        </button>
        <button class="tab-btn" onclick="switchTab('register')">
            <i class="fas fa-user-plus me-2"></i>Create Account
        </button>
    </div>


    <div class="form-container">
        <div class="form-tab active" id="loginTab">
            <h2 class="form-title">Welcome Back!</h2>
            <p class="form-subtitle">Please sign in to your account</p>


            <div class="message error" id="loginError" style="display: none;">
                <i class="fas fa-exclamation-circle me-2"></i>
                Invalid username or password!
            </div>

            <form action="LoginServlet" method="post" id="loginForm">
                <div class="input-group">
                    <label for="loginUsername">Username</label>
                    <div class="input-wrapper">
                        <i class="fas fa-user input-icon"></i>
                        <input type="text" name="username" id="loginUsername" class="form-input" required
                               placeholder="Enter your username">
                    </div>
                </div>

                <div class="input-group">
                    <label for="loginPassword">Password</label>
                    <div class="input-wrapper">
                        <i class="fas fa-lock input-icon"></i>
                        <input type="password" name="password" id="loginPassword" class="form-input" required
                               placeholder="Enter your password">
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

            <div class="form-options">
                <a href="#" class="form-link" onclick="showForgotPassword()">
                    <i class="fas fa-question-circle me-1"></i>Forgot Password?
                </a>
            </div>

            <div class="divider">
                <span>Don't have an account?</span>
            </div>

            <button class="submit-btn" onclick="switchTab('register')" style="background: linear-gradient(45deg, #10b981, #059669);">
                <i class="fas fa-user-plus me-2"></i>
                Create New Account
            </button>
        </div>


        <div class="form-tab" id="registerTab">
            <h2 class="form-title">Create Account</h2>
            <p class="form-subtitle">Join PahanaEdu Bookshop System</p>


            <div class="message success" id="registerSuccess" style="display: none;">
                <i class="fas fa-check-circle me-2"></i>
                Account created successfully! Please login.
            </div>

            <form action="RegisterServlet" method="post" id="registerForm">
                <div class="input-group">
                    <label for="registerFullName">Full Name</label>
                    <div class="input-wrapper">
                        <i class="fas fa-user input-icon"></i>
                        <input type="text" name="fullName" id="registerFullName" class="form-input" required
                               placeholder="Enter your full name">
                    </div>
                </div>

                <div class="input-group">
                    <label for="registerUsername">Username</label>
                    <div class="input-wrapper">
                        <i class="fas fa-at input-icon"></i>
                        <input type="text" name="username" id="registerUsername" class="form-input" required
                               placeholder="Choose a username">
                    </div>
                </div>

                <div class="input-group">
                    <label for="registerEmail">Email Address</label>
                    <div class="input-wrapper">
                        <i class="fas fa-envelope input-icon"></i>
                        <input type="email" name="email" id="registerEmail" class="form-input" required
                               placeholder="Enter your email">
                    </div>
                </div>

                <div class="input-group">
                    <label for="registerPassword">Password</label>
                    <div class="input-wrapper">
                        <i class="fas fa-lock input-icon"></i>
                        <input type="password" name="password" id="registerPassword" class="form-input" required
                               placeholder="Create a password">
                        <i class="fas fa-eye toggle-password" onclick="togglePassword('registerPassword')"></i>
                    </div>
                </div>

                <div class="input-group">
                    <label for="confirmPassword">Confirm Password</label>
                    <div class="input-wrapper">
                        <i class="fas fa-lock input-icon"></i>
                        <input type="password" name="confirmPassword" id="confirmPassword" class="form-input" required
                               placeholder="Confirm your password">
                        <i class="fas fa-eye toggle-password" onclick="togglePassword('confirmPassword')"></i>
                    </div>
                </div>

                <button type="submit" class="submit-btn" style="background: linear-gradient(45deg, #10b981, #059669);">
                    <i class="fas fa-user-plus me-2"></i>
                    Create Account
                </button>

                <div class="loading" id="registerLoading">
                    <div class="spinner"></div>
                    <span class="ms-2">Creating account...</span>
                </div>
            </form>

            <div class="divider">
                <span>Already have an account?</span>
            </div>

            <button class="submit-btn" onclick="switchTab('login')">
                <i class="fas fa-sign-in-alt me-2"></i>
                Sign In Instead
            </button>
        </div>
    </div>


    <div class="footer">
        <i class="fas fa-shield-alt me-1"></i>
        © 2025 PahanaEdu Bookshop System - Secure & Reliable
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>

    function switchTab(tabName) {

        document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
        document.querySelectorAll('.form-tab').forEach(tab => tab.classList.remove('active'));

        if (tabName === 'login') {
            document.querySelector('.tab-btn').classList.add('active');
            document.getElementById('loginTab').classList.add('active');
        } else {
            document.querySelectorAll('.tab-btn')[1].classList.add('active');
            document.getElementById('registerTab').classList.add('active');
        }
    }


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


    document.getElementById('registerForm').addEventListener('submit', function(e) {
        const password = document.getElementById('registerPassword').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        if (password !== confirmPassword) {
            e.preventDefault();
            alert('Passwords do not match!');
            return false;
        }

        if (password.length < 6) {
            e.preventDefault();
            alert('Password must be at least 6 characters long!');
            return false;
        }
    });


    document.getElementById('loginForm').addEventListener('submit', function() {
        document.getElementById('loginLoading').style.display = 'block';
    });

    document.getElementById('registerForm').addEventListener('submit', function() {
        document.getElementById('registerLoading').style.display = 'block';
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
            this.parentElement.parentElement.style.transform = 'scale(1.02)';
            this.parentElement.parentElement.style.transition = 'transform 0.3s ease';
        });

        input.addEventListener('blur', function() {
            this.parentElement.parentElement.style.transform = 'scale(1)';
        });
    });


    document.addEventListener('keydown', function(e) {
        if (e.key === 'Tab') {
            // Allow normal tab behavior
        } else if (e.key === 'Enter' && e.ctrlKey) {
            // Ctrl+Enter to switch tabs
            const currentTab = document.querySelector('.form-tab.active').id;
            switchTab(currentTab === 'loginTab' ? 'register' : 'login');
        }
    });


    window.addEventListener('load', function() {
        document.querySelector('.main-container').style.opacity = '0';
        setTimeout(() => {
            document.querySelector('.main-container').style.opacity = '1';
        }, 200);
    });
</script>

</body>
</html>