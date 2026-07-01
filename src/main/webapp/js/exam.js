// ============================================================
// Exam Taking JavaScript
// ============================================================

// Auto-save answers (prevents data loss)
let examState = {
    answers: {},
    currentQuestion: 1,
    timeRemaining: 0
};

function saveExamState() {
    try {
        sessionStorage.setItem('examState', JSON.stringify(examState));
    } catch(e) { console.error('Failed to save state'); }
}

function loadExamState() {
    try {
        const saved = sessionStorage.getItem('examState');
        if (saved) {
            examState = JSON.parse(saved);
        }
    } catch(e) { console.error('Failed to load state'); }
}

// Prevent page refresh/leave during exam
window.addEventListener('beforeunload', function(e) {
    if (document.querySelector('.exam-body')) {
        e.preventDefault();
        e.returnValue = 'Are you sure you want to leave? Your exam progress will be lost.';
    }
});

// Keyboard navigation
document.addEventListener('keydown', function(e) {
    if (!document.querySelector('.question-card')) return;
    
    const current = document.querySelector('.question-card[style*="block"]');
    if (!current) return;
    
    const currentId = parseInt(current.id.split('-')[1]);
    
    if (e.key === 'ArrowRight' && currentId < totalQuestions) {
        showQuestion(currentId + 1);
    } else if (e.key === 'ArrowLeft' && currentId > 1) {
        showQuestion(currentId - 1);
    }
});

// Fullscreen request
function requestFullscreen() {
    const elem = document.documentElement;
    if (elem.requestFullscreen) elem.requestFullscreen();
    else if (elem.webkitRequestFullscreen) elem.webkitRequestFullscreen();
}