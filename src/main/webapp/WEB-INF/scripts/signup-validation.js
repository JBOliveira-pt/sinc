function validateBirthDate() {
    const birthDateInput = document.getElementById('birthDate');
    const birthDate = new Date(birthDateInput.value);
    const today = new Date();
    let age = today.getFullYear() - birthDate.getFullYear();
    const monthDiff = today.getMonth() - birthDate.getMonth();
    const dayDiff = today.getDate() - birthDate.getDate();

    birthDateInput.classList.remove('is-invalid');
    document.getElementById('birthDateFeedback').textContent = '';

    if (monthDiff < 0 || (monthDiff === 0 && dayDiff < 0)) {
        age--;
    }

    if (age > 99 || age < 18) {
        document.getElementById('birthDateFeedback').textContent = 'Idade deve estar entre 18 e 99 anos';
        birthDateInput.classList.add('is-invalid');
        return false;
    }
    return true;
}

function validateAdmissionDate() {
    const admissionDateInput = document.getElementById('admissionDate');
    const admissionDate = new Date(admissionDateInput.value);
    const today = new Date();
    let yearsDiff = today.getFullYear() - admissionDate.getFullYear();
    const monthDiff = today.getMonth() - admissionDate.getMonth();
    const dayDiff = today.getDate() - admissionDate.getDate();

    admissionDateInput.classList.remove('is-invalid');
    document.getElementById('admissionDateFeedback').textContent = '';

    if (admissionDate > today) {
        document.getElementById('admissionDateFeedback').textContent = 'A data de admissão não pode ser no futuro.';
        admissionDateInput.classList.add('is-invalid');
        return false;
    }
    if (monthDiff < 0 || (monthDiff === 0 && dayDiff < 0)) {
        yearsDiff--;
    }

    if (yearsDiff > 5) {
        document.getElementById('admissionDateFeedback').textContent = 'Data de admissão deve ser inferior a 5 anos';
        admissionDateInput.classList.add('is-invalid');
        return false;
    }
    return true;
}


function validateForm(event) {
    let validBirthDate = validateBirthDate();
    let validAdmissionDate = validateAdmissionDate();
    let validPassword = validatePassword();

    let valid = validBirthDate && validAdmissionDate && validPassword;
    if (!valid) {
        event.preventDefault();
    }
    return valid;
}

function validatePassword() {
    const password = document.getElementById('password');
    let isValid = true;

    password.classList.remove('is-invalid');
    document.getElementById('passwordFeedback').textContent = '';

    if (password.value.length < 8 || !/[A-Z]/.test(password.value) || !/[0-9]/.test(password.value)) {
        console.log("Password must be at least 8 characters long, contain one uppercase letter, and contain one number.");
        document.getElementById('passwordFeedback').textContent = 'Sua passe deve ter pelo menos 8 caracteres, uma letra maiúscula e um número.';
        password.classList.add('is-invalid');
        isValid = false;
    }

    return isValid;
}

function removeInvalidFeedback(event) {
    event.target.classList.remove('is-invalid');
    event.target.nextElementSibling.textContent = '';
}

//on load
document.addEventListener('DOMContentLoaded', function () {
    document.getElementById("signupForm").addEventListener("submit", validateForm);
});

const departmentPositions = {
    TI: [
        {value: 'PROGRAMADOR', label: 'Programador'},
        {value: 'ANALISTA', label: 'Analista'},
        {value: 'ARQUITETO_SOFTWARE', label: 'Arquiteto de Software'}
    ],
    MARKETING: [
        {value: 'ANALISTA_MARKETING', label: 'Analista de Marketing'},
        {value: 'GERENTE_MARKETING', label: 'Gerente de Marketing'},
        {value: 'SOCIAL_MEDIA', label: 'Social Media'}
    ],
    FINANCEIRO: [
        {value: 'CONTABILISTA', label: 'Contabilista'},
        {value: 'ANALISTA_FINANCEIRO', label: 'Analista Financeiro'},
        {value: 'CONTROLLER', label: 'Controller'}
    ],
    RH: [
        {value: 'RECRUTADOR', label: 'Recrutador'},
        {value: 'PSICOLOGO', label: 'Psicólogo'},
        {value: 'GERENTE_RH', label: 'Gerente de RH'}
    ],
    JURIDICO: [
        {value: 'ADVOGADO', label: 'Advogado'},
        {value: 'ASSISTENTE_JURIDICO', label: 'Assistente Jurídico'}
    ],
    GERENCIA: [
        {value: 'GERENTE_PROJETO', label: 'Gerente de Projetos'},
        {value: 'GERENTE_PRODUTO', label: 'Gerente de Produto'}
    ],
    DIRETORIA: [
        {value: 'DIRETOR', label: 'Diretor'},
        {value: 'DIRETOR_EXECUTIVO', label: 'Diretor Executivo'}
    ]
};

const departmentTechnologies = {
    TI: [
        {value: 'JAVA', label: 'Java'},
        {value: 'PYTHON', label: 'Python'},
        {value: 'JAVASCRIPT', label: 'JavaScript'},
        {value: 'PHP', label: 'PHP'},
        {value: 'RUBY', label: 'Ruby'}
    ],
    MARKETING: [
        {value: 'PHOTOSHOP', label: 'Adobe Photoshop'},
        {value: 'ILLUSTRATOR', label: 'Adobe Illustrator'},
        {value: 'ANALYTICS', label: 'Google Analytics'},
        {value: 'SOCIALMEDIA', label: 'Social Media Tools'}
    ],
    FINANCEIRO: [
        {value: 'SAP', label: 'SAP'},
        {value: 'EXCEL', label: 'Excel Avançado'},
        {value: 'QUICKBOOKS', label: 'QuickBooks'},
        {value: 'SAGE', label: 'Sage'}
    ],
    RH: [
        {value: 'WORKDAY', label: 'Workday'},
        {value: 'BAMBOO', label: 'BambooHR'},
        {value: 'ADP', label: 'ADP'}
    ],
    JURIDICO: [
        {value: 'LEGALONE', label: 'Legal One'},
        {value: 'PROJURIS', label: 'ProJuris'},
        {value: 'ESAJ', label: 'E-SAJ'}
    ],
    GERENCIA: [
        {value: 'MSPROJECT', label: 'MS Project'},
        {value: 'TRELLO', label: 'Trello'},
        {value: 'JIRA', label: 'Jira'}
    ],
    DIRETORIA: [
        {value: 'POWERBI', label: 'Power BI'},
        {value: 'TABLEAU', label: 'Tableau'},
        {value: 'SALESFORCE', label: 'Salesforce'}
    ]
};

function updateSelectOptions(select, options, defaultText) {
    select.innerHTML = `<option value="" selected disabled>${defaultText}</option>`;
    options.forEach(item => {
        const option = document.createElement('option');
        option.value = item.value;
        option.textContent = item.label;
        select.appendChild(option);
    });
    select.style.display = options.length ? 'block' : 'none';
}

document.addEventListener('DOMContentLoaded', function () {
    const departmentSelect = document.getElementById('department');
    const technologiesSelect = document.getElementById('technologies');
    const positionSelect = document.getElementById('position');
    const roleSelect = document.getElementById('role');

    positionSelect.disabled = true;
    roleSelect.disabled = true;
    technologiesSelect.disabled = true;

    departmentSelect.addEventListener('change', function () {
        const selectedDepartment = this.value;
        const technologies = departmentTechnologies[selectedDepartment] || [];
        const positions = departmentPositions[selectedDepartment] || [];

        const hasSelection = selectedDepartment !== '';
        positionSelect.disabled = !hasSelection;
        roleSelect.disabled = !hasSelection;
        technologiesSelect.disabled = !hasSelection;

        updateSelectOptions(technologiesSelect, technologies, 'Tecnologia');
        updateSelectOptions(positionSelect, positions, 'Cargo');

        if (!hasSelection) {
            positionSelect.value = '';
            roleSelect.value = '';
            technologiesSelect.value = '';
        }
    });
    document.addEventListener('DOMContentLoaded', function() {
        const interestsSelect = document.getElementById('interests');
        const MAX_SELECTIONS = 5;
        interestsSelect.addEventListener('mousedown', function(e) {
            e.preventDefault();
            const option = e.target.closest('option');
            if (!option) return;
            const selectedCount = Array.from(this.options).filter(opt => opt.selected).length;
            if (!option.selected && selectedCount >= MAX_SELECTIONS) {
                alert(`Não seleciones mais de 5 interesses!`);
                return;
            }
            option.selected = !option.selected;
            const event = new Event('change');
            this.dispatchEvent(event);
        });
        interestsSelect.addEventListener('mousemove', function(e) {
            e.preventDefault();
        });
    });
});