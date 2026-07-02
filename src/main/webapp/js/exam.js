let currentQuestion = 0;
let totalQuestions = 0;
let answers = {};
let timerInterval = null;
let timeLeft = 0;

function initExam() {
    const panels = document.querySelectorAll('.question-panel');
    totalQuestions = panels.length;
    if (totalQuestions === 0) return;

    showQuestion(0);
    startTimer();
}

function showQuestion(index) {
    const panels = document.querySelectorAll('.question-panel');
    panels.forEach(p => p.classList.remove('active'));
    panels[index].classList.add('active');
    currentQuestion = index;
    updateNavButtons();
    updateNavigationGrid();
}

function updateNavButtons() {
    const prevBtn = document.getElementById('prevBtn');
    const nextBtn = document.getElementById('nextBtn');
    if (prevBtn) prevBtn.disabled = currentQuestion === 0;
    if (nextBtn) {
        nextBtn.textContent = currentQuestion === totalQuestions - 1 ? 'Finish' : 'Next';
        nextBtn.innerHTML = currentQuestion === totalQuestions - 1
            ? '<i class="bi bi-flag-fill me-2"></i>Finish'
            : 'Next <i class="bi bi-arrow-right ms-2"></i>';
    }
}

function selectOption(questionId, option) {
    answers[questionId] = option;
    const panel = document.querySelector(`.question-panel[data-qid="${questionId}"]`);
    if (panel) {
        panel.querySelectorAll('.option-btn').forEach(btn => btn.classList.remove('selected'));
        const selectedBtn = panel.querySelector(`.option-btn[data-option="${option}"]`);
        if (selectedBtn) selectedBtn.classList.add('selected');
    }
    updateNavigationGrid();
}

function updateNavigationGrid() {
    const navBtns = document.querySelectorAll('.question-nav-btn');
    navBtns.forEach((btn, i) => {
        btn.classList.remove('current', 'answered');
        if (i === currentQuestion) {
            btn.classList.add('current');
        } else {
            const qid = btn.getAttribute('data-qid');
            if (qid && answers[qid]) {
                btn.classList.add('answered');
            }
        }
    });
}

function startTimer() {
    const durationEl = document.getElementById('examDuration');
    if (!durationEl) return;
    timeLeft = parseInt(durationEl.value) * 60;
    updateTimerDisplay();
    timerInterval = setInterval(() => {
        timeLeft--;
        updateTimerDisplay();
        if (timeLeft <= 0) {
            clearInterval(timerInterval);
            submitExam();
        }
    }, 1000);
}

function updateTimerDisplay() {
    const display = document.getElementById('timerDisplay');
    if (!display) return;
    const mins = Math.floor(timeLeft / 60);
    const secs = timeLeft % 60;
    display.textContent = `${String(mins).padStart(2, '0')}:${String(secs).padStart(2, '0')}`;
    display.classList.remove('timer-warning', 'timer-danger');
    if (timeLeft <= 60) {
        display.classList.add('timer-danger');
    } else if (timeLeft <= 300) {
        display.classList.add('timer-warning');
    }
}

function submitExam() {
    if (timerInterval) clearInterval(timerInterval);
    const form = document.getElementById('examForm');
    if (form) {
        for (const [qid, answer] of Object.entries(answers)) {
            const input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'answer_' + qid;
            input.value = answer;
            form.appendChild(input);
        }
        form.submit();
    }
}

function confirmSubmit() {
    const unanswered = totalQuestions - Object.keys(answers).length;
    let msg = 'Are you sure you want to submit the exam?';
    if (unanswered > 0) {
        msg = `You have ${unanswered} unanswered question(s). Are you sure you want to submit?`;
    }
    if (confirm(msg)) {
        submitExam();
    }
}

document.addEventListener('DOMContentLoaded', function () {
    initExam();

    window.addEventListener('beforeunload', function (e) {
        if (timeLeft > 0 && Object.keys(answers).length > 0) {
            e.preventDefault();
            e.returnValue = 'Exam is in progress. Are you sure you want to leave?';
        }
    });
});