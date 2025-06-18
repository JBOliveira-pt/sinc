document.addEventListener('DOMContentLoaded', function() {
    const toastEl = document.getElementById('successToast');
    if (toastEl) {
        const toast = new bootstrap.Toast(toastEl, {
            autohide: true,
            delay: 3000
        });
        toast.show();
    }

    const modals = document.querySelectorAll('.modal');
    modals.forEach(modal => {
        modal.addEventListener('hidden.bs.modal', function(event) {
            try {
                const fileInput = this.querySelector('input[type="file"]');
                const uploadLabel = this.querySelector('label[for="attachment"]');
                const preview = this.querySelector('#attachmentPreview');
                const previewContainer = this.querySelector('#previewContainer');

                if (fileInput) fileInput.value = '';

                if (uploadLabel) {
                    uploadLabel.innerHTML = `
                        <i class="bi bi-upload" style="font-size: 32px; color: #0A3D62;"></i>
                        <input type="file" class="form-control d-none" id="attachment" name="attachment" onchange="previewFile()">
                    `;
                }

                if (preview) {
                    preview.src = '';
                    preview.style.display = 'none';
                }

                if (previewContainer) {
                    previewContainer.style.display = 'none';
                }
            } catch (error) {
                console.error('Error resetting modal:', error);
            }
        });
    });
});
document.addEventListener('DOMContentLoaded', function() {
    const modal = document.getElementById('modalPostInstitucional');

    modal.addEventListener('hide.bs.modal', function() {
        document.body.focus();
    });

    modal.addEventListener('shown.bs.modal', function() {
        document.getElementById('title').focus();
    });
});

function previewFile() {
    try {
        const preview = document.getElementById('attachmentPreview');
        const fileInput = document.querySelector('input[type=file]');
        const previewContainer = document.getElementById('previewContainer');
        const uploadLabel = document.querySelector('label[for="attachment"]');
        const postButton = document.querySelector('.modal-footer button[type="submit"]');
        const warningDiv = document.getElementById('fileWarning') || createWarningDiv();
        const fileInfoDiv = document.getElementById('fileInfo') || createFileInfoDiv();

        warningDiv.style.display = 'none';
        fileInfoDiv.style.display = 'none';
        postButton.disabled = false;

        if (!preview || !fileInput || !previewContainer || !uploadLabel) {
            console.error('Required elements not found');
            return;
        }

        const file = fileInput.files[0];

        if (file) {
            if (!file.type.startsWith('image/')) {
                warningDiv.style.display = 'block';
                warningDiv.textContent = '⚠️ Apenas arquivos de imagem são permitidos.';
                warningDiv.style.color = '#dc3545';
                postButton.disabled = true;
                fileInput.value = '';
                fileInfoDiv.style.display = 'none';
                return;
            }

            if (file.size > 1048576) {
                warningDiv.style.display = 'block';
                warningDiv.textContent = '⚠️ Arquivo muito grande! Por favor, selecione uma imagem menor que 1MB.';
                warningDiv.style.color = '#dc3545';
                postButton.disabled = true;
                fileInput.value = '';
                fileInfoDiv.style.display = 'none';
                return;
            }

            const reader = new FileReader();
            reader.onloadend = function() {
                const originalInput = fileInput.cloneNode(true);

                uploadLabel.innerHTML = '';

                const img = document.createElement('img');
                img.src = reader.result;
                img.style.maxHeight = '165px';
                img.style.width = '100%';
                img.style.objectFit = 'cover';
                img.style.borderRadius = '8px';
                uploadLabel.appendChild(img);

                uploadLabel.appendChild(originalInput);

                const fileSize = (file.size / 1024).toFixed(2);
                fileInfoDiv.style.display = 'block';
                fileInfoDiv.textContent = file.name + ' (' + fileSize + ' KB)';
                fileInfoDiv.insertAdjacentHTML('afterbegin', '<i class="bi bi-file-earmark-image"></i> ');

                preview.style.display = 'none';
                previewContainer.style.display = 'none';
            }
            reader.readAsDataURL(file);
        } else {
            uploadLabel.innerHTML = `
                <i class="bi bi-upload" style="font-size: 32px; color: #0A3D62;"></i>
                <input type="file" class="form-control d-none" id="attachment" name="attachment" onchange="previewFile()">
            `;
            preview.style.display = 'none';
            previewContainer.style.display = 'none';
            fileInfoDiv.style.display = 'none';
        }
    } catch (error) {
        console.error('Error in previewFile:', error);
    }
}

function createWarningDiv() {
    const warningDiv = document.createElement('div');
    warningDiv.id = 'fileWarning';
    warningDiv.style.marginTop = '5px';
    warningDiv.style.fontSize = '12px';
    warningDiv.style.fontWeight = 'bold';
    document.querySelector('label[for="attachment"]').parentNode.appendChild(warningDiv);
    return warningDiv;
}

function createFileInfoDiv() {
    const fileInfoDiv = document.createElement('div');
    fileInfoDiv.id = 'fileInfo';
    fileInfoDiv.style.marginTop = '5px';
    fileInfoDiv.style.fontSize = '12px';
    fileInfoDiv.style.color = '#666';
    document.querySelector('label[for="attachment"]').parentNode.appendChild(fileInfoDiv);
    return fileInfoDiv;
}