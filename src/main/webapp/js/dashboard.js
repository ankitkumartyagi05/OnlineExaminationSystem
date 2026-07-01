// ============================================================
// Dashboard JavaScript
// ============================================================

document.addEventListener('DOMContentLoaded', function() {
    initSidebarToggle();
    initDashboardAnimations();
});

function initSidebarToggle() {
    const sidebar = document.querySelector('.dashboard-sidebar');
    const toggleBtn = document.querySelector('.btn-toggle-sidebar');
    if (toggleBtn && sidebar) {
        toggleBtn.addEventListener('click', () => {
            sidebar.classList.toggle('active');
        });
    }
}

function initDashboardAnimations() {
    if (typeof gsap === 'undefined') return;

    // Animate KPI cards
    gsap.from('.kpi-card', {
        y: 30, opacity: 0, duration: 0.6, stagger: 0.1
    });

    // Animate chart cards
    gsap.from('.chart-card', {
        y: 30, opacity: 0, duration: 0.6, delay: 0.3
    });

    // Animate welcome banner
    gsap.from('.welcome-banner', {
        y: 20, opacity: 0, duration: 0.8
    });
}