<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>S.tore</title>
    <%@ include file="templates/head.jsp"%>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Lato:wght@400;700&display=swap');
        body {
            font-family: 'Lato', sans-serif;
            background: linear-gradient(118deg, rgba(175, 222, 242, 0.90) 0%, rgba(57, 141, 195, 0.85) 100%), url('/images/background.png') no-repeat center center / cover;
            display: flow;
            height: 1000px;
            overflow: hidden;
            overflow-y: scroll;
        }
    </style>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Check if there's a stored toast message
            const message = localStorage.getItem('toastMessage');
            const type = localStorage.getItem('toastType');

            if (message) {
                // Display the toast
                showToast(message, type);

                // Clear stored message
                localStorage.removeItem('toastMessage');
                localStorage.removeItem('toastType');
            }
        });

        function comprarProduto(productId, valor) {
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
                            // show toast message
                            showToast(text, 'success');
                            // update coins on navbar by id subtract valor
                            document.querySelectorAll('.coin-balance').forEach(el => {
                                el.innerHTML = parseInt(el.innerHTML) - valor;
                            });
                            // close modal
                            const modal = document.getElementById('modal' + productId);
                            const modalInstance = bootstrap.Modal.getInstance(modal);
                            modalInstance.hide();
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

            // Default message if empty
            if (!message || message.trim() === '') {
                message = "Saldo insuficiente para realizar esta compra.";
            }

            // Remove any existing toasts
            const existingToasts = document.querySelectorAll('.toast-container');
            existingToasts.forEach(t => t.remove());

            // Create toast container
            const toastContainer = document.createElement('div');
            toastContainer.className = 'toast-container position-fixed bottom-0 end-0 p-3';
            toastContainer.style.zIndex = '5000';

            // Create toast element with explicit styling
            const toastEl = document.createElement('div');
            toastEl.className = `toast`;
            toastEl.setAttribute('role', 'alert');
            toastEl.setAttribute('aria-live', 'assertive');
            toastEl.setAttribute('aria-atomic', 'true');

            // Set explicit background color based on type
            toastEl.style.backgroundColor = type === 'danger' ? '#dc3545' : '#198754';
            toastEl.style.color = '#ffffff';

            // Create toast body with explicit styling
            const toastBody = document.createElement('div');
            toastBody.className = 'toast-body';
            toastBody.textContent = message;
            toastBody.style.padding = '0.75rem';
            toastBody.style.display = 'block';

            // Add elements to DOM
            toastEl.appendChild(toastBody);
            toastContainer.appendChild(toastEl);
            document.body.appendChild(toastContainer);

            // Initialize and show Bootstrap toast
            const toast = new bootstrap.Toast(toastEl, {delay: 3000});
            toast.show();

            // Remove from DOM when hidden
            toastEl.addEventListener('hidden.bs.toast', function () {
                toastContainer.remove();
            });
        }

        // Function to update the coin balance in the UI
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
    </script>
</head>
<body>

<%--Nav Bar--%>
    <%@ include file="templates/navbar.jsp" %>

<%--Página--%>
<div class="storeWrapper">

<%--Cabeçalho--%>

    <div class="storeContainers">

        <div class="storeHeader">
            <h2>Bem-vindo à <strong>S.tore</strong></h2>
            <p>Espaço reservado para usar as suas S.inCoins</p>
                <br>
        </div>
    <%--Produtos--%>

        <div class="storeButtonAlign">
            <div class="storeContainer">
                <c:forEach items="${products}" var="product" varStatus="status">
                    <div class="storeCard" data-bs-toggle="modal" data-bs-target="#modal${product.id}">
                        <img src="<c:url value='${product.imageUrl}' />" alt="${product.name}">
                        <p style="margin: 0;">${product.name}</p>
                        <div style="display: flex; justify-content: center; align-items: center;">
                            <p class="price" style="margin: 0;"><strong style="color: #333">${product.price}</strong>
                                S.inCoins</p>
                        </div>
                    </div>

                    <!-- Modal for each productModal for each product -->
                    <div class="modal fade" id="modal${product.id}" tabindex="-1" role="dialog" aria-labelledby="modal${product.id}Label" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 500px;">
                            <div class="modal-content" style="background-color: white; border-radius: 12px; padding: 20px;">
                                <div class="modal-header" style="border-bottom: none; text-align: center; padding: 0; position: relative; justify-content: center;">
                                    <h5 class="modal-title" id="modal${product.id}Label" style="flex-grow: 1; text-align: center;">${product.name}</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" style="position: absolute; right: 0;"></button>
                                </div>
                                <div class="modal-body text-center" style="padding: 0">
                                    <img src="<c:url value='${product.imageUrl}' />" alt="${product.name}" style="width: 180px; height: auto; border-radius: 8px;">
                                    <p style="font-size: 16px; color: #666; margin-top: 10px; margin-top: 0">${product.description}</p>
                                    <p style="font-size: 25px; font-weight: bold; color: #333; margin: 0">${product.price} <span style="color: #ffc107; font-size: 18px; font-weight: normal">S.InCoins</span></p>
                                    <p style="font-size: 14px; color: #777; margin: 0">Marca: ${product.marca} | Modelo: ${product.modelo}</p>
                                    <p style="font-size: 12px; color: #999; margin: 0">Disponibilidade: sujeita à análise do Administrador</p>
                                </div>
                                <div class="modal-footer" style="border-top: none; display: flex; flex-direction: column; align-items: center; gap: 10px; padding-bottom: 0">
                                    <button type="button" class="btn btn-primary" onclick="comprarProduto(${product.id}, ${product.price})" style="border-color: #398dc3; width: 120px; border-radius: 12px; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.6);">Comprar</button>
                                    <button type="button" class="btn btn-outline-custom1 gradient-custom-3 mb-3 center" onclick="adicionarAoCarrinho(${product.id}, '${product.name}', ${product.price}, '${product.imageUrl}')" style="width: 180px; color: gray">Adicionar às compras</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <div>
                <button class="btn btn-lg compras" data-bs-toggle="modal" data-bs-target="#modalComprasCard" style="position: relative; top: 50%; margin-right: 30px; margin-left: 30px">
                    <i class="bi bi-bag"></i>
                </button>
            </div>
        </div>
    </div>
</div>

<%--Carrinho de Compras--%>
<div class="modal fade" id="modalComprasCard" tabindex="-1" role="dialog" aria-labelledby="modalComprasCardLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 500px;">
        <div class="modal-content" style="background-color: white; border-radius: 12px; padding: 20px;">
            <div class="modal-header" style="border-bottom: none; text-align: center; padding: 0">
                <h3 class="modal-title" id="modalComprasCardLabel" style="font-weight: bold;font-size: 25px; padding-left: 18%">Meu carrinho de compras</h3>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body" id="carrinhoCompras" style="display: flex; flex-direction: column; gap: 10px; padding: 35px 35px 20px;"></div>

            <div class="modal-footer" style="border-top: none; display: flex; flex-direction: column; align-items: center; gap: 10px; padding-bottom: 0; padding-top: 0">
                <button type="button" class="btn btn-primary" onclick="concluirCompras()" style=" border-color: #398dc3; width: 150px; border-radius: 12px; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.6);">Concluir compras</button>
                <button type="button" class="btn btn-outline-custom1 gradient-custom-3 mb-3 center" onclick="limparCarrinho()" style=" width: 180px; color: gray">Desistir das compras</button>
            </div>
        </div>
    </div>
</div>

<%--Script do Carrinho de Compras--%>
<script src="scripts/store.js"></script>

</body>
</html>
