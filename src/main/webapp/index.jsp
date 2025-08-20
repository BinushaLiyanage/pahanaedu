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
            background: linear-gradient(135deg, #1e3a8a 0%, #1e40af 50%, #3b82f6 100%);
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
            animation: float 8s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); opacity: 0.6; }
            50% { transform: translateY(-30px) rotate(180deg); opacity: 1; }
        }

        .navbar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(15px);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
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
            color: #1e3a8a !important;
            text-decoration: none;
        }

        .navbar-brand:hover {
            transform: scale(1.05);
            transition: transform 0.3s ease;
        }

        .navbar-nav .nav-link {
            font-weight: 500;
            color: #1e40af !important;
            margin: 0 1rem;
            padding: 0.5rem 1rem !important;
            border-radius: 25px;
            transition: all 0.3s ease;
            position: relative;
        }

        .navbar-nav .nav-link:hover {
            background: #1e40af;
            color: white !important;
            transform: translateY(-2px);
        }

        .navbar-nav .nav-link.active {
            background: #1e3a8a;
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
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(20px);
            padding: 1.5rem 2.5rem;
            border-radius: 15px;
            box-shadow: 0 30px 80px rgba(0, 0, 0, 0.3);
            text-align: center;
            max-width: 800px;
            width: 85%;
            animation: heroFadeIn 1.2s ease-out;
            position: relative;
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.2);
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
                transform: translateY(50px) scale(0.95);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        .hero-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: #1e3a8a;
            margin-bottom: 0.5rem;
            line-height: 1.1;
        }

        .hero-subtitle {
            font-size: 1.1rem;
            color: #64748b;
            margin-bottom: 1.2rem;
            font-weight: 400;
        }

        .features {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1rem;
            margin: 1.5rem 0;
            justify-items: center;
        }

        .feature-card {
            background: rgba(248, 250, 252, 0.9);
            padding: 1rem 0.8rem;
            border-radius: 12px;
            text-align: center;
            transition: all 0.3s ease;
            border: 2px solid rgba(30, 64, 175, 0.1);
            width: 100%;
            max-width: 180px;
            position: relative;
            overflow: hidden;
        }

        .feature-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.6s;
        }

        .feature-card:hover::before {
            left: 100%;
        }

        .feature-card:hover {
            transform: translateY(-10px) scale(1.05);
            background: rgba(255, 255, 255, 0.95);
            box-shadow: 0 20px 40px rgba(30, 58, 138, 0.2);
            border-color: rgba(30, 64, 175, 0.3);
        }

        .feature-icon {
            font-size: 2rem;
            color: #1e40af;
            margin-bottom: 0.5rem;
            display: block;
            transition: all 0.3s ease;
        }

        .feature-card:hover .feature-icon {
            color: #1e3a8a;
            transform: scale(1.1);
        }

        .feature-title {
            font-size: 0.95rem;
            font-weight: 600;
            color: #1e3a8a;
            margin-bottom: 0.3rem;
        }

        .feature-description {
            font-size: 0.9rem;
            color: #64748b;
            line-height: 1.5;
        }

        .btn-custom {
            background: linear-gradient(135deg, #1e3a8a, #1e40af);
            border: none;
            color: white;
            padding: 0.8rem 2rem;
            font-size: 1rem;
            font-weight: 600;
            border-radius: 50px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            text-decoration: none;
            display: inline-block;
            margin: 0.8rem;
            box-shadow: 0 10px 30px rgba(30, 58, 138, 0.3);
        }

        .btn-custom::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .btn-custom:hover::before {
            left: 100%;
        }

        .btn-custom:hover {
            transform: translateY(-3px) scale(1.05);
            background: linear-gradient(135deg, #1e40af, #3b82f6);
            box-shadow: 0 15px 40px rgba(30, 58, 138, 0.4);
            color: white;
            text-decoration: none;
        }

        .stats-section {
            display: flex;
            justify-content: space-around;
            margin: 3rem 0;
            gap: 2rem;
            flex-wrap: wrap;
        }

        .stat-item {
            text-align: center;
            flex: 1;
            min-width: 150px;
            padding: 1rem;
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: #1e3a8a;
            display: block;
            margin-bottom: 0.5rem;
        }

        .stat-label {
            font-size: 1rem;
            color: #64748b;
            font-weight: 500;
        }

        @media (max-width: 768px) {
            .hero-title {
                font-size: 2rem;
            }

            .hero-container {
                padding: 1.2rem 1rem;
                margin: 1rem;
                max-width: 95%;
            }

            .features {
                grid-template-columns: repeat(2, 1fr);
                gap: 1rem;
            }

            .stats-section {
                flex-direction: column;
                gap: 1.5rem;
            }

            .navbar-nav .nav-link {
                margin: 0.2rem 0;
            }

            .btn-custom {
                padding: 0.7rem 1.5rem;
                font-size: 0.95rem;
            }
        }

        .footer {
            background: rgba(30, 58, 138, 0.1);
            backdrop-filter: blur(15px);
            padding: 3rem 0;
            text-align: center;
            color: #1e3a8a;
            margin-top: 4rem;
            border-top: 1px solid rgba(255, 255, 255, 0.2);
        }

        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, #1e3a8a 0%, #1e40af 50%, #3b82f6 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 9999;
            transition: opacity 0.5s ease;
        }

        .spinner {
            width: 50px;
            height: 50px;
            border: 4px solid rgba(255, 255, 255, 0.3);
            border-top: 4px solid white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .hero-divider {
            width: 50px;
            height: 2px;
            background: linear-gradient(135deg, #1e3a8a, #1e40af);
            margin: 1rem auto;
            border-radius: 2px;
        }

        .system-badge {
            background: linear-gradient(135deg, #1e3a8a, #1e40af);
            color: white;
            padding: 0.3rem 0.7rem;
            border-radius: 50px;
            font-size: 0.8rem;
            font-weight: 600;
            display: inline-block;
            margin-bottom: 1rem;
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
            <i class="fas fa-shield-alt me-2"></i>PahanaEdu
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
                    <a class="nav-link" href="help.jsp" onclick="scrollToAbout()">
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
        <div class="system-badge">
            <i class="fas fa-cog me-1"></i>Management System
        </div>

        <h1 class="hero-title">PahanaEdu</h1>
        <p class="hero-subtitle">Advanced Bookshop Management System</p>
        <div class="hero-divider"></div>

        <div class="features" id="features">
            <div class="feature-card">
                <i class="fas fa-users feature-icon"></i>
                <div class="feature-title">Customer Management</div>
            </div>

            <div class="feature-card">
                <i class="fas fa-boxes feature-icon"></i>
                <div class="feature-title">Inventory Control</div>
            </div>

            <div class="feature-card">
                <i class="fas fa-file-invoice feature-icon"></i>
                <div class="feature-title">Smart Billing</div>
            </div>

            <div class="feature-card">
                <i class="fas fa-shield-alt feature-icon"></i>
                <div class="feature-title">Secure Access</div>
            </div>

        </div>

        <div class="mt-4">
            <a href="login.jsp" class="btn-custom">
                <i class="fas fa-rocket me-2"></i>Access System
            </a>
        </div>
    </div>
</section>

<section id="about" class="footer">
    <div class="container">
        <h3><i class="fas fa-shield-alt me-2"></i>About PahanaEdu Management System</h3>
        <p class="mt-3">
            Professional bookshop management solution designed for efficiency, security, and scalability.
        </p>
        <p class="mt-2">&copy; 2025 PahanaEdu Bookshop System. All rights reserved.</p>
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
        const particleCount = 60;

        for (let i = 0; i < particleCount; i++) {
            const particle = document.createElement('div');
            particle.className = 'particle';

            const size = Math.random() * 8 + 4;
            particle.style.width = size + 'px';
            particle.style.height = size + 'px';
            particle.style.left = Math.random() * 100 + '%';
            particle.style.top = Math.random() * 100 + '%';
            particle.style.animationDelay = Math.random() * 8 + 's';
            particle.style.animationDuration = (Math.random() * 4 + 6) + 's';

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
            navbar.style.boxShadow = '0 4px 25px rgba(0, 0, 0, 0.2)';
        } else {
            navbar.style.background = 'rgba(255, 255, 255, 0.95)';
            navbar.style.boxShadow = '0 4px 20px rgba(0, 0, 0, 0.15)';
        }
    });

    document.addEventListener('DOMContentLoaded', function() {
        createParticles();
    });

    document.querySelectorAll('.btn-custom').forEach(btn => {
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