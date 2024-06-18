// Function to update the cart display
function updateCartDisplay() {
    const cart = JSON.parse(localStorage.getItem('cart')) || [];
    const cartList = document.getElementById('list-of-cart');
    const numberItemCart = document.getElementById('number-item-cart');
    const payment = document.getElementById('navpayment');
    let totalPrice = 0;

    cartList.innerHTML = ''; // Clear existing items

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
                <a href="#!" data-index="${index}" class="delete-link">Delete</a>
            </div>
        `;
        cartList.appendChild(li);
    });

    // Add event listeners to the delete links
    const deleteLinks = document.querySelectorAll('.delete-link');
    deleteLinks.forEach(link => {
        link.addEventListener('click', removeItemFromCart);
    });

    console.log(cart);


    document.getElementById("totalPrice").textContent = `Item (${cart.length}): $${totalPrice}`;

    numberItemCart.textContent = cart.length;



}

// Function to add an item to the cart
function addItemToCart(name, img, price, quantity) {
    const cart = JSON.parse(localStorage.getItem('cart')) || [];
    let totalPrice = quantity * price;
    const newItem = {name, img, price, quantity, totalPrice};
    cart.push(newItem);
    localStorage.setItem('cart', JSON.stringify(cart));
    updateCartDisplay();
}

// Function to remove an item from the cart
function removeItemFromCart(event) {
    event.preventDefault();
    const cart = JSON.parse(localStorage.getItem('cart')) || [];
    const index = event.target.getAttribute('data-index');
    cart.splice(index, 1);
    localStorage.setItem('cart', JSON.stringify(cart));
    updateCartDisplay();

    if (cart.length === 0) {
        window.location.href = "index.jsp";
    }
}

function payment(event) {
    if (event) {
        event.preventDefault();
    }
    const cart = JSON.parse(localStorage.getItem('cart')) || [];
    if (cart.length !== 0) {
        let payment = 'Payment';
        window.location.href = payment;
    } else {
        alert("need choose product before payment");
    }
}
function directpayment(event) {
    localStorage.clear();
}

document.addEventListener('DOMContentLoaded', updateCartDisplay);
