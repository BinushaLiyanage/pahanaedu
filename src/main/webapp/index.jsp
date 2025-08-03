<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome - PahanaEdu</title>


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
            overflow-x: hidden;
        }


        .particles {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            overflow: hidden;
        }

        .particle {
            position: absolute;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            animation: float 6s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }


        .navbar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
            padding: 1rem 0;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            transition: all 0.3s ease;
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
            color: #667eea !important;
            text-decoration: none;
        }

        .navbar-brand:hover {
            transform: scale(1.05);
            transition: transform 0.3s ease;
        }

        .navbar-nav .nav-link {
            font-weight: 500;
            color: #333 !important;
            margin: 0 1rem;
            padding: 0.5rem 1rem !important;
            border-radius: 25px;
            transition: all 0.3s ease;
            position: relative;
        }

        .navbar-nav .nav-link:hover {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white !important;
            transform: translateY(-2px);
        }

        .navbar-nav .nav-link.active {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white !important;
        }


        .hero-section {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding-top: 80px;
            position: relative;
        }

        .hero-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            padding: 4rem 3rem;
            border-radius: 30px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.15);
            text-align: center;
            max-width: 600px;
            width: 90%;
            animation: heroFadeIn 1.2s ease-out;
            position: relative;
            overflow: hidden;
        }

        .hero-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            animation: shimmer 3s infinite;
        }

        @keyframes shimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        @keyframes heroFadeIn {
            from {
                opacity: 0;
                transform: translateY(50px) scale(0.9);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        .hero-title {
            font-size: 3.5rem;
            font-weight: 700;
            background: linear-gradient(45deg, #667eea, #764ba2);
            background-clip: text;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 1.5rem;
            line-height: 1.2;
        }

        .hero-subtitle {
            font-size: 1.3rem;
            color: #666;
            margin-bottom: 2rem;
            font-weight: 400;
        }

        .hero-description {
            font-size: 1.1rem;
            color: #777;
            margin-bottom: 3rem;
            line-height: 1.6;
        }


        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin: 3rem 0;
        }

        .feature-card {
            background: rgba(255, 255, 255, 0.1);
            padding: 1.5rem;
            border-radius: 15px;
            text-align: center;
            transition: transform 0.3s ease;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .feature-card:hover {
            transform: translateY(-5px);
            background: rgba(255, 255, 255, 0.2);
        }

        .feature-icon {
            font-size: 2.5rem;
            color: #667eea;
            margin-bottom: 1rem;
        }

        .feature-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 0.5rem;
        }

        .feature-text {
            font-size: 0.9rem;
            color: #666;
        }


        .btn-custom {
            background: linear-gradient(45deg, #667eea, #764ba2);
            border: none;
            color: white;
            padding: 1rem 2.5rem;
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 50px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            text-decoration: none;
            display: inline-block;
            margin: 0.5rem;
        }

        .btn-custom::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s;
        }

        .btn-custom:hover::before {
            left: 100%;
        }

        .btn-custom:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
            color: white;
            text-decoration: none;
        }

        .btn-outline-custom {
            background: transparent;
            border: 2px solid #667eea;
            color: #667eea;
            padding: 1rem 2.5rem;
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 50px;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            margin: 0.5rem;
        }

        .btn-outline-custom:hover {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
            text-decoration: none;
        }


        @media (max-width: 768px) {
            .hero-title {
                font-size: 2.5rem;
            }

            .hero-container {
                padding: 2rem 1.5rem;
                margin: 1rem;
            }

            .navbar-nav .nav-link {
                margin: 0.2rem 0;
            }
        }


        .footer {
            background: rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
            padding: 2rem 0;
            text-align: center;
            color: white;
            margin-top: 5rem;
        }


        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 9999;
            transition: opacity 0.5s ease;
        }

        .spinner {
            width: 50px;
            height: 50px;
            border: 5px solid rgba(255, 255, 255, 0.3);
            border-top: 5px solid white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>


<div class="loading-overlay" id="loadingOverlay">
    <div class="spinner"></div>
</div>


<div class="particles" id="particles"></div>


<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="#" onclick="scrollToTop()">
            <i class="fas fa-book-open me-2"></i>PahanaEdu
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="#" onclick="scrollToTop()">
                        <i class="fas fa-home me-1"></i>Home
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="#Help Section" onclick="scrollToAbout()">
                        <i class="fas fa-info-circle me-1"></i>Help Section
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="login.jsp">
                        <i class="fas fa-sign-in-alt me-1"></i>Login
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>


<section class="hero-section">
    <div class="hero-container">
        <h1 class="hero-title">PahanaEdu</h1>
        <p class="hero-subtitle">Advanced Bookshop Management System</p>
        <p class="hero-description">
            Streamline your bookshop operations with our comprehensive management solution.
            Handle customers, inventory, billing, and analytics all in one powerful platform.
        </p>


        <div class="features" id="features">
            <div class="feature-card">
                <i class="fas fa-users feature-icon"></i>
                <div class="feature-title">Customer Management</div>
                <div class="feature-text">Efficiently manage customer accounts and history</div>
            </div>
            <div class="feature-card">
                <i class="fas fa-boxes feature-icon"></i>
                <div class="feature-title">Inventory Control</div>
                <div class="feature-text">Track books and stock levels in real-time</div>
            </div>
            <div class="feature-card">
                <i class="fas fa-file-invoice feature-icon"></i>
                <div class="feature-title">Smart Billing</div>
                <div class="feature-text">Generate professional bills and receipts</div>
            </div>
        </div>

        <div class="mt-4">
            <a href="login.jsp" class="btn-custom">
                <i class="fas fa-rocket me-2"></i>Get Started
            </a>
            <a href="#about" class="btn-outline-custom" onclick="scrollToAbout()">
                <i class="fas fa-info-circle me-2"></i>Learn More
            </a>
        </div>
    </div>
</section>


<section id="about" class="footer">
    <div class="container">
        <h3><i class="fas fa-book me-2"></i>About PahanaEdu</h3>
        <p class="mt-3">
            Welcome to PahanaEdu
        </p>
        <p>&copy; 2025 PahanaEdu Bookshop System. All rights reserved.</p>
    </div>
</section>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>

    window.addEventListener('load', function() {
        setTimeout(() => {
            document.getElementById('loadingOverlay').style.opacity = '0';
            setTimeout(() => {
                document.getElementById('loadingOverlay').style.display = 'none';
            }, 500);
        }, 1000);
    });


    function createParticles() {
        const particlesContainer = document.getElementById('particles');
        const particleCount = 50;

        for (let i = 0; i < particleCount; i++) {
            const particle = document.createElement('div');
            particle.className = 'particle';

            const size = Math.random() * 10 + 5;
            particle.style.width = size + 'px';
            particle.style.height = size + 'px';
            particle.style.left = Math.random() * 100 + '%';
            particle.style.top = Math.random() * 100 + '%';
            particle.style.animationDelay = Math.random() * 6 + 's';
            particle.style.animationDuration = (Math.random() * 3 + 3) + 's';

            particlesContainer.appendChild(particle);
        }
    }


    function scrollToTop() {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
        setActiveNav('home');
    }

    function scrollToFeatures() {
        document.getElementById('features').scrollIntoView({
            behavior: 'smooth'
        });
        setActiveNav('features');
    }

    function scrollToAbout() {
        document.getElementById('about').scrollIntoView({
            behavior: 'smooth'
        });
        setActiveNav('about');
    }

    function setActiveNav(section) {
        document.querySelectorAll('.nav-link').forEach(link => {
            link.classList.remove('active');
        });

        if (section === 'home') {
            document.querySelector('.nav-link[href="#"]').classList.add('active');
        }
    }


    window.addEventListener('scroll', function() {
        const navbar = document.querySelector('.navbar');
        if (window.scrollY > 50) {
            navbar.style.background = 'rgba(255, 255, 255, 0.98)';
            navbar.style.boxShadow = '0 2px 30px rgba(0, 0, 0, 0.15)';
        } else {
            navbar.style.background = 'rgba(255, 255, 255, 0.95)';
            navbar.style.boxShadow = '0 2px 20px rgba(0, 0, 0, 0.1)';
        }
    });


    document.addEventListener('DOMContentLoaded', function() {
        createParticles();
    });


    document.querySelectorAll('.btn-custom, .btn-outline-custom').forEach(btn => {
        btn.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-3px) scale(1.05)';
        });

        btn.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0) scale(1)';
        });
    });
</script>

</body>
</html>