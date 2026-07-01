// ============================================================
// ExamPortal - Main JavaScript
// ============================================================

// Initialize AOS
document.addEventListener('DOMContentLoaded', function() {
    if (typeof AOS !== 'undefined') {
        AOS.init({
            duration: 1000,
            once: true,
            offset: 100
        });
    }

    initNavbarScroll();
    initCounterAnimation();
    initGsapAnimations();
    initCardTilt();
    initSmoothScroll();
});

// Navbar scroll effect
function initNavbarScroll() {
    const navbar = document.getElementById('mainNav');
    if (!navbar) return;
    window.addEventListener('scroll', () => {
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });
}

// Counter animation
function initCounterAnimation() {
    const counters = document.querySelectorAll('.stat-number');
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                animateCounter(entry.target);
                observer.unobserve(entry.target);
            }
        });
    }, { threshold: 0.5 });

    counters.forEach(counter => observer.observe(counter));
}

function animateCounter(element) {
    const target = parseInt(element.getAttribute('data-target'));
    const suffix = element.getAttribute('data-suffix') || '';
    const duration = 2000;
    const step = target / (duration / 16);
    let current = 0;

    const timer = setInterval(() => {
        current += step;
        if (current >= target) {
            current = target;
            clearInterval(timer);
        }
        element.textContent = Math.floor(current).toLocaleString() + suffix;
    }, 16);
}

// GSAP Animations
function initGsapAnimations() {
    if (typeof gsap === 'undefined') return;

    gsap.registerPlugin(ScrollTrigger);

    // Hero section animation
    gsap.from('.hero-badge', { duration: 0.8, y: -30, opacity: 0, delay: 0.2 });
    gsap.from('.hero-title', { duration: 1, y: 50, opacity: 0, delay: 0.4 });
    gsap.from('.hero-subtitle', { duration: 1, y: 30, opacity: 0, delay: 0.6 });
    gsap.from('.hero-actions', { duration: 0.8, y: 30, opacity: 0, delay: 0.8 });
    gsap.from('.hero-stats', { duration: 0.8, y: 30, opacity: 0, delay: 1 });

    // Floating cards
    gsap.utils.toArray('.floating-card').forEach((card, i) => {
        gsap.to(card, {
            y: '+=20',
            duration: 2 + i * 0.5,
            repeat: -1,
            yoyo: true,
            ease: 'sine.inOut'
        });
    });

    // Feature cards entrance
    gsap.utils.toArray('.feature-card').forEach((card, i) => {
        gsap.from(card, {
            scrollTrigger: { trigger: card, start: 'top 80%' },
            y: 50, opacity: 0, duration: 0.6, delay: i * 0.1
        });
    });

    // Section titles
    gsap.utils.toArray('.section-title').forEach(title => {
        gsap.from(title, {
            scrollTrigger: { trigger: title, start: 'top 85%' },
            y: 30, opacity: 0, duration: 0.8
        });
    });
}

// Card tilt effect
function initCardTilt() {
    document.querySelectorAll('.glass-card').forEach(card => {
        card.addEventListener('mousemove', (e) => {
            const rect = card.getBoundingClientRect();
            const x = e.clientX - rect.left;
            const y = e.clientY - rect.top;
            const centerX = rect.width / 2;
            const centerY = rect.height / 2;
            const rotateX = (y - centerY) / 20;
            const rotateY = (centerX - x) / 20;
            card.style.transform = `perspective(1000px) rotateX(${rotateX}deg) rotateY(${rotateY}deg) translateY(-5px)`;
        });
        card.addEventListener('mouseleave', () => {
            card.style.transform = 'perspective(1000px) rotateX(0) rotateY(0)';
        });
    });
}

// Smooth scroll
function initSmoothScroll() {
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                e.preventDefault();
                target.scrollIntoView({ behavior: 'smooth', block: 'start' });
            }
        });
    });
}

// Toggle sidebar (dashboard)
function toggleSidebar() {
    const sidebar = document.getElementById('sidebar');
    if (sidebar) sidebar.classList.toggle('active');
}