function updateCharCount(textarea) {
    const maxLength = 500;
    const currentLength = textarea.value.length;
    document.getElementById('charCount').textContent =
        currentLength + '/' + maxLength + ' characters';
}

document.addEventListener('DOMContentLoaded', function () {
    const textarea = document.getElementById('aboutMe');
    if (textarea && textarea.value) {
        updateCharCount(textarea);
    }
});

document.addEventListener('DOMContentLoaded', function () {
    const viewMode = document.getElementById('viewMode');
    const editMode = document.getElementById('editMode');
    const editButton = document.getElementById('editAboutMe');
    const cancelButton = document.getElementById('cancelEdit');

    if (editButton) {
        editButton.addEventListener('click', function() {
            viewMode.style.display = 'none';
            editMode.style.display = 'block';
            const textarea = document.getElementById('aboutMe');
            if (textarea && textarea.value) {
                updateCharCount(textarea);
            }
        });
    }

    if (cancelButton) {
        cancelButton.addEventListener('click', function(e) {
            e.preventDefault();
            viewMode.style.display = 'block';
            editMode.style.display = 'none';
        });
    }
});
// Add to your existing script
document.addEventListener('DOMContentLoaded', function() {
    const profileImage = document.getElementById('profileImage');
    if (profileImage) {
        profileImage.addEventListener('change', function() {
            const preview = document.getElementById('preview');
            const file = this.files[0];

            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    preview.src = e.target.result;
                }
                reader.readAsDataURL(file);
            }
        });
    }
});
document.addEventListener('DOMContentLoaded', function () {
    const viewMode = document.getElementById('viewMode');
    const editMode = document.getElementById('editMode');
    const editButton = document.getElementById('editAboutMe');
    const cancelButton = document.getElementById('cancelEdit');
    const textarea = document.getElementById('aboutMe');
    let originalContent = textarea ? textarea.value : '';

    if (editButton) {
        editButton.addEventListener('click', function() {
            originalContent = textarea.value; // Store original content
            viewMode.style.display = 'none';
            editMode.style.display = 'block';
            if (textarea) {
                updateCharCount(textarea);
            }
        });
    }

    if (cancelButton) {
        cancelButton.addEventListener('click', function(e) {
            e.preventDefault();
            textarea.value = originalContent; // Reset to original content
            updateCharCount(textarea);
            viewMode.style.display = 'block';
            editMode.style.display = 'none';
        });
    }
});