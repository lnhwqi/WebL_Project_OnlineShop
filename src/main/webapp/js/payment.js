/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */





const cart = JSON.parse(localStorage.getItem('cart')) || [];
const variable = 123;
function updateCartDisplay() {
    const cart = JSON.parse(localStorage.getItem('cart')) || [];
    const cartList = document.getElementById('list-of-cart');
    const numberItemCart = document.getElementById('number-item-cart');


    let totalPrice = 0;
    let quantity = 0;

    cartList.innerHTML = '';

    cart.forEach((item, index) => {
        const li = document.createElement('li');
        totalPrice += item.totalPrice;
        li.innerHTML = `
            <div style="display: flex; align-items: center; justify-content: space-between; margin: 16px; border: 1px solid #000; padding: 4px 8px; line-height: 1.3">
                <div style="display: flex; align-items: center;">
                    <img src="${item.img}" alt="${item.name}" style="width: 30px; height: 30px; margin-right: 10px;">
                    <div>
                        <p>Name: ${item.name}</p>
                        <p>Price: $${item.totalPrice}</p>
                        <p>Quantity: ${item.quantity}</p>
                    </div>
                </div>
            </div>
        `;
        quantity += item.quantity;
        cartList.appendChild(li);
    });

    // Add event listeners to the delete links
    const deleteLinks = document.querySelectorAll('.delete-link');
    deleteLinks.forEach(link => {
        link.addEventListener('click', removeItemFromCart);
    });

    console.log(cart);


    document.getElementById("totalPrice").textContent = `Item (${cart.length}): $${totalPrice}`;

    numberItemCart.textContent = quantity;
    const orderListString = cart.map(item => `${item.name}:${item.quantity}`).join(';');

    document.getElementById('quantity').value = quantity;

    document.getElementById('orderlist').value = orderListString;
    document.getElementById('subtotal').value = totalPrice;



}
updateCartDisplay();