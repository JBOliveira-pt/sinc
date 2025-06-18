let cartTotal = 0;

//ADIÇÃO DE PRODUTOS AO CARRINHO
function adicionarAoCarrinho(id, name, price, imageUrl) {
    const cartItems = JSON.parse(sessionStorage.getItem('cartItems')) || [];

    const existingItem = cartItems.find(item => item.id === id);

    if (existingItem) {
        existingItem.quantity += 1;
    } else {
        cartItems.push({ id, name, price, imageUrl, quantity: 1 });
    }

    sessionStorage.setItem('cartItems', JSON.stringify(cartItems));
    updateCart();
    showNotification('Produto adicionado ao carrinho!');
}

function showNotification(message) {
    const notification = document.createElement('div');
    notification.className = 'alert alert-success alert-dismissible fade show text-center position-absolute w-auto';
    notification.role = 'alert';
    notification.innerHTML = `
        ${message}
    `;
    document.body.appendChild(notification);
    notification.style.top = '90%';
    notification.style.left = '50%';
    notification.style.transform = 'translate(-50%, -50%)';
    notification.style.zIndex = '9999';

    setTimeout(() => {
        notification.classList.remove('show');
        notification.classList.add('hide');
        setTimeout(() => {
            notification.remove();
        }, 500);
    }, 3000);
}

//ATUALIZAÇÃO DO CARRINHO
function updateCart() {
    const carrinho = document.getElementById('carrinhoCompras');
    carrinho.innerHTML = '';
    const cartItems = JSON.parse(sessionStorage.getItem('cartItems')) || [];
    cartTotal = 0;
    cartItems.forEach(({ id, name, price, imageUrl, quantity }) => {
        const itemElement = document.createElement('div');
        itemElement.style.display = 'flex';
        itemElement.style.alignContent = 'left';
        const imageElement = document.createElement('img');
        imageElement.src = imageUrl;
        imageElement.style.maxWidth = '80px';
        imageElement.style.marginRight = '10px';
        imageElement.style.alignContent = 'left';
        const textContainer = document.createElement('div');
        textContainer.style.display = 'flex';
        textContainer.style.flexDirection = 'column';
        textContainer.style.alignContent = 'left';
        textContainer.style.justifyContent = 'center';
        textContainer.innerHTML = `<p style="line-height: 10px; font-size: 14px"><strong>Quantidade:</strong> ${quantity}</p>
                                  <p style="line-height: 10px; font-size: 14px"><strong>Id:</strong> ${id}</p>
                                  <p style="line-height: 10px; font-size: 14px"><strong>Nome:</strong> ${name}</p>
                                  <p style="line-height: 10px; font-size: 14px"><strong>S.inCoins:</strong> ${price * quantity}</p>`;
        itemElement.appendChild(imageElement);
        itemElement.appendChild(textContainer);
        carrinho.appendChild(itemElement);

        cartTotal += price * quantity;
    });

    const totalElement = document.createElement('div');
    totalElement.style.marginTop = '20px';
    totalElement.innerHTML =    `<hr>
                                <p style="align-content: center"><strong>Total:</strong> ${cartTotal} S.inCoins</p>`;
    carrinho.appendChild(totalElement);

    const concluirButton = document.querySelector('[onclick^="concluirCompras"]');
    if (concluirButton) {
        concluirButton.setAttribute('onclick', `concluirCompras(${cartTotal})`);
    }

}

//CONCLUIR COMPRAS
function concluirCompras() {
    const cartItems = JSON.parse(sessionStorage.getItem('cartItems')) || [];
    let total = 0;

    cartItems.forEach(item => {
        total += item.price * item.quantity;
    });

    const url = "/store/concluirCompras";

    fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ items: cartItems, total: total })
    })
        .then(response => {
            if (response.ok) {
                return response.text().then(text => {

                    const modalElement = document.querySelector(`#modalComprasCard`);
                    const modal = modalElement ? bootstrap.Modal.getInstance(modalElement) : null;
                    if (modal) {
                        modal.hide();
                    }

                    sessionStorage.setItem('cartItems', '[]');

                    localStorage.setItem('toastMessage', 'Compra realizada com sucesso!');
                    localStorage.setItem('toastType', 'success');

                    window.location.reload();
                });
            } else {
                return response.text().then(text => {
                    console.log("Error response:", text);
                    showToast(text || 'Saldo insuficiente para realizar esta compra.', 'danger');
                });
            }
        })
        .catch(error => {
            console.error('Error:', error);
            showToast('Ocorreu um erro ao processar a compra.', 'danger');
        });
}

//LIMPAR CARRINHO
function limparCarrinho() {
    sessionStorage.setItem('cartItems', "[]");
    updateCart();
}

document.addEventListener('DOMContentLoaded', updateCart);

//ADIÇÃO DE EVENTO DE CLICK NO BOTÃO DE LOGOUT
document.addEventListener('DOMContentLoaded', function() {
    const logoutButton = document.getElementById('logoutButton');
    if (logoutButton) {
        logoutButton.addEventListener('click', function(event) {
            const cartItems = JSON.parse(sessionStorage.getItem('cartItems')) || [];
            if (cartItems.length > 0) {
                const confirmLogout = confirm("Tens itens em seu carrinho! Quer mesmo fazer logout?");
                if (!confirmLogout) {
                    event.preventDefault();
                    return;
                }
            }
            limparCarrinho();
            window.location.href = '/login';
        });
    }
});

//ADIÇÃO DE EVENTO DE CLICK NO BOTÃO DE COMPRAR
document.addEventListener('DOMContentLoaded', function() {
    const message = localStorage.getItem('toastMessage');
    const type = localStorage.getItem('toastType');

    if (message) {
        showToast(message, type);

        localStorage.removeItem('toastMessage');
        localStorage.removeItem('toastType');
    }
});

function comprarProduto(productId) {
    console.log("Attempting to purchase product with ID:", productId);
    const url = "/store/purchase/" + productId;
    fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        }
    })
        .then(response => {
            if (response.ok) {
                return response.text().then(text => {

                    const modalElement = document.querySelector(`#modal${productId}`);
                    const modal = modalElement ? bootstrap.Modal.getInstance(modalElement) : null;
                    if (modal) {
                        modal.hide();
                    }

                    localStorage.setItem('toastMessage', 'Compra realizada com sucesso!');
                    localStorage.setItem('toastType', 'success');

                    window.location.reload();
                });
            } else {
                return response.text().then(text => {
                    console.log("Error response:", text);
                    showToast(text || 'Saldo insuficiente para realizar esta compra.', 'danger');
                });
            }
        })
        .catch(error => {
            console.error('Error:', error);
            showToast('Ocorreu um erro ao processar a compra.', 'danger');
        });
}

function showToast(message, type) {
    console.log("Creating toast with message:", message);

    if (!message || message.trim() === '') {
        message = "Saldo insuficiente para realizar esta compra.";
    }

    const existingToasts = document.querySelectorAll('.toast-container');
    existingToasts.forEach(t => t.remove());

    const toastContainer = document.createElement('div');
    toastContainer.className = 'toast-container position-fixed bottom-0 end-0 p-3';
    toastContainer.style.zIndex = '5000';

    const toastEl = document.createElement('div');
    toastEl.className = `toast`;
    toastEl.setAttribute('role', 'alert');
    toastEl.setAttribute('aria-live', 'assertive');
    toastEl.setAttribute('aria-atomic', 'true');

    toastEl.style.backgroundColor = type === 'danger' ? '#dc3545' : '#198754';
    toastEl.style.color = '#ffffff';

    const toastBody = document.createElement('div');
    toastBody.className = 'toast-body';
    toastBody.textContent = message;
    toastBody.style.padding = '0.75rem';
    toastBody.style.display = 'block';

    toastEl.appendChild(toastBody);
    toastContainer.appendChild(toastEl);
    document.body.appendChild(toastContainer);

    const toast = new bootstrap.Toast(toastEl, {delay: 3000});
    toast.show();

    toastEl.addEventListener('hidden.bs.toast', function () {
        toastContainer.remove();
    });
}

function atualizarSaldo() {
    console.log("atualizando o saldo...")
    fetch('/user/profile/balance', {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json'
        }
    })
        .then(response => response.json())
        .then(data => {
            const elements = document.querySelectorAll('.coin-balance');
            elements.forEach(el => {
                el.innerHTML = data.coins;
            })
        })
        .catch(error => console.error('Error updating balance:', error));
}